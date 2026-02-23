part of 'reservations_bloc.dart';

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();
  @override
  List<Object?> get props => [];
}

class GetTodayReservationsEvent extends ReservationsEvent {}
class GetAllReservationsEvent extends ReservationsEvent {}
class GetUpcomingReservationsEvent extends ReservationsEvent {}

class CreateReservationEvent extends ReservationsEvent {
  final Map<String, dynamic> reservationData;
  const CreateReservationEvent({required this.reservationData});
  @override
  List<Object?> get props => [reservationData];
}

class CheckInReservationEvent extends ReservationsEvent {
  final int id;
  const CheckInReservationEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class CancelReservationEvent extends ReservationsEvent {
  final int id;
  const CancelReservationEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class MarkNoShowEvent extends ReservationsEvent {
  final int id;
  const MarkNoShowEvent({required this.id});
  @override
  List<Object?> get props => [id];
}