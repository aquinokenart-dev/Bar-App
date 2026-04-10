import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<String> cart;

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart "),
      ),
      body: cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cart[index]),
                );
              },
            ),
    );
  }
}