import 'dart:convert';

import 'package:crud_product_app/routenames.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Addproduct extends StatefulWidget {

  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final TextEditingController _textEditingController = TextEditingController();
  Map<String, dynamic> product = {};
  Future<void> addproduct() async {
    var url = Uri.https('dummyjson.com', '/products/add');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'title': _textEditingController.text}));
    if (response.statusCode == 201) {
      
      setState(() {
        product = json.decode(response.body);
        _textEditingController.clear();
      });
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
          "Add Product",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 7, 14, 20)),
        ),
      ),
      body:Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              label: Text("Add Product"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              addproduct();
            },
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          const SizedBox(height: 30),

          
          if (product.isNotEmpty) ...[
              Text(
              "Id: ${product['id']}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              " Title: ${product['title']}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }
}
