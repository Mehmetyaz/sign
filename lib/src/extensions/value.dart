part of sign;

/// To signal for variables
extension ToSignalExtension<T> on T {
  /// Converts the value to a signal.
  ///
  /// See also:
  ///  * [Signal]
  Signal<T> toSignal() => Signal<T>(this);

  /// Converts the value to a global signal.
  ///
  /// See also:
  ///  * [GlobalSignal]
  GlobalSignal<T> toGlobalSignal() => GlobalSignal<T>(this);
}
