import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Usermodel {
  final String? id;
  final String name;
  final String thumbnail;
  final String title;
  final String desc;
  final String videoname;
  final String lat;
  final String lng;
  const Usermodel(
      {this.id,
      required this.name,
      required this.thumbnail,
      required this.desc,
      required this.title,
      required this.videoname,
      required this.lat,
      required this.lng});

  tojson() {
    return {
      "ID": id,
      "Name": name,
      "Thumbnail": thumbnail,
      "Title": title,
      "Description": desc,
      "Video": videoname,
      "Latitude": lat,
      "Longitude": lng
    };
  }

  factory Usermodel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentsnapshot) {
    final data = documentsnapshot.data()!;
    return Usermodel(
        id: documentsnapshot.id,
        name: data["Name"],
        thumbnail: data["Thumbnail"],
        title: data["Title"],
        desc: data["Description"],
        videoname: data["Video"],
        lat: data["Latitude"],
        lng: data["Longitude"]);
  }
}
