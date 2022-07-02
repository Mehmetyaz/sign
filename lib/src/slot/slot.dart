part of sign;

/// Listen signals
abstract class Slot<T> {
  /// On signal
  void onValue(T value);
}

/// Slot with handler
class SlotWithHandler<T> extends Slot<T> {
  ///
  SlotWithHandler(this.handler);

  ///
  final void Function(T) handler;

  @override
  void onValue(T value) => handler(value);
}
