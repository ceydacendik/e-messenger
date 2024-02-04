import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/user_service.dart';
import 'package:flutter_application_1/widgets/textformfield.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //SERVİSİMİZİ KULLANMAK İÇİN BURADA TANIMLADIK
  final UserService _service = UserService();

  //VERİLERİ UYGULAMA KAPANIRSA VEYA YENİDEN BAŞLATILIRSA DİYE SAKLAMAK İÇİN SHAREDPREFERENCES KULLANDIK. LOCAL VERİTABANI
  storeData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    storeage.setString("Email", _emailController.text);
  }

  //KAYDETTİĞİMİZ VERİLERİ EKRANDA GÖSTERMEK İÇİN YAZILDI
  readData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    var mail = storeage.getString("Email");

    setState(() {
      _emailController.text = mail ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    //BU SAYFA AÇILDIĞINDA KAYDEDİLEN VERİLERİ EKRANDA GÖSTERMEK İÇİN
    readData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Expanded(
        child: Column(
          children: [
            Image.asset('assets/images/Vector1.png'),
            Text(
              'Hello',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 64),
            ),
            Text(
              'Sign in to your account',
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
            ),
            SizedBox(height: screenSize.height * 0.05),
            textFormField(
              labeltext: 'E-mail',
              icon: const Icon(Icons.mail),
              obsecureText: false,
              controller: _emailController,
            ),
            textFormField(
              icon: const Icon(Icons.person),
              labeltext: 'Password',
              obsecureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: screenSize.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Sign In',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(width: screenSize.width * 0.04),
                GestureDetector(
                  onTap: () async {
                    //WEB SERVİSE ATTIĞIMIZ İSTEK İLE GİRİLEN ŞİFRE EŞİT Mİ DEĞİL Mİ KONTROLU YAPILIYOR
                    if (_passwordController.text == 'pistol') {
                      //EŞİTSE GİRİŞ BAŞARILI OLUYOR VE VERİLER VERİTABANINA KAYIT EDİLİYOR
                      _service.login(_emailController.text,
                          _passwordController.text, context);
                      storeData();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login Success')));
                    } else {
                      //DEĞİLSE ŞİFRE HATALI
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Şifre hatalı')));
                    }
                  },
                  child: Image.asset('assets/images/nextbutton.png'),
                ),
                SizedBox(width: screenSize.width * 0.04),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/Vector2.png',
                        height: screenSize.height * 0.25),
                    const Text('Don’t have an account?'),
                    TextButton(
                      onPressed: () {
                        //REGİSTER SAYFASINA YÖNLENDİRİYORUZ
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/register', (route) => false);
                      },
                      child: const Text('Create'),
                    ),
                    SizedBox(width: screenSize.width * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
