import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/admin/admin_aturan.dart';
import 'package:pakar_hati/admin/admin_gejala.dart';
import 'package:pakar_hati/admin/admin_hati.dart';
import 'package:pakar_hati/admin/admin_jenis_penyakit.dart';
import 'package:pakar_hati/admin/admin_knowladge.dart';
import 'package:pakar_hati/admin/admin_tambah_gejalaadmin.dart';
import 'package:pakar_hati/admin/admin_tambah_penyakit.dart';
import 'package:pakar_hati/admin/admin_tambah_penyakit_admin.dart';
import 'package:pakar_hati/pages/about.dart';
import 'package:pakar_hati/pages/main.dart';
import 'package:pakar_hati/providers/firestore_service.dart';
import 'package:pakar_hati/theme/color.dart';

class BerandaAdmin extends StatefulWidget {
  const BerandaAdmin({super.key});

  @override
  State<BerandaAdmin> createState() => _BerandaAdminState();
}

class _BerandaAdminState extends State<BerandaAdmin> {
  final String? profile = FirebaseAuth.instance.currentUser!.uid;
  FirestoreService authService = FirestoreService();

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
                            BoxIcons.bxs_brain,
                            color: backgroundColor,
                            size: 70,
                          ),
                          onPressed: () async {
                            // await Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const TambahPenyakit(),
                            //     ));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Penyakit Hati',
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
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 80,
                          icon: const Icon(
                            BoxIcons.bxs_book_heart,
                            color: backgroundColor,
                            size: 70,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddGejala(),
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
                            BoxIcons.bxs_notepad,
                            color: backgroundColor,
                            size: 70,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminAturan(),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Rules',
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
                            FontAwesome.user_doctor,
                            color: backgroundColor,
                            size: 70,
                          ),
                          onPressed: () async {
                            // await Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const GejalaScreen(),
                            //     ));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Certainty Factor',
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
                            color: backgroundColor,
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
