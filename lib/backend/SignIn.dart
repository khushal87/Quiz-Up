import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;


  @override
  void initState(){
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 2500),vsync: this);
    animation =  CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future _signIn() async {
    GoogleSignInAccount gSI = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await gSI.authentication;

    _auth.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken).then((user){
      Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {

    double uni_height = MediaQuery.of(context).size.height;
    double uni_width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image(
          image: AssetImage('images/SignInBackGround/finalBack.gif'),
          fit: BoxFit.cover,
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: uni_height/2 - uni_height/3.2),
            ),
            Container(
              height: (animation.value*120),
              width: (animation.value*120),
              child: Image(
                image: AssetImage('images/appLogo.png'),
              ),
              ),
            Padding(padding: EdgeInsets.only(top: uni_height/16)),
            Text(
              "Alpas",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nexa',
                  fontSize: 50.0,
                  fontWeight: FontWeight.normal
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: uni_height/8),
              child: Center(
                child: Container(
                  width: uni_width/1.09,
                  height: uni_height/12.8,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 30.0,
                    onPressed: () => _signIn().catchError((e) => print(e)),
                    color: Color(0xFFFF000F),
                    child: Row(
                      children: <Widget>[
                        Image(
                            image: AssetImage('images/whitegooglelogo.png'),
                            height: uni_height/32,
                            width: uni_width/18
                        ),
                        Padding(padding: EdgeInsets.all(uni_width/14.4)),
                        Text(
                          'Sign In with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: uni_width/20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );  }
}

