class PaginationMetaData {
  //default will be null
  final String? rooteNode;
  final String totalNode;
  final String currentPageNode;
  final String perPageNode;

  PaginationMetaData(
      {this.rooteNode,
      this.totalNode = "total",
      this.currentPageNode = "currentPage",
      this.perPageNode = "perPage"});
}
