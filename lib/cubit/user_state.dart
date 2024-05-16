part of 'user_cubit.dart';

class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserModel userModel;

  UserSuccess(this.userModel);
}

final class ScanSuccess extends UserState {
  bool loading = true;

  
}

final class ScanFailure extends UserState {
  final String message;

  ScanFailure(this.message);
}

final class ScanLoading extends UserState {
  ScanLoading();
}
