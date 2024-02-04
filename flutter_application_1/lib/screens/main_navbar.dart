import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/responsive.dart';
import 'package:flutter_application_1/screens/communication_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  //UYGULAMA AÇILDIĞINDA HANGİ SAYFADA AÇILMASI GEREKTİĞİNİ BELİRLEMEK İÇİN SAYISAL DEĞER OLUŞTURDUK
  int _selectedIndex = 0;
  //BOTTOM NABİGATİON BAR'IN HANGİ SAYFALARDAN OLUŞACAĞINI BELİRLEDİK
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CommunicationScreen(),
    ProfileScreen(),
  ];

  //BASTIĞIM ZAMAN SEÇTİĞİM İNDEXE GİTMESİ İÇİN
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Screen device = Screen.mobile;

  @override
  Widget build(BuildContext context) {
    //RESPONSİVE OLMASI İÇİN
    final screenSize = MediaQuery.of(context).size;

    setState(() {
      device = detectScreen(screenSize);
    });
    return Scaffold(
      //BOTTOM NAV BARIN ÖZELLİKLERİ
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: GNav(
          onTabChange: (index) => _onItemTapped(index),
          tabMargin: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.02),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          color: Colors.grey.shade500,
          activeColor: Colors.blue,
          backgroundColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade200,
          selectedIndex: _selectedIndex,
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.contact_phone_outlined,
              text: 'Contact Us',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ]),
    );
  }
}
