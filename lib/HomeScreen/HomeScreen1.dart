import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:weight_o_gram/Global/Colors/Gradient.dart';
import 'package:weight_o_gram/Global/Model/WeightList.dart';
import 'package:weight_o_gram/Global/Variables/GobalVariables.dart';
import 'package:weight_o_gram/Global/widgets/CustomButton.dart';
import 'package:weight_o_gram/Global/widgets/CustomTextField.dart';
import 'package:weight_o_gram/HomeScreen/HomeScreen2.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Size size;

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: size.width,
            height: 70,
            child: Container(
              decoration: BoxDecoration(
                  gradient: customGradient(),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Text("Weight O'gram",
                          style: TextStyle(
                            fontFamily: 'Goldman',
                            color: Colors.white,
                            fontSize: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? size.width * .07
                                : MediaQuery.of(context).size.height * .08,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? 30
                    : 90,
            vertical:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? 80
                    : 80,
          ),
          child: Form(
              key: _formKey,
              child: ListBody(
                children: [
                  CustomTextField.number(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter weight!';
                      }
                      return null;
                    },
                    hint: "Enter Weight",
                    fontSize: 22.0,
                    controller: _weightController,
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? 0
                        : 30,
                  ),
                  CustomButton.gradientBackground(
                      text: 'Submit',
                      fontSize: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.width * .05
                          : MediaQuery.of(context).size.height * .05,
                      height: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.width * .11
                          : MediaQuery.of(context).size.height * .10,
                      onTap: () {
                        if (_weightController.text == "") {
                          Fluttertoast.showToast(
                              msg: "Please enter details correctly");
                        } else {
                          _formKey.currentState.save();
                          userData = NewUser(
                            weight: _weightController.text,
                          );
                          FirebaseFirestore.instance
                              .collection("NewUser")
                              .doc()
                              .set({
                            'weight': userData.weight,
                            'time': DateFormat('dd/MM/yyyy    kk:mm')
                                .format(DateTime.now()),
                          });
                          setState(() {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen2.routeName);
                          });
                        }
                      }),
                ],
              )),
        )),
      ),
    );
  }
}
