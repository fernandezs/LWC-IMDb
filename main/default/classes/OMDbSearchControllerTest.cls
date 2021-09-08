@isTest
private class OMDbSearchControllerTest {
    
    @isTest
    private static void whenCallingApiWithValidApiKey_shouldReturnAResultList() {
        MocksQueue.add(OMDbFactoryMock.getResponseOKForSearchResult());
        AuraActionResult auraResult;
        OMDbSearchResult searchResult;

        Test.startTest();
        try {
            auraResult = OMDbSearchController.searchMovie('Batman');
            searchResult = (OMDbSearchResult) JSON.deserialize((String) auraResult.result, OMDbSearchResult.class);
        } catch (Exception ex) {}
        Test.stopTest();

        System.assertEquals(true, auraResult.success);
        System.assertEquals('True',searchResult.Response);
    }

    @isTest
    private static void whenCallingApiWithInvalidApiKey_ShouldThrowAnException() {
        MocksQueue.add(OMDbFactoryMock.getFailResponseForUnauthorizedEndPoint());
        AuraActionResult auraResult;
        OMDbSearchResult searchResult;
        Test.startTest();
        try {
            auraResult = OMDbSearchController.searchMovie('Batman');
        } catch (Exception ex) {}
        Test.stopTest();

        System.assertEquals(false, auraResult.success);
        System.assertEquals('Unauthorized',auraResult.error);
    }

    @isTest
    private static void whenCallingApiForUnkownMovie_shouldReturnMovieNotFound() {
        MocksQueue.add(OMDbFactoryMock.getResponseOKForMovieNotFound());
        AuraActionResult auraResult;
        OMDbSearchResult searchResult;

        Test.startTest();
        try {
            auraResult = OMDbSearchController.searchMovie('non-existent movie');
            searchResult = (OMDbSearchResult) JSON.deserialize((String) auraResult.result, OMDbSearchResult.class);
        } catch (Exception ex) {}
        Test.stopTest();

        System.assertEquals(false, auraResult.success);
        System.assertEquals('Movie not found!', auraResult.error);
    }

    @isTest
    private static void whenCallingApiWithOmdbId_shouldReturnMovie() {
        MocksQueue.add(OMDbFactoryMock.getOKResponseForMovieById());
        AuraActionResult auraResult;
        OMDbMovie movie;

        Test.startTest();
        auraResult = OMDbSearchController.findMovieById('tt3896198');
        movie = (OMDbMovie) JSON.deserialize((String) auraResult.result, OMDbMovie.class);
        Test.stopTest();

        System.assertEquals(true, auraResult.success);
        System.assertEquals('Guardians of the Galaxy Vol. 2', movie.Title);
    }
}