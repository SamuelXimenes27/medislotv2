import 'package:medislot/main/composites/composites.dart';
import 'package:medislot/validation/validation.dart';

import '../../../builders/builders.dart';

Validation makeLoginValidation() => ValidationComposite(makeLoginValidations());

List<FieldValidation> makeLoginValidations() => [
      ...ValidationBuilder.field('email').required().email().build(),
      ...ValidationBuilder.field('password').required().min(6).build()
    ];
