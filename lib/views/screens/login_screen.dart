import 'package:chat_app/controllers/login_controller.dart';
import 'package:chat_app/views/button_components/rounded_rectangular_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/login_screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;

  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logoTag',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email address')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              const SizedBox(
                height: 24.0,
              ),
              Obx(() => loginController.showSpinner.isFalse
                  ? RoundedRectangularButton(
                      onPressed: () {
                        loginController.signInUser(
                            emailAddress: email, password: password);
                      },
                      color: Colors.lightBlueAccent,
                      buttonName: "Log In")
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
