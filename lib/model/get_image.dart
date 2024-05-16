// import 'package:image_picker/image_picker.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class GetImage {
  Future pickImageAndScanQR(BuildContext context) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      final scanner = MobileScannerController();

      final barcodes = await scanner.analyzeImage(image.path);
      if (barcodes!.barcodes[0].displayValue != null) {
        return barcodes.barcodes[0].displayValue;
      } else {
        return "No QR Code found";
      }
    }
  }
}
