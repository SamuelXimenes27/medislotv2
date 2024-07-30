import '../validation.dart';

abstract class Validation {
  ValidationError? validate({
    required String field,
    required Map input,
  });
}
