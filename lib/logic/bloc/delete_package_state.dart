part of 'delete_package_bloc.dart';

abstract class DeletePackageState extends Equatable {
  const DeletePackageState();

  @override
  List<Object> get props => [];
}

class DeletePackageInitial extends DeletePackageState {}

class DeletePackageLoading extends DeletePackageState {}

class DeletePackageSuccess extends DeletePackageState {}

class DeletePackageFailure extends DeletePackageState {
  final String error;

  const DeletePackageFailure({required this.error});

  @override
  List<Object> get props => [];
}
