part of sign;

/// help to convert stream to change notifier
extension StreamNotifier<T> on Stream<T> {
  /// Notify changes on `onData`
  /// Please don't forget close
  /// listen started after construct
  StreamSignal<T?> get signalStream => SignalStreamNullable<T>(this);

  /// Notify changes on `onData`
  /// Please don't forget close
  /// listen started after construct
  StreamSignal<T> streamSignalWithDefault(T defaultValue) =>
      SignalStreamNonNullable<T>(this, defaultValue);
}
