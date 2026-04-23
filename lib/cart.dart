import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<String> cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void removeItem(int index) {
    setState(() {
      widget.cart.removeAt(index);
    });
  }

  void confirmOrder() {
    if (widget.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cart is empty!")),
      );
      return;
    }

    setState(() {
      widget.cart.clear();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Order Confirmed 🎉"),
          content: const Text("Your drinks are being prepared!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart 🛒"),
      ),

      body: widget.cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.cart[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeItem(index),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: confirmOrder,
                    child: const Text("Confirm Order"),
                  ),
                ),
              ],
            ),
    );
  }
}