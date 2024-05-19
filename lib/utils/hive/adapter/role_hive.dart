import 'package:hive/hive.dart';
import 'package:trashgrab/models/role_enum.dart';

part 'role_hive.g.dart';

@HiveType(typeId: 0)
class RoleHive extends HiveObject {
  @HiveField(0)
  RoleUserCurrent? role;
}
