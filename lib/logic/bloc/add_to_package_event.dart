part of 'add_to_package_bloc.dart';

abstract class AddToPackageEvent extends Equatable {
  const AddToPackageEvent();

  @override
  List<Object> get props => [];
}

class AddToPackage extends AddToPackageEvent {
  final String packageId;
  final String serviceId;

  const AddToPackage({
    required this.packageId,
    required this.serviceId,
  });

  @override
  List<Object> get props => [];
}
