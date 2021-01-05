import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_o_gram/Global/Colors/Colors.dart';
import 'package:weight_o_gram/Global/Colors/Gradient.dart';
import 'package:weight_o_gram/Global/widgets/CustomButton.dart';
import 'package:weight_o_gram/Global/widgets/errorDilouge.dart';
import 'package:weight_o_gram/HomeScreen/HomeScreen1.dart';

class AnonymousSignIn extends StatefulWidget {
  static final String routeName = "/AnonymousSignIn";
  @override
  _AnonymousSignInState createState() => _AnonymousSignInState();
}

class _AnonymousSignInState extends State<AnonymousSignIn> {
  Size size;

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (e) {
      print(e);
      Navigator.pop(context);
      DefaultErrorDialog.showErrorDialog(context: context, message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: customGradient(),
        ),
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "Weight O'gram",
                style: TextStyle(
                  fontFamily: 'Goldman',
                  color: Colors.white,
                  fontSize: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? size.width * .11
                      : MediaQuery.of(context).size.height * .1,
                ),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? MediaQuery.of(context).size.width * .50
                        : MediaQuery.of(context).size.height * .20,
                  ),
                  Container(
                    height: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? MediaQuery.of(context).size.width * .50
                        : MediaQuery.of(context).size.height * .45,
                    width: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? MediaQuery.of(context).size.width / 1.5
                        : MediaQuery.of(context).size.height * 0.80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 8,
                              blurRadius: 5)
                        ]),
                    child: Container(
                      decoration: BoxDecoration(
                          color: whiteColor(),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(50))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? 70
                                : 60),
                        child: CustomButton.gradientBackground(
                            text: 'Sign In',
                            fontSize: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? MediaQuery.of(context).size.width * .09
                                : MediaQuery.of(context).size.height * .09,
                            onTap: () {
                              _signInAnonymously();
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
