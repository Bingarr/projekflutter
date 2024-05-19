import 'package:flutter/material.dart';
import 'package:trashgrab/providers/bookmark_provider.dart';
import 'package:trashgrab/screens/bookmark_page.dart';
import 'package:trashgrab/models/item_model.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<Map<String, dynamic>> itemsList = [
    {
      'title': 'Kaleng',
      'subtitle': 'Rp 5000/kg',
      'isFavorite': false,
      'image': 'assets/icons/kaleng.png',
    },
    {
      'title': 'Plastik',
      'subtitle': 'Rp 4500/kg',
      'isFavorite': false,
      'image': 'assets/icons/sampah-plastik.webp',
    },
    {
      'title': 'Kardus',
      'subtitle': 'Rp 4000/kg ',
      'isFavorite': false,
      'image': 'assets/icons/kardus.png',
    },
    {
      'title': 'Kertas',
      'subtitle': 'Rp 3000/kg',
      'isFavorite': false,
      'image': 'assets/icons/kertas.jpg',
    },
    {
      'title': 'Besi',
      'subtitle': 'Rp 6000/kg',
      'isFavorite': false,
      'image': 'assets/icons/besi.jpg',
    },
    {
      'title': 'Sampah Organik',
      'subtitle': 'Rp 0/kg',
      'isFavorite': false,
      'image': 'assets/icons/sampah-organik.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          "Daftar Jenis Sampah",
          textAlign: TextAlign.center,
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 21, 111, 24),
        actions: [
          Row(
            children: [
              Text(provider.count.toString()),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookmarksPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(itemsList[index]['image']),
                        radius: 35,
                      ),
                      onTap: () {
                        provider.addCount();

                        ItemModel itemModel = ItemModel(
                          title: itemsList[index]['title'],
                          subTitle: itemsList[index]['subtitle'],
                          isFavorite: !itemsList[index]['isFavorite'],
                        );

                        provider.addItems(itemModel);

                        setState(() {
                          itemsList[index]['status'] = true;
                          itemsList[index]['isFavorite'] =
                              !itemsList[index]['isFavorite'];
                          // Update status favorit
                        });
                      },
                      title: Text(itemsList[index]['title']),
                      subtitle: Text(itemsList[index]['subtitle']),
                      trailing: itemsList[index]['isFavorite']
                          ? const Icon(Icons.add_box_outlined,
                              color: Colors.blue)
                          : const Icon(Icons.add_box),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
