import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/responsive.dart';
import 'package:flutter_application_1/models/onboarding_model.dart';
import 'package:gap/gap.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //SAYFANIN CONTROLLERI
  PageController controller = PageController();

  //MODELİN HANGİ FOTOĞRAFLARI HANGİ BALKIĞI VE AÇIKLAMAYI ALACAĞINI BELİRLEMEK İÇİN LİSTE OLUŞTURDUK BU LİSTE İÇİNE MODELS DOSYASINDAKİ ONOARDİNG MODELDEN ALIYOR
  List<OnboardingModel> onbList = [
    OnboardingModel(
        'assets/images/onboarding1.png',
        'Connect: Bringing People Together',
        'Easy to use, powerful connections. A personal connection app that brings your friends, family, and loved ones together.'),
    OnboardingModel(
        'assets/images/onboarding2.png',
        'Share Memories: Personal Connections',
        'The easiest way to share memories. Connect with special individuals, build strong bonds.'),
  ];

  //İLK SAYFANIN HANGİSİ OLACAĞINI BELİRLEMEK İÇİN SAYISAL DEĞER
  int currentIndex = 0;

  Screen device = Screen.mobile;

  @override
  Widget build(BuildContext context) {
    //RESPONSİVE
    final screenSize = MediaQuery.of(context).size;

    setState(() {
      device = detectScreen(screenSize);
    });

    return Scaffold(
        body: PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      itemCount: onbList.length,
      onPageChanged: (value) {
        //BASTIĞIMDA DİĞER SAYFAYA GİTMESİN İÇİN
        setState(() {
          currentIndex = value;
        });
      },
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: screenSize.height * 0.1),
            SizedBox(
              height: screenSize.height * 0.35,
              //YUKARIDA OLUŞTURDUĞUMUZ LİSTENİN İÇİNDEN İMAGEI EKRANA YAZDIRDIK
              child: Image.asset(onbList[index].image),
            ),
            const Gap(30),
            SizedBox(
                height: screenSize.height * 0.11,
                width: screenSize.width * 0.9,
                //YUKARIDA OLUŞTURDUĞUMUZ LİSTENİN İÇİNDEN BAŞLIĞI EKRANA YAZDIRDIK

                child: Text(onbList[index].title,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    textAlign: TextAlign.center)),
            const Gap(20),
            SizedBox(
                height: screenSize.height * 0.06,
                width: screenSize.width * 0.9,
                //YUKARIDA OLUŞTURDUĞUMUZ LİSTENİN İÇİNDEN AÇIKLAMAYI EKRANA YAZDIRDIK

                child: Text(onbList[index].description,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.center)),
            const Gap(50),
            //BU KOD HANGİ SAYFADA OLDUĞUMUZU BELİRTEN BUTTONUN ÜSTÜNDEKİ ÇİZGİ
            SizedBox(
              height: screenSize.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onbList.length,
                  (index) {
                    return Container(
                      height: 5,
                      width: currentIndex == index ? 30 : 5,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            //BUTONUMUZ
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize:
                      Size(screenSize.width * 0.9, screenSize.height * 0.08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onPressed: () {
                //OLDUĞUMUZ SAYFA İLE LİSTEDEKİ SAYFA AYNI İSE YANİ SAYFALAR BİTTİYSE SON SAYFADA İSEK WELCOME SAYFASINA AT
                if (currentIndex == onbList.length - 1) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/welcome', (route) => false);
                }
                //ANİMASYONLU OLARAK BİR SONRAKİ SAYFAYA GEÇİŞ
                controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        );
      },
    ));
  }
}
