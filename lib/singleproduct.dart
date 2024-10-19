import 'dart:convert';
import 'package:crud_product_app/routenames.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Singleproduct extends StatefulWidget {
  final int productId;
  const Singleproduct({super.key, required this.productId});

  @override
  State<Singleproduct> createState() => _SingleproductState();
}

class _SingleproductState extends State<Singleproduct> {
  Map<String, dynamic> product = {};
  @override
  void initState() {
    super.initState();
    fetchsingleproduct(widget.productId);
  }

  Future<void> fetchsingleproduct(int id) async {
    var url = Uri.https('dummyjson.com', '/products/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        product = jsonDecode(response.body);
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
          "Single Product",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 16, 68, 110)),
        ),
      ),
      body: product.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title:${product['title']}",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 20,),
                    Text("Description : ${product['description']}"),
                    const SizedBox(height: 20,),
                    Text("category : ${product['category']}",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20,),
                    Text("Price :${product['price']}",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  //   Image.network(product['images']) 
                   ],
                ),
              ),
            ),
    );
  }
}
