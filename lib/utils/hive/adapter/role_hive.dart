import 'package:hive/hive.dart';

part 'role_hive.g.dart';

@HiveType(typeId: 0)
class RoleHive extends HiveObject {
  @HiveField(0)
  int? role;
}
