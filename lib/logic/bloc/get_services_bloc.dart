import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/service.dart';
import '../../data/repositories/service_repository.dart';

part 'get_services_event.dart';
part 'get_services_state.dart';

class GetServicesBloc extends Bloc<GetServicesEvent, GetServicesState> {
  final ServiceRepository serviceRepository;

  GetServicesBloc({
    required this.serviceRepository,
  }) : super(GetServicesInitial()) {
    on<GetServices>(_onGetServices);
  }

  Future<void> _onGetServices(
    GetServices event,
    Emitter<GetServicesState> emit,
  ) async {
    emit(GetServicesLoading());

    try {
      final List<Service> services = await serviceRepository.getServices(
        category: event.category,
      );

      emit(GetServicesSuccess(services: services));
    } catch (err) {
      emit(GetServicesFailure(error: err.toString()));
    }
  }
}
