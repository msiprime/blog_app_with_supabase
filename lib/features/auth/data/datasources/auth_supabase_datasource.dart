import 'dart:async' show Future, FutureOr;

import 'package:capestone_test/features/auth/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDatasource {
  Session? get currentSessionKey;

  Future<ProfileModel?> getCurrentUserData();

  Future<ProfileModel> signIn({
    required String email,
    required String password,
  });

  Future<ProfileModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  FutureOr<void> signOut();

// Future<Either<Failure, Unit>> checkIfUserIsLoggedIn();
}
