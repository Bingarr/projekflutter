
import 'package:hive/hive.dart';
import 'package:trashgrab/utils/hive/adapter/role_hive.dart';

class RoleHiveServices {
  RoleHiveServices._();

  static final roleBox = Hive.box('role');
  static const roleKey = 'role-key';

  static Future<void> setRole(int role) async {
    RoleHive roleHive = RoleHive()..role = role;

    await roleBox.put(roleKey, roleHive);
    roleHive.save();
  }

  static RoleHive? getRole() {
    RoleHive? data = roleBox.get(roleKey);

    return data;
  }

  static void deleteRole() {
    roleBox.delete(roleKey);
    roleBox.clear();
  }
}
