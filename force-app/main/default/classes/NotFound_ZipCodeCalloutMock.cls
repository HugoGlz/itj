global class NotFound_ZipCodeCalloutMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        
        HTTPResponse response = new HTTPResponse();
        response.setBody('{}');
        response.setStatusCode(200);
        response.setStatus('OK');
        return response;
    }

}