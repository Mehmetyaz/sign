part of sign;

/// To signal for variables
extension ToSignalExtension<T> on T {
  /// Converts the value to a signal.
  ///
  /// See also:
  ///  * [Signal]
  Signal<T> get signal => Signal<T>(this);

  /// Converts the value to a global signal.
  ///
  /// See also:
  ///  * [GlobalSignal]
  GlobalSignal<T> get globalSignal => GlobalSignal<T>(this);
}
