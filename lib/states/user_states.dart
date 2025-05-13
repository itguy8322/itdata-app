abstract class UserStates {}

class UserInitial extends UserStates {}

class UserLoading extends UserStates {}

class UserLoaded extends UserStates {
  final Map<String, dynamic> user;
  UserLoaded(this.user);
}

class UserError extends UserStates {
  final String message;
  UserError(this.message);
}
