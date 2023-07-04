part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSucsess extends AuthState {}

class AuthFaluire extends AuthState {
  String errmessage;
  AuthFaluire({required this.errmessage});
}

class UserImageSelectedSucsess extends AuthState {}

class UserImageSelectedFaliure extends AuthState {}

class SucsessSavedatatofireStore extends AuthState {}

class FaliureSavedatatofireStore extends AuthState {}

class LoadingState extends AuthState {}

class LoginSucsess extends AuthState {}

class LoginFaliure extends AuthState {
  final errmessage;

  LoginFaliure(this.errmessage);
}
