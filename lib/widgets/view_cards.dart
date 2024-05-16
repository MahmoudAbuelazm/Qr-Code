import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewUserCards extends StatelessWidget {
  const ViewUserCards({
    super.key,
    required this.height,
    required this.width,
    required this.qrCode,
  });

  final double height;
  final double width;
  final List<String?> qrCode;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      itemCount: qrCode.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: height * 0.1,
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
                        qrCode[index]!,
                        overflow: TextOverflow.ellipsis,
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
        );
      },
    );
  }
}
