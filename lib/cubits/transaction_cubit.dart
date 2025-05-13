import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/services/transac_service.dart';
import 'package:itdata/states/transac_states.dart';

class TransactionCubit extends Cubit<TransacStates> {
  TransactionCubit() : super(TransacInitial());

  void add_transaction(
    String username,
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      emit(TransacLoading());
      await TransacService().addTransaction(path, username, data);
      emit(TransacLoaded([]));
    } catch (e) {
      emit(TransacError("error"));
    }
  }

  void load_transactions(String? username, String path) async {
    try {
      emit(TransacLoading());
      final transactions = await TransacService().loadtransactions(
        path,
        username!,
      );
      emit(TransacLoaded(transactions["transactions"]));
    } catch (e) {
      emit(TransacError("error"));
    }
  }
}
