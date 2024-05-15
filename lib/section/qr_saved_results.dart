import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_elevated_button.dart';

class QrSavedResults extends StatelessWidget {
  const QrSavedResults({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
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
              SizedBox(height: height * 0.04),
              SizedBox(
                height: height * 0.5,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: const Color(0xffF4F4F4),
                        child: Row(
                          children: [
                            Image.asset(
                              'images/Group 15.png',
                              width: 41,
                            ),
                            SizedBox(width: width * 0.02),
                            Text(
                              "7E0918FF",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Send',
              ),
            ]),
          )),
    );
  }
}
