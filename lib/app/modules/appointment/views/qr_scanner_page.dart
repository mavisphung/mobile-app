import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:hi_doctor_v2/app/modules/meeting/views/raw_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'GlobalKey debugLabel: QR');

  final _isFlashed = false.obs;
  final _isFrontCamera = false.obs;
  final _isScan = false.obs;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Quét mã QR'),
      body: Stack(
        children: [
          Center(child: _buildQrView(context)),
          _toolbar(),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (Get.width < 400 || Get.height < 400) ? 150.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      if (result != null) {
        Get.toNamed(Routes.CHECK_IN, arguments: result!.code);
        result = null;
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      Get.back();
    }
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatusRawButton(
            onPressed: () async {
              await controller?.toggleFlash();
              _isFlashed.value = await controller?.getFlashStatus() ?? false;
            },
            rxBool: _isFlashed,
            iconDataOn: PhosphorIcons.flashlight_fill,
            iconDataOff: PhosphorIcons.flashlight_thin,
            fillColor: Colors.blueAccent,
          ),
          StatusRawButton(
            onPressed: () async {
              _isScan.value ? await controller?.pauseCamera() : await controller?.resumeCamera();
              _isScan.value = !_isScan.value;
            },
            rxBool: _isScan,
            iconDataOn: PhosphorIcons.barcode_fill,
            iconDataOff: PhosphorIcons.barcode_thin,
            size: 45,
            fillColor: Colors.blueAccent,
          ),
          StatusRawButton(
            onPressed: () async {
              await controller?.flipCamera();
              final cameraFacing = await controller?.getCameraInfo();
              if (cameraFacing != null) {
                _isFrontCamera.value = describeEnum(cameraFacing) == 'front' ? true : false;
              }
            },
            rxBool: _isFrontCamera,
            iconDataOn: PhosphorIcons.camera_rotate_fill,
            iconDataOff: PhosphorIcons.camera_rotate_thin,
            fillColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _isFlashed.close();
    _isFrontCamera.close();
    _isScan.close();
    controller?.dispose();
    super.dispose();
  }
}
