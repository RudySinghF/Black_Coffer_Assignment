import 'dart:async';

import 'package:black_coffer/Home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final _formkey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  bool _load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryanimation) {
                return Home();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            )));
// 2. Future.delayed
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.270,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/FAI.png"),
          ),
          Center(
            child: Text("Grow Smarter",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontWeight: FontWeight.normal)),
          ),
          SizedBox(
            height: 20,
          ),
          if (_load)
            ...[]
          else ...[
            const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            )
          ]
        ],
      ),
    );
  }
}
