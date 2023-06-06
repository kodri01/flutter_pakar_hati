// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:pakar_hati/admin/admin_jenis_penyakit.dart';
// import 'package:pakar_hati/models/model_pakar.dart';
// import 'package:pakar_hati/providers/firestore_service.dart';
// import 'package:pakar_hati/theme/color.dart';

// class TambahPenyakit extends StatefulWidget {
//   const TambahPenyakit({
//     super.key,
//     this.penyakit,
//     this.id,
//   });

//   final Penyakit? penyakit;
//   final String? id;

//   @override
//   State<TambahPenyakit> createState() => _TambahPenyakitState();
// }

// class _TambahPenyakitState extends State<TambahPenyakit> {
//   final _formKey = GlobalKey<FormState>();
//   // late TextEditingController idController;
//   late TextEditingController namaController;
//   late TextEditingController deskripsiController;
//   late TextEditingController solusiController;

//   @override
//   void initState() {
//     super.initState();
//     // idController = TextEditingController();
//     namaController = TextEditingController();
//     deskripsiController = TextEditingController();
//     solusiController = TextEditingController();

// //untuk membaca data dari firebase
//     if (widget.penyakit != null) {
//       // idController.text = widget.penyakit!.id;
//       namaController.text = widget.penyakit!.namaPenyakit;
//       deskripsiController.text = widget.penyakit!.deskripsi;
//       solusiController.text = widget.penyakit!.solusi;
//     }
//   }

//   @override
//   void dispose() {
//     // idController.dispose();
//     namaController.dispose();
//     deskripsiController.dispose();
//     solusiController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         iconTheme: const IconThemeData(color: secondaryTextColor),
//         automaticallyImplyLeading: true,
//         title: const Text(
//           'Tambah penyakit',
//           style: TextStyle(
//               fontFamily: 'Poppins', color: secondaryTextColor, fontSize: 22),
//         ),
//         elevation: 0,
//         actions: [
//           TextButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   if (widget.penyakit != null) {
//                     await SistemPakar().editPenyakit(
//                         Penyakit(
//                             namaPenyakit: namaController.text,
//                             deskripsi: deskripsiController.text,
//                             solusi: solusiController.text),
//                         widget.id!);
//                     // await SistemPakar.addPenyakit(
//                     //   Penyakit(namaPenyakit: PenyakitController.text),
//                     //   widget.id!,
//                     // );
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) => AlertDialog(
//                               title: const Text('Success !!',
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                   )),
//                               content: Text(
//                                   'Penyakit (${widget.penyakit!.namaPenyakit}) berhasil diperbarui!'),
//                               actions: [
//                                 TextButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const AdminJenisPenyakit(),
//                                           ));
//                                     },
//                                     child: Text('Oke'))
//                               ],
//                             ));
//                   } else {
//                     await SistemPakar().addPenyakit(Penyakit(
//                         // id: idController.text,
//                         namaPenyakit: namaController.text,
//                         deskripsi: deskripsiController.text,
//                         solusi: solusiController.text));
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) => AlertDialog(
//                               title: const Text('Success !!',
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                   )),
//                               content: const Text(
//                                   'Penyakit baru berhasil ditambahkan!'),
//                               actions: [
//                                 TextButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const AdminJenisPenyakit(),
//                                           ));
//                                     },
//                                     child: const Text('Oke'))
//                               ],
//                             ));
//                   }
//                 }
//               },
//               child: const Icon(BoxIcons.bx_check)),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // TextFormField(
//               //   controller: idController,
//               //   keyboardType: TextInputType.multiline,
//               //   maxLines: null,
//               //   decoration: const InputDecoration(
//               //     hintText: 'Masukan ID Penyakit',
//               //     label: Text('Contoh: P001'),
//               //   ),
//               //   validator: (value) {
//               //     if (value!.isEmpty) {
//               //       return 'ID Penyakit tidak boleh kosong';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               TextFormField(
//                 controller: namaController,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: const InputDecoration(
//                   hintText: 'Contoh: Hepatitis A',
//                   label: Text('Masukan Nama Penyakit'),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Nama Penyakit tidak boleh kosong';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: deskripsiController,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: const InputDecoration(
//                   hintText: 'Deskripsi Penyakit',
//                   label: Text('Masukan Deskripsi Penyakit'),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Deskripsi Penyakit tidak boleh kosong';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: solusiController,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: const InputDecoration(
//                   hintText: 'Solusi Penyakit',
//                   label: Text('Masukan Solusi Penyakit'),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Solusi Penyakit tidak boleh kosong';
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
