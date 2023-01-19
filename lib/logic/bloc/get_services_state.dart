part of 'get_services_bloc.dart';

abstract class GetServicesState extends Equatable {
  const GetServicesState();

  @override
  List<Object> get props => [];
}

class GetServicesInitial extends GetServicesState {}

class GetServicesLoading extends GetServicesState {}

class GetServicesSuccess extends GetServicesState {
  final List<Service> services;

  const GetServicesSuccess({required this.services});

  @override
  List<Object> get props => [];
}

class GetServicesFailure extends GetServicesState {
  final String error;

  const GetServicesFailure({required this.error});

  @override
  List<Object> get props => [];
}
