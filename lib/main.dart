import 'package:booksports/APIstuffs/apistuffs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'test.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports Rubbish',
      theme: ThemeData.dark(),
      home: Test(),
      initialBinding: BindingsBuilder(() async {
        await Firebase.initializeApp();
        return Get.lazyPut(() => APIStuffs());
      })));
}
