import 'package:flutter/material.dart';
import 'package:test_example/screen/accommodation.dart';
// import 'package:test_example/screen/location.dart';
// import 'package:test_example/screen/list_restaurant.dart';
// import 'package:test_example/screen/list_accommodation.dart';
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      // home: HomePage(),
    );
  }
}