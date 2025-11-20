import 'package:flutter/material.dart';
import 'package:frontend/ChooseRoleScreen/Choose_role_screen.dart';

import 'package:frontend/ClientHomeScreen/ClientHome.dart';
import 'package:frontend/InfluencerHomeScreen/InfluencerHome.dart';

class MainRouter extends StatelessWidget {
  final RoleService roleService = RoleService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserRole?>(
      future: roleService.getRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final role = snapshot.data;

        if (role == null) {
          // إذا لم يكن هناك دور محفوظ، انتقل لصفحة الاختيار
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/role-selection');
          });
          return SizedBox();
        }

        // توجيه حسب الدور
        switch (role) {
          case UserRole.influencer:
            return Influencerhome();
          case UserRole.client:
            return ClientHome();
          case UserRole.platform:
            return Scaffold();
        }
      },
    );
  }
}
















// import 'package:frontend/ChooseRoleScreen/Choose_role_screen.dart';
// import 'package:frontend/ClientHomeScreen/Routing_client/router_genrator_client.dart';
// import 'package:frontend/InfluencerHomeScreen/InfluencerHome.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final router = GoRouter(
//   initialLocation: '/',
//   redirect: (context, state) async {
//     final prefs = await SharedPreferences.getInstance();
//     final role = prefs.getString('user_role');
//     if (role == 'influencer') return '/influencer';
//     if (role == 'client') return '/client';
//     return null; // يبقى في choose-role
//   },
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => ChooseRoleScreen()),
//     router_genrator_client,
//     GoRoute(path: '/influencer', builder: (context, state) => Influencerhome()),
//   ],
// );
