import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/model/models.dart';
import 'package:shopify_admin/class/repository/auth%20repository/auth_repo.dart';

part 'app_event.dart';
part 'app_state.dart';

class ShopifyAuthBloc extends Bloc<ShopifyAuthEvent, ShopifyAuthState> {
  ShopifyAuthBloc(this._userRepository) : super(InitialState()) {
    on<LoginEvent>(_onLoginEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }

  void _onLoginEvent(LoginEvent event, Emitter<ShopifyAuthState> emit) async {
    emit(LoadingState());
    try {
      await _userRepository.login(email: event.email, pasaword: event.password);
      emit(AuthenticatedState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorsState(error: _userRepository.errorMessage(e.code)));
    }
  }

  void _onSignUpEvent(SignUpEvent event, Emitter<ShopifyAuthState> emit) async {
    emit(LoadingState());
    try {
      await _userRepository.signUp(users: event.users);
      // print(_userRepository.authStateChange);
      emit(SignedUpState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorsState(error: _userRepository.errorMessage(e.code)));
    }
  }

  void _onSignOutEvent(SignOutEvent event, Emitter<ShopifyAuthState> emit) {
    emit(LoadingState());
    _userRepository.signOut();
    emit(SignedOutState());
  }

  final UserRepository _userRepository;
}
