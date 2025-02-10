import 'package:equatable/equatable.dart';

class LoginByEmailParams extends Equatable {
  final String email;
  final String password;

  const LoginByEmailParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
