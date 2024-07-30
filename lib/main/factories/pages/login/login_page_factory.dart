import 'package:flutter/material.dart';

import '../../../../ui/ui.dart';
import '../../factories.dart';

Widget makeLoginPage() => LoginPage(presenter: makeGetxLoginPresenter());
