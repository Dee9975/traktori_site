import 'package:flutter/material.dart';
import 'package:lauki_web/theme.dart';

void main() {
  runApp(const MyApp());
}

class MenuItem {
  final String name;
  final int price;
  final String description;
  final String? image;

  MenuItem({
    required this.name,
    required this.price,
    required this.description,
    this.image,
  });
}

List<MenuItem> items = [
  MenuItem(
    name: "Plānās pankūkas ar pašmāju ievārijumiem",
    description: "Pieejamie ievārijumi: upeņu, aveņu",
    price: 500,
  ),
  MenuItem(
    name: "Plānās pankūkas ar sieru",
    description: " ",
    image: "images/cheese_pancake.jpg",
    price: 500,
  ),
  MenuItem(
    name: "Plānās pankūkas ar žāvētu vistas gaļu un sieru",
    description: "",
    price: 700,
  ),
  MenuItem(
      name:
          "Skābu kāpostu zupa pasniegta ar pašceptu sēklu maizi vai ar mizu ceptu kartupeli",
      description: "",
      price: 500,
      image: "images/soup.jpg"),
];

List<MenuItem> dessertItems = [
  MenuItem(
      name: "Burbuļvafeles ar saldējumu vai putukrējumu",
      price: 600,
      description: " ",
      image: "images/vafele.jpg"),
  MenuItem(
      name: "Zefīri", price: 150, description: "", image: "images/zefirs.jpg"),
  MenuItem(
    name: "Makarūni",
    price: 180,
    description: "",
    image: "images/mac.jpg",
  ),
];

List<MenuItem> drinksMenu = [
  MenuItem(
    name: "Koktelis 1",
    price: 180,
    description: "",
  ),
  MenuItem(
    name: "Koktelis 2",
    price: 180,
    description: "",
  ),
  MenuItem(
    name: "Koktelis 3",
    price: 180,
    description: "",
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      "Abhaya Libre",
      "Abhaya Libre",
    );

    final MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.dark(),
      home: const Scaffold(
        body: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset("images/tractor.jpg"),
            Positioned(
              top: 16,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: const Text(
                  "Pie kāpurķēžu traktora",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Ēdienkarte",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
        ...items.map((e) => MenuItemTile(item: e)),
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Deserti",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
        ...dessertItems.map((e) => MenuItemTile(item: e)),
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Dzērienkarte",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
        ...drinksMenu.map((e) => MenuItemTile(item: e)),
      ],
    );
  }
}

class MenuItemTile extends StatefulWidget {
  const MenuItemTile({required this.item, super.key});

  final MenuItem item;

  @override
  State<MenuItemTile> createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: !expanded && widget.item.image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(widget.item.image!),
            )
          : null,
      title: Text(
        widget.item.name,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        "€ ${widget.item.price / 100}",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      onExpansionChanged: (value) {
        setState(() {
          expanded = value;
        });
      },
      children: [
        if (widget.item.description.isNotEmpty || widget.item.image != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.item.image != null) ...[
                  const SizedBox(
                    width: 16,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.item.image!,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ],
                const SizedBox(
                  width: 16,
                ),
                Text(
                  widget.item.description,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
