import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/package.dart';
import '../../data/repositories/package_repository.dart';

part 'get_packages_event.dart';
part 'get_packages_state.dart';

class GetPackagesBloc extends Bloc<GetPackagesEvent, GetPackagesState> {
  final PackageRepository packageRepository;

  GetPackagesBloc({
    required this.packageRepository,
  }) : super(GetPackagesInitial()) {
    on<GetPackages>(_onGetPackages);
  }

  Future<void> _onGetPackages(
    GetPackages event,
    Emitter<GetPackagesState> emit,
  ) async {
    emit(GetPackagesLoading());

    try {
      final List<Package> packages = await packageRepository.getPackages();

      emit(GetPackagesSuccess(packages: packages));
    } catch (err) {
      emit(GetPackagesFailure(error: err.toString()));
    }
  }
}
