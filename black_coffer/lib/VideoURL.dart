import 'package:firebase_storage/firebase_storage.dart';

Future<String> getVideoUrl(String path) async {
  final Reference ref = FirebaseStorage.instance.ref().child('videos/${path}');
  return await ref.getDownloadURL();
}
