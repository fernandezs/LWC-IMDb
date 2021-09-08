public with sharing class AuraActionResult {
	@AuraEnabled
	public Boolean success {get;set;}
	@AuraEnabled
	public String error {get;set;}
	@AuraEnabled
	public Object result {get;set;}

	public AuraActionResult() {
		success = true;
	}

	public AuraActionResult(Exception e) {
		error = e.getMessage();
        success = false;
        System.debug(LoggingLevel.ERROR, e.getMessage());
		System.debug(LoggingLevel.ERROR, e.getStackTraceString());
	}
}