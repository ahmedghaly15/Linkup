import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/domain/usecases/forgot_password/forgot_password_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordCubit({required this.forgotPasswordUseCase})
      : super(const ForgotPasswordInitial());

  void forgotPassword({required String email}) {
    emit(const ForgotPasswordLoading());
    forgotPasswordUseCase(email).then((value) {
      value.fold(
        (failure) =>
            emit(ForgotPasswordError(error: failure.failureMsg.toString())),
        (success) => emit(const ForgotPasswordSuccess()),
      );
    });
  }
}
