import 'package:flutter/material.dart';
import 'package:the_e_shop/fuction/get_product_data.dart';

import '../model/product_model.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

 late Future<ProductModel> futureProducts;

  @override
  void initState() {
    super.initState();
    print("Hello");
    futureProducts = GetProduct.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: FutureBuilder<ProductModel>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.products == null) {
            return const Center(child: Text("No products found"));
          }

          final products = snapshot.data!.products!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    product.image ?? "",
                    width: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                  ),
                  title: Text(product.title ?? "No title"),
                  subtitle: Text("Price: \$${product.price ?? 0}"),
                ),
              );
            },
          );
        },
      ),
    );}
}