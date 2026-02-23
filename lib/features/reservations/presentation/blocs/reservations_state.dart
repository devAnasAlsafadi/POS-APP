part of 'reservations_bloc.dart';

abstract class ReservationsState extends Equatable {
  const ReservationsState();

  @override
  List<Object?> get props => [];
}

class ReservationsInitial extends ReservationsState {}

class ReservationsLoading extends ReservationsState {}

// ✅ تعديل: إضافة قائمة الحجوزات مع ميزة الاختلاف لضمان تحديث الـ UI
class ReservationsLoaded extends ReservationsState {
  final List<ReservationEntity> reservations;
  // أضفنا هذا الحقل عشان لو الـ UI محتاج يعرف إيش الفلتر الشغال حالياً
  final String? filterType;

  const ReservationsLoaded({
    required this.reservations,
    this.filterType,
  });

  @override
  List<Object?> get props => [reservations, filterType];
}

// ✅ حالة النجاح للعمليات (Check-in, Cancel, No-Show)
class ReservationOperationSuccess extends ReservationsState {
  final String message;
  // نصيحة: أضف الـ ID الخاص بالحجز اللي تعدل عشان تقدر تحدث الـ UI محلياً
  final int? reservationId;

  const ReservationOperationSuccess({
    required this.message,
    this.reservationId,
  });

  @override
  List<Object?> get props => [message, reservationId];
}

class ReservationsError extends ReservationsState {
  final String message;

  const ReservationsError({required this.message});

  @override
  List<Object?> get props => [message];
}