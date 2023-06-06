// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:pakar_hati/admin/admin_gejala.dart';
// import 'package:pakar_hati/models/model_pakar.dart';
// import 'package:pakar_hati/providers/firestore_service.dart';
// import 'package:pakar_hati/theme/color.dart';

// class GejalaHati extends StatefulWidget {
//   const GejalaHati({
//     super.key,
//     this.gejala,
//     this.id,
//   });

//   final Gejala? gejala;
//   final String? id;

//   @override
//   State<GejalaHati> createState() => _GejalaHatiState();
// }

// class _GejalaHatiState extends State<GejalaHati> {
//   final _formKey = GlobalKey<FormState>();
//   // late TextEditingController idController;
//   late TextEditingController namaController;
//   // late TextEditingController nilaiCfController;

//   @override
//   void initState() {
//     super.initState();
//     // idController = TextEditingController();
//     namaController = TextEditingController();
//     // nilaiCfController = TextEditingController();

// //untuk membaca data dari firebase
//     if (widget.gejala != null) {
//       namaController.text = widget.gejala!.namaGejala;
//       // nilaiCfController.text = widget.gejala!.nilaiCf;
//     }
//   }

//   @override
//   void dispose() {
//     // idController.dispose();
//     namaController.dispose();
//     // nilaiCfController.dispose();
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
//           'Tambah Gejala',
//           style: TextStyle(
//               fontFamily: 'Poppins', color: secondaryTextColor, fontSize: 22),
//         ),
//         elevation: 0,
//         actions: [
//           TextButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   if (widget.gejala != null) {
//                     await SistemPakar().editGejala(
//                         Gejala(
//                           namaGejala: namaController.text,
//                         ),
//                         widget.id!);
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: const Text(
//                           'Success !!',
//                           style: TextStyle(
//                             color: Colors.green,
//                           ),
//                         ),
//                         content: Text(
//                           'Gejala (${widget.gejala!.namaGejala}) berhasil diperbarui!',
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const AdminGejala(),
//                                 ),
//                               );
//                             },
//                             child: const Text('Oke'),
//                           )
//                         ],
//                       ),
//                     );
//                   } else {
//                     await SistemPakar().addGejala(
//                       Gejala(
//                         namaGejala: namaController.text,
//                       ),
//                     );
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: const Text(
//                           'Success !!',
//                           style: TextStyle(
//                             color: Colors.green,
//                           ),
//                         ),
//                         content:
//                             const Text('Gejala baru berhasil ditambahkan!'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const AdminGejala(),
//                                 ),
//                               );
//                             },
//                             child: const Text('Oke'),
//                           )
//                         ],
//                       ),
//                     );
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
//               TextFormField(
//                 controller: namaController,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: const InputDecoration(
//                   hintText: 'Contoh: Sakit Perut',
//                   label: Text('Masukan Nama Gejala'),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Nama gejala tidak boleh kosong';
//                   }
//                   return null;
//                 },
//               ),
//               // TextFormField(
//               //   controller: nilaiCfController,
//               //   keyboardType: TextInputType.multiline,
//               //   maxLines: null,
//               //   decoration: const InputDecoration(
//               //     hintText: 'Contoh: 0.2',
//               //     label: Text('Masukan Nilai CF Gejala'),
//               //   ),
//               //   validator: (value) {
//               //     if (value!.isEmpty) {
//               //       return 'Nilai CF gejala tidak boleh kosong';
//               //     }
//               //     if (double.tryParse(value) == null) {
//               //       return 'Nilai CF harus berupa angka 0-1';
//               //     }
//               //     return null;
//               //   },
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
