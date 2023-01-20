part of 'get_packages_bloc.dart';

abstract class GetPackagesState extends Equatable {
  const GetPackagesState();

  @override
  List<Object> get props => [];
}

class GetPackagesInitial extends GetPackagesState {}

class GetPackagesLoading extends GetPackagesState {}

class GetPackagesSuccess extends GetPackagesState {
  final List<Package> packages;

  const GetPackagesSuccess({required this.packages});

  @override
  List<Object> get props => [];
}

class GetPackagesFailure extends GetPackagesState {
  final String error;

  const GetPackagesFailure({required this.error});

  @override
  List<Object> get props => [];
}
