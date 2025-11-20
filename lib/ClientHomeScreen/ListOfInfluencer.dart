import 'package:flutter/material.dart';
import 'package:frontend/core/styling/App_colors.dart';
import 'package:frontend/core/styling/App_font.dart';
import 'package:frontend/core/styling/App_img.dart';
import 'package:frontend/core/styling/App_text_style.dart';
import 'package:frontend/core/widget/CustomButtonWidget.dart';

class ListOfInfluencers extends StatelessWidget {
  const ListOfInfluencers({super.key});

  @override
  Widget build(BuildContext context) {
     List<CardInfluencer> influencers = [
      CardInfluencer(
        title: 'Numidia Lezoul',
        tag: 'سفير المنصة لمجال الفن سنة 2024',
        mainAreas: 'الغناء, التمثيل, الموضة',
       
      ),
      CardInfluencer(
        title: 'Abderazak',
        tag: 'سفير المنصة لمجال الفن سنة 2024',
        mainAreas: 'الكوميديا, المحتوى الترفيهي',
     
      ),
      CardInfluencer(
        title: 'Sarah Beauty',
        mainAreas: 'المكياج, التجميل',
       
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المؤثرين'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: AppColors.witheColor),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(150),
        ),
        onPressed: () {},
        child: Icon(Icons.filter_alt_outlined, color: AppColors.premrayColor),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:ListView.builder(
          itemCount: influencers.length,
          itemBuilder: (context, index) {
            return CardOfInfuencer(
              influencer: influencers[index],
              details: () {
               
                print('فتح تفاصيل ${influencers[index].title}');
              },
            );
          },
        ),
      ),
    );
  }
}

class CardOfInfuencer extends StatelessWidget {
 
   final CardInfluencer influencer;
   final Function() details;
  const CardOfInfuencer({super.key, required this.influencer , required this.details});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
   
    return Card(
      color: Colors.purple[40],
      shadowColor: AppColors.premrayColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                
                
                 child: influencer.img != null && influencer.img!.isNotEmpty
      ? Image.network(
          influencer.img!,
          height: height * 0.11,
          width: height * 0.11,
          fit: BoxFit.cover,
        )
      : Image.asset(
          AppImg.photo_profile,
          height: height * 0.11,
          width: height * 0.11,
          fit: BoxFit.cover,
        ),
               ),
              Column(
                children: [
                  Text(
                    influencer.title,
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFont.mainFontName,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    influencer.tag ??''
                    // 'الاوسمة :سفير المنصة لمجال الفن سنة 2024'
                    ,
                    style: TextStyle(
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.mainFontName,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(influencer.mainAreas
                    // 'الغناء ,التمثيل ,الموضة'
                    ,
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.mainFontName,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 90),
            child: CustomButtonWidget(
              colorButton: AppColors.premrayColor,
              onPressd: details,
              textStyle: AppTextStyle.textStyle,
              textButton: 'تفاصيل',
              heigth: height * 0.03,

              radius: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 90),
            child: CustomButtonWidget(
              colorButton: AppColors.premrayColor,
              onPressd: (){},
              textStyle: AppTextStyle.textStyle,
              textButton: 'ابدء اشهارك الان',
              heigth: height * 0.03,
              width: width * 0.55,
              radius: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class CardInfluencer {
  final String title;
  final String? tag;
  final String mainAreas;
  final String? img;

  const CardInfluencer({
    required this.title,
    this.tag,
    required this.mainAreas,
    this.img,
 
  });
  
}
