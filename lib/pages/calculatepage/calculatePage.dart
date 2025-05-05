import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konversiapp/bgWidget.dart';
import 'calculate.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final CalculateLogic _logic = CalculateLogic();
  String _hasil = "0";

  void _calculate() {
    setState(() {
      _hasil = _logic.calculate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'BinHex',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: '.SF Pro Text',
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kalkulator Operasi Bilangan Komputer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          fontFamily: '.SF Pro Text',
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text("Masukkan Basis Bilangan"),
                    const SizedBox(height: 20),
                    _inputBasis(),
                    const SizedBox(height: 20),
                    _sectionInputBasis(context),
                    const SizedBox(height: 20),
                    _kolomhasil(),
                    const SizedBox(height: 2.5),
                    _hitunghasil(context),
                    const SizedBox(height: 7.5),
                    _hitungreset(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputBasis() {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            icon: SizedBox.shrink(),
            isExpanded: true,
            value: _logic.basisBilangan,
            alignment: Alignment.center,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _logic.basisBilangan = newValue;
                });
              }
            },
            items:
                _logic.basisbilanganList.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _sectionInputBasis(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _inputField(_logic.bilangan1Controller, "0"),
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width / 3 - 80,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: SizedBox.shrink(),
                  isExpanded: true,
                  value: _logic.operasiBilangan,
                  items:
                      _logic.operasiBilanganList.map<DropdownMenuItem<String>>((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.center,
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _logic.operasiBilangan = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        _inputField(_logic.bilangan2Controller, "0"),
      ],
    );
  }

  Widget _inputField(TextEditingController controller, String hintText) {
    RegExp allowedChars;

    switch (_logic.basisBilangan) {
      case "Biner":
        allowedChars = RegExp(r'[0-1]');
        break;
      case "Oktal":
        allowedChars = RegExp(r'[0-7]');
        break;
      case "Desimal":
        allowedChars = RegExp(r'[0-9]');
        break;
      case "Hexadesimal":
        allowedChars = RegExp(r'[0-9a-fA-F]');
        break;
      default:
        allowedChars = RegExp(r'.*');
    }

    return Container(
      width: MediaQuery.of(context).size.width / 3 - 10,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        inputFormatters: [FilteringTextInputFormatter.allow(allowedChars)],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget _kolomhasil() {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          _hasil,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _hitunghasil(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(225.0, 50.0),
        elevation: 10,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        _showDetailDialogs(context, _logic);
      },
      child: const Text(
        "tampilkan detail",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
      ),
    );
  }

  // void _showDetailDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text(""),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: const [Text("")],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Tutup"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _hitungreset() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(225.0, 50.0),
            backgroundColor: const Color.fromARGB(255, 56, 163, 202),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            shadowColor: Colors.black,
          ),
          onPressed: _calculate,
          child: const Text(
            "Hitung",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _showDetailDialogs(BuildContext context, CalculateLogic logic) {
    String detailPerhitungan =
        logic.getDetail(); // Pastikan getDetail() ada di calculate.dart

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("details"),
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                detailPerhitungan,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }
}
