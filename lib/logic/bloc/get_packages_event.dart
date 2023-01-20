part of 'get_packages_bloc.dart';

abstract class GetPackagesEvent extends Equatable {
  const GetPackagesEvent();

  @override
  List<Object> get props => [];
}

class GetPackages extends GetPackagesEvent {}
