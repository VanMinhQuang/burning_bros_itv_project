class Service{
  static int serviceTimeOut = 60;


  Future<Map<String, String>> createHeaderAuthorization() async {
    var headersContentType = 'application/json';

    return {
      'Content-type': headersContentType,
    };
  }

  bool isResponseSuccess(int statusCode) {
    var result = false;
    if (statusCode == 200 ||
        statusCode == 201 ||
        statusCode == 202 ||
        statusCode == 203 ||
        statusCode == 204 ||
        statusCode == 205 ||
        statusCode == 206 ||
        statusCode == 207 ||
        statusCode == 208 ||
        statusCode == 226) result = true;
    return result;
  }

  bool isResponseErrorNetwork(int statusCode) {
    var result = false;
    if (statusCode == 500 ||
        statusCode == 404 ||
        statusCode == 301 ||
        statusCode == 302 ||
        statusCode == 303) result = true;
    return result;
  }

  static isHasJsonMessage(String message) {
    message = message.toLowerCase();
    return message.contains('message') || message.contains('messages');
  }

  dynamic responseBody(var response) {

    ///Status Response Success
    if (isResponseSuccess(response.statusCode)) {
      return response.body;
    }

    ///Status Response ErrorNetwork
    else if (isResponseErrorNetwork(response.statusCode)) {
      throw 'Network failed, error code: ${response.statusCode}';
    } else if (response.statusCode == 401){
      throw  'User relogin, error code: ${response.statusCode}';
    }else{
      throw 'Error happened, error code :  ${response.statusCode}';
    }

    ///Other Server Response mess
  }
}