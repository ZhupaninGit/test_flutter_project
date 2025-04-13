import 'package:cloud_firestore/cloud_firestore.dart';

class StickerPacksRepository {
  final CollectionReference _stickerPacks =
      FirebaseFirestore.instance.collection("sticker_pack");

  Stream<QuerySnapshot> getStickerPacksStream() {
    return _stickerPacks.snapshots();
  }


}