import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'loading_view_model.g.dart';

@riverpod
class LoadingViewModel extends _$LoadingViewModel {
  @override
  bool build() => false;

  void setLoading(bool loading) {
    state = loading;
  }
}