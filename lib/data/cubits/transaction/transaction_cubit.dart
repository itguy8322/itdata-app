import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/models/transaction/transaction.dart';
import 'package:itdata/services/transac_service.dart';
import 'package:itdata/data/cubits/transaction/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  TransactionCubit() : super(TransactionStates.initial());
  void reset() {
    emit(TransactionStates.initial());
  }
  void setUserId(String id){
    emit(state.copyWith(userId: id));
  }

  void addTransaction(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      emit(state);
      await TransacService().add(id, data);
      emit(state);
    } catch (e) {
      emit(state);
    }
  }

  void loadTransactions() async {
    try {
      emit(
        state.copyWith(
          loadingInProgress: true,
          loadingFailure: false,
          loadingSuccess: false,
        ),
      );
      final data = await TransacService().load(state.userId);
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
      //print(" =============== ERROR ==============");
      //print(e.toString());
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
