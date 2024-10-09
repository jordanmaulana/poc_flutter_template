class Pagination {
  final int lastVisiblePage;
  final bool hasNextPage;
  final int currentPage;
  final int count;
  final int total;
  final int perPage;

  Pagination({
    required this.lastVisiblePage,
    required this.hasNextPage,
    required this.currentPage,
    required this.count,
    required this.total,
    required this.perPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      lastVisiblePage: json['last_visible_page'],
      hasNextPage: json['has_next_page'],
      currentPage: json['current_page'],
      count: json['items']['count'],
      total: json['items']['total'],
      perPage: json['items']['per_page'],
    );
  }
}

class PaginatedResponse<T> {
  final Pagination pagination;
  final List<T> data;

  PaginatedResponse({required this.pagination, required this.data});

  // General factory method that takes a function to parse each item in "data".
  factory PaginatedResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return PaginatedResponse(
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
    );
  }
}
