import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/providers/activty_provider.dart';
import 'package:trashgrab/providers/base_provider.dart';
import 'package:trashgrab/providers/bookmark_provider.dart';
import 'package:trashgrab/providers/type_provider.dart';
import 'package:trashgrab/screens/activity_screen.dart';
import 'package:trashgrab/screens/jenis_sampah_screen.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/grid_type_item.dart';

class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            _AppBar(),
            _Body(),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TypeProvider>();
    final baseProvider = context.watch<BaseProvider>();
    final activityProvider = context.watch<ActivityProvider>();
    final bookmarkProvider = context.watch<BookmarkProvider>();

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Jadwal Pickup",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildDayContainer(
                          context: context,
                          day: 'Senin',
                          onTap: () async {
                            await bookmarkProvider.pickDateTime(context);
                            if (bookmarkProvider.dateValue != null) {
                              baseProvider.changeIndex(2);
                            }
                          },
                        ),
                        buildDayContainer(
                          context: context,
                          day: 'Rabu',
                          onTap: () async {
                            await bookmarkProvider.pickDateTime(context);
                            if (bookmarkProvider.dateValue != null) {
                              baseProvider.changeIndex(2);
                              doSnackbar(
                                context,
                                'Tanggal Penjemputan terpilih',
                              );
                            }
                          },
                        ),
                        buildDayContainer(
                          context: context,
                          day: 'Jumat',
                          onTap: () async {
                            await bookmarkProvider.pickDateTime(context);
                            if (bookmarkProvider.dateValue != null) {
                              baseProvider.changeIndex(2);
                            }
                          },
                        ),
                        buildDayContainer(
                          context: context,
                          day: 'Sabtu',
                          onTap: () async {
                            await bookmarkProvider.pickDateTime(context);
                            if (bookmarkProvider.dateValue != null) {
                              baseProvider.changeIndex(2);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: provider.streamType,
                    builder: (context, snapshot) {
                      Widget child = Container();

                      if (snapshot.hasError) {
                        child = Center(
                          child: Column(
                            children: [
                              30.verticalSpace,
                              const Text('Something went wrong'),
                            ],
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        child = Center(
                          child: Column(
                            children: [
                              30.verticalSpace,
                              const Text("Loading"),
                            ],
                          ),
                        );
                      } else {
                        encapFunction(
                          () => provider.updateList(snapshot.data?.docs),
                        );
                        int itemCount = snapshot.data?.docs.length ?? 0;

                        child = GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.89,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: itemCount > 4 ? 3 : itemCount,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            final data = snapshot.data!.docs[i];

                            return GridTypeItem(
                              name: data['name'] ?? '-',
                              imageUrl: data['image'] ?? '',
                              harga:
                                  (data['harga'] as int? ?? 0).formatNumber(),
                              onTap: () async {
                                bool navigate = await provider.tapDetailType(
                                  context: context,
                                  nama: data['name'] ?? '-',
                                  image: data['image'] ?? '',
                                  idType: data['id'] ?? '',
                                  listId: provider.listTye![i]['list_id'] ??
                                      <dynamic>[],
                                  harga: (data['harga'] as int? ?? 0)
                                      .formatNumber(),
                                );
                                if (navigate) {
                                  baseProvider.changeIndex(2);
                                }
                              },
                            );
                          },
                        );
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Jenis sampah",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return const JenisSampahScreen();
                                    }),
                                  );
                                },
                                child: Text(
                                  "Lihat lainnya",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: kPrimaryColor),
                                ),
                              ),
                              10.horizontalSpace,
                            ],
                          ),
                          child,
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: activityProvider.streamActivity,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              if (!(snapshot.data!.data()?["status_display"] as bool? ??
                  false)) {
                return const SizedBox();
              }
              final data = snapshot.data!.data();
              List<String> desc = (data?['desc'] as String? ?? '').split(' - ');

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ActivityScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 5),
                        color: Colors.green.shade400.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      desc.first,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'ProductSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      desc.last,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'ProductSans',
                      ),
                    ),
                    leading: const Icon(Icons.fire_truck_rounded),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    tileColor: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDayContainer({
    required BuildContext context,
    required String day,
    required Function() onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 236, 232, 232),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Icon(Icons.date_range_rounded),
              Text(day),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 100,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color.fromARGB(255, 67, 136, 69),
            Color.fromARGB(255, 21, 111, 24),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,\nGood Morning",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // CircleButton(
              //   icon: Icons.notifications,
              //   onPressed: () {},
              // ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // const SearchTextField()
        ],
      ),
    );
  }
}
