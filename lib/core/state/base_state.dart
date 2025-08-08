import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

@immutable
sealed class BaseState {
  const BaseState();
}

final class InitialState extends BaseState {
  const InitialState();
}

final class LoadingState extends BaseState {
  const LoadingState();
}

final class LoadingStateWithProgress extends BaseState {
  final double progress;

  const LoadingStateWithProgress({required this.progress});
}

final class SuccessState<T> extends BaseState {
  final T? data;

  const SuccessState({this.data});
}

final class ErrorState extends BaseState {
  final String? error;

  const ErrorState({this.error});
}

final class TimeoutState extends BaseState {
  const TimeoutState();
}

final class InternetErrorState extends BaseState {
  const InternetErrorState();
}

final class VersionErrorState extends BaseState {
  const VersionErrorState();
}

final class UnknownErrorState extends BaseState {
  final String? error;

  const UnknownErrorState({this.error});
}

final class PermissionPermanentlyDeniedState extends BaseState {
  const PermissionPermanentlyDeniedState();
}

final class AccessDeniedError extends BaseState {
  const AccessDeniedError();
}
