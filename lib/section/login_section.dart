import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_textfield.dart';
import 'qr_modal_bottom_sheet.dart';

class LoginSection extends StatelessWidget {
  LoginSection({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const CustomTextField(
              hintText: 'Enter your Phone',
              passowrd: false,
            ),
            SizedBox(height: height * 0.02),
            const CustomTextField(
              hintText: 'Password',
              passowrd: true,
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forget Password?',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff757575),
                      ),
                    ))
              ],
            ),
            SizedBox(height: height * 0.02),
            CustomElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return QrModalBottomSheet(height: height, width: width);
                      });
                }
              },
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
