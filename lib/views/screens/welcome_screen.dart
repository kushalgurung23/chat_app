import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/views/screens/login_screen.dart';
import 'package:chat_app/views/screens/registration_screen.dart';
import 'package:chat_app/views/button_components/rounded_rectangular_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  // Initial route's id should be "/" in order to follow good flutter practice.
  static const String id = "/";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // For custom animation, we have three things to consider in flutter:
  // 1. Ticker: Something that helps to count the time and tick the animation along.
  // 2. Animation Controller: It's like manager of animation that tells the animation when to start, end, loop back, forward, etc.
  // 3. Animation Value: 0 to 1 sec. This helps to perform animation like changing height, color, etc.
  // lazy keyword helps us to initialize the non-nullable data type later in the future, but should be initialized before compiling the application.
  late AnimationController animationController;
  late Animation tweanAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // this: Referencing to the object of the class within the class.
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // For background color
    tweanAnimation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);

    // For logo animation
    // logoAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    // tweanAnimation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     animationController.forward();
    //   }
    // });

    // proceeds the animation forward.
    animationController.forward();

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: tweanAnimation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logoTag',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                SizedBox(
                    child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: 'Festive',
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Flash Chat'),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                )),
              ],
            ),
            SizedBox(
              height: size.height / 6,
            ),
            RoundedRectangularButton(
                onPressed: () => Get.toNamed(LoginScreen.id),
                color: Colors.lightBlueAccent,
                buttonName: "Log in"),
            RoundedRectangularButton(
                onPressed: () => Get.toNamed(RegistrationScreen.id),
                color: Colors.blueAccent,
                buttonName: "Register"),
          ],
        ),
      ),
    );
  }
}
