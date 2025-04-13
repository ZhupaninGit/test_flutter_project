import 'package:cloud_firestore/cloud_firestore.dart';

class StickerPack {
  final String id;
  final String name;
  final String author;
  final String bannerPhotoUrl;
  final List<String> stickersUrl;

  StickerPack(
      {required this.id,
      required this.name,
      required this.author,
      required this.bannerPhotoUrl,
      required this.stickersUrl});

  factory StickerPack.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StickerPack(
      id: doc.id,
      name: data['name'] as String,
      author: data['author'] as String,
      bannerPhotoUrl: data["bannerPhotoUrl"] as String,
      stickersUrl: List<String>.from(data['stickersUrl'] as List),
    );
  }


}
