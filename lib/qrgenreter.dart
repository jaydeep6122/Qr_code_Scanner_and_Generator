import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class qrgenrate extends StatefulWidget {
  const qrgenrate({super.key});

  @override
  State<qrgenrate> createState() => _qrgenrateState();
}

class _qrgenrateState extends State<qrgenrate> {
  TextEditingController urlController = TextEditingController();
  var textdata = "";
  var qrresult = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textdata = "";
  }

  qrdata() async {
    try {
      final qrcodedata = await FlutterBarcodeScanner.scanBarcode(
          "black", "Cancle", true, ScanMode.QR);
      setState(() {
        qrresult = qrcodedata;
      });
    } on PlatformException {
      qrresult = "Error To Scan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Qr Code"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (textdata.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: QrImageView(
                  data: urlController.text,
                  size: 200,
                ),
              ),
            TextField(
              controller: urlController,
              decoration: InputDecoration(hintText: "Enter Data "),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    textdata = urlController.text.trim();
                  });
                },
                child: Text("Genrate QR Code")),
            if (qrresult.isNotEmpty) Text("$qrresult"),
            TextButton(onPressed: qrdata, child: const Text("Scan QR Code"))
          ],
        ),
      ),
    ));
  }
}
