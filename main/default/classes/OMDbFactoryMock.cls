@IsTest
public class OMDbFactoryMock {
    public static Mock getResponseOKForSearchResult() {
        return new Mock(200,'OK','{"Search": [{"Title": "Batman Begins","Year": "2005","imdbID": "tt0372784","Type": "movie","Poster": "https://amazon.test.jpg"},{"Title": "Batman v Superman: Dawn of Justice","Year": "2016","imdbID": "tt2975590","Type": "movie","Poster": "https://m.media-amazon.com/test.jpg"}],"totalResults": "2","Response": "True"}',new Map<String, String>());
    }
    public static Mock getResponseOKForMovieNotFound() {
        return new  Mock(200,'OK','{"Response": "False","Error": "Movie not found!"}',new Map<String, String>());
    }
    public static Mock getFailResponseForUnauthorizedEndPoint() {
        return new Mock(401,'Unauthorized','{"Response": "False","Error": "Invalid API key!"}',new Map<String, String>());
    }
    public static Mock getOKResponseForMovieById() {
        return new Mock(200,'OK',movieJSON(),new Map<String, String>());
    }

    static String movieJSON() {
        String json = '{'+
		'  \"Title\": \"Guardians of the Galaxy Vol. 2\",'+
		'  \"Year\": \"2017\",'+
		'  \"Rated\": \"PG-13\",'+
		'  \"Released\": \"05 May 2017\",'+
		'  \"Runtime\": \"136 min\",'+
		'  \"Genre\": \"Action, Adventure, Comedy\",'+
		'  \"Director\": \"James Gunn\",'+
		'  \"Writer\": \"James Gunn, Dan Abnett, Andy Lanning\",'+
		'  \"Actors\": \"Chris Pratt, Zoe Saldana, Dave Bautista\",'+
		'  \"Plot\": \"The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord\'s encounter with his father the ambitious celestial being Ego.\",'+
		'  \"Language\": \"English\",'+
		'  \"Country\": \"United States\",'+
		'  \"Awards\": \"Nominated for 1 Oscar. 15 wins & 58 nominations total\",'+
		'  \"Poster\": \"https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg\",'+
		'  \"Ratings\": ['+
		'    {'+
		'      \"Source\": \"Internet Movie Database\",'+
		'      \"Value\": \"7.6/10\"'+
		'    },'+
		'    {'+
		'      \"Source\": \"Rotten Tomatoes\",'+
		'      \"Value\": \"85%\"'+
		'    },'+
		'    {'+
		'      \"Source\": \"Metacritic\",'+
		'      \"Value\": \"67/100\"'+
		'    }'+
		'  ],'+
		'  \"Metascore\": \"67\",'+
		'  \"imdbRating\": \"7.6\",'+
		'  \"imdbVotes\": \"600,709\",'+
		'  \"imdbID\": \"tt3896198\",'+
		'  \"Type\": \"movie\",'+
		'  \"DVD\": \"10 Jul 2017\",'+
		'  \"BoxOffice\": \"$389,813,101\",'+
		'  \"Production\": \"Marvel Studios, Walt Disney Pictures\",'+
		'  \"Website\": \"N/A\",'+
		'  \"Response\": \"True\"'+
		'}';
        return json;
    }
}