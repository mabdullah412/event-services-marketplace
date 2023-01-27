import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/package_repository.dart';
import 'get_packages_bloc.dart';

part 'delete_package_event.dart';
part 'delete_package_state.dart';

class DeletePackageBloc extends Bloc<DeletePackageEvent, DeletePackageState> {
  final GetPackagesBloc getPackagesBloc;
  final PackageRepository packageRepository;

  DeletePackageBloc({
    required this.packageRepository,
    required this.getPackagesBloc,
  }) : super(DeletePackageInitial()) {
    on<DeletePackage>(_onDeletePackage);
  }

  Future<void> _onDeletePackage(
    DeletePackage event,
    Emitter<DeletePackageState> emit,
  ) async {
    emit(DeletePackageLoading());

    try {
      final dynamic response = packageRepository.deletePackage(
        packageId: event.packageId,
      );

      if (response == false) {
        emit(const DeletePackageFailure(error: 'Token error'));
        return;
      }

      // re-call getPackages after deleting package
      getPackagesBloc.add(GetPackages());

      emit(DeletePackageSuccess());
    } catch (err) {
      emit(DeletePackageFailure(error: err.toString()));
    }
  }
}
