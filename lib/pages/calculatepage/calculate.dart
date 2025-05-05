import 'package:flutter/material.dart';

class CalculateLogic {
  String basisBilangan = "Desimal";
  String operasiBilangan = "+";
  final TextEditingController bilangan1Controller = TextEditingController();
  final TextEditingController bilangan2Controller = TextEditingController();

  final List<String> basisbilanganList = [
    "Biner",
    "Oktal",
    "Desimal",
    "Hexadesimal",
  ];
  final List<String> operasiBilanganList = ["+", "-", "x", "/"];

  String calculate() {
    try {
      int bilangan1 = _convertToDecimal(
        bilangan1Controller.text,
        basisBilangan,
      );
      int bilangan2 = _convertToDecimal(
        bilangan2Controller.text,
        basisBilangan,
      );

      int hasil;
      switch (operasiBilangan) {
        case "+":
          hasil = bilangan1 + bilangan2;
          break;
        case "-":
          hasil = bilangan1 - bilangan2;
          break;
        case "x":
          hasil = bilangan1 * bilangan2;
          break;
        case "/":
          if (bilangan2 == 0) {
            return "Error: Pembagian dengan nol";
          }
          hasil = bilangan1 ~/ bilangan2;
          break;
        default:
          return "Operasi tidak valid";
      }

      return _convertFromDecimal(hasil, basisBilangan);
    } catch (e) {
      return "Error: Input tidak valid";
    }
  }

  int _convertToDecimal(String value, String basis) {
    switch (basis) {
      case "Biner":
        return int.parse(value, radix: 2);
      case "Oktal":
        return int.parse(value, radix: 8);
      case "Desimal":
        return int.parse(value);
      case "Hexadesimal":
        return int.parse(value, radix: 16);
      default:
        throw Exception("Basis tidak valid");
    }
  }

  String _convertFromDecimal(int value, String basis) {
    switch (basis) {
      case "Biner":
        return value.toRadixString(2);
      case "Oktal":
        return value.toRadixString(8);
      case "Desimal":
        return value.toString();
      case "Hexadesimal":
        return value.toRadixString(16).toUpperCase();
      default:
        throw Exception("Basis tidak valid");
    }
  }

  String getDetail() {
    try {
      int bilangan1 = _convertToDecimal(
        bilangan1Controller.text,
        basisBilangan,
      );
      int bilangan2 = _convertToDecimal(
        bilangan2Controller.text,
        basisBilangan,
      );

      int hasil;
      String operatorSymbol = operasiBilangan;
      switch (operasiBilangan) {
        case "+":
          hasil = bilangan1 + bilangan2;
          break;
        case "-":
          hasil = bilangan1 - bilangan2;
          break;
        case "x":
          hasil = bilangan1 * bilangan2;
          break;
        case "/":
          if (bilangan2 == 0) {
            return "Error: Pembagian dengan nol";
          }
          hasil = bilangan1 ~/ bilangan2;
          break;
        default:
          return "Operasi tidak valid";
      }

      String hasilKonversi = _convertFromDecimal(hasil, basisBilangan);
      String bil1Konversi = _convertFromDecimal(bilangan1, basisBilangan);
      String bil2Konversi = _convertFromDecimal(bilangan2, basisBilangan);

      return """
      $bil1Konversi
      $bil2Konversi
      ----------$operatorSymbol
      $hasilKonversi
      """;
    } catch (e) {
      return "Error: Input tidak valid";
    }
  }
}
