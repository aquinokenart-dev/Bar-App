import 'package:flutter/material.dart';

void main() {
  runApp(const BarApp());
}

class BarApp extends StatelessWidget {
  const BarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bar App 🍹"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Bar Menu",
                style: TextStyle(fontSize: 24),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  print("Mojito Ordered");
                },
                child: const Text("Order Mojito"),
              ),

              ElevatedButton(
                onPressed: () {
                  print("Margarita Ordered");
                },
                child: const Text("Order Margarita"),
              ),

              ElevatedButton(
                onPressed: () {
                  print("Whiskey Ordered");
                },
                child: const Text("Order Whiskey"),
              ),

              ElevatedButton(
                onPressed: () {
                  print("Beer Ordered");
                },
                child: const Text("Order Beer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}