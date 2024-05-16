import 'package:bloc/bloc.dart';

import '../model/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void login(UserModel userModel) {
    emit(UserLoading());
    Future.delayed(const Duration(seconds: 3), () {
      emit(UserSuccess(userModel));
    });
  }

  void scan(String? qrCode) {
    if (qrCode != null) {
      emit(ScanSuccess());
      Future.delayed(const Duration(seconds: 3), () {
        ScanSuccess().loading = false;
      });
    } else {
      emit(ScanFailure("Invalid QR Code"));
    }
  }
}
