import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/pages/about.dart';
import 'package:pakar_hati/pages/diagnosa.dart';
import 'package:pakar_hati/pages/diagnose.dart';
import 'package:pakar_hati/pages/page_gejala.dart';
import 'package:pakar_hati/pages/hati.dart';
import 'package:pakar_hati/pages/jenis_penyakit.dart';
import 'package:pakar_hati/providers/database_service.dart';
import 'package:pakar_hati/providers/firestore_service.dart';
import 'package:pakar_hati/theme/color.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  FirestoreService authService = FirestoreService();
  DatabaseService user = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Container(
                    width: 500,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          'https://st3.depositphotos.com/3926317/35985/v/600/depositphotos_359853970-stock-illustration-doctor-cartoon-character-thank-you.jpg',
                          width: 500,
                          height: 2000,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 60, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Sistem Pakar Diagnosa \nPenyakit Hati',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 80,
                          icon: const Icon(
                            BoxIcons.bxs_heart,
                            color: backgroundColor,
                            size: 70,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PageHati()));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tentang Hati',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 80,
                          icon: const Icon(
                            BoxIcons.bxs_brain,
                            color: backgroundColor,
                            size: 70,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const JenisPenyakit(),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Jenis Penyakit',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: thirdColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 80,
                          icon: const Icon(
                            BoxIcons.bxs_book_heart,
                            color: Color(0xFFF9F9F9),
                            size: 70,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PageGejala(),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Daftar Gejala',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 80,
                          icon: const Icon(
                            FontAwesome.stethoscope,
                            color: backgroundColor,
                            size: 70,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Diagnosa(),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Diagnosa',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: thirdColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 80,
                          icon: const Icon(
                            BoxIcons.bxs_help_circle,
                            color: backgroundColor,
                            size: 70,
                          ),
                          onPressed: () async {
                            // await Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const Diagnose(),
                            //     ));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Bantuan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 80,
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            BoxIcons.bxs_info_circle,
                            color: Color(0xFFF9F9F9),
                            size: 70,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Tentang(),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Tentang",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
