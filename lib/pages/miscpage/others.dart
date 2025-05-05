String hitungLangkahKonversi(String input, String dariSistem, String keSistem) {
  if (input.isEmpty) return "Masukkan angka terlebih dahulu.";

  try {
    int baseDari = _getBase(dariSistem);
    int baseKe = _getBase(keSistem);

    int desimal = int.parse(input, radix: baseDari);

    String langkahDesimal = _generateLangkahKeDesimal(input, baseDari);

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
