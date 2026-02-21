import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/domain/entities/success_response.dart';
import '../../../../../core/errors/errors.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login_usecase.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      final result = await loginUseCase(event.email, event.password);

      result.fold(
            (failure) {
          if (failure is ServerFailure) {
            emit(LoginFailure(message: failure.message));
          } else {
            emit(const LoginFailure(message: "Unexpected Error"));
          }
        },
            (user) => emit(LoginSuccess(user: user)),
      );
    });
  }
}