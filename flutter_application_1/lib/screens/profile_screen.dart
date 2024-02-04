import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //MAİL CONTROLLER OLUŞTURDUK
  final TextEditingController emailController = TextEditingController(text: "");

  //VERİTABANINA KAYDETTİĞİMİZ MAİLİ UYGULAMA AÇILINCA OKUMAK İÇİN
  readData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    var email = storeage.getString("email");

    setState(() {
      emailController.text = email ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    //BU SAYFA AÇILINCA VERİYİ GÖSTER
    readData();
  }

  //VERİTABANINA KAYDEDİLEN VERİYİ SİLMEK İÇİN. YANİ ÇIKIŞ YAPMAK İÇİN LOGOUT
  clearData() async {
    final SharedPreferences storeage = await SharedPreferences.getInstance();
    storeage.clear();
  }

  @override
  Widget build(BuildContext context) {
    //RESPONSİVE
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/200/300'), radius: 50),
              SizedBox(height: screenSize.height * 0.02),
              Text(
                //EĞER YENİ BİR KAYIT OLUŞTURUYORSA PROFİLDE O KISMIN MAİL ADRESİ YAZSIN EĞER SERVİSTEKİ KULLANICI İLE GİRİŞ YAPIYORSA ONU GÖSTERMESİ İÇİN SORGU
                emailController.text.isNotEmpty ? emailController.text : 'eve.holt@reqres.in',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: screenSize.height * 0.05),
              SizedBox(
                height: screenSize.height * 0.08,
                width: screenSize.width * 0.8,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  onPressed: () {
                    //LOGOUT TUŞUNA BASINCA VERİYİ SİLİP welcome SAYFASINA ATIYOR
                    clearData();
                    Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
