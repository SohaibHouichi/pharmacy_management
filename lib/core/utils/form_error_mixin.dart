import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/core.dart';import 'package:pharmacy_management/core/utils/validators.dart';

mixin FormErrorsMixin on GetxController {
  final formKey = GlobalKey<FormState>();
  final errorMessage = RxnString();
  final fieldErrors = <String, List<String>>{}.obs;
  final autovalidateMode = AutovalidateMode.disabled.obs;

  /// Server error for [field] takes priority, then the local [rules].
  Validator validator(String field, List<Validator> rules) => (value) {
    final serverError = fieldErrors[field]?.first;
    if (serverError != null) return serverError;
    return Validators.compose(rules)(value);
  };

  void clearFieldError(String field) => fieldErrors.remove(field);

  void clearErrors() {
    errorMessage.value = null;
    fieldErrors.clear();
  }

  bool validateForm() {
    clearErrors();
    autovalidateMode.value = AutovalidateMode.onUserInteraction;
    return formKey.currentState?.validate() ?? false;
  }

  void resetForm() {
    autovalidateMode.value = AutovalidateMode.disabled;
    clearErrors();
  }

  void handleFailure(Failure failure) {
    errorMessage.value = failure.message;
    if (failure is ValidationFailure) {
      fieldErrors.value = failure.errors ?? {};
      formKey.currentState?.validate();
    }
  }
}
