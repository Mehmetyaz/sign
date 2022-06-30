part of sign;

/// Listen signals
abstract class Slot<T> {
  /// On signal
  void onValue(T value);
}
