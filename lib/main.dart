import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_test/core/multi_provider.dart';
import 'package:ota_test/features/my_home_page/view/my_home_page.dart';

void main() {
  runApp(const OtaApp());
}

class OtaApp extends StatelessWidget {
  const OtaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMultiProvider(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
