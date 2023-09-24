

String generateDeepLink(String path, Map<String, String> queryParameters) {
    final Uri deepLink = Uri(
      scheme: 'example.com', // Replace with your own scheme (e.g., 'myapp')
      path: path,
      queryParameters: queryParameters,
    );
    return deepLink.toString();
  }