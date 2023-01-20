part of 'create_package_bloc.dart';

abstract class CreatePackageState extends Equatable {
  const CreatePackageState();

  @override
  List<Object> get props => [];
}

class CreatePackageInitial extends CreatePackageState {}

class CreatePackageLoading extends CreatePackageState {}

class CreatePackageSuccess extends CreatePackageState {}

class CreatePackageFailure extends CreatePackageState {
  final String error;

  const CreatePackageFailure({required this.error});

  @override
  List<Object> get props => [];
}
