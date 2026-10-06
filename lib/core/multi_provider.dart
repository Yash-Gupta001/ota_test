import 'package:flutter/material.dart';
import 'package:ota_test/features/my_home_page/provider/my_home_page_provider.dart';
import 'package:ota_test/features/page_two/provider/page_two_provider.dart';
import 'package:provider/provider.dart';

class AppMultiProvider extends StatelessWidget {
  final Widget child;

  const AppMultiProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyHomePageProvider()),
        ChangeNotifierProvider(create: (_) => PageTwoProvider()),
      ],
      child: child,
    );
  }
}
