class PaginationManager {
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;

  void reset() {
    page = 1;
    hasMore = true;
    isLoading = false;
  }

  void nextPage() {
    page++;
  }
}
