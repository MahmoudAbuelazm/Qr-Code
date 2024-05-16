part of 'user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      phone: fields[0] as String,
      password: fields[1] as String,
      savedQrCodes: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.phone)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.savedQrCodes);
  }
}
