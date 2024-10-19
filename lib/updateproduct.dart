// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:crud_product_app/routenames.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Updateproduct extends StatefulWidget {
  final int productId;
  const Updateproduct({super.key, required this.productId});
  @override
  State<Updateproduct> createState() => _UpdateproductState();
}

class _UpdateproductState extends State<Updateproduct> {
  Map<String, dynamic> product = {};
  final TextEditingController _titlecontroller = TextEditingController();

  Future<void> updatetitle(int id) async {
    var url = Uri.https('dummyjson.com', '/products/$id');
    var response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"title": _titlecontroller.text}),
    );
    if (response.statusCode == 200) {
      setState(() {
        product = json.decode(response.body);
        _titlecontroller.clear();
      });
    } else {
      print('Failed to update the product title');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, Routenames.getall);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          "Update Title",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 7, 14, 20)),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _titlecontroller,
            decoration: const InputDecoration(
              label: Text("Update Title"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              updatetitle(widget.productId);
            },
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            " Title: ${product['title']}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "price: ${product['price']}",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
