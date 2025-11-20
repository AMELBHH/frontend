import 'package:flutter/material.dart';
import 'package:frontend/ChooseRoleScreen/Choose_role_screen.dart';
import 'package:frontend/ClientHomeScreen/ListOfInfluencer.dart';

import 'package:frontend/core/styling/App_colors.dart';
import 'package:frontend/core/styling/App_text_style.dart';
import 'package:frontend/core/widget/CustomButtonWidget.dart';


class ClientHome extends StatelessWidget {
  final RoleService roleService = RoleService();
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await roleService.clearRole();
              Navigator.pushReplacementNamed(context, '/role-selection');
            },
          ),
        ],
          title: Text("DZ_PUB"),

          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home, color: AppColors.witheColor)),
              Tab(icon: Icon(Icons.person, color: AppColors.witheColor)),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBarView(
              children: [
                //home
                Home(),
                //profile
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {
           Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ListOfInfluencers()),
);

          },
          textButton: 'قائمة المؤثرين',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {
            //context.pushNamed(AppRoutes.listOfInfluencersByNiche);
          },
          textButton: 'قائمة المؤثرين حسب المجال',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {
            // context.pushNamed(AppRoutes.customPromotion);
          },
          textButton: 'ترويج حسب الطلب',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {},
          textButton: 'اشهاراتي',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {
            // context.pushNamed(AppRoutes.platformServices);
          },
          textButton: 'خدمات المنصة الاحترافية',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
      ],
    );
  }
}
