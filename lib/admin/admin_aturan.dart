import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/admin/admin_navbar.dart';
import 'package:pakar_hati/admin/admin_tambah_aturan.dart';
import 'package:pakar_hati/models/model_pakar.dart';
import 'package:pakar_hati/theme/color.dart';

class AdminAturan extends StatefulWidget {
  const AdminAturan({super.key, this.aturan});
  final Aturan? aturan;

  @override
  State<AdminAturan> createState() => _AdminAturanState();
}

class _AdminAturanState extends State<AdminAturan> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final int nomor = 0;

  Future<DocumentSnapshot> getGejala(String gejalaId) async {
    return await FirebaseFirestore.instance
        .collection('gejala')
        .doc(gejalaId)
        .get();
  }

  Future<DocumentSnapshot> getPenyakit(String penyakitId) async {
    return await FirebaseFirestore.instance
        .collection('penyakit')
        .doc(penyakitId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const AdminNavBar();
                },
              ));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: backgroundColor,
          iconTheme: const IconThemeData(color: secondaryTextColor),
          title: const Text(
            "Aturan Sistem Pakar",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 22, color: secondaryTextColor),
          ),
          actions: [
            IconButton(
              icon: const Icon(FontAwesome.plus),
              tooltip: 'Tambah Aturan',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const TambahAturan();
                  },
                ));
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('aturan').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columnSpacing: 41,
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Nama Penyakit',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Nama Gejala',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Bobot',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
                rows:
                    List<DataRow>.generate(snapshot.data!.docs.length, (index) {
                  DocumentSnapshot aturan = snapshot.data!.docs[index];
                  return DataRow(cells: <DataCell>[
                    DataCell(
                      FutureBuilder(
                        future: getPenyakit(aturan['penyakitId']),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> futureSnapshot) {
                          if (futureSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading...');
                          }
                          DocumentSnapshot penyakit = futureSnapshot.data!;
                          return Text(penyakit['namaPenyakit']);
                        },
                      ),
                    ),
                    DataCell(
                      FutureBuilder(
                        future: getGejala(aturan['gejalaId']),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> futureSnapshot) {
                          if (futureSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading...');
                          }
                          DocumentSnapshot gejala = futureSnapshot.data!;
                          return Text(gejala['namaGejala']);
                        },
                      ),
                    ),
                    DataCell(
                      Text(
                        aturan['bobot'].toStringAsFixed(1),
                      ),
                    ),
                  ]);
                }),
              ),
            );
          },
        ));
  }
}
