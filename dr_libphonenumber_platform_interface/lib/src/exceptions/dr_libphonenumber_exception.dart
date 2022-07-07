part of libphonenumber_platform_interface;

class DrLibphonenumberException implements Exception {
  DrLibphonenumberException(this.message);

  final String message;

  @override
  String toString() => message;
}