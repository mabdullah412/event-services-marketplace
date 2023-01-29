import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/package_repository.dart';
import 'get_packages_bloc.dart';

part 'remove_from_package_event.dart';
part 'remove_from_package_state.dart';

class RemoveFromPackageBloc
    extends Bloc<RemoveFromPackageEvent, RemoveFromPackageState> {
  final PackageRepository packageRepository;
  final GetPackagesBloc getPackagesBloc;

  RemoveFromPackageBloc({
    required this.packageRepository,
    required this.getPackagesBloc,
  }) : super(RemoveFromPackageInitial()) {
    on<RemoveFromPackage>(_onRemoveFromPackage);
  }

  Future<void> _onRemoveFromPackage(
    RemoveFromPackage event,
    Emitter<RemoveFromPackageState> emit,
  ) async {
    emit(RemoveFromPackageLoading());

    try {
      final dynamic response = await packageRepository.removeFromPackage(
        packageId: event.packageId,
        serviceId: event.serviceId,
      );

      if (response == false) {
        emit(const RemoveFromPackageFailure(error: 'Token errror'));
      }

      // recall getPackagesBloc after removing service from package
      getPackagesBloc.add(GetPackages());

      emit(RemoveFromPackageSuccess());
    } catch (err) {
      emit(RemoveFromPackageFailure(error: err.toString()));
    }
  }
}
