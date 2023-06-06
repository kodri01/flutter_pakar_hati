import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/admin/admin_navbar.dart';
import 'package:pakar_hati/pages/beranda.dart';
import 'package:pakar_hati/pages/navbar.dart';
import 'package:pakar_hati/pages/register.dart';
import 'package:pakar_hati/providers/database_service.dart';
import 'package:pakar_hati/providers/firestore_service.dart';
import 'package:pakar_hati/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pakar_hati/theme/widget.dart';
import '../providers/firestore_auth_service.dart';
import '../providers/helper_funtion.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  // DatabaseService snap = DatabaseService();
  FirestoreService authService = FirestoreService();
  bool _isObscure = true;
  bool _isLoading = false;
  String email = '';
  String password = '';
  String role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdColor,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 150, bottom: 100),
                child: Text(
                  ' Sistem Pakar Diagnosa Penyakit Hati',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: primaryTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: primaryTextColor,
                      style: const TextStyle(
                          color: backgroundColor,
                          decoration: TextDecoration.none),
                      decoration: textDecoration.copyWith(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: backgroundColor,
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter your valid email";
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: primaryTextColor,
                      obscureText: _isObscure,
                      style: const TextStyle(color: backgroundColor),
                      decoration: textDecoration.copyWith(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(
                          BoxIcons.bxs_user,
                          color: backgroundColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: backgroundColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (() {
                  login();
                }),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x33000000),
                        offset: Offset(0, 10),
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text.rich(
                TextSpan(
                    text: "Don't have an account? ",
                    style:
                        const TextStyle(color: backgroundColor, fontSize: 14),
                    children: [
                      TextSpan(
                          text: "Register here",
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: backgroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ));
                            })
                    ]),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '- Or Login with -',
                  style: TextStyle(
                      color: primaryTextColor, fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                // onTap: () async {
                //   await FirestoreService().loginwithgoogle();

                //   if (FirebaseAuth.instance.currentUser != null) {
                //     if (!mounted) return;
                //     Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const NavBar(),
                //         ));
                //   }
                // },
                onTap: () {
                  loginGoogle();
                },
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x33000000),
                        offset: Offset(0, 10),
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: () {
                              loginGoogle();
                              // await FirestoreService().loginwithgoogle();

                              // if (FirebaseAuth.instance.currentUser != null) {
                              //   if (!mounted) return;
                              //   Navigator.pushReplacement(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => const NavBar(),
                              //       ));
                              // } else {
                              //   showDialog(
                              //       context: context,
                              //       builder: (context) => AlertDialog(
                              //             title: Text(
                              //                 "Your username and password is incorrect"),
                              //             actions: [
                              //               ElevatedButton(
                              //                   onPressed: () {
                              //                     Navigator.pop(context);
                              //                   },
                              //                   child: Text("Oke"))
                              //             ],
                              //           ));
                              // }
                            },
                            icon: Logo(Logos.google)),
                      ),
                      const Text(
                        'Masuk menggunakan \nakun google',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // login() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     final user = await FirebaseAuthService.login(email, password);
  //     if (user != null) {
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const NavBar(),
  //           ));
  //     } else {
  //       showSnackbar(context, Colors.red, user);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWhitEmailPassword(email, password)
          .then((value) async {
        if (value == true) {
          DocumentSnapshot snap =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .getUser();
          await HelperFuntions.saveUserLoggedInStatus(value);

          if (snap['role'] == 'admin') {
            return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminNavBar(),
                ));
          } else {
            return Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NavBar(),
                ));
          }
          // QuerySnapshot snapshot =
          //     await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          //         .getUserData(email);

          // await HelperFuntions.saveUserLoggedInStatus(value);
          // await HelperFuntions.saveUserEmailSF(email);
          // await HelperFuntions.saveUserNameSF(snapshot.docs[0]['fullName']);
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  loginGoogle() async {
    await authService.loginwithGoogle();
    if (FirebaseAuth.instance.currentUser != null) {
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBar(),
          ));
    }
  }
}
