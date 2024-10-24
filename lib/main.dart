import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plug2go/db/app_db.dart';
import 'package:plug2go/di/injector.dart';
import 'package:plug2go/features/notifications/notification_page.dart';
import 'package:plug2go/features/notifications/provider/notification_provider.dart';
// import 'package:plug2go/firebase_options.dart';
import 'package:plug2go/localizations/supported_locales.dart';
import 'package:plug2go/style/custom_theme.dart';
import 'package:plug2go/utils/flutter_kronos_date_time.dart';
import 'package:provider/provider.dart';

late PermissionStatus permissionStatus;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51Pz3OiBROBZzk355fgFtwLHLs3r6s3G4jihxEwBKzWlJEwNlQhujbmht61931heILmdVU35U7fcNaWG65E04R7wV00HLrsbDVp';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  await Hive.initFlutter();
  Injector.initModules();
  if (!await FlutterKronosDateTime.instance().isInitialized()) {
    FlutterKronosDateTime.instance().initialize();
  }
  permissionStatus = await Permission.locationWhenInUse.status;
  await Injector.instance.isReady<AppDB>();
  unawaited(
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
  );
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<NotificationProvider>(
          create: (context) => NotificationProvider(Injector.instance()),
          lazy: false,
        ),
      ],
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          designSize: const Size(393, 852),
          builder: (_, child) => MaterialApp(
            title: 'Plug 2 Go',
            debugShowCheckedModeBanner: false,
            theme: CustomTheme().light,
            themeMode: ThemeMode.light,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: SupportedLocales.all,
            navigatorKey: rootNavKey,
            home: const NotificationPage(),
          ),
        ),
      ),
    );
  }
}
