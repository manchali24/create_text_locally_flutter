import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(CreateTextWidget());
}

class CreateTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateTextStatefulWidget(title: 'Create Text document'),
    );
  }
}

class CreateTextStatefulWidget extends StatefulWidget {
  CreateTextStatefulWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CreateTextState createState() => _CreateTextState();
}

class _CreateTextState extends State<CreateTextStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Generate Text file',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: _createText,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _createText() async {

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    PdfDocument document = PdfDocument();
    //Save the document
    List<int> bytes = document.save();
    //Dispose the document
    document.dispose();

    //Get external storage directory
    Directory directory = await getExternalStorageDirectory();
    //Get directory path
    String path = directory.path;

    File file = File('$path/logintime.txt');

    await file.writeAsString('login_time: $formattedDate\r\n', mode: FileMode.append);
    //Open the PDF document in mobile
    //OpenFile.open('$path/input1.txt');
  }
}
