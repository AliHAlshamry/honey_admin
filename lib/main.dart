import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'api/api_utils.dart';
import 'config/routes.dart';
import 'config/themes/app_theme.dart';
import 'utils/constants/app_colors.dart';
import 'utils/constants/app_strings.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Hive.initFlutter();
  await Hive.openBox(AppStrings.boxKey);
  ApiUtils().initializeDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: AppTheme().lightTheme,
      locale: const  Locale('ar'),
      initialRoute: '/',
      getPages: routes,
      builder: (context, child) {
        EasyLoading.instance
          ..dismissOnTap = false
          ..userInteractions = false
          ..backgroundColor = AppColors.yellow500Color
          ..progressColor = Colors.white
          ..textColor = Colors.white
          ..indicatorColor = Colors.white
          ..loadingStyle = EasyLoadingStyle.custom;
        var easyLoading = Directionality(textDirection : TextDirection.rtl, child: FlutterEasyLoading(child: child));
        return easyLoading;
      },
      //home: const MyHomePage(),
    );
  }
}