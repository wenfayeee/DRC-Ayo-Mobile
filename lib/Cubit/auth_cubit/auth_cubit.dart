// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial()) {
//     checkSignIn();
//   }

//   Future<void> checkSignIn() async {
//     final User? user = await checkSignInStatus();

//     if (user != null) {
//       emit(AuthSuccess(user));
//     }
//   }

  // Future<void> registerWithEmailAndPassword(
  //     String email, String password) async {
  //   emit(AuthLoading());

  //   try {
  //     final user = await registerWithEmailAndPassword(email, password)
  //     emit(AuthSuccess(user));
  //   } catch (error) {
  //     emit(AuthError(error.toString()));
  //   }
  // }

  // Future<void> signIn(String email, String password) async {
  //   emit(AuthLoading());
  //   try {
  //     // Implement your own logic for signing in with email and password.
  //     // Replace the following line with your custom implementation.
  //     final user = await signInWithEmailAndPassword(email, password);
  //     emit(AuthSuccess(user));
  //   } catch (error) {
  //     emit(AuthFailed(error.toString()));
  //   }
  // }

  // Future<void> signOut() async {
  //   emit(AuthLoading());
  //   try {
  //     // Implement your own logic for signing out the user.
  //     // Replace the following line with your custom implementation.
  //     await signOutCurrentUser();

  //     emit(AuthSignOut());
  //   } catch (error) {
  //     emit(AuthError(error.toString()));
  //   }
  // }
// }
