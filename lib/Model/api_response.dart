class APIResponse{
  dynamic data;
  bool error;
  String? errorMessage;
  dynamic statusCode;

  APIResponse({this.data, this.statusCode, this.errorMessage, this.error = false});
}