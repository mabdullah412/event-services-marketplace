part of 'get_user_services_bloc.dart';

abstract class GetUserServicesState extends Equatable {
  const GetUserServicesState();

  @override
  List<Object> get props => [];
}

class GetUserServicesInitial extends GetUserServicesState {}

class GetUserServicesLoading extends GetUserServicesState {}

class GetUserServicesSuccess extends GetUserServicesState {
  final List<Service> services;

  const GetUserServicesSuccess({required this.services});

  @override
  List<Object> get props => [];
}

class GetUserServicesFailure extends GetUserServicesState {
  final String error;

  const GetUserServicesFailure({required this.error});

  @override
  List<Object> get props => [];
}
