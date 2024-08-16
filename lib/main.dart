import 'package:flutter/foundation.dart';
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

String releasePath = kDebugMode ? '' : 'assets/';

List<MenuItem> items = [
  MenuItem(
    name: "Plānās pankūkas ar pašmāju ievārijumiem",
    description:
        "Izvēlies ievārījumu:\n\t\t\tupeņu-apelsīnu\n\t\t\tzemeņu\n\t\t\tēkšķogu\n\t\t\trabarberu-banānu",
    price: 500,
  ),
  MenuItem(
    name: "Plānās pankūkas ar sieru",
    description: " ",
    image: "${releasePath}images/cheese_pancake.jpg",
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
    image: "${releasePath}images/soup.jpg",
  ),
];

List<MenuItem> dessertItems = [
  MenuItem(
      name: "Burbuļvafeles ar saldējumu vai putukrējumu",
      price: 650,
      description:
          "Izvēlies 2 no šīm garšām:\n\t\t\tvaniļa\n\t\t\tcitronu sorberts\n\t\t\tzemeņu sorberts",
      image: "${releasePath}images/vafele.jpg"),
  MenuItem(
    name: "Zefīri",
    price: 150,
    description: "",
    image: "${releasePath}images/zefirs.jpg",
  ),
  MenuItem(
    name: "Makarūni",
    price: 180,
    description: "",
    image: "${releasePath}images/mac.jpg",
  ),
];

List<MenuItem> drinksMenu = [
  MenuItem(
    name: "Aveņu bazilika fizz",
    price: 150,
    description: "",
  ),
  MenuItem(
    name: "Pašmāju mohito",
    price: 150,
    description: "",
  ),
  MenuItem(
    name: "Rabarberu rozmarīna svaigums",
    price: 150,
    description: "",
  ),
  MenuItem(
    name: "Krūka ar garšīgu ūdeni",
    price: 150,
    description: "",
    image: "${releasePath}images/udens.jpg",
  ),
  MenuItem(
    name: "Krūka ar pašmāju limonādi",
    price: 450,
    description:
        "Izvēlies no šīm garšām:\n\taveņu\n\tupeņu\n\tcidoniju\n\trabarberu\n\tpiparmētru",
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
            Image.asset("${releasePath}images/tractor.jpg"),
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
                      width: 150,
                    ),
                  ),
                ],
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    widget.item.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
