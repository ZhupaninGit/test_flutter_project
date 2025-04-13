import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageSaverService {
  static Future<String> downloadImage(BuildContext context, String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));

      final dir = await getTemporaryDirectory();
      var filename = '${dir.path}/sticker.png';

      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final result = await FlutterFileDialog.saveFile(params: params);

      if(result == null){
        return "Стікер не збережено.";
      }

      return "Стікер успішно збережено!";
    } catch (e) {
      log(e.toString());
      return "Виникла невідома проблема, стікер не було збережено.";
    }
  }
}
