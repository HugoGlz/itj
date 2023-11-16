global class US_ZipCodeCalloutMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        
        HTTPResponse response = new HTTPResponse();
        response.setBody('{"post code": "89109", "country": "United States", "country abbreviation": "US", "places": [{"place name": "Las Vegas", "longitude": "-115.1454", "state": "Nevada", "state abbreviation": "NV", "latitude": "36.126"}]}');
        response.setStatusCode(200);
        response.setStatus('OK');
        return response;
    }

}