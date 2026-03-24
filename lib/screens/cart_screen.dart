import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tanizkart/models/cart_item.dart';
import 'package:tanizkart/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> cartItems = [
    CartItem(
      name: "Fresh Tomato",
      price: 31.18,
      weight: "500g",
      image:
          "https://images.unsplash.com/photo-1582284540020-8acbe03f4924?q=80&w=735&auto=format&fit=crop",
      selected: true,
      quantity: 1,
    ),
    CartItem(
      name: "Broccoli",
      price: 23.18,
      weight: "500g",
      image:
          "https://images.unsplash.com/photo-1584270354949-c26b0d5b4a0c?auto=format&fit=crop&q=80&w=150",
      selected: true,
      quantity: 2,
    ),
    CartItem(
      name: "Eggs",
      price: 20.18,
      weight: "6 items",
      image:
          "https://images.unsplash.com/photo-1639194335563-d56b83f0060c?w=600&auto=format&fit=crop&q=60",
      selected: false,
      quantity: 1,
    ),
  ];

  String selectedPaymentMethod = "UPI";
  String userName = "Jayanth V";
  String userAddress = "No. 123, Main Road, Bangalore, Karnataka - 560001";
  String userPhone = "+91 98765 43210";
  String deliveryTime = "Today, 6 PM - 8 PM";

  final TextEditingController couponController = TextEditingController();
  bool couponApplied = false;
  double couponDiscount = 0.0;
  String appliedCouponCode = "";

  double get subtotal {
    return cartItems
        .where((item) => item.selected)
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get deliveryFee => subtotal == 0 ? 0 : (subtotal > 100 ? 0 : 25);

  double get gst => subtotal * 0.05;

  double get totalAmount => subtotal + deliveryFee + gst - couponDiscount;

  int get selectedCount => cartItems.where((item) => item.selected).length;

  bool get isAllSelected =>
      cartItems.isNotEmpty && cartItems.every((item) => item.selected);

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item removed from cart"),
        backgroundColor: Color(0xFF041AA5),
      ),
    );
  }

  void _increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  void _toggleSelectAll(bool value) {
    setState(() {
      for (var item in cartItems) {
        item.selected = value;
      }
    });
  }

  void _applyCoupon() {
    final code = couponController.text.trim().toUpperCase();

    if (subtotal == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Select items before applying coupon"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      if (code == "SAVE10") {
        couponApplied = true;
        appliedCouponCode = code;
        couponDiscount = subtotal * 0.10;
      } else if (code == "FLAT50" && subtotal >= 300) {
        couponApplied = true;
        appliedCouponCode = code;
        couponDiscount = 50;
      } else {
        couponApplied = false;
        appliedCouponCode = "";
        couponDiscount = 0;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          couponApplied
              ? "Coupon applied successfully"
              : "Invalid coupon or conditions not met",
        ),
        backgroundColor:
            couponApplied ? const Color(0xFF041AA5) : Colors.redAccent,
      ),
    );
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  void _goToCheckout() {
    final selectedItems = cartItems.where((item) => item.selected).toList();

    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one item to checkout.'),
          backgroundColor: Color(0xFF041AA5),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutScreen(
          items: selectedItems,
          customerName: userName,
          customerAddress: userAddress,
          customerPhone: userPhone,
          selectedPaymentMethod: selectedPaymentMethod,
          deliveryTime: deliveryTime,
          couponCode: appliedCouponCode,
          couponDiscount: couponDiscount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
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
                    "My Cart",
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
                  child: Icon(
                    PhosphorIcons.dotsThreeOutline(),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: cartItems.isEmpty
                ? _buildEmptyCart()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCartTopInfo(),
                        const SizedBox(height: 18),
                        ...List.generate(cartItems.length, (index) {
                          final item = cartItems[index];
                          return _buildCartItem(item, index);
                        }),
                        const SizedBox(height: 20),
                        _buildCouponSection(),
                        const SizedBox(height: 20),
                        _buildDeliveryInfo(),
                        const SizedBox(height: 20),
                        _buildPersonalDetailsBox(),
                        const SizedBox(height: 20),
                        _buildPaymentSection(),
                        const SizedBox(height: 20),
                        _buildBillSummary(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
          ),
          if (cartItems.isNotEmpty) _buildBottomCheckoutBar(),
        ],
      ),
    );
  }

  Widget _buildCartTopInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cart Overview",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF041AA5),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF041AA5).withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "$selectedCount item(s) selected",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isAllSelected,
                    activeColor: const Color(0xFF041AA5),
                    onChanged: (value) => _toggleSelectAll(value ?? false),
                  ),
                  const Text(
                    "Select All",
                    style: TextStyle(
                      color: Color(0xFF041AA5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              item.image,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 75,
                  height: 75,
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.weight,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _quantityButton(
                      icon: Icons.remove,
                      onTap: () => _decreaseQuantity(index),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF041AA5),
                        ),
                      ),
                    ),
                    _quantityButton(
                      icon: Icons.add,
                      onTap: () => _increaseQuantity(index),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => _removeItem(index),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: item.selected,
                      activeColor: const Color(0xFF041AA5),
                      onChanged: (value) {
                        setState(() {
                          item.selected = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "₹${(item.price * item.quantity).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "₹${item.price.toStringAsFixed(2)} each",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF041AA5).withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 16,
          color: const Color(0xFF041AA5),
        ),
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
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
          const Text(
            "Apply Coupon",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF041AA5),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: couponController,
                  decoration: InputDecoration(
                    hintText: "Enter code (SAVE10 / FLAT50)",
                    filled: true,
                    fillColor: const Color(0xFFF5F6FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _applyCoupon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF041AA5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Apply",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          if (couponApplied) ...[
            const SizedBox(height: 10),
            Text(
              "Coupon applied! You saved ₹${couponDiscount.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.local_shipping_outlined, color: Color(0xFF041AA5)),
              SizedBox(width: 10),
              Text(
                "Delivery Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Estimated delivery: $deliveryTime",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            "Free delivery on orders above ₹100",
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF041AA5).withValues(alpha: 0.1),
        ),
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
                icon: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Color(0xFF041AA5),
                ),
                label: const Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF041AA5),
                    fontWeight: FontWeight.bold,
                  ),
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
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          const SizedBox(height: 5),
          Text(
            userPhone,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Column(
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
    );
  }

  Widget _buildBillSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long, color: Color(0xFF041AA5)),
              SizedBox(width: 10),
              Text(
                "Bill Summary",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF041AA5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildSummaryRow("Subtotal", subtotal),
          _buildSummaryRow("Delivery Fee", deliveryFee),
          _buildSummaryRow("GST (5%)", gst),
          _buildSummaryRow("Discount", -couponDiscount, valueColor: Colors.green),
          const Divider(height: 24),
          _buildSummaryRow(
            "Grand Total",
            totalAmount,
            isBold: true,
            valueColor: const Color(0xFF041AA5),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    double amount, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: isBold ? 16 : 14,
            ),
          ),
          Text(
            amount < 0
                ? "- ₹${amount.abs().toStringAsFixed(2)}"
                : "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: isBold ? 16 : 14,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckoutBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 18, 25, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
          const SizedBox(height: 8),
          if (couponDiscount > 0)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "You saved ₹${couponDiscount.toStringAsFixed(2)} on this order",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: _goToCheckout,
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
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 90,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            const Text(
              "Your cart is empty",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF041AA5),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Looks like you haven’t added anything yet.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF041AA5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
              ),
              child: const Text(
                "Continue Shopping",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
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
          style: TextStyle(
            color: Color(0xFF041AA5),
            fontWeight: FontWeight.bold,
          ),
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
                userName = nameController.text.trim();
                userAddress = addressController.text.trim();
                userPhone = phoneController.text.trim();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF041AA5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
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
    final bool isSelected = selectedPaymentMethod == value;

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
          color: isSelected
              ? const Color(0xFF041AA5).withValues(alpha: 0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF041AA5)
                : Colors.grey.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF041AA5) : Colors.grey,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  color:
                      isSelected ? const Color(0xFF041AA5) : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF041AA5),
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}