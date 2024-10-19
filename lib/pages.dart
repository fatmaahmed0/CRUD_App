import 'package:crud_product_app/addproduct.dart';
import 'package:crud_product_app/getallproducts.dart';
import 'package:crud_product_app/home.dart';
import 'package:crud_product_app/routenames.dart';
import 'package:crud_product_app/singleproduct.dart';
import 'package:crud_product_app/updateproduct.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings? settings) {
    switch (settings?.name) {
      case Routenames.initial:
        return MaterialPageRoute(builder: (_) => const Home());

      case Routenames.getall:
        return MaterialPageRoute(builder: (_) => const Getallproducts());

      case Routenames.update:
        final int productid = settings!.arguments as int;
        return MaterialPageRoute(builder: (_) {
          return Updateproduct(productId: productid);
        });

      case Routenames.getsingle:
        final int productid = settings!.arguments as int;
        return MaterialPageRoute(builder: (_) {
          return Singleproduct(
            productId: productid,
          );
        });
      case Routenames.add:
        return MaterialPageRoute(builder: (_) => const Addproduct());
    }
    return null;
  }
}
