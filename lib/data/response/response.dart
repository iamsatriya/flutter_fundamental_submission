class Response {
  final bool error;

  Response({required this.error});
}

class ResponseWithMessage extends Response {
  final String message;
  ResponseWithMessage({required super.error, required this.message});
}
