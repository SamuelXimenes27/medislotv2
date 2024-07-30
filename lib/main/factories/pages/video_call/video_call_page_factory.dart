import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/ui.dart';

Widget makeVideoCallPageFactory() => VideoCallPage(appointmentId: Get.parameters['appointment_id'] ?? '');
