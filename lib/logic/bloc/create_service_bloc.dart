import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/service_repository.dart';
import 'get_user_services_bloc.dart';

part 'create_service_event.dart';
part 'create_service_state.dart';

class CreateServiceBloc extends Bloc<CreateServiceEvent, CreateServiceState> {
  final GetUserServicesBloc getUserServicesBloc;
  final ServiceRepository serviceRepository;

  CreateServiceBloc({
    required this.getUserServicesBloc,
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

      // recall GetUserServices after creating a new service
      getUserServicesBloc.add(GetUserServices());

      emit(CreateServiceSuccess());
    } catch (err) {
      emit(CreateServiceFailure(error: err.toString()));
    }
  }
}
