import 'package:equatable/equatable.dart';

enum ProfileStatus { loading, success, failure, initial}
class ProfileState extends Equatable {
  final ProfileStatus status;
  final dynamic data;
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.data,
});

  ProfileState copyWith({
    ProfileStatus? status,

    dynamic data,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,

      data: data ?? this.data,

    );
  }

  @override
  List<Object?> get props => [status,data];
}
