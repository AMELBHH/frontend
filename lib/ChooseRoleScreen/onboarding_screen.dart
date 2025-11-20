



import 'package:flutter/material.dart';
import 'package:frontend/ChooseRoleScreen/Choose_role_screen.dart';
import 'package:frontend/ClientHomeScreen/ClientHome.dart';
import 'package:frontend/InfluencerHomeScreen/InfluencerHome.dart';
import 'package:frontend/core/styling/App_img.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final RoleService roleService = RoleService();
  UserRole? role;

  List<String> texts = [];
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    loadRoleAndContent();
  }

  Future<void> loadRoleAndContent() async {
    role = await roleService.getRole();

    if (role == UserRole.influencer) {
      texts = [
        "كسب المال من محتواك",
        "تواصل مع العلامات التجارية",
        "تابع عروضك بسهولة"
      ];
      images = [
        AppImg.first_nfluencer,
        AppImg.second_img,
        AppImg.third_img,
      ];
    } else if (role == UserRole.client) {
      texts = [
        "اكتشف أفضل المؤثرين لتسويق منتجك بسهولة وفي دقائق",
        "أرسل طلب إعلان وحدد التفاصيل والسعر الذي يناسبك",
        "شاهد منتجك يصل لجمهور واسع، ودع التأثير يبدأ"
      ];
      images = [
        AppImg.first_client,
        AppImg.second_img,
        AppImg.third_img,
      ];
    }

    setState(() {}); // لتحديث الشاشة بعد تحميل النصوص والصور
  }

  void nextPage() {
    if (_currentIndex < texts.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);

    if (role == UserRole.influencer) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Influencerhome()));
    } else if (role == UserRole.client) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ClientHome()));
    } else {
      // إذا لم يكن الدور معروف، ارجع لصفحة اختيار الدور
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => RoleSelectionPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (role == null) {
      // عرض مؤشر انتظار أثناء تحميل الدور
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: texts.length,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        images[i],
                        height: 300,
                      ),
                      SizedBox(height: 40),
                      Text(
                        texts[i],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: nextPage,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: Text(
                          _currentIndex == texts.length - 1
                              ? "ابدأ"
                              : "التالي",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}















// import 'package:flutter/material.dart';
// import 'package:frontend/ChooseRoleScreen/Choose_role_screen.dart';
// import 'package:frontend/core/styling/App_img.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:frontend/ClientHomeScreen/ClientHome.dart';
// import 'package:frontend/InfluencerHomeScreen/InfluencerHome.dart';

// class OnboardingScreen extends StatefulWidget {
//   //final String role; // influencer / client
  
//  // const OnboardingScreen({required this.role, super.key});

//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _controller = PageController();
//   int _currentIndex = 0;
// final RoleService roleService = RoleService();
//   late List<String> texts;
//   late List<String> images;
// late UserRole? role;
//   @override
//   void initState() {
//     super.initState();
//      initRole();
//     void initRole() async {
//   role = await roleService.getRole();

//   if (role == UserRole.influencer) {
//     texts = [
//       "كسب المال من محتواك",
//       "تواصل مع العلامات التجارية",
//       "تابع عروضك بسهولة"
//     ];
//     images = [
//       AppImg.first_nfluencer,
//       AppImg.second_img,
//       AppImg.third_img,
//     ];
//   } else {
//     texts = [
//       '.اكتشف أفضل المؤثرين لتسويق منتجك بسهولة وفي دقائق',
//       '.أرسل طلب إعلان وحدد التفاصيل والسعر الذي يناسبك',
//       '.شاهد منتجك يصل لجمهور واسع، ودع التأثير يبدأ'
//     ];
//     images = [
//       AppImg.first_client,
//       AppImg.second_img,
//       AppImg.third_img,
//     ];
//   }
//   setState(() {}); // لتحديث الشاشة بعد تحميل البيانات
// }
// void completeOnboarding() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('onboarding_seen', true);

//   if (role == UserRole.influencer) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (_) => Influencerhome()));
//   } else {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (_) => ClientHome()));
//   }
// }

//   //   if (roleService.getRole =='influencer') {
//   //     texts = [
//   //       "كسب المال من محتواك",
//   //       "تواصل مع العلامات التجارية",
//   //       "تابع عروضك بسهولة"
//   //     ];
//   //     images = [
//   //     AppImg.first_nfluencer,
//   //      AppImg.second_img,
//   //       AppImg.third_img,
//   //     ];
//   //   } else if(roleService.getRole =='Client'){
//   //     texts = [
//   //       '.اكتشف أفضل المؤثرين لتسويق منتجك بسهولة وفي دقائق',
//   //      '.أرسل طلب إعلان وحدد التفاصيل والسعر الذي يناسبك',
//   //       '.شاهد منتجك يصل لجمهور واسع، ودع التأثير يبدأ'
//   //     ];
//   //     images = [
//   //        AppImg.first_client,
//   //     AppImg.second_img,
//   //       AppImg.third_img,
//   //     ];
//   //   }
//   // }

//   void nextPage() {
//     if (_currentIndex < texts.length - 1) {
//       _controller.nextPage(
//           duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//     } else {
//       completeOnboarding();
//     }
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               controller: _controller,
//               itemCount: texts.length,
//               onPageChanged: (i) => setState(() => _currentIndex = i),
//               itemBuilder: (_, i) {
//                 return Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // الصورة
//                       Image.asset(
//                         images[i],
//                         height: 300,
//                       ),
//                       SizedBox(height: 40),

//                       // النص
//                       Text(
//                         texts[i],
//                         style: TextStyle(
//                             fontSize: 24, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 40),

//                       // زر التالي / ابدأ
//                       ElevatedButton(
//                         onPressed: nextPage,
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 50, vertical: 15),
//                         ),
//                         child: Text(
//                           _currentIndex == texts.length - 1
//                               ? "ابدأ"
//                               : "التالي",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
