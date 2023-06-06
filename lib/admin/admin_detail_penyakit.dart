import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pakar_hati/models/model_pakar.dart';
import 'package:pakar_hati/theme/color.dart';

class AdminDetailPenyakit extends StatefulWidget {
  const AdminDetailPenyakit({super.key, this.penyakit, required this.id});
  final Penyakit? penyakit;
  final String? id;

  @override
  State<AdminDetailPenyakit> createState() => _AdminDetailPenyakitState();
}

class _AdminDetailPenyakitState extends State<AdminDetailPenyakit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: secondaryTextColor),
        title: const Text(
          "Detail Penyakit",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: secondaryTextColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: shadowColor,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Text(
                          widget.penyakit!.namaPenyakit,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    widget.penyakit!.deskripsi,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        color: secondaryTextColor),
                                  ),
                                )
                              ],
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                        child: Text(
                          'Solusi :',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    widget.penyakit!.solusi,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        color: secondaryTextColor),
                                  ),
                                )
                              ],
                            )),
                      ),
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
}
