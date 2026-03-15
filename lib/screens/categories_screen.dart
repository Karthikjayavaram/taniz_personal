import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6E9), // Creamy background as per image
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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
                              style: TextStyle(color: Color(0xFF041AA5)), // Blue on light background
                            ),
                            TextSpan(
                              text: "Kart",
                              style: TextStyle(color: Color(0xFF041AA5)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.shopping_bag_outlined, color: const Color(0xFF041AA5)),
                ],
              ),
              const SizedBox(height: 30),

              // Categories Header
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
              const SizedBox(height: 20),

              // Categories Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
                children: [
                  _buildCategoryItem("Fruits", "https://cdn-icons-png.flaticon.com/512/3194/3194591.png"),
                  _buildCategoryItem("Vegetables", "https://cdn-icons-png.flaticon.com/512/2329/2329903.png"),
                  _buildCategoryItem("Dairy", "https://cdn-icons-png.flaticon.com/512/2674/2674505.png"),
                  _buildCategoryItem("Bakery", "https://cdn-icons-png.flaticon.com/512/3014/3014532.png"),
                  _buildCategoryItem("Beverages", "https://cdn-icons-png.flaticon.com/512/2922/2922037.png"),
                  _buildCategoryItem("Snacks", "https://cdn-icons-png.flaticon.com/512/2553/2553691.png"),
                  _buildCategoryItem("Meat", "https://cdn-icons-png.flaticon.com/512/1046/1046769.png"),
                  _buildCategoryItem("Reels", "https://cdn-icons-png.flaticon.com/512/4406/4406124.png"),
                ],
              ),
              const SizedBox(height: 30),

              // Most Popular Header
              const Text(
                "Most Popular",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
              const SizedBox(height: 20),

              // Horizontal Products
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPopularCard("Fresh Tomato", "₹40.00", "https://images.unsplash.com/photo-1596733430284-f7437764b1a9?auto=format&fit=crop&q=80&w=150"),
                    _buildPopularCard("Broccoli", "₹60.00", "https://images.unsplash.com/photo-1584270354949-c26b0d5b4a0c?auto=format&fit=crop&q=80&w=150"),
                    _buildPopularCard("Eggs", "₹80.00", "https://images.unsplash.com/photo-1598965402089-897ce52e8355?auto=format&fit=crop&q=80&w=150"),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Promo Code
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Apply promo code for better prices",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Checkout Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF041AA5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                      const SizedBox(width: 10),
                      const Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Total Price Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Four items products - ₹250.20",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const Text(
                    "₹186.24",
                    style: TextStyle(
                      color: Color(0xFF041AA5),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imageUrl) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Image.network(imageUrl, width: 40, height: 40),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPopularCard(String title, String price, String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
          Text(price, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFFECE02),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text("Add to Cart", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
