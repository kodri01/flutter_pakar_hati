import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/admin/admin_detail_penyakit.dart';
import 'package:pakar_hati/admin/admin_navbar.dart';
import 'package:pakar_hati/admin/admin_tambah_penyakit.dart';
import 'package:pakar_hati/admin/admin_tambah_penyakit_admin.dart';
import 'package:pakar_hati/models/model_pakar.dart';
import 'package:pakar_hati/theme/color.dart';

class AdminJenisPenyakit extends StatefulWidget {
  const AdminJenisPenyakit({super.key, this.penyakit});
  final Penyakit? penyakit;

  @override
  State<AdminJenisPenyakit> createState() => _AdminJenisPenyakitState();
}

class _AdminJenisPenyakitState extends State<AdminJenisPenyakit> {
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
                return const AdminNavBar();
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
        actions: [
          IconButton(
            icon: const Icon(FontAwesome.plus),
            tooltip: 'Tambah penyakit',
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) {
              //     return const TambahPenyakit();
              //     // return const PenyakitHati();
              //   },
              // ));
            },
          )
        ],
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
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              onPressed: (context) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                            'Peringatan!!',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                              'Anda yakin akan menghapus penyakit (${penyakit[index].namaPenyakit}) ??'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Batal'),
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await firestore
                                                    .collection('penyakit')
                                                    .doc(id)
                                                    .delete();
                                                Navigator.pop(context, 'Ya');
                                              },
                                              child: const Text('Ya'),
                                            ),
                                          ],
                                        ));
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: backgroundColor,
                              icon: BoxIcons.bxs_trash,
                              label: 'Delete',
                            ),
                            // SlidableAction(
                            //   onPressed: (context) {
                            //     Navigator.push(context, MaterialPageRoute(
                            //       builder: (context) {
                            //         return TambahPenyakit(
                            //           penyakit: penyakit[index],
                            //           id: id,
                            //         );
                            //       },
                            //     ));
                            //   },
                            //   backgroundColor: thirdColor,
                            //   foregroundColor: backgroundColor,
                            //   icon: BoxIcons.bxs_pencil,
                            //   label: 'Edit',
                            // ),
                          ],
                        ),
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
