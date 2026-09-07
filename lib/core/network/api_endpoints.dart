abstract class ApiEndpoints {
  // Base URL for the API
  static const String baseUrl = 'https://studiosie.store/sie-api/api/pharmacy';

  // authentication endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String currentUser = '/auth/me';

  // dashboard endpoint
  static const String dashboard = '/dashboard';

  // categories endpoint
  static const String categories = '/categories';

  // medicines endpoints
  static const String medicines = '/medicines';
  static String medicine(int id) {
    return '/medicines/$id';
  }

  // sales endpoints
  static const String sales = '/sales';
  static String sale(int id) {
    return '/sales/$id';
  }

  // inventory endpoints
  static const String inventoryAlerts = '/inventory/alerts';
  static const String inventoryStock = '/inventory/stock';
}