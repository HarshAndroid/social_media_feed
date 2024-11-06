part of 'auth_cubit.dart';

final class AuthState {
  final bool hidePass;
  final bool isNewUser;
  final bool keepSignedIn;

  AuthState({
    required this.hidePass,
    required this.isNewUser,
    required this.keepSignedIn,
  });

  AuthState copyWith({
    final bool? hidePass,
    final bool? isNewUser,
    final bool? keepSignedIn,
  }) {
    return AuthState(
      hidePass: hidePass ?? this.hidePass,
      isNewUser: isNewUser ?? this.isNewUser,
      keepSignedIn: keepSignedIn ?? this.keepSignedIn,
    );
  }
}