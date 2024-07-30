import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/ui.dart';
import '../../factories.dart';

Widget makePageFactory() => ClinicPage(presenter: makeClinicPresenterFactory(Get.parameters['clinic_id'] ?? ''));
