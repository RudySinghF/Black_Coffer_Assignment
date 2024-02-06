import 'package:black_coffer/firebase/Auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class signupcontroller extends GetxController{
    static signupcontroller get instance => Get.find();
    final phone = TextEditingController();
    void phoneAuthentication(String phone) {
    Authentication.instance.phoneAuthentication(phone);
  }
  }