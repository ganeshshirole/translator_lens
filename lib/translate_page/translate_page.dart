import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatePage extends StatefulWidget {
  final text;

  TranslatePage({Key key, this.text}) : super(key: key);

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  String dropdownValue1 = 'English';
  String dropdownValue2 = 'Hindi';

  Map languages = {"English": "en", "Hindi": "hi", "Marathi": "mr"};

  var translator = GoogleTranslator();
  var textController = TextEditingController();

  var translated = '';

  @override
  void initState() {
    textController.text = widget.text;
    translate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Text(
                    'Translator',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black54,
                          size: 20.0, //   30.0,
                        ),
                        value: dropdownValue1,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue1 = newValue;
                          });
                          translate();
                        },
                        items: <String>['English', 'Hindi', 'Marathi']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.compare_arrows),
                    onPressed: () {
                      var temp = dropdownValue1;
                      dropdownValue1 = dropdownValue2;
                      dropdownValue2 = temp;
                      setState(() {});
                      translate();
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black54,
                          size: 20.0, //   30.0,
                        ),
                        value: dropdownValue2,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue2 = newValue;
                          });
                          translate();
                        },
                        items: <String>['English', 'Hindi', 'Marathi']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                  border: new Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: textController,
                  onChanged: (value) {
                    translate();
                  },
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontFamily: 'Montserrat'),
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: 'Enter text',
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  translated,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontFamily: 'Montserrat'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void translate() async {
    var translation = await translator.translate(textController.text,
        from: languages[dropdownValue1], to: languages[dropdownValue2]);

    print(translation);
    translated = translation;
    setState(() {});
  }
}
