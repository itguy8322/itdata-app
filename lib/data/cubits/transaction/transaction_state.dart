// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itdata/data/models/transaction/transaction.dart';

part 'transaction_state.freezed.dart';

@freezed
abstract class TransactionStates with _$TransactionStates {
  const factory TransactionStates({
    required String userId,
    required List<Transaction>? transactions,
    required bool loadingInProgress,
    required bool loadingSuccess,
    required bool loadingFailure,
  }) = _TransactionStates;

  factory TransactionStates.initial() {
    return TransactionStates(
      userId: '',
      transactions: [],
      loadingInProgress: false,
      loadingSuccess: false,
      loadingFailure: false,
    );
  }
}
