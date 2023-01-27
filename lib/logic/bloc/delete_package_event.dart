part of 'delete_package_bloc.dart';

abstract class DeletePackageEvent extends Equatable {
  const DeletePackageEvent();

  @override
  List<Object> get props => [];
}

class DeletePackage extends DeletePackageEvent {
  final String packageId;

  const DeletePackage({required this.packageId});

  @override
  List<Object> get props => [];
}
