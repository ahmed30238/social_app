import 'dart:convert';
import 'dart:io';

extension FileExtension on File {
  Future<String> convertToBase64() async {
    String base64Image = "";
    var bytes = await readAsBytes();
    base64Image = base64Encode(bytes);
    return base64Image;
  }
}

extension ListedFileExtension on List<File> {
  Future<List<String>> getBase64Images() async {
    List<String> base64Image = [];
    for (int i = 0; i < length; i++) {
      var base64 = await this[i].convertToBase64();
      base64Image.add(base64);
    }
    return base64Image;
  }
}
