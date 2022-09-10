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
  final Map<Type, GlobalSignal> _signals = {};

  final Map<Type, List<Slot>> _idleSlots = {};

  /// Sign signals by type
  void sign<T extends GlobalSignal>(dynamic value) {
    _signals[T]?.emit();
  }

  void _registerSignal(GlobalSignal signal) {
    if (_signals[signal.runtimeType] != null) {
      throw Exception('Signal already registered. \n'
          'Global signals can only be registered once.\n'
          'Don\'t create the same signal instance twice or dispose '
          'first before creating it again.');
    }
    if (_idleSlots[signal.runtimeType] != null) {
      signal.slots.addAll((_idleSlots[signal.runtimeType] ?? []));
      _idleSlots.remove(signal.runtimeType);
    }
    _signals[signal.runtimeType] = signal;
  }

  void _unregisterSignal(GlobalSignal signal) {
    _idleSlots[signal.runtimeType] ??= [];
    _idleSlots[signal.runtimeType]?.addAll(signal.slots);
    signal.clearSlots();
    _signals.remove(signal.runtimeType);
  }

  void _registerSlot(GlobalSlot slot, Type runtimeType) {
    if (_signals[runtimeType] == null) {
      _idleSlots[runtimeType] ??= [];
      _idleSlots[runtimeType]!.add(slot);
    } else {
      _signals[runtimeType]?.addSlot(slot);
    }
  }

  void _unregisterSlot(GlobalSlot slot, Type runtimeType) {
    _signals[runtimeType]?.removeSlot(slot);
    _idleSlots[runtimeType]?.remove(slot);
  }
}
