import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  // The associated error message
  final String message;

  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occured',
  ]);

  //creates an authentication message from firebase authentication exception code
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'Account already exists for this email.',
        );
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or formatted badly.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation not allowed. Contact support',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a strong password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithEmailAndPasswordFailure implements Exception {
  //the associated message
  final String message;

  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occured',
  ]);

  //creates an authentication message from firebase authentication exception code
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Contact support.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

//thrown during logout process if failure occurs
class LogOutFailure implements Exception {
  final String message;

  const LogOutFailure([
    this.message = 'Error caused. Retry Signing Out',
  ]);
}

class UserDeleteFailure implements Exception {
  final String message;

  const UserDeleteFailure([
    this.message = 'Try again after Log In.',
  ]);
}

class AuthenticationRepo {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthenticationRepo({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Stream<User?> authStateSTream() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }

  Future<void> deleteUser() async {
    try {
      await _firebaseAuth.currentUser?.delete();
    } catch (_) {
      throw UserDeleteFailure();
    }
  }
}
