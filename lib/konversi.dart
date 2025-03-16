String konversiBilangan(String input, String dari, String ke) {
  //Contoh | print(konversiBilangan("1010", "Biner", "Desimal")); 10
  int angka;

  input = input.replaceAll(',', '').replaceAll('.', '');

  switch (dari) {
    case "Biner":
      angka = int.parse(input, radix: 2);
      break;
    case "Oktal":
      angka = int.parse(input, radix: 8);
      break;
    case "Desimal":
      angka = int.parse(input, radix: 10);
      break;
    case "Heksadesimal":
      angka = int.parse(input, radix: 16);
      break;
    default:
      return "Error";
  }

  switch (ke) {
    case "Biner":
      return angka.toRadixString(2);
    case "Oktal":
      return angka.toRadixString(8);
    case "Desimal":
      return angka.toString();
    case "Heksadesimal":
      return angka.toRadixString(16).toUpperCase();
    default:
      return "Error";
  }
}

//1×2³ + 0×2² + 1×2¹ + 0×2⁰ = 10