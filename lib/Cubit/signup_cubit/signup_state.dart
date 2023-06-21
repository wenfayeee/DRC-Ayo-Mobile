// part of 'signup_cubit.dart';

// enum SignUpStatus { initial, submitting, success, error }

// class SignUpState extends Equatable {
//   final String email;
//   final String password;
//   final SignUpStatus status;

//   const SignUpState({
//     required this.email,
//     required this.password,
//     required this.status,
//   });

//   factory SignUpState.initial() {
//     return const SignUpState(
//       email: '',
//       password: '',
//       status: SignUpStatus.initial,
//     );
//   }

//   SignUpState copyWith({
//     String? email,
//     String? password,
//     SignUpStatus? status,
//   }) {
//     return SignUpState(
//         email: email ?? this.email,
//         password: password ?? this.password,
//         status: status ?? this.status);
//   }

//   @override
//   List<Object> get props => [email, password, status];
// }
