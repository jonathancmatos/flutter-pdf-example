import 'package:flutter/material.dart';
import 'package:flutter_pdf_example/views/report.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: const Text("OPEN PDF"),
          onPressed: () async{
            await Report().generatePDF();
          },
        ),
      ),
    );
  }
}
