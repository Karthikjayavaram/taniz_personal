import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tanizkart/models/cart_item.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> items;

  const CheckoutScreen({super.key, required this.items});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late List<CartItem> _items;

  // ─── Brand Colors ──────────────────────────────────────────────────────────
  static const Color _primaryBlue = Color(0xFF041AA5);
  static const Color _accentYellow = Color(0xFFFECE02);
  static const Color _bgColor = Color(0xFFF4F6FF);

  // ─── Bill Computation ──────────────────────────────────────────────────────
  double get _itemTotal =>
      _items.fold(0.0, (sum, item) => sum + item.subtotal);

  double get _gst => _itemTotal * 0.05;

  double get _deliveryFee => _itemTotal >= 199 ? 0.0 : 40.0;

  double get _discount => _itemTotal >= 150 ? _itemTotal * 0.10 : 0.0;

  double get _platformFee => 5.0;

  double get _grandTotal =>
      _itemTotal - _discount + _deliveryFee + _gst + _platformFee;

  @override
  void initState() {
    super.initState();
    // deep-copy so changes don't affect the parent CartScreen
    _items = widget.items.map((e) => e.copy()).toList();
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  void _increaseQty(int index) {
    setState(() => _items[index].quantity++);
  }

  void _decreaseQty(int index) {
    if (_items[index].quantity <= 1) {
      _showRemoveDialog(index);
    } else {
      setState(() => _items[index].quantity--);
    }
  }

  void _showRemoveDialog(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Remove item?',
          style: TextStyle(
              color: _primaryBlue, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          'Remove "${_items[index].name}" from your order?',
          style: const TextStyle(color: Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _removeItem(index);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child:
                const Text('Remove', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _OrderSuccessSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: _items.isEmpty
                ? _buildEmptyState(context)
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Order Items', '${_items.length} items'),
                        const SizedBox(height: 12),
                        ..._buildItemCards(),
                        const SizedBox(height: 12),
                        _buildAddMoreButton(context),
                        const SizedBox(height: 24),
                        _buildBillDetails(),
                        const SizedBox(height: 24),
                        _buildSavingsBadge(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _items.isEmpty ? null : _buildPlaceOrderBar(),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: _primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 18),
                ),
              ),
              const Expanded(
                child: Text(
                  'Checkout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              // Secure badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.5)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lock_outline, color: Colors.greenAccent, size: 12),
                    SizedBox(width: 4),
                    Text(
                      'Secure',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _progressStep('Cart', true, isFirst: true),
                _progressDivider(true),
                _progressStep('Checkout', true),
                _progressDivider(false),
                _progressStep('Payment', false),
                _progressDivider(false),
                _progressStep('Done', false, isLast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressStep(String label, bool active,
      {bool isFirst = false, bool isLast = false}) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: active ? _accentYellow : Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: active
                ? const Icon(Icons.check, color: _primaryBlue, size: 14)
                : Icon(Icons.circle, color: Colors.white30, size: 8),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: active ? _accentYellow : Colors.white38,
            fontSize: 10,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _progressDivider(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
        decoration: BoxDecoration(
          color: active
              ? _accentYellow.withValues(alpha: 0.7)
              : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  // ─── Section Title ─────────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _primaryBlue,
              letterSpacing: 0.2),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            subtitle,
            style: const TextStyle(
                fontSize: 12,
                color: _primaryBlue,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  // ─── Item Cards ────────────────────────────────────────────────────────────
  List<Widget> _buildItemCards() {
    return List.generate(_items.length, (index) {
      final item = _items[index];
      return Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  item.image,
                  width: 76,
                  height: 76,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(PhosphorIcons.image(),
                        color: Colors.grey[400], size: 30),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF1A1A2E)),
                          ),
                        ),
                        // Delete button
                        GestureDetector(
                          onTap: () => _removeItem(index),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.delete_outline,
                                color: Colors.redAccent, size: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.weight,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Quantity stepper
                        Container(
                          decoration: BoxDecoration(
                            color: _primaryBlue.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              _stepperBtn(
                                  icon: Icons.remove,
                                  onTap: () => _decreaseQty(index)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  '${item.quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: _primaryBlue),
                                ),
                              ),
                              _stepperBtn(
                                  icon: Icons.add,
                                  onTap: () => _increaseQty(index)),
                            ],
                          ),
                        ),
                        // Subtotal
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₹${item.subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: _primaryBlue),
                            ),
                            if (item.quantity > 1)
                              Text(
                                '₹${item.price.toStringAsFixed(2)} each',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 11),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _stepperBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          color: _primaryBlue,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  // ─── Add More ──────────────────────────────────────────────────────────────
  Widget _buildAddMoreButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _primaryBlue.withValues(alpha: 0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
                color: _primaryBlue.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: _primaryBlue.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.add, color: _primaryBlue, size: 16),
            ),
            const SizedBox(width: 10),
            const Text(
              'Add More Products',
              style: TextStyle(
                  color: _primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Bill Details ──────────────────────────────────────────────────────────
  Widget _buildBillDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 6))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
            decoration: const BoxDecoration(
              color: _primaryBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Icon(Icons.receipt_long_outlined,
                    color: Colors.white, size: 20),
                const SizedBox(width: 10),
                const Text(
                  'Bill Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_items.length} item${_items.length > 1 ? 's' : ''}',
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          // Bill rows
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                _billRow(
                  label: 'Item Total',
                  value: '₹${_itemTotal.toStringAsFixed(2)}',
                  icon: Icons.shopping_bag_outlined,
                  iconColor: Colors.blue,
                ),
                _billDivider(),
                _billRow(
                  label: 'GST (5%)',
                  value: '₹${_gst.toStringAsFixed(2)}',
                  icon: Icons.account_balance_outlined,
                  iconColor: Colors.orange,
                ),
                _billDivider(),
                _billRow(
                  label: 'Delivery Fee',
                  value: _deliveryFee == 0
                      ? 'FREE'
                      : '₹${_deliveryFee.toStringAsFixed(2)}',
                  icon: Icons.delivery_dining_outlined,
                  iconColor: Colors.teal,
                  valueColor: _deliveryFee == 0 ? Colors.green : Colors.black87,
                  valueBold: _deliveryFee == 0,
                  hint: _deliveryFee != 0
                      ? 'Free above ₹199'
                      : null,
                ),
                _billDivider(),
                _billRow(
                  label: 'Platform Fee',
                  value: '₹${_platformFee.toStringAsFixed(2)}',
                  icon: Icons.devices_outlined,
                  iconColor: Colors.purple,
                ),
                if (_discount > 0) ...[
                  _billDivider(),
                  _billRow(
                    label: 'Discount (10%)',
                    value: '− ₹${_discount.toStringAsFixed(2)}',
                    icon: Icons.local_offer_outlined,
                    iconColor: Colors.green,
                    valueColor: Colors.green,
                    valueBold: true,
                  ),
                ],
                const SizedBox(height: 14),
                Container(height: 1.5, color: _primaryBlue.withValues(alpha: 0.12)),
                const SizedBox(height: 14),
                // Grand total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount Payable',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF1A1A2E)),
                    ),
                    Text(
                      '₹${_grandTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: _primaryBlue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _billRow({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
    Color valueColor = Colors.black87,
    bool valueBold = false,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 13, color: Colors.black54)),
                if (hint != null)
                  Text(hint,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: valueBold ? FontWeight.bold : FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _billDivider() =>
      Container(height: 1, color: Colors.grey.withValues(alpha: 0.1));

  // ─── Savings Badge ─────────────────────────────────────────────────────────
  Widget _buildSavingsBadge() {
    if (_discount == 0 && _deliveryFee != 0) return const SizedBox.shrink();
    final savings = _discount + (_deliveryFee == 0 ? 40 : 0);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withValues(alpha: 0.12),
            Colors.teal.withValues(alpha: 0.08)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.celebration_outlined,
              color: Colors.green, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    const TextStyle(fontSize: 13, color: Colors.black87),
                children: [
                  const TextSpan(text: 'You\'re saving '),
                  TextSpan(
                    text: '₹${savings.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  const TextSpan(text: ' on this order! 🎉'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Empty State ───────────────────────────────────────────────────────────
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(PhosphorIcons.shoppingCartSimple(),
              size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            'Your cart is empty',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to proceed with checkout',
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Browse Products'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Place Order Bar ───────────────────────────────────────────────────────
  Widget _buildPlaceOrderBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4))
        ],
      ),
      child: Row(
        children: [
          // Mini total summary
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Payable',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(
                  '₹${_grandTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: _primaryBlue),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // CTA
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: _placeOrder,
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF041AA5), Color(0xFF2A4FFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: _primaryBlue.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 6))
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined,
                        color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Place Order',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Order Success Bottom Sheet ────────────────────────────────────────────────
class _OrderSuccessSheet extends StatelessWidget {
  const _OrderSuccessSheet();

  static const Color _primaryBlue = Color(0xFF041AA5);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.check_circle, color: Colors.green, size: 48),
          ),
          const SizedBox(height: 20),
          const Text(
            'Order Placed! 🎉',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: _primaryBlue),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your order has been placed successfully.\nWe\'ll deliver it to you shortly.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black45, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // close sheet
                Navigator.of(context).pop(); // back to cart
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text(
                'Back to Shopping',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
