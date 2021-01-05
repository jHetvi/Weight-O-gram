import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weight_o_gram/Global/Colors/Colors.dart';
import 'package:weight_o_gram/Global/Colors/Gradient.dart';
import 'package:weight_o_gram/Global/Variables/GobalVariables.dart';
import 'package:weight_o_gram/HomeScreen/HomeScreen1.dart';
import 'package:weight_o_gram/SignInScreen/AnonymousSignIn.dart';

class HomeScreen2 extends StatefulWidget {
  static final String routeName = "/HomeScreen2";
  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

Size size;

class _HomeScreen2State extends State<HomeScreen2> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        CircularProgressIndicator();

        await FirebaseFirestore.instance.collection("NewUser").doc().get();
      } on PlatformException catch (e) {
        print("PlatformException when fetching other profile data. E = " +
            e.code +
            " - " +
            e.message);
        Navigator.of(context).pop();
        await Fluttertoast.showToast(msg: "Error");
        Navigator.of(context).pop();
      }
    });
  }

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
                margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: whiteColor(), size: 35.0),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeName);
                          });
                        }),
                    Expanded(
                      child: Center(
                        child: Text("Weight O'gram",
                            style: TextStyle(
                              fontFamily: 'Goldman',
                              color: Colors.white,
                              fontSize: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? size.width * .10
                                  : MediaQuery.of(context).size.height * .08,
                            ),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    IconButton(
                        icon:
                            Icon(Icons.logout, color: whiteColor(), size: 35.0),
                        onPressed: () {
                          setState(() {
                            _logOutFunction();
                          });
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("NewUser")
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length == 0)
                      return Text('NO DATA YET');
                    else
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        height: size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                leading: Text(
                                  "Wight: ",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                ),
                                subtitle: Text(
                                    snapshot.data.docs[index]
                                        .data()["time"]
                                        .toString(),
                                    style: new TextStyle(fontSize: 15.0)),
                                title: RichText(
                                    text: TextSpan(
                                  text: snapshot.data.docs[index]
                                      .data()["weight"]
                                      .toString(),
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: ' kg',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                trailing: Column(
                                  children: [
                                    // if (userData.newUserId == currentUser.uid)
                                    PopupMenuButton(
                                        onSelected: null,
                                        tooltip: 'Menu',
                                        icon: Icon(
                                          Icons.more_vert,
                                          size: 20,
                                        ),
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                  onTap: () => deleteItem(),
                                                  onPanCancel: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Expanded(
                                                          child: Text("Delete"))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                  onTap: () => editItem(),
                                                  onPanCancel: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Expanded(
                                                          child: Text("Edit")),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ])
                                  ],
                                ),
                              );
                            }),
                      );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteItem() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              "Are you sure you want to delete the post?",
              style: TextStyle(
                color: blackColor(),
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: bgLightColor(),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: bgDarkColor(),
                ),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('NewUser')
                      .doc(userData.newUserId)
                      .delete()
                      .whenComplete(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }

  editItem() {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController con = TextEditingController();
          return AlertDialog(
            content: TextField(
              controller: con,
              decoration: InputDecoration(
                hintText: "Edit your Weight",
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () async {
                    if (con.text != null) {
                      await FirebaseFirestore.instance
                          .collection('NewUser')
                          .doc(userData.newUserId)
                          .update({'weight': con.text}).whenComplete(() {
                        Navigator.of(context).pop();
                      });
                    } else {
                      Fluttertoast.showToast(msg: "Enter a valid text");
                    }
                  },
                  child: Text('Update')),
            ],
          );
        });
  }

  Future<void> _logOutFunction() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed(AnonymousSignIn.routeName);
    } on PlatformException catch (_) {
      Fluttertoast.showToast(
          msg: "Error occured while logout. \nPlease try once again");
    } catch (_) {
      Fluttertoast.showToast(
          msg: "Error occured while logout. \nPlease try after a while");
    }
  }
}
