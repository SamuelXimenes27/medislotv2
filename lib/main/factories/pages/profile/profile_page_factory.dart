import 'package:flutter/material.dart';

import '../../../../ui/ui.dart';
import '../../factories.dart';

Widget makeProfilePage() => ProfilePage(presenter: makeProfilePresenterFactory());
