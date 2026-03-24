import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

const _categories = [
  {
    'label': 'Fruits',
    'color': Color(0xFFFF6B6B),
    'icon': '🍎',
    'products': [
      {
        'name': 'Red Apples',
        'price': '₹120',
        'unit': '1 kg',
        'image':
            'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Bananas',
        'price': '₹50',
        'unit': '6 pcs',
        'image':
            'https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Mango',
        'price': '₹90',
        'unit': '2 pcs',
        'image':
            'https://images.unsplash.com/photo-1553279768-865429fa0078?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Grapes',
        'price': '₹80',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Orange',
        'price': '₹60',
        'unit': '4 pcs',
        'image':
            'https://images.unsplash.com/photo-1547514701-42782101795e?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Pineapple',
        'price': '₹70',
        'unit': '1 pc',
        'image':
            'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=200&q=80&auto=format&fit=crop'
      },
    ],
  },
  {
    'label': 'Vegetables',
    'color': Color(0xFF51CF66),
    'icon': '🥦',
    'products': [
      {
        'name': 'Tomato',
        'price': '₹40',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1596733430284-f7437764b1a9?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Broccoli',
        'price': '₹60',
        'unit': '1 head',
        'image':
            'https://images.unsplash.com/photo-1584270354949-c26b0d5b4a0c?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Carrots',
        'price': '₹30',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Bell Pepper',
        'price': '₹50',
        'unit': '3 pcs',
        'image':
            'https://images.unsplash.com/photo-1563203369-26f2e4a5ccf7?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Spinach',
        'price': '₹25',
        'unit': '250 g',
        'image':
            'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Potato',
        'price': '₹35',
        'unit': '1 kg',
        'image':
            'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=200&q=80&auto=format&fit=crop'
      },
    ],
  },
  {
    'label': 'Dairy Products',
    'color': Color(0xFF4DABF7),
    'icon': '🥛',
    'products': [
      {
        'name': 'Full Cream Milk',
        'price': '₹60',
        'unit': '1 L',
        'image':
            'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Butter',
        'price': '₹55',
        'unit': '100 g',
        'image':
            'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Cheese Slice',
        'price': '₹80',
        'unit': '200 g',
        'image':
            'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Curd',
        'price': '₹40',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Paneer',
        'price': '₹90',
        'unit': '200 g',
        'image':
            'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Cream',
        'price': '₹45',
        'unit': '200 ml',
        'image':
            'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=200&q=80&auto=format&fit=crop'
      },
    ],
  },
  {
    'label': 'Bakery Items',
    'color': Color(0xFFFFD43B),
    'icon': '🍞',
    'products': [
      {
        'name': 'White Bread',
        'price': '₹35',
        'unit': '400 g',
        'image':
            'https://images.unsplash.com/photo-1598373182133-52452f7691ef?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Croissant',
        'price': '₹30',
        'unit': '2 pcs',
        'image':
            'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Muffin',
        'price': '₹25',
        'unit': '1 pc',
        'image':
            'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Pita Bread',
        'price': '₹40',
        'unit': '4 pcs',
        'image':
            'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Cake Slice',
        'price': '₹60',
        'unit': '1 pc',
        'image':
            'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Bagel',
        'price': '₹45',
        'unit': '2 pcs',
        'image':
            'https://images.unsplash.com/photo-1586444248902-2f64eddc13df?w=200&q=80&auto=format&fit=crop'
      },
    ],
  },
  {
    'label': 'Snacks',
    'color': Color(0xFFFF922B),
    'icon': '🍿',
    'products': [
      {
        'name': 'Potato Chips',
        'price': '₹30',
        'unit': '150 g',
        'image':
            'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Popcorn',
        'price': '₹25',
        'unit': '100 g',
        'image':
            'https://images.unsplash.com/photo-1585647347483-22b66260dfff?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Cookies',
        'price': '₹55',
        'unit': '200 g',
        'image':
            'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Crackers',
        'price': '₹40',
        'unit': '150 g',
        'image':
            'https://images.unsplash.com/photo-1574894709920-11b28be1d80d?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Granola Bar',
        'price': '₹35',
        'unit': '1 pc',
        'image':
            'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Nachos',
        'price': '₹45',
        'unit': '200 g',
        'image':
            'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=200&q=80&auto=format&fit=crop'
      },
    ],
  },
  {
    'label': 'Beverages',
    'color': Color(0xFF20C997),
    'icon': '🧃',
    'products': [
      {
        'name': 'Orange Juice',
        'price': '₹70',
        'unit': '1 L',
        'image':
            'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Green Tea',
        'price': '₹50',
        'unit': '25 bags',
        'image':
            'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Cold Coffee',
        'price': '₹80',
        'unit': '250 ml',
        'image':
            'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Coconut Water',
        'price': '₹40',
        'unit': '500 ml',
        'image':
            'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Sparkling Water',
        'price': '₹35',
        'unit': '500 ml',
        'image':
            'https://images.unsplash.com/photo-1559839877-5427b5bb42e9?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Mango Lassi',
        'price': '₹55',
        'unit': '300 ml',
        'image':
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=200&q=80&auto=format&fit=crop'
      },
    ],
  },
  {
    'label': 'Meat & Fish',
    'color': Color(0xFFE64980),
    'icon': '🍗',
    'products': [
      {
        'name': 'Chicken Breast',
        'price': '₹180',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1604503468506-a8da13d11c02?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Eggs',
        'price': '₹80',
        'unit': '12 pcs',
        'image':
            'https://images.unsplash.com/photo-1598965402089-897ce52e8355?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Fish Fillet',
        'price': '₹220',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Mutton',
        'price': '₹350',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1602473774892-6e56fb3ad24e?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Prawns',
        'price': '₹280',
        'unit': '250 g',
        'image':
            'https://images.unsplash.com/photo-1565680018434-b513d5e5fd47?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Salmon',
        'price': '₹400',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=200&q=80&auto=format&fit=crop'
      },
    ],
  },
  {
    'label': 'Frozen Foods',
    'color': Color(0xFF748FFC),
    'icon': '🧊',
    'products': [
      {
        'name': 'Frozen Pizza',
        'price': '₹150',
        'unit': '1 pc',
        'image':
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Ice Cream',
        'price': '₹120',
        'unit': '500 ml',
        'image':
            'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Frozen Peas',
        'price': '₹55',
        'unit': '500 g',
        'image':
            'https://images.unsplash.com/photo-1576161787924-01fc0cf4ebb6?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Nuggets',
        'price': '₹180',
        'unit': '400 g',
        'image':
            'https://images.unsplash.com/photo-1562967914-608f82629710?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Frozen Samosa',
        'price': '₹70',
        'unit': '10 pcs',
        'image':
            'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=200&q=80&auto=format&fit=crop'
      },
      {
        'name': 'Waffles',
        'price': '₹90',
        'unit': '4 pcs',
        'image':
            'https://images.unsplash.com/photo-1562376552-0d160a2f238d?w=200&q=80&auto=format&fit=crop'
      },
    ],
  },
];

class StoreScreen extends StatelessWidget {
  final int? scrollToCategoryIndex;

  const StoreScreen({super.key, this.scrollToCategoryIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF041AA5),
            expandedHeight: 180,
            collapsedHeight: 112,
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF041AA5),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                                    'TK',
                                    style: TextStyle(
                                      color: Color(0xFF041AA5),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'taniz',
                                        style: TextStyle(
                                          color: Color(0xFFFECE02),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Kart',
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
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                PhosphorIcons.shoppingBag(),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                PhosphorIcons.magnifyingGlass(),
                                color: Colors.grey[400],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search products...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 22, 20, 4),
              child: Text(
                'Shop by Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final cat = _categories[index];
                return _CategorySection(category: cat);
              },
              childCount: _categories.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 110),
          ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final Map<String, dynamic> category;

  const _CategorySection({required this.category});

  @override
  Widget build(BuildContext context) {
    final color = category['color'] as Color;
    final products = List<Map<String, String>>.from(
      category['products'] as List,
    );

    final rows = <List<Map<String, String>>>[];
    for (int i = 0; i < products.length; i += 2) {
      final end = (i + 2 < products.length) ? i + 2 : products.length;
      rows.add(products.sublist(i, end));
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      category['icon'] as String,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category['label'] as String,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: color,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 308,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                left: 14,
                right: 6,
                bottom: 14,
              ),
              itemCount: rows.length,
              itemBuilder: (context, colIndex) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: rows[colIndex]
                      .map(
                        (product) => _ProductCard(
                          product: product,
                          accentColor: color,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, String> product;
  final Color accentColor;

  const _ProductCard({
    required this.product,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 132,
      margin: const EdgeInsets.only(right: 10, bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),
            child: Image.network(
              product['image']!,
              width: 120,
              height: 70,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 120,
                  height: 70,
                  alignment: Alignment.center,
                  color: Colors.grey.shade100,
                  child: const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                width: 120,
                height: 70,
                color: accentColor.withOpacity(0.1),
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: accentColor,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          product['name']!,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                            height: 1.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Text(
                          product['unit']!,
                          style: TextStyle(
                            fontSize: 8.5,
                            color: Colors.grey[500],
                            height: 1.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Text(
                          product['price']!,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 14,
                      ),
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