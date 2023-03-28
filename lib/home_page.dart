import 'dart:convert';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sidekicks = {
    'Batman': 'Robin',
    'Superman': 'Lois Lane',
    'Harry Potter': 'Ron and Hermione'
  };
  static const jsonArray = '''
  [{"text": "foo", "value": 1, "status": true},
   {"text": "bar", "value": 2, "status": false}]
''';
  final List<dynamic> dynamicList = jsonDecode(jsonArray);
  List<Map<String, dynamic>> secilenDetay = [];
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    // final List<Map<String, dynamic>> fooData =
    //     List.from(dynamicList.where((x) => x is Map && x['text'] == 'foo'));

    final List<Map<String, dynamic>> fooData =
        List.from(dynamicList.whereType<Map>());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sidekicks
                  .map((key, value) => MapEntry(key, Text(value)))
                  .values
                  .toList(),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                //prefixIcon: Icon(Icons.settings),
                hintText: 'Seçenekler',
                filled: true,
                fillColor: Colors.transparent,
                errorStyle: TextStyle(color: Colors.yellow),
              ),
              items: fooData.map((map) {
                return DropdownMenuItem(
                  value: map['text'],
                  child: Text(map['text']),
                );
              }).toList(),
              onChanged: (value) => dropDownCallback(value),
            ),
            const SizedBox(
              height: 70,
            ),
            Column(
              children: secilenDetay
                  .map((e) => Column(
                        children: [
                          Text(
                            "Text: ${e["text"]}",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Value: ${e["value"]}",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Status: ${e["status"]}",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void dropDownCallback(Object? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
        deneme(selectedValue);
      });
    }
  }

  deneme(String? value) {
    secilenDetay =
        List.from(dynamicList.where((x) => x is Map && x['text'] == '$value'));
  }
}
