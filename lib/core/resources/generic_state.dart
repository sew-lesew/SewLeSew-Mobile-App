// ignore_for_file: public_member_api_docs, sort_constructors_first
class GenericState<T> {
  final String? failure;
  final bool? isSuccess;
  final bool? isLoading;
  final T? data;
  GenericState({
    this.failure,
    this.isSuccess,
    this.isLoading,
    this.data,
  });

  GenericState<T> copyWith({
    String? failure,
    bool? isSuccess,
    bool? isLoading,
    T? data,
  }) {
    return GenericState<T>(
      failure: failure ?? this.failure,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
    );
  }
}
