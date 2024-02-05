import 'package:quantum_fetch/src/metadata/pagination_meta_data.dart';

abstract class IQuantumFetchPagination {}

class QuantumFetchPagination extends IQuantumFetchPagination {
  final int? total;
  final int? currentPage;
  final int? perPage;
  QuantumFetchPagination({this.total, this.currentPage, this.perPage});

  factory QuantumFetchPagination.fromJson(
      Map<String, dynamic>? json, PaginationMetaData paginationMetaData) {
    return QuantumFetchPagination(
      total: json?[paginationMetaData.totalNode] as int?,
      currentPage: json?[paginationMetaData.currentPageNode] as int?,
      perPage: json?[paginationMetaData.perPageNode] as int?,
    );
  }
}
