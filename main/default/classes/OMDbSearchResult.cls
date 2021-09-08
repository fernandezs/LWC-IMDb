public class OMDbSearchResult {

	public List<Search> Search;
	public String totalResults;
	public String Response;
    public String Error;

	public class Search {
		public String Title;
		public String Year;
		public String imdbID;
		public String Type;
		public String Poster;
	}

	public static OMDbSearchResult parse(String json) {
		return (OMDbSearchResult) System.JSON.deserialize(json, OMDbSearchResult.class);
	}
}