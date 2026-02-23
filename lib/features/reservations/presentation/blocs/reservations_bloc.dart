import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_wiz_tech/features/reservations/domain/entities/reservation_entity.dart';
import '../../domain/usecase/cancel_reservation_use_case.dart';
import '../../domain/usecase/check_in_reservation_use_case.dart';
import '../../domain/usecase/create_reservation_use_case.dart';
import '../../domain/usecase/get_all_reservations_use_case.dart';
import '../../domain/usecase/get_today_reservations_use_case.dart';
import '../../domain/usecase/get_upcoming_reservations_use_case.dart';
import '../../domain/usecase/no_show_reservation_use_case.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final GetAllReservationsUseCase getAllReservationsUseCase;
  final GetTodayReservationsUseCase getTodayReservationsUseCase;
  final GetUpcomingReservationsUseCase getUpcomingReservationsUseCase;
  final CreateReservationUseCase createReservationUseCase;
  final CheckInReservationUseCase checkInReservationUseCase;
  final CancelReservationUseCase cancelReservationUseCase;
  final NoShowReservationUseCase noShowReservationUseCase;

  ReservationsBloc({
    required this.getAllReservationsUseCase,
    required this.getTodayReservationsUseCase,
    required this.getUpcomingReservationsUseCase,
    required this.createReservationUseCase,
    required this.checkInReservationUseCase,
    required this.cancelReservationUseCase,
    required this.noShowReservationUseCase,
  }) : super(ReservationsInitial()) {
    on<GetTodayReservationsEvent>(_onGetTodayReservations);
    on<GetAllReservationsEvent>(_onGetAllReservations);
    on<GetUpcomingReservationsEvent>(_onGetUpcoming);
    on<CreateReservationEvent>(_onCreateReservation);
    on<CheckInReservationEvent>(_onCheckInReservation);
    on<CancelReservationEvent>(_onCancelReservation);
    on<MarkNoShowEvent>(_onMarkNoShow);
  }

  Future<void> _onGetTodayReservations(GetTodayReservationsEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoading());
    final result = await getTodayReservationsUseCase();
    result.fold(
          (failure) => emit(ReservationsError(message: failure.message)),
          (response) => emit(ReservationsLoaded(reservations: response.data!)),
    );
  }

  Future<void> _onCreateReservation(CreateReservationEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoading());
    final result = await createReservationUseCase(event.reservationData);
    result.fold(
          (failure) => emit(ReservationsError(message: failure.message)),
          (response) => emit(ReservationOperationSuccess(message: response.message ?? "Created")),
    );
  }

  Future<void> _onCheckInReservation(CheckInReservationEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoading());
    final result = await checkInReservationUseCase(event.id);
    result.fold(
          (failure) => emit(ReservationsError(message: failure.message)),
          (response) => emit(ReservationOperationSuccess(message: response.message ?? "Checked-In")),
    );
  }

  Future<void> _onCancelReservation(CancelReservationEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoading());
    final result = await cancelReservationUseCase(event.id);
    result.fold(
          (failure) => emit(ReservationsError(message: failure.message)),
          (response) => emit(ReservationOperationSuccess(message: response.message ?? "Cancelled")),
    );
  }

  Future<void> _onMarkNoShow(MarkNoShowEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoading());
    final result = await noShowReservationUseCase(event.id);
    result.fold(
          (failure) => emit(ReservationsError(message: failure.message)),
          (response) => emit(ReservationOperationSuccess(message: response.message ?? "Marked as No-Show")),
    );
  }

  // أحداث جلب القائمة الكاملة أو القادمة
  Future<void> _onGetAllReservations(GetAllReservationsEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoading());
    final result = await getAllReservationsUseCase();
    result.fold(
          (failure) => emit(ReservationsError(message: failure.message)),
          (response) => emit(ReservationsLoaded(reservations: response.data!)),
    );
  }

  Future<void> _onGetUpcoming(GetUpcomingReservationsEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoading());
    final result = await getUpcomingReservationsUseCase();
    result.fold(
          (failure) => emit(ReservationsError(message: failure.message)),
          (response) => emit(ReservationsLoaded(reservations: response.data!)),
    );
  }
}