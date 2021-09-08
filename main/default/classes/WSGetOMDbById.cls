public with sharing class WSGetOMDbById {
    public static Response findById(String imdbID) {
        Response result = new Response();
        return (Response) WSAPIOMDb.callResource(imdbID, 'i', result);
    }

	public class Response extends WSAPIOMDb.WSOmdbResult {
		public OMDbMovie result {get; set;}

		public override void processResponse(HttpResponse response) {
			result = OMDbMovie.parse(response.getBody());
		}
	}
}