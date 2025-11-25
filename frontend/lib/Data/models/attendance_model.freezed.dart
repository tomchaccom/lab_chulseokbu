// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceRecordModel {

 String get date; int get timeInMinutes; double get timeInHours;
/// Create a copy of AttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceRecordModelCopyWith<AttendanceRecordModel> get copyWith => _$AttendanceRecordModelCopyWithImpl<AttendanceRecordModel>(this as AttendanceRecordModel, _$identity);

  /// Serializes this AttendanceRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRecordModel&&(identical(other.date, date) || other.date == date)&&(identical(other.timeInMinutes, timeInMinutes) || other.timeInMinutes == timeInMinutes)&&(identical(other.timeInHours, timeInHours) || other.timeInHours == timeInHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,timeInMinutes,timeInHours);

@override
String toString() {
  return 'AttendanceRecordModel(date: $date, timeInMinutes: $timeInMinutes, timeInHours: $timeInHours)';
}


}

/// @nodoc
abstract mixin class $AttendanceRecordModelCopyWith<$Res>  {
  factory $AttendanceRecordModelCopyWith(AttendanceRecordModel value, $Res Function(AttendanceRecordModel) _then) = _$AttendanceRecordModelCopyWithImpl;
@useResult
$Res call({
 String date, int timeInMinutes, double timeInHours
});




}
/// @nodoc
class _$AttendanceRecordModelCopyWithImpl<$Res>
    implements $AttendanceRecordModelCopyWith<$Res> {
  _$AttendanceRecordModelCopyWithImpl(this._self, this._then);

  final AttendanceRecordModel _self;
  final $Res Function(AttendanceRecordModel) _then;

/// Create a copy of AttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? timeInMinutes = null,Object? timeInHours = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,timeInMinutes: null == timeInMinutes ? _self.timeInMinutes : timeInMinutes // ignore: cast_nullable_to_non_nullable
as int,timeInHours: null == timeInHours ? _self.timeInHours : timeInHours // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceRecordModel].
extension AttendanceRecordModelPatterns on AttendanceRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int timeInMinutes,  double timeInHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceRecordModel() when $default != null:
return $default(_that.date,_that.timeInMinutes,_that.timeInHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int timeInMinutes,  double timeInHours)  $default,) {final _that = this;
switch (_that) {
case _AttendanceRecordModel():
return $default(_that.date,_that.timeInMinutes,_that.timeInHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int timeInMinutes,  double timeInHours)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceRecordModel() when $default != null:
return $default(_that.date,_that.timeInMinutes,_that.timeInHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceRecordModel implements AttendanceRecordModel {
  const _AttendanceRecordModel({required this.date, required this.timeInMinutes, required this.timeInHours});
  factory _AttendanceRecordModel.fromJson(Map<String, dynamic> json) => _$AttendanceRecordModelFromJson(json);

@override final  String date;
@override final  int timeInMinutes;
@override final  double timeInHours;

/// Create a copy of AttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceRecordModelCopyWith<_AttendanceRecordModel> get copyWith => __$AttendanceRecordModelCopyWithImpl<_AttendanceRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceRecordModel&&(identical(other.date, date) || other.date == date)&&(identical(other.timeInMinutes, timeInMinutes) || other.timeInMinutes == timeInMinutes)&&(identical(other.timeInHours, timeInHours) || other.timeInHours == timeInHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,timeInMinutes,timeInHours);

@override
String toString() {
  return 'AttendanceRecordModel(date: $date, timeInMinutes: $timeInMinutes, timeInHours: $timeInHours)';
}


}

/// @nodoc
abstract mixin class _$AttendanceRecordModelCopyWith<$Res> implements $AttendanceRecordModelCopyWith<$Res> {
  factory _$AttendanceRecordModelCopyWith(_AttendanceRecordModel value, $Res Function(_AttendanceRecordModel) _then) = __$AttendanceRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String date, int timeInMinutes, double timeInHours
});




}
/// @nodoc
class __$AttendanceRecordModelCopyWithImpl<$Res>
    implements _$AttendanceRecordModelCopyWith<$Res> {
  __$AttendanceRecordModelCopyWithImpl(this._self, this._then);

  final _AttendanceRecordModel _self;
  final $Res Function(_AttendanceRecordModel) _then;

/// Create a copy of AttendanceRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? timeInMinutes = null,Object? timeInHours = null,}) {
  return _then(_AttendanceRecordModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,timeInMinutes: null == timeInMinutes ? _self.timeInMinutes : timeInMinutes // ignore: cast_nullable_to_non_nullable
as int,timeInHours: null == timeInHours ? _self.timeInHours : timeInHours // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ToggleResponseModel {

 bool get isActive; String get lastOnTime;
/// Create a copy of ToggleResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleResponseModelCopyWith<ToggleResponseModel> get copyWith => _$ToggleResponseModelCopyWithImpl<ToggleResponseModel>(this as ToggleResponseModel, _$identity);

  /// Serializes this ToggleResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleResponseModel&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastOnTime, lastOnTime) || other.lastOnTime == lastOnTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isActive,lastOnTime);

@override
String toString() {
  return 'ToggleResponseModel(isActive: $isActive, lastOnTime: $lastOnTime)';
}


}

/// @nodoc
abstract mixin class $ToggleResponseModelCopyWith<$Res>  {
  factory $ToggleResponseModelCopyWith(ToggleResponseModel value, $Res Function(ToggleResponseModel) _then) = _$ToggleResponseModelCopyWithImpl;
@useResult
$Res call({
 bool isActive, String lastOnTime
});




}
/// @nodoc
class _$ToggleResponseModelCopyWithImpl<$Res>
    implements $ToggleResponseModelCopyWith<$Res> {
  _$ToggleResponseModelCopyWithImpl(this._self, this._then);

  final ToggleResponseModel _self;
  final $Res Function(ToggleResponseModel) _then;

/// Create a copy of ToggleResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isActive = null,Object? lastOnTime = null,}) {
  return _then(_self.copyWith(
isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastOnTime: null == lastOnTime ? _self.lastOnTime : lastOnTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ToggleResponseModel].
extension ToggleResponseModelPatterns on ToggleResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToggleResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToggleResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToggleResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ToggleResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToggleResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ToggleResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isActive,  String lastOnTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToggleResponseModel() when $default != null:
return $default(_that.isActive,_that.lastOnTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isActive,  String lastOnTime)  $default,) {final _that = this;
switch (_that) {
case _ToggleResponseModel():
return $default(_that.isActive,_that.lastOnTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isActive,  String lastOnTime)?  $default,) {final _that = this;
switch (_that) {
case _ToggleResponseModel() when $default != null:
return $default(_that.isActive,_that.lastOnTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToggleResponseModel implements ToggleResponseModel {
  const _ToggleResponseModel({required this.isActive, required this.lastOnTime});
  factory _ToggleResponseModel.fromJson(Map<String, dynamic> json) => _$ToggleResponseModelFromJson(json);

@override final  bool isActive;
@override final  String lastOnTime;

/// Create a copy of ToggleResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleResponseModelCopyWith<_ToggleResponseModel> get copyWith => __$ToggleResponseModelCopyWithImpl<_ToggleResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToggleResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleResponseModel&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastOnTime, lastOnTime) || other.lastOnTime == lastOnTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isActive,lastOnTime);

@override
String toString() {
  return 'ToggleResponseModel(isActive: $isActive, lastOnTime: $lastOnTime)';
}


}

/// @nodoc
abstract mixin class _$ToggleResponseModelCopyWith<$Res> implements $ToggleResponseModelCopyWith<$Res> {
  factory _$ToggleResponseModelCopyWith(_ToggleResponseModel value, $Res Function(_ToggleResponseModel) _then) = __$ToggleResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool isActive, String lastOnTime
});




}
/// @nodoc
class __$ToggleResponseModelCopyWithImpl<$Res>
    implements _$ToggleResponseModelCopyWith<$Res> {
  __$ToggleResponseModelCopyWithImpl(this._self, this._then);

  final _ToggleResponseModel _self;
  final $Res Function(_ToggleResponseModel) _then;

/// Create a copy of ToggleResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isActive = null,Object? lastOnTime = null,}) {
  return _then(_ToggleResponseModel(
isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastOnTime: null == lastOnTime ? _self.lastOnTime : lastOnTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
