import 'package:flutter/material.dart';

class Calculatepage extends StatefulWidget {
  const Calculatepage({super.key});

  @override
  State<Calculatepage> createState() => _CalculatepageState();
}

class _CalculatepageState extends State<Calculatepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("TextSpan Example")),
        body: const Center(
          child: Text.rich(
            TextSpan(
              text: "Kata biasa, ",
              style: TextStyle(fontSize: 20, color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: "warna merah",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ", dan kembali biasa.",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
