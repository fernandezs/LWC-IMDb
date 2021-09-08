public class RestWS {
	private String endpoint = '';
	public WSParameter[] parameters;
	public WSParameter bodyParameter;
	public HttpRequest request;

	public Boolean hasError = false;
	public String errorMessage = '';

	public RestWS(String endpoint, String method, WSParameter[] urlParameters, WSParameter bodyParameter) {
		request = new HttpRequest();
		request.setMethod(method);
		request.setTimeout(120000);
		this.bodyParameter = bodyParameter;
		this.endpoint = endpoint;
		this.parameters = urlParameters;
	}

	public void addHeaderRequest(String key, String value) {
		if (this.request != null) {
			this.request.setHeader(key, value);
		}
	}

	public RestWS(String endpoint, String method, WSParameter[] urlParameters, String bodyParameter) {
		this(endpoint, method, urlParameters, new WSParameter('body', bodyParameter, false, false));
	}

	public RestWS(String endpoint, String method, WSParameter[] urlParameters) {
		this(endpoint, method, urlParameters, '');
	}

	private String getMissingParametersMessage() {
		if (parameters == null && bodyParameter == null) {
			return '';
		}

		WSParameter[] parametersToCheck = new WSParameter[]{};
		if (parameters != null) {
			parametersToCheck.addAll(parameters);
		}
		if (bodyParameter != null) {
			parametersToCheck.add(bodyParameter);
		}

		String[] missingParms = new String[]{};
		for (WSParameter parameter: parametersToCheck) {
			if (parameter.isRequired && String.isBlank(parameter.value)) {
				missingParms.add(parameter.name);
			}
		}

		if (missingParms.size() > 0) {
			String message = String.format(
					'Faltan parametros para realizar la operacion: {0} .',
					new String[] {String.join(missingParms, ',') }
			);
			return message;
		} else {
			return '';
		}
	}

	private String formatEndpoint() {
		if (parameters == null || parameters.isEmpty()) {
			return endpoint;
		}
		List<String> paramValues = new List<String>();
		for (WSParameter parameter : parameters) {
			paramValues.add(parameter.toString());
		}
		return String.format(endpoint, paramValues);
	}

	private String getBody() {

		if (request.getMethod() == 'GET' || request.getMethod() == 'OPTIONS' || bodyParameter == null) {
			return '';
		}

		return bodyParameter.toString();
	}

	public WSResult invoke(WSResult result) {
        if (Test.isRunningTest()) {
            MocksQueue.setMock();
        }
		result.request = request;

		String missingParamsMessage = getMissingParametersMessage();

		if (String.isNotBlank(missingParamsMessage)) {
			result.hasError = true;
			result.message = missingParamsMessage;
			return result;
		}

		request.setEndpoint(formatEndpoint());
		String body = getBody();
		if (String.isNotBlank(body)) {
			request.setBody(body);
		}
		result.request = request;

		try {
			HttpResponse response = new Http().send(request);
			result.response = response;

			System.debug(LoggingLevel.WARN,'Callout: ' +  request.getEndpoint());

			result.hasError = response.getStatusCode() < 200 || response.getStatusCode() >= 300;

			if(!result.hasError) {
				result.processResponse(response);
			}
            else if (response.getStatusCode() == 401) {
                result.message = 'Unauthorized';
            }
            else {
                result.message = response.getBody();
            }

		} catch(Exception ex) {
			result.hasError = true;
			result.message = ex.getMessage();
		}

		return result;
	}
}