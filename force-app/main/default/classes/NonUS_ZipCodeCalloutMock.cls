global class NonUS_ZipCodeCalloutMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        
        HTTPResponse response = new HTTPResponse();
        response.setBody('{"post code": "10379", "country": "Mexico", "country abbreviation": "MX", "places": [{"place name": "Vista Hermosa", "longitude": "-99.2413", "state": "Distrito Federal", "state abbreviation": "DIF", "latitude": "19.3206"}]}');
        response.setStatusCode(200);
        response.setStatus('OK');
        return response;
    }

}