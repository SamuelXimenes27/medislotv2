import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/ui.dart';
import '../../factories.dart';

Widget makeAppointmentPageFactory() =>
    MakeAppointmentPage(presenter: makeAppointmentPresenterFactory(Get.parameters['clinic_id'] ?? ''));
