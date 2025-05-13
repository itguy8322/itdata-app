abstract class TransacStates {}

class TransacInitial extends TransacStates {}

class TransacLoading extends TransacStates {}

class TransacLoaded extends TransacStates {
  final List<Map<String, dynamic>> transactions;
  TransacLoaded(this.transactions);
}

class TransacError extends TransacStates {
  final String message;
  TransacError(this.message);
}
