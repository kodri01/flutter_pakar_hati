import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/pages/beranda.dart';
import 'package:pakar_hati/pages/main.dart';
import 'package:pakar_hati/pages/navbar.dart';
import 'package:pakar_hati/providers/firestore_auth_service.dart';
import 'package:pakar_hati/providers/firestore_service.dart';
import 'package:pakar_hati/providers/helper_funtion.dart';
import 'package:pakar_hati/theme/color.dart';
import 'package:pakar_hati/theme/textfield_custom.dart';

import '../theme/widget.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.user});
  final User? user;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  FirestoreService authService = FirestoreService();
  bool _isLoading = false;
  bool _isObscure = true;
  String email = '';
  String password = '';
  String fullName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: secondaryTextColor),
        title: const Text(
          "Registrasi",
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 22, color: secondaryTextColor),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: thirdColor,
            ))
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    Container(
                      width: 250,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        'Buat akun Anda dengan mengisi form di bawah ini.',
                        style: TextStyle(fontFamily: 'Poppin', fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            style: const TextStyle(
                                color: secondaryTextColor,
                                decoration: TextDecoration.none),
                            decoration: textDecorationregist.copyWith(
                              labelText: 'Full Name',
                              hintText: 'Enter your full name',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: thirdColor,
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                fullName = val;
                              });
                            },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return "Full Name can't be empty";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: secondaryTextColor,
                                decoration: TextDecoration.none),
                            decoration: textDecorationregist.copyWith(
                              labelText: 'Email',
                              hintText: 'Enter your email address',
                              prefixIcon: const Icon(
                                Icons.email,
                                color: thirdColor,
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
                            obscureText: _isObscure,
                            style: const TextStyle(color: secondaryTextColor),
                            decoration: textDecorationregist.copyWith(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(
                                BoxIcons.bxs_user,
                                color: thirdColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: thirdColor,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            register();
                          },
                          child: Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              color: thirdColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: shadowColor,
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
                                  'Register',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: backgroundColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(
                                  color: secondaryTextColor, fontSize: 14),
                              children: [
                                TextSpan(
                                    text: "Login Now",
                                    style: const TextStyle(
                                        color: thirdColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Main(),
                                            ));
                                      })
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // register() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     final user = await FirebaseAuthService.signup(fullName, email, password);
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

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerWhitEmailPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFuntions.saveUserLoggedInStatus(true);
          await HelperFuntions.saveUserEmailSF(email);
          await HelperFuntions.saveUserNameSF(fullName);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavBar(),
              ));
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
