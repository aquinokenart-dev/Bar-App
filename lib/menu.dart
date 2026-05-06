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
      "Whiskey": 4,
      "Beer": 6,
      "Gin": 3,
      "Rum": 5,
    },
    "Mild": {
      "Mojito": 5,
      "Margarita": 3,
      "Lemonade": 7,
      "Iced Tea": 4,
    },
    "Light": {
      "Fruit Punch": 6,
      "Sparkling Water": 8,
      "Virgin Mojito": 5,
      "Apple Juice": 4,
    },
  };

  List<String> cart = [];

  void orderDrink(String category, String drink) {
    if (drinks[category]![drink]! > 0) {
      setState(() {
        drinks[category]![drink] = drinks[category]![drink]! - 1;
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Strong": return Colors.red;
      case "Mild": return Colors.green;
      case "Light": return Colors.orange;
      default: return Colors.blue;
    }
  }

  Color _getCategoryLightColor(String category) {
    switch (category) {
      case "Strong": return Colors.red[100]!;
      case "Mild": return Colors.green[100]!;
      case "Light": return Colors.orange[100]!;
      default: return Colors.blue[100]!;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case "Strong": return "🥃 Strong Drinks";
      case "Mild": return "🍃 Mild Drinks";
      case "Light": return "🧃 Light Drinks";
      default: return category;
    }
  }

  String _getDrinkEmoji(String drink) {
    switch (drink) {
      case 'Whiskey': return '🥃';
      case 'Beer': return '🍺';
      case 'Gin': return '🍸';
      case 'Rum': return '🍶';
      case 'Mojito': return '🍃';
      case 'Margarita': return '🍋';
      case 'Lemonade': return '🍊';
      case 'Iced Tea': return '🧋';
      case 'Fruit Punch': return '🍹';
      case 'Sparkling Water': return '💧';
      case 'Virgin Mojito': return '🌿';
      case 'Apple Juice': return '🍎';
      default: return '🍹';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bar Menu 🍹'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: openCart,
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: drinks.keys.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Section header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _getCategoryLightColor(category),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getCategoryColor(category),
                  ),
                ),
                child: Text(
                  _getCategoryLabel(category),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _getCategoryColor(category),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Drink list
              ...drinks[category]!.keys.map((drink) {
                int stock = drinks[category]![drink]!;
                bool outOfStock = stock == 0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getCategoryLightColor(category),
                      child: Text(
                        _getDrinkEmoji(drink),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    title: Text(
                      drink,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: outOfStock ? Colors.grey : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      outOfStock ? 'Out of stock' : 'Available: $stock',
                      style: TextStyle(
                        color: outOfStock ? Colors.red : Colors.green[700],
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: outOfStock
                          ? null
                          : () => orderDrink(category, drink),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: outOfStock
                            ? Colors.grey
                            : Colors.blue,
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),

              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      ),
    );
  }
}