import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../section/qr_saved_results.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isFlashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      if (isFlashOn) {
        controller!.toggleFlash();
      }
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("QR Code")),
        body: Stack(
          children: [
            // Camera View with Cutout
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 0,
                cutOutSize: MediaQuery.of(context).size.width * 0.7,
              ),
            ),

            // White Container at the Top with Text
            Positioned(
              top: -1,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text("Place the QR code inside the box to scan",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                        )),
              ),
            ),

            // Text Below the Cutout
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              left: 0,
              right: 0,
              child: Center(
                child: Text("Scan",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                        )),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  _pickImageAndScanQR(context);
                },
                child: const Icon(
                  Icons.image_outlined,
                  size: 22,
                ),
              ),
            ),

            // Flash Toggle Button
            Positioned(
              bottom: 20,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  _toggleFlash();
                },
                child: Icon(
                  isFlashOn
                      ? Icons.flash_off_outlined
                      : Icons.flash_on_outlined,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageAndScanQR(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final qrCode = await _scanQRFromImage(pickedFile.path);

      if (qrCode != null) {
        result = qrCode;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No QR code found in the image')),
        );
      }
      // Do something with the QR code...
    }
  }

  _scanQRFromImage(String path) async {
    return QrImageView(
      data: path,
      version: QrVersions.auto,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.dispose();
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => QrSavedResults(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width));
      print(result!.code);
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => QRResultScreen(result!.code)));
    });
  }

  void _toggleFlash() {
    if (controller != null) {
      setState(() {
        isFlashOn = !isFlashOn;
      });
      controller!.toggleFlash();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
