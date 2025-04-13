import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_project/core/services/image_saver_service.dart';
import 'package:test_project/data/models/sticker_pack.dart';
import 'package:test_project/data/repositories/sticker_packs_repository.dart';

class StickersViewModel extends ChangeNotifier {
  final StickerPacksRepository _stickerPacksRepository =
      StickerPacksRepository();
  StreamSubscription? _stickerPacksSubscription;

  List<StickerPack> _stickerPacks = [];
  List<StickerPack> get stickerPacks => _stickerPacks;

  StickersViewModel() {
    _listenToStickerPacks();
  }

  @override
  void dispose() {
    _stickerPacksSubscription?.cancel();
    super.dispose();
  }

  void _listenToStickerPacks() {
    _stickerPacksSubscription =
        _stickerPacksRepository.getStickerPacksStream().listen((snapshot) {
      _stickerPacks =
          snapshot.docs.map((doc) => StickerPack.fromJson(doc)).toList();
      // копіюю відповідь три рази для тестування
      _stickerPacks = List.generate(3, (_) => stickerPacks).expand((e) => e).toList();
      notifyListeners();
    }, onError: (error) {
      log("Error fetching notes: $error");
    });
  }

  void onDownloadImageButtonPress(BuildContext context, String url) async {
    final result = await ImageSaverService.downloadImage(context, url);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result,style: const TextStyle(color: Colors.purpleAccent,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
    );
  }
}
