import 'package:crud_product_app/pages.dart';
import 'package:crud_product_app/routenames.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DevicePreview(builder: (context)=>const MyApp()) );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routenames.initial,
      onGenerateRoute: AppRoute.generate,
      
    );
  }
}
