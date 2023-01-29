part of 'remove_from_package_bloc.dart';

abstract class RemoveFromPackageEvent extends Equatable {
  const RemoveFromPackageEvent();

  @override
  List<Object> get props => [];
}

class RemoveFromPackage extends RemoveFromPackageEvent {
  final String serviceId;
  final String packageId;

  const RemoveFromPackage({
    required this.packageId,
    required this.serviceId,
  });

  @override
  List<Object> get props => [];
}
