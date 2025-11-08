import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/repositories/auth_repository.dart';
import 'package:flutter_project/logic/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository,
        super(const AuthState()) {
    _init();
  }

  void _init(){
    emit(state.copyWith(status: AuthStatus.initial));

    _authStateSubscription = _authRepository.authStateChanges.listen((user) async {
      if(user!=null){
        try {
          final userData = await _authRepository.getUserData(user.uid);
          emit(state.copyWith(
              status: AuthStatus.authenticated,
              user: userData,
          ));
        } catch (e) {
          emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
        }
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    });
  }

  Future<void> signIn ({
    required String email,
    required String password,
}) async {
    // loading state
    emit(state.copyWith(status: AuthStatus.loading));
    // login process
    try {
      final user = await _authRepository.signin(email: email, password: password);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e){
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> signUp ({
    required String email,
    required String username,
    required String name,
    required String password,
    required String phoneNumber,
  }) async {
    // loading state
    emit(state.copyWith(status: AuthStatus.loading));
    // login process
    try {
      final user = await _authRepository.signup(email: email, username: username, name: name, password: password, phoneNumber: phoneNumber);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e){
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.logout();
      emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }
}