import 'package:coinrich/Provider/CyrptoProvider.dart';
import 'package:coinrich/UI/HomeScreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CryptoProvider(),
        child: MaterialApp(
          home: Homescreen(),
        ));
  }
}
