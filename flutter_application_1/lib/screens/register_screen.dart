import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/responsive.dart';
import 'package:flutter_application_1/widgets/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //KAYIT OLACAĞIMIZ VERİLERİN CONTROLLERLARI
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController firstNameController =
      TextEditingController(text: "");
  final TextEditingController lastNameController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController confirmPasswordController =
      TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    //SAYFA AÇILINCA KAYDEDİLERN VERİYİ GÖSTER
    readData();
  }

  Screen device = Screen.mobile;

  //YENİ KAYIT OLUŞTURURKEN VERİLERİ VERİTABANINA KAYDETMEK İÇİN
  storeData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();

    storeage.setString("email", emailController.text);
    storeage.setString("firstName", firstNameController.text);
    storeage.setString("lastName", lastNameController.text);
    storeage.setString("password", passwordController.text);
    storeage.setString("passwordAgain", confirmPasswordController.text);

    //KAYIT BAŞARILIYSA MESAJ
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data Saved')));
  }

  //OLUŞTURULAN VERİYİ TEMİZLEMEK İÇİN
  clearData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    storeage.clear();
  }

  //KAYDEDİLEN VERİYİ OKUMAK İÇİN
  readData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    var email = storeage.getString("email");
    var firstName = storeage.getString("firstName");
    var lastName = storeage.getString("lastName");
    var password = storeage.getString("password");
    var passwordAgain = storeage.getString("passwordAgain");

    setState(() {
      emailController.text = email ?? '';
      firstNameController.text = firstName ?? '';
      lastNameController.text = lastName ?? '';
      passwordController.text = password ?? '';
      confirmPasswordController.text = passwordAgain ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    //RESPONSİVE
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      device = detectScreen(screenSize);
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Image.asset('assets/images/Vector1.png'),
          const Text(
            'Create account',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenSize.height * 0.05),
          textFormField(
            labeltext: 'E-mail',
            icon: const Icon(Icons.email),
            controller: emailController,
            obsecureText: false,
          ),
          textFormField(
            labeltext: 'First Name',
            icon: const Icon(Icons.person),
            controller: firstNameController,
            obsecureText: false,
          ),
          textFormField(
            labeltext: 'Last Name',
            icon: const Icon(Icons.person),
            controller: lastNameController,
            obsecureText: false,
          ),
          textFormField(
            labeltext: 'Password',
            icon: const Icon(Icons.password),
            controller: passwordController,
            obsecureText: true,
          ),
          textFormField(
            labeltext: 'Again Password',
            icon: const Icon(Icons.password),
            controller: confirmPasswordController,
            obsecureText: true,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/Vector2.png', height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Create',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(width: screenSize.width * 0.05),
                  GestureDetector(
                    onTap: () {
                      //VERİYİ VERİTABANINA KAYDETTİKTEN SONRA HOME PAGE
                      storeData();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/mainnavbar', (route) => false);
                    },
                    child: Image.asset('assets/images/nextbutton.png'),
                  ),
                  SizedBox(width: screenSize.width * 0.05),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
