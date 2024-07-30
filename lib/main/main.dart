import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medislot/main/factories/pages/clinic/clinic_page_factory.dart';
import 'package:medislot/main/factories/pages/history/history_page_factory.dart';
import 'package:medislot/main/factories/pages/home/home_page_factory.dart';
import 'package:medislot/main/factories/pages/login/login.dart';
import 'package:medislot/main/factories/pages/make_appointment/make_appointment_page_factory.dart';
import 'package:medislot/main/factories/pages/profile/profile.dart';
import 'package:medislot/main/factories/pages/splash/splash_page_factory.dart';
import 'package:medislot/ui/components/app_theme.dart';

import 'factories/pages/result_clinics/result_clinic_page_factory.dart';
import 'factories/pages/upcoming/upcoming_page_factory.dart';
import 'factories/pages/video_call/video_call_page_factory.dart';

void main() => runApp(const MedislotApp());

class MedislotApp extends StatelessWidget {
  const MedislotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final routeObserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());
    return GetMaterialApp(
      title: 'Medislot',
      theme: makeAppTheme(),
      navigatorObservers: [routeObserver],
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fadeIn),
        GetPage(name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(name: '/home', page: makeHomePage, transition: Transition.fadeIn),
        GetPage(name: '/clinic_search_result', page: makeResultClinicPageFactory, transition: Transition.fadeIn),
        GetPage(name: '/clinic/:clinic_id', page: makePageFactory, transition: Transition.fadeIn),
        GetPage(name: '/profile', page: makeProfilePage, transition: Transition.fadeIn),
        GetPage(name: '/history', page: makeHistoryPageFactory, transition: Transition.fadeIn),
        GetPage(name: '/upcoming', page: makeUpcomingPage, transition: Transition.fadeIn),
        GetPage(name: '/makeAppointment/:clinic_id', page: makeAppointmentPageFactory, transition: Transition.fadeIn),
        GetPage(name: '/videocall/:appointment_id', page: makeVideoCallPageFactory),
      ],
    );
  }
}
