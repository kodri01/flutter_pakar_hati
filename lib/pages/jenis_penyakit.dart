import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/admin/admin_beranda.dart';
import 'package:pakar_hati/admin/admin_detail_penyakit.dart';
import 'package:pakar_hati/admin/admin_navbar.dart';
import 'package:pakar_hati/admin/admin_tambah_penyakit.dart';
import 'package:pakar_hati/models/model_pakar.dart';
import 'package:pakar_hati/pages/navbar.dart';
import 'package:pakar_hati/providers/firestore_service.dart';
import 'package:pakar_hati/theme/color.dart';

class JenisPenyakit extends StatefulWidget {
  const JenisPenyakit({super.key, this.penyakit});
  final Penyakit? penyakit;

  @override
  State<JenisPenyakit> createState() => _JenisPenyakitState();
}

class _JenisPenyakitState extends State<JenisPenyakit> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const NavBar();
              },
            ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: secondaryTextColor),
        automaticallyImplyLeading: false,
        title: const Text(
          'Jenis Penyakit',
          style: TextStyle(
              fontFamily: 'Poppins', color: secondaryTextColor, fontSize: 22),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection('penyakit')
            .orderBy('namaPenyakit', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var penyakit = snapshot.data!.docs
                .map((penyakit) => Penyakit.fromFirestore(penyakit))
                .toList();

            return ListView.builder(
              itemCount: penyakit.length,
              itemBuilder: (context, index) {
                var id = snapshot.data!.docs[index].id;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Container(
                          width: 320,
                          height: 80,
                          decoration: BoxDecoration(
                            color: thirdColor,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                color: shadowColor,
                                offset: Offset(0, 5),
                              )
                            ],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AdminDetailPenyakit(
                                      penyakit: penyakit[index],
                                      id: id,
                                    );
                                  },
                                ));
                              },
                              leading: const Icon(
                                BoxIcons.bxs_heart,
                                color: primaryTextColor,
                                size: 60,
                              ),
                              title: Text(
                                penyakit[index].namaPenyakit,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: primaryTextColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: const Icon(
                                BoxIcons.bx_right_arrow,
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
