// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupMemberStatusModel {

 int get memberId; String get nickname; bool get isActive; double get totalHours;
/// Create a copy of GroupMemberStatusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupMemberStatusModelCopyWith<GroupMemberStatusModel> get copyWith => _$GroupMemberStatusModelCopyWithImpl<GroupMemberStatusModel>(this as GroupMemberStatusModel, _$identity);

  /// Serializes this GroupMemberStatusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMemberStatusModel&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.totalHours, totalHours) || other.totalHours == totalHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,nickname,isActive,totalHours);

@override
String toString() {
  return 'GroupMemberStatusModel(memberId: $memberId, nickname: $nickname, isActive: $isActive, totalHours: $totalHours)';
}


}

/// @nodoc
abstract mixin class $GroupMemberStatusModelCopyWith<$Res>  {
  factory $GroupMemberStatusModelCopyWith(GroupMemberStatusModel value, $Res Function(GroupMemberStatusModel) _then) = _$GroupMemberStatusModelCopyWithImpl;
@useResult
$Res call({
 int memberId, String nickname, bool isActive, double totalHours
});




}
/// @nodoc
class _$GroupMemberStatusModelCopyWithImpl<$Res>
    implements $GroupMemberStatusModelCopyWith<$Res> {
  _$GroupMemberStatusModelCopyWithImpl(this._self, this._then);

  final GroupMemberStatusModel _self;
  final $Res Function(GroupMemberStatusModel) _then;

/// Create a copy of GroupMemberStatusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = null,Object? nickname = null,Object? isActive = null,Object? totalHours = null,}) {
  return _then(_self.copyWith(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,totalHours: null == totalHours ? _self.totalHours : totalHours // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupMemberStatusModel].
extension GroupMemberStatusModelPatterns on GroupMemberStatusModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupMemberStatusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupMemberStatusModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupMemberStatusModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupMemberStatusModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupMemberStatusModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupMemberStatusModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberId,  String nickname,  bool isActive,  double totalHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupMemberStatusModel() when $default != null:
return $default(_that.memberId,_that.nickname,_that.isActive,_that.totalHours);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberId,  String nickname,  bool isActive,  double totalHours)  $default,) {final _that = this;
switch (_that) {
case _GroupMemberStatusModel():
return $default(_that.memberId,_that.nickname,_that.isActive,_that.totalHours);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberId,  String nickname,  bool isActive,  double totalHours)?  $default,) {final _that = this;
switch (_that) {
case _GroupMemberStatusModel() when $default != null:
return $default(_that.memberId,_that.nickname,_that.isActive,_that.totalHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupMemberStatusModel implements GroupMemberStatusModel {
  const _GroupMemberStatusModel({required this.memberId, required this.nickname, required this.isActive, required this.totalHours});
  factory _GroupMemberStatusModel.fromJson(Map<String, dynamic> json) => _$GroupMemberStatusModelFromJson(json);

@override final  int memberId;
@override final  String nickname;
@override final  bool isActive;
@override final  double totalHours;

/// Create a copy of GroupMemberStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupMemberStatusModelCopyWith<_GroupMemberStatusModel> get copyWith => __$GroupMemberStatusModelCopyWithImpl<_GroupMemberStatusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupMemberStatusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupMemberStatusModel&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.totalHours, totalHours) || other.totalHours == totalHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,nickname,isActive,totalHours);

@override
String toString() {
  return 'GroupMemberStatusModel(memberId: $memberId, nickname: $nickname, isActive: $isActive, totalHours: $totalHours)';
}


}

/// @nodoc
abstract mixin class _$GroupMemberStatusModelCopyWith<$Res> implements $GroupMemberStatusModelCopyWith<$Res> {
  factory _$GroupMemberStatusModelCopyWith(_GroupMemberStatusModel value, $Res Function(_GroupMemberStatusModel) _then) = __$GroupMemberStatusModelCopyWithImpl;
@override @useResult
$Res call({
 int memberId, String nickname, bool isActive, double totalHours
});




}
/// @nodoc
class __$GroupMemberStatusModelCopyWithImpl<$Res>
    implements _$GroupMemberStatusModelCopyWith<$Res> {
  __$GroupMemberStatusModelCopyWithImpl(this._self, this._then);

  final _GroupMemberStatusModel _self;
  final $Res Function(_GroupMemberStatusModel) _then;

/// Create a copy of GroupMemberStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = null,Object? nickname = null,Object? isActive = null,Object? totalHours = null,}) {
  return _then(_GroupMemberStatusModel(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,totalHours: null == totalHours ? _self.totalHours : totalHours // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
