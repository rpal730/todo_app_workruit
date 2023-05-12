class CustomException implements Exception {
  final String message, details;

  const CustomException({this.message = '', this.details = ''});

  @override
  String toString() => '$runtimeType: $message\n$details';
}
