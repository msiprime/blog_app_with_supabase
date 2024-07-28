import 'dart:async' show Future, FutureOr;

import 'package:capestone_test/core/error/exceptions.dart';
import 'package:capestone_test/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:capestone_test/features/auth/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabaseDatasourceImpl implements AuthSupabaseDatasource {
  final SupabaseClient supabaseClient;

  AuthSupabaseDatasourceImpl({required this.supabaseClient});

  @override
  Session? get currentSessionKey => supabaseClient.auth.currentSession;

  // this session will give us only id and email.
  // final user = supabaseClient.auth.currentUser;
  // we can get more data by using the id to get the user data from the database.
  // this will help updating the user data in the future.
  // so latest information must be fetched from the database not from the supabase auth.

  @override
  Future<ProfileModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException('User is null');
      }

      return ProfileModel.fromJson(
        response.user!.toJson(),
      );
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<ProfileModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      if (response.user == null) {
        throw const ServerException('User not created');
      }

      return ProfileModel.fromJson(
        response.user!.toJson(),
      );
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  FutureOr<void> signOut() {
    try {
      return supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<ProfileModel?> getCurrentUserData() async {
    try {
      if (currentSessionKey != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select('*')
            .eq('id', currentSessionKey!.user.id);
        return ProfileModel.fromJson(userData.first).copyWith(
          email: currentSessionKey!.user.email,
        );
      }
      return null;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
