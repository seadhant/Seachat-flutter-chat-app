import 'package:flutter/material.dart';
import 'package:flutterchatapp/screens/login_screen.dart';
import 'package:flutterchatapp/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutterchatapp/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller  = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller,curve: Curves.decelerate);

    controller.forward();

//    animation.addStatusListener((status){
//      if (status == AnimationStatus.completed){controller.reverse(from: 1.0);}
//      else if (status == AnimationStatus.dismissed){controller.forward(from: 0.0);}
//    });

    controller.addListener((){
      setState(() {

      });
      print(controller.value);
    });

  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller.value*100,
                  ),
                ),
                Expanded(
                  child: TextLiquidFill(
                    waveDuration: Duration(seconds: 2),
                    waveColor: Colors.black,
                    boxBackgroundColor: Colors.white,
                    text:'Sea Chat',
                    textStyle: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
//            SizedBox(
//              height: 48.0,
//            ),
            RoundedButton(text: 'Log In',colour: Colors.lightBlueAccent,ontouch: () {
              Navigator.pushNamed(context, LoginScreen.id);
              //Go to login screen.
            },),
            RoundedButton(text: 'Register',colour: Colors.blueAccent,ontouch: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
              //Go to login screen.
            },),
          ],
        ),
      ),
    );
  }
}