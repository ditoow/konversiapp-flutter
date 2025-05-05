String hitungLangkahKonversi(String input, String dariSistem, String keSistem) {
  if (input.isEmpty) return "Masukkan angka terlebih dahulu.";

  try {
    int baseDari = _getBase(dariSistem);
    int baseKe = _getBase(keSistem);

    int desimal = int.parse(input, radix: baseDari);

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
    String karakter = input[i].toUpperCase();
    int nilai = int.parse(karakter, radix: base);
    int pangkat = panjang - 1 - i;

    if (base == 16 && nilai >= 10) {
      langkah.add("$karakter × $base^$pangkat");
    } else {
      langkah.add("$nilai × $base^$pangkat");
    }
  }

  return "${langkah.join(" + ")} = ${int.parse(input, radix: base)}";
}

String _generateLangkahDariDesimal(int desimal, int base) {
  if (base == 10) return "$desimal (sudah dalam desimal)";

  List<String> langkah = [];
  int angka = desimal;
  String hasil = "";

  while (angka > 0) {
    int sisa = angka % base;

    String sisaHex = sisa < 10 ? "$sisa" : String.fromCharCode(55 + sisa);

    if (angka ~/ base > 0) {
      langkah.add("$angka ÷ $base = ${angka ~/ base}, sisa $sisaHex");
    }

    hasil = sisaHex + hasil;
    angka ~/= base;
  }

  return "${langkah.join("\n")}\n\n❍ Hasil akhir : $hasil";
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
