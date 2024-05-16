import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../cubit/user_cubit.dart';
import '../model/get_image.dart';
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
  String imgQr = "";

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
      child: BlocProvider(
        create: (context) => UserCubit(),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is ScanFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            if (state is ScanSuccess && state.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ScanSuccess && state.loading == false) {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => QrSavedResults(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      qrCode: result?.code ?? imgQr));
            }
            return Scaffold(
              appBar: AppBar(title: const Text("QR Code")),
              body: Stack(
                children: [
                  // Camera View with Cutout
                  QRView(
                    key: qrKey,
                    onQRViewCreated: (QRViewController controller) {
                      this.controller = controller;
                      controller.scannedDataStream.listen((scanData) {
                        setState(() {
                          result = scanData;
                        });
                        controller.dispose();
                        if (result!.code != null) {
                          context.read<UserCubit>().scan(result!.code);
                        }
                      });
                    },
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
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                  )),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        GetImage image = GetImage();
                        imgQr = await image.pickImageAndScanQR(context);

                        context.read<UserCubit>().scan(imgQr);
                      },
                      child: const Icon(
                        Icons.image_outlined,
                        color: Colors.white,
                        size: 30,
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
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
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
