import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/feature/profile/cubit/profile_state.dart';
import 'package:new_project/feature/profile/repository/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit(this.profileRepository) : super(const ProfileState());
  
  Future<void> getUserData()async{
    emit(state.copyWith(
      status: ProfileStatus.loading,
    ));

    try {
      final result = await profileRepository.getUser();

      emit(
        state.copyWith(
          status: ProfileStatus.success,

          data: result,

        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,

          message: e.toString(),
        ),
      );
    }
  }
}