import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/providers/staff_provider.dart';
import 'package:trashgrab/providers/transaction_provider.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/my_radio_button.dart';

class StaffBottomSheet extends StatelessWidget {
  const StaffBottomSheet({
    Key? key,
    required this.tap,
  }) : super(key: key);

  final Function() tap;

  @override
  Widget build(BuildContext context) {
    final staffProvider = context.watch<StaffProvider>();
    final provider = context.watch<TransactionProvider>();

    return Wrap(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 8,
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Builder(builder: (context) {
                      if (staffProvider.listRadio.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: staffProvider.listRadio.length,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        separatorBuilder: (_, i) => 5.verticalSpace,
                        itemBuilder: (_, i) {
                          return MyRadioButton(
                            valueText: staffProvider.listRadio[i].nama,
                            value: staffProvider.listRadio[i].id,
                            groupValue: provider.pickedStaff?.id ?? '',
                            tap: () => provider.pickStaff(
                              staffProvider.listRadio[i],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  20.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: tap,
                      child: const Text(
                        'Pilih',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
