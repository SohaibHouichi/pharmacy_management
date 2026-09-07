import 'package:get/get_utils/src/get_utils/get_utils.dart';

typedef Validator = String? Function(String?);

class Validators {
  const Validators._();

  static Validator required([String label = 'This field']) =>
      (value) => (value ?? '').trim().isEmpty ? '$label is required' : null;

  static Validator email() => (value) {
    final input = (value ?? '').trim();
    if (input.isEmpty) return null;
    return GetUtils.isEmail(input) ? null : 'Enter a valid email address';
  };

  static Validator minLength(int min, [String label = 'This field']) =>
      (value) => (value ?? '').length < min
      ? '$label must be at least $min characters'
      : null;

  /// Runs rules in order, returning the first error.
  static Validator compose(List<Validator> rules) => (value) {
    for (final rule in rules) {
      final error = rule(value);
      if (error != null) return error;
    }
    return null;
  };
  static Validator positiveNumber([String label = 'This field']) => (value) {
    final input = (value ?? '').trim();
    // `required` already handles empty, so skip it here.
    if (input.isEmpty) return null;

    final parsed = double.tryParse(input);
    if (parsed == null) return '$label must be a number';
    if (parsed <= 0) return '$label must be greater than zero';
    return null;
  };

  static Validator wholeNumber([String label = 'This field']) => (value) {
    final input = (value ?? '').trim();
    if (input.isEmpty) return null;

    final parsed = int.tryParse(input);
    if (parsed == null) return '$label must be a whole number';
    if (parsed < 0) return '$label cannot be negative';
    return null;
  };
}
