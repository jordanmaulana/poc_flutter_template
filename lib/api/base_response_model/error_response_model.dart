// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  int? status;
  String? type;
  Map<String, List<String>>? messages;
  String? error;

  ErrorResponse({
    this.status,
    this.type,
    this.messages,
    this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        status: json["status"],
        type: json["type"],
        messages: json["messages"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "type": type,
        "messages": messages,
        "error": error,
      };
}
