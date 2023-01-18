import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/service.dart';
import '../../data/repositories/service_repository.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository serviceRepository;

  ServiceBloc({
    required this.serviceRepository,
  }) : super(ServiceInitial()) {
    on<GetServices>(_onGetServices);
  }

  Future<void> _onGetServices(
    GetServices event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());

    try {
      final List<Service> services = await serviceRepository.getServices(
        category: event.category,
      );

      emit(ServiceLoaded(services: services));
    } catch (err) {
      emit(ServiceFailure(error: err.toString()));
    }
  }
}
