import 'dart:ffi';
import 'dart:io';

import 'package:black_coffer/bottomnav.dart';
import 'package:black_coffer/firebase/Controller/Vid_Details.dart';
import 'package:black_coffer/firebase/Models/Usermodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:random_string/random_string.dart';

class VideoUploadPage extends StatefulWidget {
  final String filePath;
  final LatLng latLng;

  const VideoUploadPage(
      {Key? key, required this.filePath, required this.latLng})
      : super(key: key);

  @override
  State<VideoUploadPage> createState() => _VideoUploadPageState();
}

String? videoFilePath;
final _formkey = GlobalKey<FormState>();
final controller = Get.put(VideoDetailscontroller());
String videoId = randomAlphaNumeric(20);

class _VideoUploadPageState extends State<VideoUploadPage> {
  String pickVideo() {
    String path = widget.filePath;
    return path;
  }

  void pickAndUploadVideo() async {
    videoFilePath = pickVideo();
    if (videoFilePath != null) {
      await uploadVideoToFirebase(videoFilePath!);
    }
  }

  Future<void> uploadVideoToFirebase(String filePath) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('videos/${videoId}.mp4');

    UploadTask uploadTask = storageReference.putFile(File(filePath));

    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => Get.to(BottomNav()));

    if (taskSnapshot.state == TaskState.success) {
      Get.snackbar("Success", "Video uploaded to Firebase Storage",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 130, 216, 133).withOpacity(0.1),
          colorText: Color.fromARGB(255, 22, 141, 26));
      String downloadURL = await storageReference.getDownloadURL();
      print("Download URL: $downloadURL");
    } else {
      Get.snackbar("Error", "Error uploading video to Firebase Storage",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 244, 121, 113).withOpacity(0.1),
          colorText: Color.fromARGB(255, 164, 23, 23));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height * 0.450,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 0.1,
                        blurRadius: 1)
                  ]),
              child: Column(
                children: [
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ],
                            ),
                            height: 50,
                            width: 265,
                            child: TextFormField(
                              controller: controller.thumbnail,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  border: InputBorder.none,
                                  hintText: 'Video Thumbnail (URL)',
                                  hintStyle: TextStyle(
                                      color: Colors.black38,
                                      fontFamily:
                                          GoogleFonts.rubik().fontFamily,
                                      fontSize: 15)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ],
                            ),
                            height: 50,
                            width: 265,
                            child: TextFormField(
                              controller: controller.title,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  hintText: 'Title',
                                  hintStyle: TextStyle(
                                      color: Colors.black38,
                                      fontFamily:
                                          GoogleFonts.rubik().fontFamily,
                                      fontSize: 15)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ],
                            ),
                            height: 50,
                            width: 265,
                            child: TextFormField(
                              controller: controller.name,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                      color: Colors.black38,
                                      fontFamily:
                                          GoogleFonts.rubik().fontFamily,
                                      fontSize: 15)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ],
                            ),
                            height: 50,
                            width: 265,
                            child: TextFormField(
                              controller: controller.desc,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  hintText: 'Description',
                                  hintStyle: TextStyle(
                                      color: Colors.black38,
                                      fontFamily:
                                          GoogleFonts.rubik().fontFamily,
                                      fontSize: 15)),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 45,
                  width: 120,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 3),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Map<String, dynamic> user = {
                              "Name": controller.name.text,
                              "Thumbnail": controller.thumbnail.text,
                              "Title": controller.title.text,
                              "Description": controller.desc.text,
                              "Video": "${videoId}.mp4",
                              "Latitude": widget.latLng.latitude.toString(),
                              "Longitude": widget.latLng.longitude.toString(),
                            };

                            VideoDetailscontroller.instance.setdata(user);
                          }
                          pickAndUploadVideo();
                        },
                        // => movetohome(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Upload",
                                style: TextStyle(
                                    fontFamily: GoogleFonts.rubik().fontFamily,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
