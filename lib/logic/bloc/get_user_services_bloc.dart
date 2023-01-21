import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/service.dart';
import '../../data/repositories/service_repository.dart';

part 'get_user_services_event.dart';
part 'get_user_services_state.dart';

class GetUserServicesBloc
    extends Bloc<GetUserServicesEvent, GetUserServicesState> {
  final ServiceRepository serviceRepository;

  GetUserServicesBloc({
    required this.serviceRepository,
  }) : super(GetUserServicesInitial()) {
    on<GetUserServices>(_onGetUserServices);
  }

  Future<void> _onGetUserServices(
    GetUserServices event,
    Emitter<GetUserServicesState> emit,
  ) async {
    emit(GetUserServicesLoading());

    try {
      final List<Service> services = await serviceRepository.getUserServices();
      emit(GetUserServicesSuccess(services: services));
    } catch (err) {
      emit(GetUserServicesFailure(error: err.toString()));
    }
  }
}
