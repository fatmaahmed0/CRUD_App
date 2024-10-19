import 'package:crud_product_app/routenames.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "CRUD App",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 16, 68, 110)),
              ),
              Buttons(
                  onpressed: () {
                    Navigator.pushNamed(context, Routenames.getall);
                  },
                  title: "Get All Products"),
              Buttons(
                  onpressed: () {
                    Navigator.pushNamed(context, Routenames.add);
                  },
                  title: "Add Product")
            ],
          ),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.onpressed,
    required this.title,
  });

  final void Function() onpressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      onPressed: onpressed,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
