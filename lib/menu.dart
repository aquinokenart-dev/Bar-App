import 'package:flutter/material.dart';
import 'cart.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Map<String, int> drinks = {
    "Mojito": 5,
    "Margarita": 3,
    "Whiskey": 4,
    "Beer": 6,
  };

  List<String> cart = [];

  void orderDrink(String drink) {
    if (drinks[drink]! > 0) {
      setState(() {
        drinks[drink] = drinks[drink]! - 1;
        cart.add(drink);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$drink is out of stock!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Menu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cart: cart),
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: drinks.keys.map((drink) {
          return ListTile(
            title: Text(drink),
            subtitle: Text("Available: ${drinks[drink]}"),
            trailing: ElevatedButton(
              onPressed: () => orderDrink(drink),
              child: const Text("Add"),
            ),
          );
        }).toList(),
      ),
    );
  }
}