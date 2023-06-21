// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'signup_state.dart';

// class SignUpCubit extends Cubit<SignUpState> {
//   SignUpCubit() : super(SignUpState.initial()) {
//     signUpWithCredentials();
//   }

//   void emailChanged(String value) {
//     emit(state.copyWith(email: value, status: SignUpStatus.initial));
//   }

//   void passwordChanged(String value) {
//     emit(state.copyWith(password: value, status: SignUpStatus.initial));
//   }

//   Future<void> signUpWithCredentials() async {
//     if (!state.status == SignUpStatus.submitting) return;
//     emit(state.copyWith(status: SignUpStatus.submitting));
//     try {
//       var user = await signUpWithCredentials();
//       emit(state.copyWith(status: SignUpStatus.success));
//     } catch (_) {}
//   }
// }
