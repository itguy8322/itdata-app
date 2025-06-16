// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_providers_state.freezed.dart';

@freezed
abstract class NetworkProvidersState with _$NetworkProvidersState {
  const factory NetworkProvidersState({
    required List<String>? networkProviders,
  }) = _NetworkProvidersState;

  factory NetworkProvidersState.initial() {
    return NetworkProvidersState(
      networkProviders: []
    );
  }
}
