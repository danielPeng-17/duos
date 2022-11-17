class ApiConstants {
  static String apiBaseUrl = 'http://10.0.2.2:3000';
  static Map<String, String> apiHeader(String token) => ({
    "content-type": "application/json",
    "authorization": 'Bearer $token',
  });
}