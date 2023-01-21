part of 'create_service_bloc.dart';

abstract class CreateServiceEvent extends Equatable {
  const CreateServiceEvent();

  @override
  List<Object> get props => [];
}

class CreateService extends CreateServiceEvent {
  final Map<dynamic, dynamic> serviceData;

  const CreateService({required this.serviceData});

  @override
  List<Object> get props => [];
}
