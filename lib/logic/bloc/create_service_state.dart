part of 'create_service_bloc.dart';

abstract class CreateServiceState extends Equatable {
  const CreateServiceState();

  @override
  List<Object> get props => [];
}

class CreateServiceInitial extends CreateServiceState {}

class CreateServiceLoading extends CreateServiceState {}

class CreateServiceSuccess extends CreateServiceState {}

class CreateServiceFailure extends CreateServiceState {
  final String error;

  const CreateServiceFailure({required this.error});

  @override
  List<Object> get props => [];
}
