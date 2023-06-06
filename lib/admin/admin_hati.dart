import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pakar_hati/providers/firestore_service.dart';
import 'package:pakar_hati/theme/color.dart';

class AdminHati extends StatefulWidget {
  const AdminHati({super.key});

  @override
  State<AdminHati> createState() => _AdminHatiState();
}

class _AdminHatiState extends State<AdminHati> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: secondaryTextColor),
        automaticallyImplyLeading: true,
        title: const Text(
          'Tentang Hati',
          style: TextStyle(
              fontFamily: 'Poppins', color: secondaryTextColor, fontSize: 22),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 320,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      'https://rsudpariaman.sumbarprov.go.id/public/img/post/upload_20170314_140330.jpg',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            'HATI (LIVER)',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: secondaryTextColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            'DESCRIPTION',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: secondaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                              child: Text(
                                'Hati merupakan organ tubuh yang paling sering mengalami kerusakan apabila terkena toksik. Zat toksik yang masuk kedalam tubuh akan mengalami proses detoksefikasi (dinetralisasi) di dalam hati oleh fungsi hati. \n\nSenyawa racun ini akan diubah menjadi senyawa lain yang sifatnya tidak lagi beracun terhadap tubuh. Jika jumlah racun yang masuk kedalam tubuh relatif kecil atau sedikit fungsi detoksifikasi baik, dalam tubuh tidak akan terjadi gejala keracunan. \n\nNamun, apabila racun masuk ke hati dalam jumlah yang besar dapat menyebabkan kerusakan struktur mikroanatomi hati',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: secondaryTextColor,
                                  fontSize: 12,
                                ),
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
      ),
    );
  }
}
