part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<Service> services;

  const ServiceLoaded({required this.services});

  @override
  List<Object> get props => [];
}

class ServiceFailure extends ServiceState {
  final String error;

  const ServiceFailure({required this.error});

  @override
  List<Object> get props => [];
}
