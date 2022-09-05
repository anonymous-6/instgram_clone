// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/responsives/mobilescreenlayout.dart';
import 'package:instagram_clone/responsives/responsive_layout.dart';
import 'package:instagram_clone/responsives/webscreenlayout.dart';
import 'package:instagram_clone/screens/sign_up.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/textfield_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authmethod().logInUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'sucess') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobilescreenlayout: MobilescreenLayout(),
            webscreenlayout: WebscreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 1,
            ),
            //svg image,
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64.0,
            ),
            const SizedBox(height: 64.0),

            //text field input for email,
            TextFieldInput(
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(height: 24.0),

            //text field input for password,
            TextFieldInput(
              hintText: 'Enter your passowrd',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
            const SizedBox(height: 40.0),
            //button login,
            InkWell(
              onTap: logInUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: const ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(child: Container(), flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const Text("Don't have an account?"),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: navigateToSignUp,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const Text(
                      "Sign Up!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
            //transistion to signing in
          ],
        ),
      )),
    );
  }
}
