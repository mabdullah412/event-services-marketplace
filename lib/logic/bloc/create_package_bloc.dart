import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/package_repository.dart';
import 'get_packages_bloc.dart';

part 'create_package_event.dart';
part 'create_package_state.dart';

class CreatePackageBloc extends Bloc<CreatePackageEvent, CreatePackageState> {
  final GetPackagesBloc getPackagesBloc;
  final PackageRepository packageRepository;

  CreatePackageBloc({
    required this.getPackagesBloc,
    required this.packageRepository,
  }) : super(CreatePackageInitial()) {
    on<CreatePackage>(_onCreatePackage);
  }

  Future<void> _onCreatePackage(
    CreatePackage event,
    Emitter<CreatePackageState> emit,
  ) async {
    emit(CreatePackageLoading());

    try {
      final dynamic response = await packageRepository.createPackage(
        name: event.name,
      );

      if (response == false) {
        emit(const CreatePackageFailure(error: 'Token error'));
        return;
      }

      // get packages again after adding a package
      getPackagesBloc.add(GetPackages());

      emit(CreatePackageSuccess());
    } catch (err) {
      emit(CreatePackageFailure(error: err.toString()));
    }
  }
}
