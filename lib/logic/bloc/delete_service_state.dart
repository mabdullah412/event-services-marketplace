part of 'delete_service_bloc.dart';

abstract class DeleteServiceState extends Equatable {
  const DeleteServiceState();

  @override
  List<Object> get props => [];
}

class DeleteServiceInitial extends DeleteServiceState {}

class DeleteServiceLoading extends DeleteServiceState {}

class DeleteServicesuccess extends DeleteServiceState {}

class DeleteServiceFailure extends DeleteServiceState {
  final String error;

  const DeleteServiceFailure({required this.error});

  @override
  List<Object> get props => [];
}
