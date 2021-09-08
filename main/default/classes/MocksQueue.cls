public with sharing class MocksQueue {	

    // FIFO para los tests, para poder setear que mocks deben usarse
    private static List<Mock> mocks = new List<Mock>();

    public static void add(Mock mock){
        mocks.add(mock);
    }

    private static Mock next(){
        Mock m = mocks.remove(0);
    	System.debug(LoggingLevel.WARN, 'Removing Mock From Queue: ' + mocks.size());
        m.log();
        return m;
    }

    public static void setMock(){
	    Test.setMock(HttpCalloutMock.class, next());
	}
}