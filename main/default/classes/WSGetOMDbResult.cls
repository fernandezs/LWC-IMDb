public with sharing class WSGetOMDbResult {
    
    public static Response searchMovies(String keyword) {
        Response result = new Response();
        return (Response) WSAPIOMDb.callResource(keyword, 's', result);
    }

	public class Response extends WSAPIOMDb.WSOmdbResult {
		public OMDbSearchResult result {get; set;}

		public override void processResponse(HttpResponse response) {
			result = OMDbSearchResult.parse(response.getBody());
            if (String.isNotBlank(result.Error)) {
                hasError = true;
                message = result.Error;
            }
		}
	}
}