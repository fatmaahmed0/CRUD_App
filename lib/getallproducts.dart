import 'dart:convert';

import 'package:crud_product_app/routenames.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Getallproducts extends StatefulWidget {
  const Getallproducts({super.key});
  @override
  State<Getallproducts> createState() => _GetallproductsState();
}

class _GetallproductsState extends State<Getallproducts> {
  final int index = 0;
  List<Map<String, dynamic>> products = [];
  @override
  void initState() {
    super.initState();
    fetchAllProduct();
  }

  Future<void> fetchAllProduct() async {
    var url = Uri.http('dummyjson.com', '/products');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        products = List<Map<String, dynamic>>.from(
            json.decode(response.body)['products']);
      });
    } else {
      throw Exception("faild to load product");
    }
  }

  Future<void> deleteProduct(int id) async {
    var url = Uri.https('dummyjson.com', '/products/$id');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      setState(() {
        products.removeWhere((product) => product['id'] == id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, Routenames.initial);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Text(
            "All products",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 16, 68, 110)),
          ),
        ),
        body: products.isEmpty ? loading() : showProducts());
  }

  ListView showProducts() {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['title']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    deleteProduct(product['id']);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routenames.update,
                        arguments: product['id']);
                  },
                  child: const Icon(
                    Icons.edit_rounded,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routenames.getsingle,
                        arguments: product['id']);
                  },
                  child: const Icon(Icons.remove_red_eye),
                ),
              ],
            ),
          );
        });
  }

  Center loading() => const Center(
        child: CircularProgressIndicator(),
      );
}
