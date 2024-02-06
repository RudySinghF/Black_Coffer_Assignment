import 'package:black_coffer/Home.dart';
import 'package:black_coffer/bottomnav.dart';
import 'package:black_coffer/firebase/Auth/authentication.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  Future<void> verifyOTP(String otp) async {
    var isVerified = await Authentication.instance.verifyOTP(otp);
    isVerified ? Get.offAll(() => const BottomNav()) : Get.back();
  }
}
