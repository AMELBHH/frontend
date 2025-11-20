import 'package:flutter/material.dart';
import 'package:frontend/ChooseRoleScreen/onboarding_screen.dart';
import 'package:frontend/ClientHomeScreen/ClientHome.dart';
import 'package:frontend/InfluencerHomeScreen/InfluencerHome.dart';



import 'package:shared_preferences/shared_preferences.dart';



enum UserRole {
  influencer,  
  client, 
  platform   
}

class RoleService {
  static const String _roleKey = 'user_role';

  // حفظ الدور
  Future<void> saveRole(UserRole role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role.toString());
  }

  // قراءة الدور
  Future<UserRole?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    final roleString = prefs.getString(_roleKey);
    
    if (roleString == null) return null;
    
    return UserRole.values.firstWhere(
      (role) => role.toString() == roleString,
      orElse: () => UserRole.influencer,
    );
  }

  // حذف الدور (لتسجيل الخروج)
  Future<void> clearRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
    await prefs.setBool('onboarding_seen', false);
  }

  // التحقق من وجود دور محفوظ
  Future<bool> hasRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_roleKey);
  }
}







class RoleSelectionPage extends StatelessWidget {
  final RoleService roleService = RoleService();

  RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختر دورك'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'مرحباً بك!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'اختر دورك للمتابعة',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),
              
              _buildRoleCard(
                context,
                title: 'مؤثر',
                icon: Icons.person_outline,
                color: Colors.purple,
                role: UserRole.influencer,
              ),
              SizedBox(height: 16),
              
              _buildRoleCard(
                context,
                title: 'معلن',
                icon: Icons.business_outlined,
                color: Colors.blue,
                role: UserRole.client,
              ),
              // SizedBox(height: 16),
              
              // _buildRoleCard(
              //   context,
              //   title: 'منصة',
              //   icon: Icons.dashboard_outlined,
              //   color: Colors.orange,
              //   role: UserRole.platform,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required UserRole role,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () async {
  await roleService.saveRole(role);
  
  // تحقق إذا شاهد المستخدم Onboarding من قبل
  final prefs = await SharedPreferences.getInstance();
  final seen = prefs.getBool('onboarding_seen') ?? false;

  if (seen) {
    // إذا شاهد Onboarding سابقًا
    if (role == UserRole.influencer) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => Influencerhome()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ClientHome()));
    }
  } else {
    // أول مرة: اذهب لشاشة Onboarding
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => OnboardingScreen()));
  }
},

        // onTap: () async {
        //   await roleService.saveRole(role);
        //   Navigator.pushReplacementNamed(context, '/main');
        // },
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_back_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}















// class ChooseRoleScreen extends StatelessWidget {
//   const ChooseRoleScreen({super.key});

//   Future<void> saveRole(String role, BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('user_role', role);

//     // if (role == "influencer") {
//     //   Navigator.pushReplacement(
//     //     context,
//     //     MaterialPageRoute(builder: (_) => OnboardingScreen(role: "influencer")),
//     //   );
//     // } else {
//     //   Navigator.pushReplacement(
//     //     context,
//     //     MaterialPageRoute(builder: (_) => OnboardingScreen(role: "client")),
//     //   );
//     // }

//  if (role == 'influencer') {
//     context.go('/influencer');
//   } else {
//     context.go('/client');
//   }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFF5F7FA), Color(0xFFE4EBF5)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Positioned(
//               top: 150,
//               child: Opacity(
//                 opacity: 0.07,
//                 child: Image.asset(
//                   'assets/image/Screenshot 2025-06-21 175622 (1).png',
//                   width: 300,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),

//             Container(
//               width: 330,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(24),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('من أنت؟'),
//                   const SizedBox(height: 8),
//                   Text(
//                     'اختر نوع الحساب الذي يناسبك للمتابعة',
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 30),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                     ),
//                     // onPressed: () => saveRole('influencer' ,context),
//                     onPressed: () async {
//                       final prefs = await SharedPreferences.getInstance();
//                       await prefs.setString(
//                         'user_role',
//                         'influencer',
//                       ); // أو 'client'
//                       await prefs.setBool(
//                         'onboarding_seen',
//                         false,
//                       ); // Onboarding مازال ما شافهاش

//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => OnboardingScreen(role: 'influencer'),
//                         ),
//                       );
//                     },
                  
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text('انا مؤثر'),
//                         Icon(Icons.person, color: Colors.white),
//                       ],
//                     ),
//                   ),











//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.purple,
//                     ),
//                     onPressed: () => saveRole("client", context),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text('انا معلن'),
//                         Icon(Icons.person, color: Colors.white),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
