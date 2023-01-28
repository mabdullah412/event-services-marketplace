import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/package_repository.dart';
import 'get_packages_bloc.dart';

part 'add_to_package_event.dart';
part 'add_to_package_state.dart';

class AddToPackageBloc extends Bloc<AddToPackageEvent, AddToPackageState> {
  final PackageRepository packageRepository;
  final GetPackagesBloc getPackagesBloc;

  AddToPackageBloc({
    required this.packageRepository,
    required this.getPackagesBloc,
  }) : super(AddToPackageInitial()) {
    on<AddToPackage>(_onAddToPackage);
  }

  Future<void> _onAddToPackage(
    AddToPackage event,
    Emitter<AddToPackageState> emit,
  ) async {
    emit(AddToPackageLoading());

    try {
      final dynamic response = await packageRepository.addToPackage(
        packageId: event.packageId,
        serviceId: event.serviceId,
      );

      if (response == false) {
        emit(const AddToPackageFailure(error: 'Token error'));
      }

      // recall getPackagesBloc after adding service to package
      getPackagesBloc.add(GetPackages());

      emit(AddToPackageSuccess());
    } catch (err) {
      emit(AddToPackageFailure(error: err.toString()));
    }
  }
}
