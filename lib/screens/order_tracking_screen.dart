import 'package:flutter/material.dart';
import 'package:tanizkart/models/cart_item.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;
  final String deliveryTime;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final String paymentMethod;
  final double totalAmount;
  final List<CartItem> items;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
    required this.deliveryTime,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.paymentMethod,
    required this.totalAmount,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> trackingSteps = [
      {
        "title": "Order Placed",
        "subtitle": "Your order has been placed successfully",
        "isCompleted": true,
      },
      {
        "title": "Packed",
        "subtitle": "Your items have been packed",
        "isCompleted": true,
      },
      {
        "title": "Out for Delivery",
        "subtitle": "Delivery partner is on the way",
        "isCompleted": false,
      },
      {
        "title": "Delivered",
        "subtitle": "Order will be delivered soon",
        "isCompleted": false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 30,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF041AA5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
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
                    "Track Order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderStatusBanner(),
                  const SizedBox(height: 20),
                  _buildOrderInfoCard(),
                  const SizedBox(height: 20),
                  _buildTrackingCard(trackingSteps),
                  const SizedBox(height: 20),
                  _buildDeliveryPartnerCard(),
                  const SizedBox(height: 20),
                  _buildItemsCard(),
                  const SizedBox(height: 20),
                  _buildDeliveryAddressCard(),
                  const SizedBox(height: 20),
                  _buildHelpSection(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF041AA5),
            Color(0xFF2D4BFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your order is on the way!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Sit tight, your fresh groceries will arrive soon.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF041AA5).withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long, color: Color(0xFF041AA5)),
              SizedBox(width: 10),
              Text(
                "Order Details",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildInfoRow("Order ID", orderId),
          const SizedBox(height: 10),
          _buildInfoRow("Estimated Delivery", deliveryTime),
          const SizedBox(height: 10),
          _buildInfoRow("Payment Method", paymentMethod),
          const SizedBox(height: 10),
          _buildInfoRow("Total Amount", "₹${totalAmount.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _buildTrackingCard(List<Map<String, dynamic>> trackingSteps) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.local_shipping_outlined, color: Color(0xFF041AA5)),
              SizedBox(width: 10),
              Text(
                "Tracking Status",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(trackingSteps.length, (index) {
            final step = trackingSteps[index];
            final bool isLast = index == trackingSteps.length - 1;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: step["isCompleted"]
                              ? const Color(0xFF041AA5)
                              : Colors.grey[300],
                        ),
                        child: Icon(
                          step["isCompleted"] ? Icons.check : Icons.circle,
                          size: 15,
                          color: step["isCompleted"]
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 3,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: step["isCompleted"]
                                  ? const Color(0xFF041AA5)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step["title"],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: step["isCompleted"]
                                  ? const Color(0xFF041AA5)
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step["subtitle"],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDeliveryPartnerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF041AA5).withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFF041AA5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delivery_dining,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Partner",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Ravi Kumar",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF041AA5),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Your order is being prepared",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.phone,
              color: Color(0xFF041AA5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.shopping_bag_outlined, color: Color(0xFF041AA5)),
              SizedBox(width: 10),
              Text(
                "Ordered Items",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported, size: 18),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "${item.name} x${item.quantity}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "₹${(item.price * item.quantity).toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Color(0xFF041AA5),
                      fontWeight: FontWeight.bold,
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

  Widget _buildDeliveryAddressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on_outlined, color: Color(0xFF041AA5)),
              SizedBox(width: 10),
              Text(
                "Delivery Address",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            customerName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            customerAddress,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            customerPhone,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message_outlined, color: Color(0xFF041AA5)),
                SizedBox(width: 8),
                Text(
                  "Chat Support",
                  style: TextStyle(
                    color: Color(0xFF041AA5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFF041AA5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.help_outline, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Need Help",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            "$title :",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}