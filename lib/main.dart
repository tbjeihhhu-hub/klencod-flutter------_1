
import 'package:flutter/material.dart';

void main() {
  runApp(const SouqApp());
}

const Color cream = Color(0xFFFFF9EE);
const Color yellow = Color(0xFFFFD76A);
const Color brown = Color(0xFF59452E);
const Color green = Color(0xFF8DAA91);

class SouqApp extends StatelessWidget {
  const SouqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سوق ال حمادي',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: yellow,
          surface: cream,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MarketPage(),
    );
  }
}

class Product {
  final String name;
  final String price;
  final String description;
  final String phone;
  final String category;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.phone,
    required this.category,
  });
}

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final List<Product> products = [];
  final TextEditingController searchController =
      TextEditingController();

  String selectedCategory = 'الكل';

  final List<String> categories = [
    'الكل',
    'سيارات',
    'موبايلات',
    'عقارات',
    'أثاث',
    'ملابس',
    'أجهزة',
    'مواشي',
    'أخرى',
  ];

  List<Product> get filteredProducts {
    return products.where((p) {
      final matchesCategory = selectedCategory == 'الكل' ||
          p.category == selectedCategory;

      final matchesSearch = p.name
          .contains(searchController.text.trim());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void addProduct(Product product) {
    setState(() {
      products.insert(0, product);
    });
  }

  void openAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddProductPage(
          onAdd: addProduct,
          categories: categories.where((e) => e != 'الكل').toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cream,
          elevation: 0,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'سوق ال حمادي 🛍️',
                style: TextStyle(
                  color: brown,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'بيع واشتري بكل سهولة',
                style: TextStyle(
                  color: green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_outline, color: brown),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'سوقك بين إيديك 💛',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: brown,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'اعرض غرضك للبيع أو ابحث عن اللي تحتاجه',
                          style: TextStyle(
                            color: brown,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'مفتوح 24 ساعة طوال الأسبوع',
                          style: TextStyle(
                            color: brown,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.storefront_rounded,
                    size: 65,
                    color: brown,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'شنو تريد تبحث عنه؟',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 43,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: categories.map((category) {
                  final selected = selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      selectedColor: yellow,
                      backgroundColor: Colors.white,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(18, 20, 18, 12),
              child: Row(
                children: [
                  Text(
                    'أحدث الإعلانات',
                    style: TextStyle(
                      color: brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'السوق مفتوح 🛍️',
                    style: TextStyle(color: green, fontSize: 12),
                  ),
                ],
              ),
            ),

            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            size: 75,
                            color: Color(0xFFD7C8A8),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'ماكو إعلانات حالياً',
                            style: TextStyle(
                              fontSize: 18,
                              color: brown,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'كن أول شخص ينشر إعلان بالسوق',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 15),
                          FilledButton(
                            onPressed: openAddPage,
                            child: const Text('أضف أول إعلان'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final p = filteredProducts[index];

                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(14),
                            leading: const CircleAvatar(
                              backgroundColor: cream,
                              child: Icon(
                                Icons.shopping_bag,
                                color: brown,
                              ),
                            ),
                            title: Text(
                              p.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: brown,
                              ),
                            ),
                            subtitle: Text(
                              '${p.category}\n${p.price} دينار\n${p.description}\nللتواصل: ${p.phone}',
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: openAddPage,
          backgroundColor: yellow,
          foregroundColor: brown,
          icon: const Icon(Icons.add),
          label: const Text(
            'أضف إعلان',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class AddProductPage extends StatefulWidget {
  final Function(Product) onAdd;
  final List<String> categories;

  const AddProductPage({
    super.key,
    required this.onAdd,
    required this.categories,
  });

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final name = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final phone = TextEditingController();

  String category = 'أخرى';

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    description.dispose();
    phone.dispose();
    super.dispose();
  }

  void publish() {
    if (name.text.trim().isEmpty ||
        price.text.trim().isEmpty ||
        phone.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى ملء اسم السلعة والسعر ورقم الهاتف'),
        ),
      );
      return;
    }

    widget.onAdd(
      Product(
        name: name.text.trim(),
        price: price.text.trim(),
        description: description.text.trim(),
        phone: phone.text.trim(),
        category: category,
      ),
    );

    Navigator.pop(context);
  }

  Widget field(String label, TextEditingController controller,
      {int lines = 1, TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: lines,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cream,
          title: const Text(
            'إضافة إعلان جديد',
            style: TextStyle(
              color: brown,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Icon(
              Icons.add_business_rounded,
              size: 75,
              color: green,
            ),
            const SizedBox(height: 18),

            field('اسم السلعة', name),

            field(
              'السعر بالدينار العراقي',
              price,
              type: TextInputType.number,
            ),

            field('وصف السلعة والتفاصيل', description, lines: 3),

            field(
              'رقم الهاتف للتواصل',
              phone,
              type: TextInputType.phone,
            ),

            const Text(
              'اختار القسم',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: brown,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: category,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              items: widget.categories.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text(c),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => category = value);
                }
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: publish,
                icon: const Icon(Icons.publish),
                label: const Text(
                  'نشر الإعلان',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: yellow,
                  foregroundColor: brown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}