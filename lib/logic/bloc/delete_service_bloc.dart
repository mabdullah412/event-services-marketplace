import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/service_repository.dart';
import 'get_user_services_bloc.dart';

part 'delete_service_event.dart';
part 'delete_service_state.dart';

class DeleteServiceBloc extends Bloc<DeleteServiceEvent, DeleteServiceState> {
  final GetUserServicesBloc getUserServicesBloc;
  final ServiceRepository serviceRepository;

  DeleteServiceBloc({
    required this.getUserServicesBloc,
    required this.serviceRepository,
  }) : super(DeleteServiceInitial()) {
    on<DeleteService>(_onDeleteService);
  }

  Future<void> _onDeleteService(
    DeleteService event,
    Emitter<DeleteServiceState> emit,
  ) async {
    emit(DeleteServiceLoading());

    try {
      final dynamic response = await serviceRepository.deleteService(
        serviceId: event.serviceId,
      );

      if (response == false) {
        emit(const DeleteServiceFailure(error: 'Token error'));
        return;
      }

      // recall GetUserServices after creating a new service
      getUserServicesBloc.add(GetUserServices());

      emit(DeleteServicesuccess());
    } catch (err) {
      emit(DeleteServiceFailure(error: err.toString()));
    }
  }
}
