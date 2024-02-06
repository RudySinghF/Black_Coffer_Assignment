import 'package:black_coffer/firebase/Auth/authentication.dart';
import 'package:black_coffer/firebase/Models/Usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Database/Firebase_DB.dart';

class VideoDetailscontroller extends GetxController {
  static VideoDetailscontroller get instance => Get.find();
  final name = TextEditingController();
  final thumbnail = TextEditingController();
  final videoname = TextEditingController();
  final title = TextEditingController();
  final desc = TextEditingController();
  final userRepo = Get.put(UserRepository());

  Future<void> setdata(Map<String, dynamic> data) async {
    await userRepo.addUser(data);
  }

  Future<List<Usermodel>> getVideoData() async {
    return await userRepo.getdata();
  }
}
