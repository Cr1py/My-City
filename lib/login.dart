import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './register.dart';
import './home.dart';
import './resetpass.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static bool _passwordVisible = false;
  static bool visible = false;
  static bool gvisible = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailidController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void initState() {
    super.initState();
    visible = false;
    gvisible = false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: Container(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 30.0),
                  ),

                  // Email Input
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 25.0),
                    child: Center(
                      child: Container(
                          width: 400,
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Image.asset('assets/logo-named.png')),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: TextFormField(
                      controller: _emailidController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black54),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                            color: Colors.black87,
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(100, 232, 236, 244),
                          labelStyle: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black54,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 1.5),
                          ),
                          labelText: 'Email')
                    ),
                  ),

                  // Password Input
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: Colors.black87,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              }),
                          filled: true,
                          fillColor: Color.fromARGB(100, 232, 236, 244),
                          labelStyle: GoogleFonts.workSans(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          hintStyle: GoogleFonts.workSans(
                            color: Colors.black54,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                            BorderSide(color: Colors.black, width: 1.5),
                          ),
                          labelText: 'Password')
                    ),
                  ),

                  //Forgot Pass
                  Container(
                    height: 30,
                    width: 300,
                    child: TextButton(
                      onPressed: () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ResetPass()));
                        });
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.workSans(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 15.0),
                  ),

                  // Login Button
                  Container(
                    height: 50,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 30, 35, 44),
                      borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_emailidController.text.contains('@')) {
                          displayToastMessage('Invalid Email-ID', context);
                        } else if (_passwordController.text.length < 8) {
                          displayToastMessage(
                              'Password should be a minimum of 8 characters',
                              context);
                        } else {
                          setState(() {
                            visible = load(visible);
                          });
                          login();
                        }
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.workSans(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visible,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Container(
                              width: 320,
                              margin: EdgeInsets.only(),
                              child: LinearProgressIndicator(
                                minHeight: 2,
                                backgroundColor: Colors.white60,
                                valueColor:
                                AlwaysStoppedAnimation(Colors.black)
                              )))),

                  // Google Sign In
                  Container(
                    height: 60,
                    width: 340,
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gvisible = load(gvisible);
                        });
                        googleSignIn(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Colors.black87,
                            width: 1
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/google.png"),
                              height: 30.0,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 40, right: 55),
                              child: Text(
                                'Sign in with Google',
                                style: GoogleFonts.workSans(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.0
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: gvisible,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Container(
                              width: 320,
                              margin: EdgeInsets.only(bottom: 20),
                              child: LinearProgressIndicator(
                                minHeight: 2,
                                backgroundColor: Colors.white70,
                                valueColor:
                                AlwaysStoppedAnimation(Colors.white),
                              )))),
                  Container(
                    height: 30,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Register()));
                      },
                      child: Text(
                        'New User? Create Account',
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                          color: Colors.black,
                        ),
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

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child("users");

  Future<void> login() async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        await auth.signInWithEmailAndPassword(
            email: _emailidController.text.trim(), password: _passwordController.text.trim());

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        });

      } catch (e) {
        setState(() {
          visible = load(visible);
        });
        displayToastMessage("", context);
      }
    }
  }

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User? currentuser =
          (await auth.signInWithCredential(credential)).user;
      if (currentuser != null) {
        dbRef.child(currentuser.uid);
        Map userDataMap = {
          'name': currentuser.displayName,
          'email': currentuser.email,
        };
        dbRef.child(currentuser.uid).set(userDataMap);

        _formKey.currentState!.save();

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        });
        displayToastMessage('Account Created', context);
      } else {
        setState(() {
          gvisible = load(gvisible);
        });
        displayToastMessage('Account has not been created', context);
      }
    } catch (e) {
      setState(() {
        gvisible = load(gvisible);
      });
      displayToastMessage("", context);
    }
  }

  bool load(visible) {
    return visible = !visible;
  }

  @override
  void dispose() {
    _emailidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}