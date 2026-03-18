function fn() {
    var config = {
        baseUrl: 'https://restful-booker.herokuapp.com',
        contentType: 'application/json',
        token: ''
    };
    
    karate.log('Base URL:', config.baseUrl);
    return config;
}