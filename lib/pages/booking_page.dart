import 'package:flutter/material.dart';
import 'package:food_donor/app.dart';
import 'package:numberpicker/numberpicker.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  int _currentHorizontalIntValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Book'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text("Quantity of food?"),
            SizedBox(height: 20),
            NumberPicker(
              value: _currentHorizontalIntValue,
              minValue: 0,
              maxValue: 100,
              step: 1,
              // itemHeight: 100,
              axis: Axis.horizontal,
              onChanged: (value) =>
                  setState(() => _currentHorizontalIntValue = value),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(16),
              //   border: Border.all(color: Colors.black26),
              // ),
            ),
          ],
        ));
  }
}
