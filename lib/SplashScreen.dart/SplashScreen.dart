
import 'package:flutter/material.dart';
import 'package:weight_o_gram/Global/Colors/Colors.dart';
import 'package:weight_o_gram/Global/Colors/Gradient.dart';
import 'package:weight_o_gram/SignInScreen/AnonymousSignIn.dart';

class SplashScreen extends StatefulWidget {
  static final String routeName = "/SplashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Size size;
  Animation animate;
  AnimationController animatecontrol;

  @override
  void initState() {
    super.initState();
    animatecontrol =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animate = Tween<double>(begin: 0.0, end: 1).animate(animatecontrol);
    animatecontrol.forward();
    landingScreen();
  }

  Future<void> landingScreen() async {
    await Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(AnonymousSignIn.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: customGradient(),
      ),
      height: double.maxFinite,
      width: double.maxFinite,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
              child: Column(
            children: [
              Expanded(
                flex: 7,
                child: AnimatedBuilder(
                  animation: animatecontrol,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, animate.value * size.height / 8),
                    child: Opacity(
                      opacity: animate.value,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Weight O'gram",
                                style: TextStyle(
                                  fontFamily: 'Goldman',
                                  color: Colors.white,
                                  fontSize: (MediaQuery.of(context)
                                              .orientation ==
                                          Orientation.portrait)
                                      ? size.width * .14
                                      : MediaQuery.of(context).size.height * .1,
                                ),
                              ),
                              SizedBox(
                                height: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? size.width * .1
                                    : MediaQuery.of(context).size.height * .05,
                              ),
                              Image(
                                  image: AssetImage(
                                      "assets/logo/Weight_o_gram_logo.png"),
                                  height: (MediaQuery.of(context).orientation ==
                                          Orientation.portrait)
                                      ? size.width * .30
                                      : MediaQuery.of(context).size.height *
                                          .2),
                              SizedBox(
                                height: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? size.width * .05
                                    : MediaQuery.of(context).size.height * .05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    backgroundColor: bgLightColor().withOpacity(0.125),
                    valueColor: AlwaysStoppedAnimation<Color>(bgLightColor()),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    animatecontrol.dispose();
    super.dispose();
  }
}
