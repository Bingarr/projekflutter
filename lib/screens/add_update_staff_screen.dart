import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/providers/staff_provider.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/custom_icon_button.dart';

class AddUpdateStaffScreen extends StatefulWidget {
  const AddUpdateStaffScreen({
    Key? key,
    this.name,
    this.plat,
    required this.isEdit,
    this.id,
    this.email,
  }) : super(key: key);

  final String? name;
  final String? plat;
  final String? email;
  final String? id;
  final bool isEdit;

  @override
  State<AddUpdateStaffScreen> createState() => _AddUpdateStaffScreenState();
}

class _AddUpdateStaffScreenState extends State<AddUpdateStaffScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController passCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController plat1Ctrl;
  late TextEditingController plat2Ctrl;
  late TextEditingController plat3Ctrl;

  @override
  void initState() {
    nameCtrl = TextEditingController(text: widget.name);
    passCtrl = TextEditingController();
    emailCtrl = TextEditingController(text: widget.email);
    if (widget.plat != null) {
      List<String> list = widget.plat!.split(' ');
      plat1Ctrl = TextEditingController(text: list[0]);
      plat2Ctrl = TextEditingController(text: list[1]);
      plat3Ctrl = TextEditingController(text: list[2]);
    } else {
      plat1Ctrl = TextEditingController();
      plat2Ctrl = TextEditingController();
      plat3Ctrl = TextEditingController();
    }

    super.initState();
  }

  void validateField(Function onTap) {
    if (nameCtrl.text.isEmpty ||
        plat1Ctrl.text.isEmpty ||
        plat3Ctrl.text.isEmpty ||
        plat2Ctrl.text.isEmpty ||
        emailCtrl.text.isEmpty) {
      doSnackbar(context, 'Please fill all field');
    } else {
      if (!widget.isEdit && passCtrl.text.isEmpty) {
        doSnackbar(context, 'Please fill all field');
      } else {
        onTap();
      }
    }
  }

  String returnPlatData() {
    return '${plat1Ctrl.text} ${plat2Ctrl.text} ${plat3Ctrl.text}';
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    plat1Ctrl.dispose();
    plat2Ctrl.dispose();
    plat3Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StaffProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Petugas' : 'Tambah Petugas',
        ),
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
                LengthLimitingTextInputFormatter(10),
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
            if (!widget.isEdit) ...[
              Text(
                'Email',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              10.verticalSpace,
              TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
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
                "Password",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: passCtrl,
                obscureText: true,
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
              const SizedBox(
                height: 10,
              ),
              20.verticalSpace,
            ],
            Text(
              'Plat',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: plat1Ctrl,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("[0-9]")),
                      FilteringTextInputFormatter.deny(
                        RegExp("~`!@#\$%^&*()_-+=:;{}[]|,./?"),
                      ),
                      LengthLimitingTextInputFormatter(2),
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
                ),
                15.horizontalSpace,
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: plat2Ctrl,
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
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
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: plat3Ctrl,
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("[0-9]")),
                      FilteringTextInputFormatter.deny(
                        RegExp("~`!@#\$%^&*()_-+=:;{}[]|,./?"),
                      ),
                      LengthLimitingTextInputFormatter(3),
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
              ],
            ),
            80.verticalSpace,
            CustomIconButton(
              onTap: () {
                validateField(() {
                  if (widget.isEdit) {
                    provider.doEditData(
                      context: context,
                      name: nameCtrl.text,
                      plat: returnPlatData(),
                      id: widget.id!,
                      // email: emailCtrl.text,
                    );
                  } else {
                    provider.doCreateData(
                      context: context,
                      name: nameCtrl.text,
                      plat: returnPlatData(),
                      email: emailCtrl.text,
                      password: passCtrl.text,
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
