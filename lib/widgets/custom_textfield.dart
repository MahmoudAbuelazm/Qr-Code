import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.passowrd,
    required this.controller,
  });

  final String hintText;
  final bool passowrd;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showpassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType:
          !widget.passowrd ? TextInputType.number : TextInputType.text,
      inputFormatters: !widget.passowrd
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ]
          : null,
      obscureText: widget.passowrd ? !showpassword : false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.black, width: 1.0)),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.grey,
        ),
        suffixIcon: widget.passowrd
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showpassword = !showpassword;
                  });
                },
                icon: Icon(
                    showpassword ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill the field';
        }
        return null;
      },
    );
  }
}
