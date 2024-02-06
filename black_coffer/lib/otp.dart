import 'package:black_coffer/firebase/Controller/otpcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _otpState();
}

var optcontroller = Get.put(OtpController());
var otpc;

class _otpState extends State<otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.270,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/Logo.png"),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.430,
                child: Column(children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text("Enter OTP",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.normal)),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    fillColor: Colors.white,
                    filled: true,
                    showFieldAsBox: true,
                    enabledBorderColor: Colors.black,
                    borderWidth: 1,
                    onSubmit: (value) {
                      otpc = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Did not get opt?, resend",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.normal)),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          OtpController.instance.verifyOTP(otpc);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          "Get started",
                          style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )),
                  )
                ]),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            alignment: Alignment.bottomRight,
            child: Text(
              "<-Back",
              style: TextStyle(
                fontFamily: GoogleFonts.rubik().fontFamily,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          )
        ],
      )),
    );
  }
}
