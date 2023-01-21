part of 'get_user_services_bloc.dart';

abstract class GetUserServicesEvent extends Equatable {
  const GetUserServicesEvent();

  @override
  List<Object> get props => [];
}

class GetUserServices extends GetUserServicesEvent {}
