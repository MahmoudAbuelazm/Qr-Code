import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:qr_code_ui/model/user_model.dart';
import 'package:qr_code_ui/screen/show_result_screen.dart';

import '../screen/qr_scan_screen.dart';
import '../widgets/custom_elevated_button.dart';

class QrSavedResults extends StatelessWidget {
  const QrSavedResults({
    super.key,
    required this.height,
    required this.width,
    required this.qrCode,
  });

  final double height;
  final double width;
  final String? qrCode;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: height * 0.02),
              Container(
                height: 5,
                width: width * 0.1,
                color: const Color(0xffD9D9D9),
              ),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'images/Group 14.png',
                    width: 41,
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              Text(
                "Scanning Result",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: height * 0.04),
              Text(
                "Proreader will Keep your last 10 days history  to keep your all scared history please purched our pro package",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffB9B9B9),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                height: height * 0.15,
                child: Card(
                  color: const Color(0xffF4F4F4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/Group 15.png',
                          width: 41,
                        ),
                        SizedBox(width: width * 0.02),
                        Expanded(
                          child: Text(
                            qrCode!,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(
                onPressed: () async {
                  var userbox = Hive.box<UserModel>('user');
                  await userbox.putAt(
                      0,
                      UserModel(
                          phone: userbox.getAt(0)!.phone,
                          password: userbox.getAt(0)!.password,
                          savedQrCodes: userbox.getAt(0)!.savedQrCodes
                            ..add(qrCode!)));
                  var getuser = Hive.box<UserModel>('user');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const ShowResultScreen();
                  }));
                  print(getuser.getAt(0)!.savedQrCodes);
                },
                text: 'Send',
              ),
              SizedBox(height: height * 0.1),
              CustomElevatedButton(
                onPressed: () async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const QRCodeScanner();
                  }));
                },
                text: 'Go Back To Scan',
              ),
              SizedBox(height: height * 0.1),
            ]),
          ),
        ));
  }
}
