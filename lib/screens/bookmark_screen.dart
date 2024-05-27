import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/providers/auth_provider.dart';
import 'package:trashgrab/providers/base_provider.dart';
import 'package:trashgrab/providers/bookmark_provider.dart';
import 'package:trashgrab/utils/extensions/date_format.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/bookmark_item.dart';
import 'package:trashgrab/widgets/custom_icon_button.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookmarkProvider>(context);
    final authProvider = Provider.of<MyAuthProvider>(context);
    final baseProvider = Provider.of<BaseProvider>(context);
    final addressCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Penjemputan'),
        backgroundColor: const Color.fromARGB(255, 21, 111, 24),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Text(
              'Tanggal Penjemputan',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            10.verticalSpace,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                provider.dateValue.toFormatGeneralDate(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ),
            10.verticalSpace,
            Text(
              'Alamat',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            10.verticalSpace,
            TextFormField(
              controller: addressCtrl,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: 'Masukan alamat',
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
              'List Item',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            10.verticalSpace,
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: provider.itemsList.length,
              separatorBuilder: (context, index) => 10.verticalSpace,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return BookmarkItem(
                  data: provider.itemsList[index],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          top: 10,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Row(
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Text(
                  provider.total.formatNumber2(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                5.horizontalSpace,
              ],
            ),
            10.verticalSpace,
            CustomIconButton(
              onTap: () {
                if (addressCtrl.text.isEmpty) {
                  doSnackbar(context, 'Please fill the field');
                } else {
                  provider.createTransaction(
                    context: context,
                    nama: authProvider.data?['username'] ?? '-',
                    alamat: addressCtrl.text,
                    onTap: () => baseProvider.changeIndex(1),
                  );
                }
              },
              color: kPrimaryColor,
              width: double.infinity,
              height: 50,
              child: const Text(
                "Ajukan Penjemputan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
