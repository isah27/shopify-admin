part of 'app_bloc.dart';

abstract class ShopifyAuthEvent extends Equatable {
  const ShopifyAuthEvent();
}

class LoginEvent extends ShopifyAuthEvent {
  final String email;
  final String password;
  const LoginEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends ShopifyAuthEvent {
  final Users users;

  const SignUpEvent({
    required this.users,
  });
  @override
  List<Object?> get props => [users];
}

class SignOutEvent extends ShopifyAuthEvent {
  @override
  List<Object?> get props => [];
}
