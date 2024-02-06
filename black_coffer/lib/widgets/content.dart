import 'package:black_coffer/Player.dart';
import 'package:black_coffer/VideoURL.dart';
import 'package:black_coffer/firebase/Controller/Vid_Details.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class contentwidget extends StatefulWidget {
  const contentwidget({super.key});

  @override
  State<contentwidget> createState() => _contentwidgetState();
}

class _contentwidgetState extends State<contentwidget> {
  final show = Get.put(VideoDetailscontroller());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: show.getVideoData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return FutureBuilder(
                              future:
                                  getVideoUrl(snapshot.data![index].videoname),
                              builder: (context, snap) {
                                if (snap.connectionState ==
                                    ConnectionState.done) {
                                  if (snap.hasData) {
                                    print(snap.data!);
                                    return VideoPlayerScreen(
                                        videoUrl: snap.data!,
                                        title: snapshot.data![index].title,
                                        name: snapshot.data![index].name);
                                  } else if (snapshot.hasError) {
                                    return Scaffold(
                                      body: Center(
                                          child:
                                              Text(snapshot.error.toString())),
                                    );
                                  } else {
                                    return Center(
                                        child: Text("Something went wrong"));
                                  }
                                } else {
                                  return Scaffold(
                                    body: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                              },
                            );
                          }),
                        );
                      },
                      child: Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 10),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data![index].thumbnail),
                                      fit: BoxFit.cover)),
                              padding: EdgeInsets.all(1),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 30,
                              child: Text(snapshot.data![index].title,
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.rubik().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 17)),
                            ),
                            Container(
                              height: 20,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(snapshot.data![index].name,
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.rubik().fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 11)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("1M views",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.rubik().fontFamily,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 11,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("4 hours ago",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.rubik().fontFamily,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 11,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }));
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(
                child: Text("Something went wrong"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
