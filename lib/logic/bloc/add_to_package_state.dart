part of 'add_to_package_bloc.dart';

abstract class AddToPackageState extends Equatable {
  const AddToPackageState();

  @override
  List<Object> get props => [];
}

class AddToPackageInitial extends AddToPackageState {}

class AddToPackageLoading extends AddToPackageState {}

class AddToPackageSuccess extends AddToPackageState {}

class AddToPackageFailure extends AddToPackageState {
  final String error;

  const AddToPackageFailure({required this.error});

  @override
  List<Object> get props => [];
}
