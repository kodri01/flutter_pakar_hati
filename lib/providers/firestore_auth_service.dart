import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FirebaseAuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static login(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static signup(String fullName, String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        await UserHelper.saveUser(user);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static loginwithgoogle() async {
    GoogleSignIn googlesignIn = GoogleSignIn();
    final acc = await googlesignIn.signIn();
    final auth = await acc!.authentication;
    final credential = await GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);

    final res = await _auth.signInWithCredential(credential);
    debugPrint(res.user?.displayName);
  }
  // Future loginwithgoogle() async {
  //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  //   AuthCredential myCredential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   UserCredential user =
  //       await FirebaseAuth.instance.signInWithCredential(myCredential);

  //   debugPrint(user.user?.displayName);
  // }
}

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveUser(User user) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    Map<String, dynamic> userData = {
      'name': user.displayName,
      'email': user.email,
      'last_login': user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      'created_at': user.metadata.creationTime!.millisecondsSinceEpoch,
      'role': 'user',
      'build_number': buildNumber,
    };

    final userRef = _db.collection('users').doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        'last_login': user.metadata.lastSignInTime!.millisecondsSinceEpoch,
        'build_number': buildNumber,
      });
    } else {
      await userRef.set(userData);
    }
    await _saveDevice(user);
  }

  static _saveDevice(User user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String? deviceId;
    Map<String, dynamic> deviceData;
    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.id;
      deviceData = {
        'os_version': deviceInfo.version.sdkInt.toString(),
        'platform': 'android',
        'model': deviceInfo.model,
        'device': deviceInfo.device
      };
    }
    if (Platform.isIOS) {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        'os_version': deviceInfo.systemVersion,
        'platform': 'ios',
        'model': deviceInfo.model,
        'device': deviceInfo.name
      };
    }

    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final deviceRef = _db
        .collection('users')
        .doc(user.uid)
        .collection('devices')
        .doc(deviceId);

    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        'update_at': nowMs,
        'uninstalled': false,
      });
    } else {
      await deviceRef.set({
        'created_at': nowMs,
        'update_at': nowMs,
        'uninstalled': false,
        'id': deviceId,
        // 'device_info': deviceData,
      });
    }
  }
}
