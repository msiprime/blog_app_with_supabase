import 'dart:async';

import 'package:capestone_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:capestone_test/core/common/entities/profile_entity.dart';
import 'package:capestone_test/core/usecase/usecase.dart';
import 'package:capestone_test/features/auth/domain/usecases/current_user_data_usecase.dart';
import 'package:capestone_test/features/auth/domain/usecases/user_signin_usecase.dart';
import 'package:capestone_test/features/auth/domain/usecases/user_signout_usecase.dart';
import 'package:capestone_test/features/auth/domain/usecases/user_signup_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;
  final UserSignInUseCase _userSignInUseCase;
  final UserSignOutUseCase _userSignOutUseCase;
  final CurrentUserUsecase _currentUserUsecase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUpUseCase userSignUpUseCase,
    required UserSignInUseCase userSignInUseCase,
    required UserSignOutUseCase userSignOutUseCase,
    required CurrentUserUsecase currentUserDataUsecase,
    required AppUserCubit appUserCubit,
  })  : _userSignUpUseCase = userSignUpUseCase,
        _userSignInUseCase = userSignInUseCase,
        _userSignOutUseCase = userSignOutUseCase,
        _currentUserUsecase = currentUserDataUsecase,
        _appUserCubit = appUserCubit,
        super(const AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(const AuthLoading()));
    on<AuthSignUpEvent>(_onUserSignUp);
    on<AuthSignInEvent>(_onUserSignIn);
    on<AuthSignOutEvent>(_onUserSignOut);
    on<AuthIsUserLoggedInEvent>(_onIsUserLoggedIn);
  }

  FutureOr<void> _onUserSignUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    // emit(const AuthLoading());
    await _userSignUpUseCase(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    ).then(
      (result) {
        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (userEntity) => _emitAuthSuccess(userEntity, emit),
        );
      },
    );
  }

  FutureOr<void> _onUserSignIn(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    // emit(const AuthLoading());
    await _userSignInUseCase(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    ).then(
      (result) {
        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (userEntity) => _emitAuthSuccess(userEntity, emit),
        );
      },
    );
  }

  FutureOr<void> _onIsUserLoggedIn(
    AuthIsUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    // emit(const AuthLoading());
    await _currentUserUsecase(NoParams()).then(
      (result) {
        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (userEntity) => _emitAuthSuccess(userEntity, emit),
        );
      },
    );
  }

  void _emitAuthSuccess(ProfileEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  Future<FutureOr<void>> _onUserSignOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    // emit(const AuthLoading());
    await _userSignOutUseCase("").then(
      (result) {
        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (_) => emit(const AuthInitial()),
        );
      },
    );
  }
}
