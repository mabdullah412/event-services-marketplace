part of 'delete_service_bloc.dart';

abstract class DeleteServiceEvent extends Equatable {
  const DeleteServiceEvent();

  @override
  List<Object> get props => [];
}

class DeleteService extends DeleteServiceEvent {
  final String serviceId;

  const DeleteService({required this.serviceId});

  @override
  List<Object> get props => [];
}
