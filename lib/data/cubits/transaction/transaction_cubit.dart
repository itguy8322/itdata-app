import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/models/transaction/transaction.dart';
import 'package:itdata/services/transac_service.dart';
import 'package:itdata/data/cubits/transaction/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  TransactionCubit() : super(TransactionStates.initial());

  void addTransaction(
    String username,
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      emit(state);
      await TransacService().add(path, username, data);
      emit(state);
    } catch (e) {
      emit(state);
    }
  }

  void loadTransactions(String? username, String path) async {
    try {
      emit(
        state.copyWith(
          loadingInProgress: true,
          loadingFailure: false,
          loadingSuccess: false,
        ),
      );
      final data = await TransacService().load(path, username!);
      List<Transaction> transactions = [];
      for (var transaction in data) {
        transactions.add(Transaction.fromJson(transaction));
      }
      emit(
        state.copyWith(
          transactions: transactions,
          loadingInProgress: false,
          loadingFailure: false,
          loadingSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingInProgress: false,
          loadingFailure: true,
          loadingSuccess: false,
        ),
      );
    }
  }
}
