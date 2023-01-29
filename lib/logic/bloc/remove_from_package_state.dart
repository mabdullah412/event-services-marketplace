part of 'remove_from_package_bloc.dart';

abstract class RemoveFromPackageState extends Equatable {
  const RemoveFromPackageState();

  @override
  List<Object> get props => [];
}

class RemoveFromPackageInitial extends RemoveFromPackageState {}

class RemoveFromPackageLoading extends RemoveFromPackageState {}

class RemoveFromPackageSuccess extends RemoveFromPackageState {}

class RemoveFromPackageFailure extends RemoveFromPackageState {
  final String error;

  const RemoveFromPackageFailure({required this.error});

  @override
  List<Object> get props => [];
}
