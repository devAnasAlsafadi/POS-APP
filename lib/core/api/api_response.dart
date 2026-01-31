class ApiResponse<T>{
  final bool? status;
  final T? data;
  final String? message;

  ApiResponse({this.status, this.data, this.message});
  factory ApiResponse.fromJson(Map<String,dynamic> json ,T Function(dynamic json) fromJsonT){
    return ApiResponse<T>(
      status: json['status'] as bool?,
      data: fromJsonT(json['data']),
      message: json['message'] as String?,
    );
  }


}