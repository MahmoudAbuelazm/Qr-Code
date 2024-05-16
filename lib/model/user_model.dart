import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
  String phone;
  @HiveField(1)
  String password;
  @HiveField(2)
  List<String> savedQrCodes;

  UserModel(
      {required this.phone,
      required this.password,
      required this.savedQrCodes});
}
