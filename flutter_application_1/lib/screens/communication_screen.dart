import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/url_launcher_button.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  @override
  Widget build(BuildContext context) {
    //RESPONSİVE OLMASI İÇİN
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contact Us',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              "assets/images/contact.png",
              height: screenSize.height * 0.4,
            ),
            const Text('Talk to our Team',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            SizedBox(height: screenSize.height * 0.02),
            //URL LAUNCHER KULLANARAK TELEFON NUMARASINA YÖNLENDİREN KOD
            UrlLauncherButton(
              title: 'Launch Phone Number',
              icon: Icons.phone,
              onPressed: () async {
                Uri uri = Uri.parse('tel:+905300000000');
                if (!await launcher.launchUrl(uri)) {
                  debugPrint("Could not launch the uri");
                }
              },
            ),
            //URL LAUNCHER KULLANARAK WEB SİTESİNE YÖNLENDİREN KOD
            UrlLauncherButton(
              title: 'Launch Website / URL',
              icon: Icons.language,
              onPressed: () {
                launcher.launchUrl(
                  Uri.parse('https://flutter.dev'),
                  mode: launcher.LaunchMode.externalApplication,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
