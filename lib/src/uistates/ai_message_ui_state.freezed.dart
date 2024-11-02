// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_message_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AiMessage {
  String get message => throw _privateConstructorUsedError;
  DateTime get sendTime => throw _privateConstructorUsedError;
  bool get fromChatGpt => throw _privateConstructorUsedError;

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiMessageCopyWith<AiMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiMessageCopyWith<$Res> {
  factory $AiMessageCopyWith(AiMessage value, $Res Function(AiMessage) then) =
      _$AiMessageCopyWithImpl<$Res, AiMessage>;
  @useResult
  $Res call({String message, DateTime sendTime, bool fromChatGpt});
}

/// @nodoc
class _$AiMessageCopyWithImpl<$Res, $Val extends AiMessage>
    implements $AiMessageCopyWith<$Res> {
  _$AiMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? sendTime = null,
    Object? fromChatGpt = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sendTime: null == sendTime
          ? _value.sendTime
          : sendTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromChatGpt: null == fromChatGpt
          ? _value.fromChatGpt
          : fromChatGpt // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiMessageImplCopyWith<$Res>
    implements $AiMessageCopyWith<$Res> {
  factory _$$AiMessageImplCopyWith(
          _$AiMessageImpl value, $Res Function(_$AiMessageImpl) then) =
      __$$AiMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, DateTime sendTime, bool fromChatGpt});
}

/// @nodoc
class __$$AiMessageImplCopyWithImpl<$Res>
    extends _$AiMessageCopyWithImpl<$Res, _$AiMessageImpl>
    implements _$$AiMessageImplCopyWith<$Res> {
  __$$AiMessageImplCopyWithImpl(
      _$AiMessageImpl _value, $Res Function(_$AiMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? sendTime = null,
    Object? fromChatGpt = null,
  }) {
    return _then(_$AiMessageImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sendTime: null == sendTime
          ? _value.sendTime
          : sendTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromChatGpt: null == fromChatGpt
          ? _value.fromChatGpt
          : fromChatGpt // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AiMessageImpl implements _AiMessage {
  const _$AiMessageImpl(
      {required this.message,
      required this.sendTime,
      required this.fromChatGpt});

  @override
  final String message;
  @override
  final DateTime sendTime;
  @override
  final bool fromChatGpt;

  @override
  String toString() {
    return 'AiMessage(message: $message, sendTime: $sendTime, fromChatGpt: $fromChatGpt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiMessageImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.sendTime, sendTime) ||
                other.sendTime == sendTime) &&
            (identical(other.fromChatGpt, fromChatGpt) ||
                other.fromChatGpt == fromChatGpt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, sendTime, fromChatGpt);

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiMessageImplCopyWith<_$AiMessageImpl> get copyWith =>
      __$$AiMessageImplCopyWithImpl<_$AiMessageImpl>(this, _$identity);
}

abstract class _AiMessage implements AiMessage {
  const factory _AiMessage(
      {required final String message,
      required final DateTime sendTime,
      required final bool fromChatGpt}) = _$AiMessageImpl;

  @override
  String get message;
  @override
  DateTime get sendTime;
  @override
  bool get fromChatGpt;

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiMessageImplCopyWith<_$AiMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
