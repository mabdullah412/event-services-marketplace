part of 'create_package_bloc.dart';

abstract class CreatePackageEvent extends Equatable {
  const CreatePackageEvent();

  @override
  List<Object> get props => [];
}

class CreatePackage extends CreatePackageEvent {
  final String name;

  const CreatePackage({required this.name});

  @override
  List<Object> get props => [];
}
