import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/providers/type_provider.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/custom_icon_button.dart';

class AddUpdateTypeScreen extends StatefulWidget {
  const AddUpdateTypeScreen({
    Key? key,
    this.name,
    this.harga,
    this.image,
    required this.isEdit,
    this.id,
  }) : super(key: key);

  final String? name;
  final String? harga;
  final String? image;
  final String? id;
  final bool isEdit;

  @override
  State<AddUpdateTypeScreen> createState() => _AddUpdateTypeScreenState();
}

class _AddUpdateTypeScreenState extends State<AddUpdateTypeScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController priceCtrl;
  late TypeProvider provider;

  @override
  void initState() {
    nameCtrl = TextEditingController(text: widget.name);
    priceCtrl = TextEditingController(text: widget.harga ?? '');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    provider = context.watch<TypeProvider>();
    super.didChangeDependencies();
  }

  void validateField(Function onTap) {
    bool fileValidate =
        widget.image != null || widget.image != '' || provider.file != null;
    if (nameCtrl.text.isEmpty ||
        priceCtrl.text.isEmpty ||
        priceCtrl.text == '' ||
        !fileValidate) {
      doSnackbar(context, 'Please fill all field');
    } else {
      onTap();
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    super.dispose();
  }

  Widget content = Icon(
    Icons.add_photo_alternate_outlined,
    size: 80,
    color: kPrimaryColor.withOpacity(0.7),
  );

  @override
  Widget build(BuildContext context) {
    if (provider.file != null) {
      content = Image.file(
        provider.file!,
        fit: BoxFit.cover,
      );
    } else if (widget.image != null && widget.image != '') {
      content = CachedNetworkImage(
        imageUrl: widget.image!,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Icon(
            Icons.add_photo_alternate_outlined,
            size: 80,
            color: kPrimaryColor.withOpacity(0.7),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Jenis Sampah' : 'Tambah Jenis Sampah',
        ),
        actions: [
          if (widget.isEdit) ...[
            const Icon(
              Icons.remove_circle_rounded,
              size: 30,
              color: Colors.red,
            ).extCupertino(
              onTap: () => provider.doDeleteData(
                context: context,
                id: widget.id!,
                image: widget.image ?? '',
              ),
            ),
            10.horizontalSpace,
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            10.verticalSpace,
            TextFormField(
              controller: nameCtrl,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp("[0-9]")),
                FilteringTextInputFormatter.deny(
                  RegExp("~`!@#\$%^&*()_-+=:;{}[]|,./?"),
                ),
                LengthLimitingTextInputFormatter(13),
              ],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            20.verticalSpace,
            Text(
              'Harga',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            10.verticalSpace,
            Row(
              children: [
                Text(
                  'Rp',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                10.horizontalSpace,
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: priceCtrl,
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                15.horizontalSpace,
                Text(
                  '/kg',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              'Gambar',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            10.verticalSpace,
            Container(
              padding: EdgeInsets.zero,
              width: double.infinity,
              height: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black87),
              ),
              child: content.extCupertino(
                onTap: () async {
                  final data = await pickImage(ImageSource.gallery);
                  if (data != null) provider.updateFile(File(data.path));
                },
              ),
            ),
            80.verticalSpace,
            CustomIconButton(
              onTap: () {
                validateField(() {
                  if (widget.isEdit) {
                    provider.doEditData(
                      image: widget.image,
                      context: context,
                      name: nameCtrl.text,
                      harga: priceCtrl.text,
                      id: widget.id!,
                    );
                  } else {
                    provider.doCreateData(
                      context: context,
                      name: nameCtrl.text,
                      harga: priceCtrl.text,
                      id: generateUuid(),
                    );
                  }
                });
              },
              color: kPrimaryColor,
              height: 50,
              width: double.infinity,
              child: Text(
                widget.isEdit ? 'Perbarui' : 'Tambah',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
