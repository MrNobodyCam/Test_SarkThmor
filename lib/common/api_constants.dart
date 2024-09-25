class APIEndPoint {
  static const String baseUrl = 'http://10.0.2.2:8989/api';
  static const String version = '/v1';
  static _ListAccommodation listAccommodation = _ListAccommodation();
}

class _ListAccommodation {
  final String listAccommodations = "/accommodations/";
}
