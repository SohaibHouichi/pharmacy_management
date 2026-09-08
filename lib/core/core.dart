/// Core utilities shared across every feature.
library;

// Constants
export 'constant/app_constants.dart';

// Domain primitives
export 'domain/expiry_status.dart';
export 'domain/paginated.dart';

// Error handling
export 'error/exceptions.dart';
export 'error/failure_handler.dart';
export 'error/failures.dart';
export 'error/guard.dart';

// Network
export 'network/api_endpoints.dart';
export 'network/api_response.dart';
export 'network/dio_exception_handler.dart';

// Services & storage
export 'services/session_service.dart';
export 'storage/storage_keys.dart';
export 'storage/storage_service.dart';

// Theme
export 'theme/app_colors.dart';
export 'theme/app_fonts.dart';
export 'theme/app_theme.dart';

// Utils
export 'utils/form_error_mixin.dart';
export 'utils/json_utils.dart';
export 'utils/validators.dart';