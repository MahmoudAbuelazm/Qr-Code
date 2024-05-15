import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_elevated_button.dart';
import 'qr_saved_results.dart';

class QrModalBottomSheet extends StatelessWidget {
  const QrModalBottomSheet({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .9,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    'images/Group 11.png',
                    width: 41,
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              Text(
                "Scan OR code",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: height * 0.04),
              Text(
                "Place qr code inside the frame to scan please avoid shake to get results quickly",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffB9B9B9),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.04),
              Image.asset(
                'images/Group 12.png',
                width: width * 0.3,
              ),
              SizedBox(height: height * 0.04),
              Text(
                "Scanning Code...",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(.55),
                ),
              ),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.photo_library,
                    color: Colors.black.withOpacity(.55),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'images/Group 13.png',
                    width: 20,
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.flash_on,
                    color: Colors.black.withOpacity(.55),
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) =>
                          QrSavedResults(height: height, width: width));
                },
                text: 'Place Camera Code',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
