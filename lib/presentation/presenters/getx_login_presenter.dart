import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../../validation/validation.dart';

class GetxLoginPresenter extends GetxController
    with LoadingManager, NavigationManager, FormManager, UIErrorManager
    implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount secureStorageClient;
  final GoToSignUpUsecase goToSignUpUsecase;
  final GoToForgotPasswordUsecase goToForgotPasswordUsecase;

  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);

  String? _email;
  String? _password;

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  GetxLoginPresenter({
    required this.validation,
    required this.authentication,
    required this.secureStorageClient,
    required this.goToSignUpUsecase,
    required this.goToForgotPasswordUsecase,
  });

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  @override
  Future<void> auth() async {
    try {
      mainError = null;
      isLoading = true;

      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final map = deviceInfo.toMap();

      log(map['model'].toString());
      log(AuthenticationParams(
              email: _email!, password: _password!, deviceName: map['model'])
          .toString());

      final account = await authentication.auth(
        AuthenticationParams(
            email: _email!, password: _password!, deviceName: map['model']),
      );

      log(account.token.toString());

      if (account.token ==
          '{"error":"The provided credentials are incorrect."}') {
        throw DomainError.invalidCredentials;
      } else {
        await secureStorageClient.save(account);

        navigateTo = '/home';
      }
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          mainError = UIError.invalidCredentials;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
      isLoading = false;
    }
  }

  UIError? _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
    };

    final error = validation.validate(field: field, input: formData);

    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    isFormValid = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  @override
  Future<void> goToSignUp() async {
    try {
      await goToSignUpUsecase();
    } catch (e) {
      mainError = UIError.unexpected;
    }
  }

  @override
  Future<void> goToForgotPassword() async {
    try {
      await goToForgotPasswordUsecase();
    } catch (e) {
      mainError = UIError.unexpected;
    }
  }
}
