public abstract class WSResult  {
	public Boolean hasError;
	public String message;
	public HttpRequest request;
	public HttpResponse response;
	public abstract void processResponse(HttpResponse response);
}