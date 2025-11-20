import 'package:flutter/material.dart';
import 'package:frontend/ChooseRoleScreen/Choose_role_screen.dart';

import 'package:frontend/Routing/router_genrator.dart';

import 'package:frontend/core/styling/theme_styles.dart';



import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final userRole = prefs.getString('user_role'); // influencer / client
  final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
  runApp(MyApp(initialRole: userRole , showOnboarding: !onboardingSeen));
}
class MyApp extends StatelessWidget {
  final String? initialRole;
  final bool showOnboarding;
  const MyApp({super.key, this.initialRole ,required this.showOnboarding});

  @override


  Widget build(BuildContext context) {
  

    return MaterialApp(
       initialRoute: '/main',
      title: 'PUP_DZ',
       theme: ThemeStyles.lightTheme,
       routes: {
        '/main': (context) => MainRouter(),
        '/role-selection': (context) => RoleSelectionPage(),
      },
    );
  }
}
