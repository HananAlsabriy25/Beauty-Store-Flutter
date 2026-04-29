import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/shop_providers.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => ShopProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beauty Store',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: TabsScreen(), 
    );
  }
}