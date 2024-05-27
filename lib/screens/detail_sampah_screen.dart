import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trashgrab/providers/type_provider.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/custom_icon_button.dart';

class DetailSampahScreen extends StatelessWidget {
  const DetailSampahScreen({
    Key? key,
    required this.imageUrl,
    required this.idType,
    required this.harga,
    required this.nama,
  }) : super(key: key);

  final String imageUrl;
  final String idType;
  final String harga;
  final String nama;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TypeProvider>();
    Widget imageChild = Icon(
      Icons.image_not_supported_outlined,
      size: 80,
      color: Colors.grey[400],
    );

    if (imageUrl != '') {
      imageChild = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Icon(
            Icons.image_not_supported_outlined,
            size: 80,
            color: Colors.grey[400],
          );
        },
      );
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Sampah'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.verticalSpace,
                imageChild,
                15.verticalSpace,
                Text(
                  nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                5.verticalSpace,
                Text(
                  harga,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                15.verticalSpace,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(
            children: [
              20.horizontalSpace,
              CustomIconButton(
                onTap: () => provider.likeOrUnlikeType(idType),
                height: 45,
                width: 45,
                child: Icon(
                  provider.statusLike
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Colors.pink,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: CustomIconButton(
                  onTap: () {
                    pop(context, result: true);
                  },
                  color: kPrimaryColor,
                  height: 45,
                  width: 45,
                  child: const Text(
                    "Pick Up Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              20.horizontalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
