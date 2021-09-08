public with sharing class OMDbSearchController {
    
    @AuraEnabled
    public static AuraActionResult searchMovie(String searchParam) {
        AuraActionResult auraResult = new AuraActionResult();
        try {
            WSGetOMDbResult.Response calloutResult = WSGetOMDbResult.searchMovies(searchParam);
            if (calloutResult.hasError) {
                auraResult.success = false;
                auraResult.error = calloutResult.message;
                return auraResult;
            }
            auraResult.result = JSON.serialize(calloutResult.result);
        } catch (Exception ex) {
            auraResult = new AuraActionResult(ex);
        }
        return auraResult;
    }
    
    @AuraEnabled
    public static AuraActionResult findMovieById(String imdbID) {
        AuraActionResult auraResult = new AuraActionResult();
        try {
            WSGetOMDbById.Response calloutResult = WSGetOMDbById.findById(imdbID);
            if (calloutResult.hasError) {
                auraResult.success = false;
                auraResult.error = calloutResult.message;
                return auraResult;
            }
            auraResult.result = JSON.serialize(calloutResult.result);
        } catch (Exception ex) {
            auraResult = new AuraActionResult(ex);
        }
        return auraResult;
    }
}