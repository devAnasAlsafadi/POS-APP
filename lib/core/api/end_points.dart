class EndPoints {
  static const String baseUrl = "https://pos.wiz-tech.co/api/waiter/";

  // Auth Endpoints
  static const String login = "auth/login";
  static const String  allTables = "tables";




  static const String  allProducts = "products";
  static const String  allOrders = "orders";
  static const String  activeOrders = "orders/active";

  // Reservation Endpoints
  static const String allReservations = "reservations";
  static const String todayReservations = "reservations/today";
  static const String upcomingReservations = "reservations/upcoming";
  static const String createReservation = "reservations";

  // specific
  static String checkInReservation(int id) => "reservations/$id/check-in";
  static String cancelReservation(int id) => "reservations/$id/cancel";
  static String noShowReservation(int id) => "reservations/$id/no-show";

  // Feedback Endpoints
  static const String feedback = "feedback";

}