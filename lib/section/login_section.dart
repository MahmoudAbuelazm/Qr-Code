import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../cubit/user_cubit.dart';
import '../model/user_model.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_textfield.dart';
import 'qr_modal_bottom_sheet.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: BlocProvider(
        create: (context) => UserCubit(),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) async {
            if (state is UserSuccess) {
              var userbox = Hive.box<UserModel>('user');
              await userbox.add(UserModel(
                  phone: phoneController.text,
                  password: passwordController.text,
                  savedQrCodes: []));
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return QrModalBottomSheet(height: height, width: width);
                  });
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Enter your Phone',
                    passowrd: false,
                    controller: phoneController,
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    hintText: 'Password',
                    passowrd: true,
                    controller: passwordController,
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<UserCubit>(context).login(UserModel(
                          phone: phoneController.text,
                          password: passwordController.text,
                          savedQrCodes: [],
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid Phone or Password')));
                      }
                    },
                    text: 'Login',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.clear();
    phoneController.clear();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
