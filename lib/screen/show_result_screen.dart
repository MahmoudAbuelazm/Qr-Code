import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:qr_code_ui/model/user_model.dart';
import 'package:qr_code_ui/screen/login_screen.dart';
import 'package:qr_code_ui/widgets/custom_elevated_button.dart';

import '../widgets/view_cards.dart';
import 'qr_scan_screen.dart';

class ShowResultScreen extends StatelessWidget {
  const ShowResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var userbox = Hive.box<UserModel>('user');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: height * 0.06),
            Text(
              "Scanning Result",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: ViewUserCards(
                height: height,
                width: width,
                qrCode: userbox.getAt(0)!.savedQrCodes,
              ),
            ),
            SizedBox(height: height * 0.05),
            CustomElevatedButton(
                text: "Log out",
                onPressed: () {
                  userbox.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                }),
            SizedBox(height: height * 0.10),
            CustomElevatedButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const QRCodeScanner();
                }));
              },
              text: 'Go Back To Scan',
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
  }
}
