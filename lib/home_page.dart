import 'package:avatar_glow/avatar_glow.dart';
//import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:testapp/main.dart';
import 'package:testapp/speech_api.dart';
//import 'package:testapp/substring_highlighted.dart';

//import 'utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = 'Press the button and start speaking';
  bool isListening = false;
  var a = [];
  var b = [];
  var imgpath = 'default';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/" + imgpath + ".jpg",
                  fit: BoxFit.cover,
                ),
              ),
              /*SubstringHighlight(
                text: text,
                terms: Command.all,
                textStyle: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                textStyleHighlight: TextStyle(
                  fontSize: 40.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                ),
              ),*/
              Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 80,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 40),
            onPressed: toggleRecording,
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        //onResult: (path) => setState(() => path=a[0]),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              //Utils.scanText(text);
              display(text);
            });
            imgpath = a[0];
          }
        },
      );

  display(String txt) {
    var ab = txt.toLowerCase();
    a = ab.split("");
    //print(a);
    for (var i = 0; i < a.length; i++) {
      if (a[i] == ' ') a.removeAt(i);
      //print(a[i]);
    }
    print(a);
    for (var i = 0; i < a.length; i++) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() => this.imgpath = a[i]);
        print(a[i]);
      });
    }
    //path = a[0];
  }
}
