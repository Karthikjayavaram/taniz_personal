import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Custom Header Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
              decoration: const BoxDecoration(
                color: Color(0xFF041AA5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Logo and Bag Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFECE02),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "TK",
                              style: TextStyle(
                                color: Color(0xFF041AA5),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "taniz",
                                  style: TextStyle(color: Color(0xFFFECE02)),
                                ),
                                TextSpan(
                                  text: "Kart",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(PhosphorIcons.shoppingBag(), color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(PhosphorIcons.magnifyingGlass(), color: Colors.grey[400]),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search products",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(PhosphorIcons.magnifyingGlass(), color: Colors.grey[400]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Banner Section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 180,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF041AA5), Color(0xFF2A4FFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Groceries\ndelivered",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        const Text(
                          "fresh & fast!",
                          style: TextStyle(
                            color: Color(0xFFFECE02),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFECE02),
                            foregroundColor: const Color(0xFF041AA5),
                            shape: RoundedRectangle_circular(20),
                            elevation: 0,
                          ),
                          child: const Text("Shop Now >>", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -10,
                    bottom: 0,
                    top: 0,
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/3724/3724720.png", // New Fresh Bag Icon
                      fit: BoxFit.contain,
                      width: 150,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Popular Products Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular Products",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF041AA5),
                    ),
                  ),
                  Icon(PhosphorIcons.dotsThreeOutline(PhosphorIconsStyle.bold), color: Colors.grey),
                ],
              ),
            ),
          ),

          // Horizontal Products List (Single Row)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 280, // Height for a single row
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 10),
                itemCount: 7,
                itemBuilder: (context, index) {
                  final products = [
                    {"name": "Fresh Tomato", "price": "₹40", "image": "https://images.unsplash.com/photo-1596733430284-f7437764b1a9?auto=format&fit=crop&q=80&w=300"},
                    {"name": "Broccoli", "price": "₹60", "image": "https://images.unsplash.com/photo-1584270354949-c26b0d5b4a0c?auto=format&fit=crop&q=80&w=300"},
                    {"name": "Fresh Eggs", "price": "₹80", "image": "https://images.unsplash.com/photo-1598965402089-897ce52e8355?auto=format&fit=crop&q=80&w=300"},
                    {"name": "Carrots", "price": "₹30", "image": "https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?auto=format&fit=crop&q=80&w=300"},
                    {"name": "Bell Pepper", "price": "₹50", "image": "https://images.unsplash.com/photo-1563203369-26f2e4a5ccf7?auto=format&fit=crop&q=80&w=300"},
                    {"name": "Banana", "price": "₹50", "image": "https://images.unsplash.com/photo-1603833665858-e61d17a86224?auto=format&fit=crop&q=80&w=300"},
                    {"name": "Apples", "price": "₹120", "image": "https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?auto=format&fit=crop&q=80&w=300"},
                  ];
                  final product = products[index % products.length];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 15, bottom: 5),
                    child: ProductCard(
                      name: product["name"]!,
                      price: product["price"]!,
                      imageUrl: product["image"]!,
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)), // Bottom padding
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image part
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Info part
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    price,
                    style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 26,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFECE02),
                        foregroundColor: const Color(0xFF041AA5),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        elevation: 0,
                      ),
                      child: const Text("Add", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper
RoundedRectangleBorder RoundedRectangle_circular(double radius) {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
}
