import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konversiapp/bgWidget.dart';
import 'package:konversiapp/konversi.dart';

class Konvertpage extends StatefulWidget {
  const Konvertpage({super.key});

  @override
  State<Konvertpage> createState() => _KonvertpageState();
}

class _KonvertpageState extends State<Konvertpage> {
  final TextEditingController _inputController = TextEditingController();
  String _hasilKonversi = "0";

  String _dariSistem = "Desimal";
  String _keSistem = "Biner";

  final List<String> sistemBilangan = [
    "Biner",
    "Oktal",
    "Desimal",
    "Heksadesimal"
  ];

  void _konversi() {
    if (_inputController.text.isEmpty) {
      _showErrorDialog();
    } else {
      setState(() {
        _hasilKonversi =
            konversiBilangan(_inputController.text, _dariSistem, _keSistem);
      });
    }
  }

  void _reset() {
    setState(() {
      _inputController.text = "";
      _hasilKonversi = "0";
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Anda Harz Memasukkan Angka"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLangkah() {
    String langkah =
        hitungLangkahKonversi(_inputController.text, _dariSistem, _keSistem);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Langkah Konversi"),
          content: SingleChildScrollView(
            child: Text(langkah, style: const TextStyle(fontSize: 16)),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String hitungLangkahKonversi(
      String input, String dariSistem, String keSistem) {
    if (input.isEmpty) return "Masukkan angka terlebih dahulu.";

    try {
      int baseDari = _getBase(dariSistem);
      int baseKe = _getBase(keSistem);

      // Konversi input ke desimal sebagai perantara
      int desimal = int.parse(input, radix: baseDari);

      // Langkah konversi ke desimal
      String langkahDesimal = _generateLangkahKeDesimal(input, baseDari);

      // Langkah konversi dari desimal ke target
      String langkahKeSistem = _generateLangkahDariDesimal(desimal, baseKe);

      return "❍ $dariSistem ⇒ $keSistem :\n\n"
          "❍ $dariSistem ⇒ Desimal :\n$langkahDesimal\n\n"
          "❍ Desimal ⇒ $keSistem :\n$langkahKeSistem";
    } catch (e) {
      return "Terjadi kesalahan dalam konversi.";
    }
  }

  String _generateLangkahKeDesimal(String input, int base) {
    List<String> langkah = [];
    int panjang = input.length;

    for (int i = 0; i < panjang; i++) {
      int nilai = int.parse(input[i], radix: base);
      int pangkat = panjang - 1 - i;
      langkah.add("$nilai × $base^$pangkat");
    }

    return "${langkah.join(" + ")} = ${int.parse(input, radix: base)}";
  }

  String _generateLangkahDariDesimal(int desimal, int base) {
    if (base == 10) return "$desimal (sudah dalam desimal)";

    List<String> langkah = [];
    int angka = desimal;

    while (angka > 0) {
      int sisa = angka % base;
      langkah.add("$angka ÷ $base = ${angka ~/ base}, sisa $sisa");
      angka ~/= base;
    }

    return "${langkah.reversed.join("\n")}\n\n❍ Hasil akhir : ${desimal.toRadixString(base).toUpperCase()}";
  }

  int _getBase(String sistem) {
    switch (sistem) {
      case "Biner":
        return 2;
      case "Oktal":
        return 8;
      case "Desimal":
        return 10;
      case "Heksadesimal":
        return 16;
      default:
        throw Exception("Sistem bilangan tidak dikenal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        'Kalkulator Konversi Bilangan Komputer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          fontFamily: '.SF Pro Text',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _kolomInput(),
                    const SizedBox(height: 20),
                    const Icon(Icons.swap_vert, size: 35, color: Colors.black),
                    const SizedBox(height: 20),
                    _kolomHasil(),
                    const SizedBox(height: 35),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(45.0, 50.0),
                              backgroundColor:
                                  const Color.fromARGB(255, 222, 221, 221),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 10,
                              shadowColor: Colors.black),
                          onPressed: _reset,
                          child: const Icon(Icons.refresh_rounded,
                              color: Colors.black, size: 20),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(225.0, 50.0),
                              backgroundColor:
                                  const Color.fromARGB(255, 56, 163, 202),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 10,
                              shadowColor: Colors.black),
                          onPressed: _konversi,
                          child: const Text(
                            "Konversi",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(225.0, 50.0),
                          elevation: 10,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: _showLangkah,
                      child: const Text(
                        "tampilkan langkah konversi",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w200),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Input Konversi
  Widget _kolomInput() {
    return Container(
      width: double.infinity,
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(
                    _dariSistem == "Biner"
                        ? r'[01]'
                        : _dariSistem == "Heksadesimal"
                            ? r'[0-9A-Fa-f]'
                            : r'[0-9]',
                  ),
                ),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Masukkan angka",
              ),
            ),
          ),
          DropdownButton<String>(
            value: _dariSistem,
            alignment: Alignment.centerRight,
            onChanged: (String? newValue) {
              setState(() {
                _dariSistem = newValue!;
                _inputController.clear(); // Kosongkan input saat sistem berubah
              });
            },
            items: sistemBilangan.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(value, textAlign: TextAlign.right)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Kolom Hasil
  Widget _kolomHasil() {
    return Container(
      width: double.infinity,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_hasilKonversi,
              style: const TextStyle(
                fontSize: 18,
              )),
          DropdownButton<String>(
            value: _keSistem,
            isDense: true,
            alignment: Alignment.centerRight,
            onChanged: (String? newValue) {
              setState(() {
                _keSistem = newValue!;
              });
            },
            items: sistemBilangan.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
