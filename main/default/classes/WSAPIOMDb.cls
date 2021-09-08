public class WSAPIOMDb {
    public final static String WS_CONFIG_SEARCH = '{0}?apiKey={1}&{2}={3}';
	public static WSOmdbResult callResource(String keyword,String searchParam, WSOmdbResult callback) {
        Api__mdt omdb = Api__mdt.getInstance('OMDb_API');
		WSParameter endpoint = new WSParameter('endpoint', omdb.Endpoint__c, true,false);
		WSParameter authParameter = new WSParameter('apiKey',omdb.Api_key__c , true);
		WSParameter param = new WSParameter('param',searchParam , true);
        WSParameter keywordParam = new WSParameter('keyword',keyword, true);
		List<WSParameter> urlParameters = new List<WSParameter>{endpoint, authParameter,param,keywordParam};
		RestWS ws = new RestWS(WS_CONFIG_SEARCH, 'GET', urlParameters);
        ws.addHeaderRequest('Content-Type', 'application/json');
        ws.addHeaderRequest('Accept', 'application/json');
		return (WSAPIOMDb.WSOmdbResult) ws.invoke(callback);
	}
    
    public abstract class WSOmdbResult extends WSResult {}
}