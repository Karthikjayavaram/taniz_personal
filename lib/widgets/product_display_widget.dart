import 'package:flutter/material.dart';

class ProductDisplay extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const ProductDisplay({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              image,
              height: 90,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),

          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              price,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xffFFD233),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
