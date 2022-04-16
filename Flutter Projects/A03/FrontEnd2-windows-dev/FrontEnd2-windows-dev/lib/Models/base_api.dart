class BaseApi {
  static String base = "http://localhost:3000";
  static var api = base + '/api/v1';
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
}
