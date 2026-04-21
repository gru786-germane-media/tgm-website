import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:tgm/core/utils/app_router.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:tgm/modules/company/views/desktop_company.dart'
    deferred as desktopCompany;
import 'package:tgm/modules/home/views/desktop_home.dart'
    deferred as desktopHome;
import 'package:tgm/modules/mediaHub/views/desktop_media_hub.dart'
    deferred as desktopMediaHub;
import 'package:tgm/modules/monetization/views/desktop_monetization.dart'
    deferred as desktopMonetization;
import 'package:tgm/modules/solutions/views/desktop_solutions.dart'
    deferred as desktopSolutions;

void main() {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance
      .ensureSemantics(); // Helps expose text to the browser

       if (kIsWeb) {
    MetaSEO().config();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _preloadChunks();
  }

  void _preloadChunks() async {
    // Wait for the initial UI to settle (e.g., 3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    // Background load the heavy chunks
    desktopHome.loadLibrary();
    desktopMonetization.loadLibrary();
    desktopSolutions.loadLibrary();
    desktopMediaHub.loadLibrary();
    desktopCompany.loadLibrary();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1728, 1117),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'TGM',
         
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff0f0f0f)),
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          routeInformationParser: appRouter.routeInformationParser,
          routerDelegate: appRouter.routerDelegate,
          routeInformationProvider: appRouter.routeInformationProvider,
        );
      },
    );
  }
}
