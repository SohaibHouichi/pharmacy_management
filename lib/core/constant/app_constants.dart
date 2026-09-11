abstract class AppConstants {
  // ─── App ────────────────────────────────────────────────
  static const String appName = 'Pharmacy Management';
  static const String appVersion = '1.0.0';
  static const String appBrand = 'PharmaSI';

  // ─── Navigation tabs ────────────────────────────────────
  static const String dashboardLabel = 'Dashboard';
  static const String medicinesLabel = 'Medicines';
  static const String salesLabel = 'Sales';
  static const String inventoryLabel = 'Inventory';

  // ─── Field labels ───────────────────────────────────────
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String nameLabel = 'Name of medicine';
  static const String priceLabel = 'Price';
  static const String quantityLabel = 'Quantity';
  static const String categoryLabel = 'Category';
  static const String expiryDateLabel = 'Expiry Date';

  // ─── Hints ──────────────────────────────────────────────
  static const String emailHint = 'you@example.com';
  static const String passwordHint = 'Enter your password';

  // ─── Buttons ────────────────────────────────────────────
  static const String loginButtonText = 'Log In';
  static const String logoutButtonText = 'Log Out';

  // ─── Auth ───────────────────────────────────────────────
  static const String loginPageSubtitle = 'Welcome back. Log in to continue.';

  // ─── Empty states ───────────────────────────────────────
  static const String emptyDashboard = 'No dashboard data available.';
  static const String emptyMedicinesMessage = 'No medicines found.';
  static const String emptySearchMessage = 'No medicines match your search.';
  static const String emptyCategoriesMessage = 'No categories available.';
  static const String emptySalesMessage = 'No sales recorded yet.';
  static const String emptyAlertsMessage = 'No inventory found.';
  static const String emptyLowStockMessage =
      'All medicines are sufficiently stocked.';

  // ─── Timing ─────────────────────────────────────────────
  static const Duration searchDebounce = Duration(seconds : 2);

  // ─── Pagination (API Guide: `page` / `per_page`, max 50) ─
  static const int defaultPageSize = 15;
  static const int maxPageSize = 50;

  // ─── Business rules ─────────────────────────────────────
  static const String cashPaymentMethod = 'cash';
  static const int expiringSoonDays = 30;
  static const int minPasswordLength = 6;

  // ─── Exception messages ─────────────────────────────────
  static const String unAuthorizedExceptionMessage =
      'Unauthorized access. Please login again.';
  static const String forbiddenExceptionMessage = 'Access forbidden.';
  static const String notFoundExceptionMessage = 'Resource not found.';
  static const String validationExceptionMessage =
      'Validation error occurred. Please check your input.';
  static const String serverExceptionMessage =
      'Server error occurred. Please try again later.';
  static const String networkExceptionMessage =
      'Network error occurred. Please check your connection.';
  static const String cacheExceptionMessage =
      'Cache error occurred. Please try again later.';
}