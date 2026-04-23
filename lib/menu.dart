import 'package:flutter/material.dart';
import 'cart.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  Map<String, Map<String, int>> drinks = {
    "Strong": {
      "Whiskey": 13,
      "Beer": 9,
    },
    "Mild": {
      "Mojito": 20,
      "Margarita": 30,
    },
  };

  List<String> cart = [];

  void orderDrink(String category, String drink) {
    if (drinks[category]![drink]! > 0) {
      setState(() {
        drinks[category]![drink] =
            drinks[category]![drink]! - 1;
        cart.add(drink);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$drink is out of stock!")),
      );
    }
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Menu 🍹"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: openCart,
          ),
        ],
      ),

      body: ListView(
        children: drinks.keys.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ...drinks[category]!.keys.map((drink) {
                return ListTile(
                  title: Text(drink),
                  subtitle: Text(
                    "Available: ${drinks[category]![drink]}",
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => orderDrink(category, drink),
                    child: const Text("Add"),
                  ),
                );
              }).toList(),

              const Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }
}