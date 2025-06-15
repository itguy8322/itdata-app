// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionStates {

 String get userId; List<Transaction>? get transactions; bool get loadingInProgress; bool get loadingSuccess; bool get loadingFailure;
/// Create a copy of TransactionStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionStatesCopyWith<TransactionStates> get copyWith => _$TransactionStatesCopyWithImpl<TransactionStates>(this as TransactionStates, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionStates&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.loadingInProgress, loadingInProgress) || other.loadingInProgress == loadingInProgress)&&(identical(other.loadingSuccess, loadingSuccess) || other.loadingSuccess == loadingSuccess)&&(identical(other.loadingFailure, loadingFailure) || other.loadingFailure == loadingFailure));
}


@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(transactions),loadingInProgress,loadingSuccess,loadingFailure);

@override
String toString() {
  return 'TransactionStates(userId: $userId, transactions: $transactions, loadingInProgress: $loadingInProgress, loadingSuccess: $loadingSuccess, loadingFailure: $loadingFailure)';
}


}

/// @nodoc
abstract mixin class $TransactionStatesCopyWith<$Res>  {
  factory $TransactionStatesCopyWith(TransactionStates value, $Res Function(TransactionStates) _then) = _$TransactionStatesCopyWithImpl;
@useResult
$Res call({
 String userId, List<Transaction>? transactions, bool loadingInProgress, bool loadingSuccess, bool loadingFailure
});




}
/// @nodoc
class _$TransactionStatesCopyWithImpl<$Res>
    implements $TransactionStatesCopyWith<$Res> {
  _$TransactionStatesCopyWithImpl(this._self, this._then);

  final TransactionStates _self;
  final $Res Function(TransactionStates) _then;

/// Create a copy of TransactionStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? transactions = freezed,Object? loadingInProgress = null,Object? loadingSuccess = null,Object? loadingFailure = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,transactions: freezed == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>?,loadingInProgress: null == loadingInProgress ? _self.loadingInProgress : loadingInProgress // ignore: cast_nullable_to_non_nullable
as bool,loadingSuccess: null == loadingSuccess ? _self.loadingSuccess : loadingSuccess // ignore: cast_nullable_to_non_nullable
as bool,loadingFailure: null == loadingFailure ? _self.loadingFailure : loadingFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _TransactionStates implements TransactionStates {
  const _TransactionStates({required this.userId, required final  List<Transaction>? transactions, required this.loadingInProgress, required this.loadingSuccess, required this.loadingFailure}): _transactions = transactions;
  

@override final  String userId;
 final  List<Transaction>? _transactions;
@override List<Transaction>? get transactions {
  final value = _transactions;
  if (value == null) return null;
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool loadingInProgress;
@override final  bool loadingSuccess;
@override final  bool loadingFailure;

/// Create a copy of TransactionStates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionStatesCopyWith<_TransactionStates> get copyWith => __$TransactionStatesCopyWithImpl<_TransactionStates>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionStates&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.loadingInProgress, loadingInProgress) || other.loadingInProgress == loadingInProgress)&&(identical(other.loadingSuccess, loadingSuccess) || other.loadingSuccess == loadingSuccess)&&(identical(other.loadingFailure, loadingFailure) || other.loadingFailure == loadingFailure));
}


@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_transactions),loadingInProgress,loadingSuccess,loadingFailure);

@override
String toString() {
  return 'TransactionStates(userId: $userId, transactions: $transactions, loadingInProgress: $loadingInProgress, loadingSuccess: $loadingSuccess, loadingFailure: $loadingFailure)';
}


}

/// @nodoc
abstract mixin class _$TransactionStatesCopyWith<$Res> implements $TransactionStatesCopyWith<$Res> {
  factory _$TransactionStatesCopyWith(_TransactionStates value, $Res Function(_TransactionStates) _then) = __$TransactionStatesCopyWithImpl;
@override @useResult
$Res call({
 String userId, List<Transaction>? transactions, bool loadingInProgress, bool loadingSuccess, bool loadingFailure
});




}
/// @nodoc
class __$TransactionStatesCopyWithImpl<$Res>
    implements _$TransactionStatesCopyWith<$Res> {
  __$TransactionStatesCopyWithImpl(this._self, this._then);

  final _TransactionStates _self;
  final $Res Function(_TransactionStates) _then;

/// Create a copy of TransactionStates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? transactions = freezed,Object? loadingInProgress = null,Object? loadingSuccess = null,Object? loadingFailure = null,}) {
  return _then(_TransactionStates(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,transactions: freezed == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>?,loadingInProgress: null == loadingInProgress ? _self.loadingInProgress : loadingInProgress // ignore: cast_nullable_to_non_nullable
as bool,loadingSuccess: null == loadingSuccess ? _self.loadingSuccess : loadingSuccess // ignore: cast_nullable_to_non_nullable
as bool,loadingFailure: null == loadingFailure ? _self.loadingFailure : loadingFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
