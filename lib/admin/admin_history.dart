import 'package:flutter/material.dart';

class AdminHistory extends StatefulWidget {
  const AdminHistory({super.key});

  @override
  State<AdminHistory> createState() => _AdminHistoryState();
}

class _AdminHistoryState extends State<AdminHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Halaman Admin History')),
    );
  }
}
