import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warnersos/widgets/screen.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  static const platform = MethodChannel('com.warnersnotes.warnersos/placeCall');
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: phoneNumber,
      children: [
        Center(
          child:
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio: 3/2,
              children: [
                TextButton(
                  onPressed: () => addDigit('1'),
                  child: Text('1', style: TextStyle(fontSize: 50, color: Colors.black),),
                  
                ),
                TextButton(
                  onPressed: () => addDigit('2'),
                  child: Text('2', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
                TextButton(
                  onPressed: () => addDigit('3'),
                  child: Text('3', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
                TextButton(
                  onPressed: () => addDigit('4'),
                  child: Text('4', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
                TextButton(
                  onPressed: () => addDigit('5'),
                  child: Text('5', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
                TextButton(
                  onPressed: () => addDigit('6'),
                  child: Text('6', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
                TextButton(
                  onPressed: () => addDigit('7'),
                  child: Text('7', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
                TextButton(
                  onPressed: () => addDigit('8'),
                  child: Text('8', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
                TextButton(
                  onPressed: () => addDigit('9'),
                  child: Text('9', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
                TextButton(
                  onPressed: placeCall,
                  child: Icon(Icons.phone_outlined, size: 50, color: Colors.black,),
                ),
                TextButton(
                  onPressed: () => addDigit('0'),
                  child: Text('0', style: TextStyle(fontSize: 50, color: Colors.black),),
                ),
              ],
            ),
        ),
      ],
    );
  }

  void placeCall() async {
    try {
      await platform.invokeMethod<int>('placeCall', {"phoneNumber": phoneNumber});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void addDigit(String digit) {
    setState(() {
      phoneNumber = phoneNumber + digit;
    });
  }
}