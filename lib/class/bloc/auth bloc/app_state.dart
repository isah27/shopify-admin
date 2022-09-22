part of 'app_bloc.dart';

abstract class ShopifyAuthState extends Equatable {
  const ShopifyAuthState();
}

class InitialState extends ShopifyAuthState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ShopifyAuthState {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends ShopifyAuthState {
  @override
  List<Object?> get props => [];
}

class SignedUpState extends ShopifyAuthState {
  @override
  List<Object?> get props => [];
}
class SignedOutState extends ShopifyAuthState {
  @override
  List<Object?> get props => [];
}

class ErrorsState extends ShopifyAuthState {
  final String error;
  const ErrorsState({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
