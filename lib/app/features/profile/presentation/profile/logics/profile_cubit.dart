import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/usecase/usecase.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/usecases/get_profile_usecase.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUsecase usecase;

  ProfileCubit({required this.usecase}) : super(const ProfileState.initial());

  void getProfile() async {
    final result = await usecase.call(NoParams());

    result.fold(
      (failure) {
        emit(const ProfileState.error('error'));
      },
      (success) {
        emit(ProfileState.loaded(success));
      },
    );
  }
}
