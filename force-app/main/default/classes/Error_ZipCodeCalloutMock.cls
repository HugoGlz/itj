global class Error_ZipCodeCalloutMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        
        HTTPResponse response = new HTTPResponse();
        response.setStatusCode(401);
        response.setStatus('Bad Request');
        return response;
    }

}