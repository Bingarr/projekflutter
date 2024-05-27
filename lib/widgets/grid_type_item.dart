import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/space_extension.dart';

class GridTypeItem extends StatelessWidget {
  const GridTypeItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.harga,
    required this.onTap,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String harga;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Widget imageChild = Icon(
      Icons.image_not_supported_outlined,
      size: 120,
      color: Colors.grey[400],
    );

    if (imageUrl != '') {
      imageChild = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: 120,
        errorWidget: (context, url, error) {
          return Icon(
            Icons.image_not_supported_outlined,
            size: 120,
            color: Colors.grey[400],
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 232, 232),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageChild,
          ),
          12.verticalSpace,
          Text(
            name,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          5.verticalSpace,
          Text(
            harga,
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ),
    ).extCupertino(onTap: onTap);
  }
}
