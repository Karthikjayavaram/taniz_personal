import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample data for the cart with reliable image URLs
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Fresh Tomato",
      "price": 31.18,
      "weight": "500g",
      "image": "https://images.unsplash.com/photo-1582284540020-8acbe03f4924?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "selected": true,
    },
    {
      "name": "Broccoli",
      "price": 23.18,
      "weight": "500g",
      "image": "https://images.unsplash.com/photo-1584270354949-c26b0d5b4a0c?auto=format&fit=crop&q=80&w=150",
      "selected": true,
    },
    {
      "name": "Eggs",
      "price": 20.18,
      "weight": "6 items",
      "image": "https://images.unsplash.com/photo-1639194335563-d56b83f0060c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZWdnc3xlbnwwfHwwfHx8MA%3D%3D",
      "selected": false,
    },
  ];

  String selectedPaymentMethod = "UPI";
  String userName = "Jayanth V";
  String userAddress = "No. 123, Main Road, Bangalore, Karnataka - 560001";
  String userPhone = "+91 98765 43210";

  double get totalAmount {
    return cartItems
        .where((item) => item['selected'] == true)
        .fold(0, (sum, item) => sum + item['price']);
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Blue Section
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                left: 20,
                right: 20,
                bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xFF041AA5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate back or to previous tab
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    "My Cart",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    PhosphorIcons.dotsThreeOutline(),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Cart Items Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Booking",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF041AA5),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),

          // Cart Items List & Additional Sections
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // List of Cart Items
                  ...List.generate(cartItems.length, (index) {
                    final item = cartItems[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
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
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              item['image'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image,
                                      color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item['weight'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Price, Checkbox and Delete
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => _removeItem(index),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                      value: item['selected'],
                                      activeColor: const Color(0xFF041AA5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          item['selected'] = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "₹${item['price']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF041AA5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  // Personal Details Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFF041AA5).withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.person_pin, color: Color(0xFF041AA5)),
                                SizedBox(width: 10),
                                Text(
                                  "Personal Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF041AA5),
                                  ),
                                ),
                              ],
                            ),
                            TextButton.icon(
                              onPressed: _showEditDetailsDialog,
                              icon: const Icon(Icons.edit, size: 16, color: Color(0xFF041AA5)),
                              label: const Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF041AA5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userAddress,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userPhone,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Payment Methods Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Method",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF041AA5),
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildPaymentOption(
                        title: "UPI / PhonePe / Google Pay",
                        icon: Icons.account_balance_wallet_outlined,
                        value: "UPI",
                      ),
                      _buildPaymentOption(
                        title: "Credit / Debit Card",
                        icon: Icons.credit_card_outlined,
                        value: "Card",
                      ),
                      _buildPaymentOption(
                        title: "Cash on Delivery",
                        icon: Icons.money_outlined,
                        value: "COD",
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Total and Checkout
          Container(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total amount:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "₹${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF041AA5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF041AA5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDetailsDialog() {
    final nameController = TextEditingController(text: userName);
    final addressController = TextEditingController(text: userAddress);
    final phoneController = TextEditingController(text: userPhone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Edit Personal Details",
          style: TextStyle(color: Color(0xFF041AA5), fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Color(0xFF041AA5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF041AA5)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Address",
                  labelStyle: TextStyle(color: Color(0xFF041AA5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF041AA5)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone",
                  labelStyle: TextStyle(color: Color(0xFF041AA5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF041AA5)),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameController.text;
                userAddress = addressController.text;
                userPhone = phoneController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF041AA5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required IconData icon,
    required String value,
  }) {
    bool isSelected = selectedPaymentMethod == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF041AA5).withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFF041AA5) : Colors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF041AA5) : Colors.grey),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF041AA5) : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF041AA5), size: 18),
          ],
        ),
      ),
    );
  }
}
