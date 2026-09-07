abstract class AppConstants {
  static const String appName = 'Pharmacy Management';
  static const String appVersion = '1.0.0';
  static const String appBrand = 'MedCare Pharmacy';

  //login page
  static const String loginPageSubtitle = 'Welcome back. Log in to continue.';
  static const String emailLabel = 'Email';
  static const String emailHint = 'you@example.com';
  static const String passwordHint = 'Enter your password';
  static const String passwordLabel = 'Password';
  static const String loginButtonText = 'Log In';
  static const String logoutButtonText = 'Log Out';

  // Dashboard constants
  static const String emptyDashboard = 'No dashboard data available.';
  static const String dashboardLable = 'Dashboard';

  // medicines page
  static const String medicinesLable = 'Medicines';
  static const Duration searchDebounce = Duration(seconds: 2);
  static const String nameLabel = 'Name of medicine';
  static const String priceLabel = 'Price';
  static const String quantityLabel = 'Quantity';
  static const String emptyMedicinesMessage = 'No medicines found.';
  static const String emptySearchMessage = 'No medicines match your search.';
  static const String emptyLowStockMessage =
      'All medicines are sufficiently stocked.';
  static const String expiryDateLabel = 'Expiry Date';
  static const String categoryLabel = 'Category';

  static const String emptyAlertsMessage = 'No inventory alerts.';
  static const String emptyCategoriesMessage = 'No categories available.';
  static const String salesLable = 'Sales';
  static const String inventoryLable = 'Inventory';
  static const String emptySalesMessage = 'No sales recorded yet.';

  // Pagination defaults (see API Guide: `page` / `per_page`, per_page max 50)
  static const int defaultPageSize = 15;
  static const int maxPageSize = 50;

  // Exception messages
  static const String unAuthorizedExceptionMessage =
      'Unauthorized access. Please login again.';
  static const String validationExceptionMessage =
      'Validation error occurred. Please check your input.';
  static const String serverExceptionMessage =
      'Server error occurred. Please try again later.';
  static const String cacheExceptionMessage =
      'Cache error occurred. Please try again later.';
  static const String forbiddenExceptionMessage = 'Access forbidden.';
  static const String notFoundExceptionMessage = 'Resource not found.';
  static const String networkExceptionMessage =
      'Network error occurred. Please check your connection.';
}
