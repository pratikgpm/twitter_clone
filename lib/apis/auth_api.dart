import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/providers.dart';

//want to signUp , want to get user account  -> Account
//want to access user related data -> model.Account (model.User)

final authAPIProvider = Provider(
  (ref) {
    final account = ref.watch(appwriteAccountProvider);
    return AuthAPI(account: account);
  },
);

abstract class IAuthAPI {
  FutureEither<model.User> signUp(
      {required String email, required String password});

  FutureEither<model.Session> login(
      {required String email, required String password});

  Future<model.User?> currentUserAccount();

  FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required Account account}) : _account = account;

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected Error occurred", stackTrace));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      final session = await _account.createEmailPasswordSession(
          email: email, password: password);
      return right(session);
    } on AppwriteException catch (e, StackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected Error occure ", StackTrace));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      await _account.deleteSession(
        sessionId: 'current',
      );
      return right(null);
    } on AppwriteException catch (e, StackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected Error occure ", StackTrace));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
