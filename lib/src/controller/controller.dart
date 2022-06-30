part of sign;

/// Global signal controller instance
final GlobalSignalController global = GlobalSignalController();

/// Global signal controller
class GlobalSignalController {
  /// Get global signal controller instance
  factory GlobalSignalController() => _instance;

  GlobalSignalController._();

  static final GlobalSignalController _instance = GlobalSignalController._();

  /// Global signals
  final Map<Type, Signal> signals = {};

  final Map<Type, List<GlobalSlot>> _idleSlots = {};

  /// Sign signals by type
  void sign<T extends GlobalSignal>() {
    signals[T]?.sign();
  }

  void _registerSignal(Signal signal) {
    if (signals[signal.runtimeType] != null) {
      throw Exception('Signal already registered. \n'
          'Global signals can only be registered once.\n'
          'Don\'t create the same signal instance twice or dispose '
          'first before creating it again.');
    }
    if (_idleSlots[signal.runtimeType] != null) {
      signal.slots.addAll((_idleSlots[signal.runtimeType] ?? []));
      _idleSlots.remove(signal.runtimeType);
    }
    signals[signal.runtimeType] = signal;
  }

  void _unregisterSignal(GlobalSignal signal) {
    _idleSlots[signal.runtimeType] ??= [];
    _idleSlots[signal.runtimeType]?.addAll(signal.slots);
    signals.remove(signal.runtimeType);
    _idleSlots.remove(signal.runtimeType);
  }

  void _registerSlot(GlobalSlot slot, Type runtimeType) {
    if (signals[runtimeType] == null) {
      _idleSlots[runtimeType] ??= [];
      _idleSlots[runtimeType]!.add(slot);
    } else {
      signals[runtimeType]?.addSlot(slot);
    }
  }

  void _unregisterSlot(GlobalSlot slot, Type runtimeType) {
    signals[runtimeType]?.removeSlot(slot);
    _idleSlots[runtimeType]?.remove(slot);
  }
}
