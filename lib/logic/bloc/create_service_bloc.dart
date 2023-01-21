import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/service_repository.dart';

part 'create_service_event.dart';
part 'create_service_state.dart';

class CreateServiceBloc extends Bloc<CreateServiceEvent, CreateServiceState> {
  final ServiceRepository serviceRepository;

  CreateServiceBloc({
    required this.serviceRepository,
  }) : super(CreateServiceInitial()) {
    on<CreateService>(_onCreateService);
  }

  Future<void> _onCreateService(
    CreateService event,
    Emitter<CreateServiceState> emit,
  ) async {
    emit(CreateServiceLoading());

    try {
      final dynamic response = await serviceRepository.createService(
        serviceData: event.serviceData,
      );

      if (response == false) {
        emit(const CreateServiceFailure(error: 'Token error'));
        return;
      }

      // recall getUserServicesBloc

      emit(CreateServiceSuccess());
    } catch (err) {
      emit(CreateServiceFailure(error: err.toString()));
    }
  }
}
