class CartItem {
  CartItem({
    required this.name,
    required this.price,
    required this.weight,
    required this.image,
    this.selected = true,
    this.quantity = 1,
  });

  final String name;
  final double price;
  final String weight;
  final String image;
  bool selected;
  int quantity;

  /// Price × quantity
  double get subtotal => price * quantity;

  CartItem copy() {
    return CartItem(
      name: name,
      price: price,
      weight: weight,
      image: image,
      selected: selected,
      quantity: quantity,
    );
  }
}
