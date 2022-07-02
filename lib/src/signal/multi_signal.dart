part of sign;

/// Handle multiple signals and sign to slots.
class MultiSignal extends Signal<void> implements Slot<void> {
  /// Create with signals
  MultiSignal(Iterable<Signal> signals, {bool growable = true})
      : _signals = List.from(signals, growable: growable),
        super(null) {
    for (var signal in signals) {
      signal.addSlot(this);
    }
  }

  ///
  void addSignal(Signal signal) {
    signal.addSlot(this);
    _signals.add(signal);
  }

  ///
  void removeSignal(Signal signal) {
    signal.removeSlot(this);
    _signals.remove(signal);
  }

  ///
  final List<Signal> _signals;

  ///
  void dispose() {
    for (var signal in _signals) {
      signal.removeSlot(this);
    }
  }

  @override
  void onValue(void value) {
    sign();
  }
}
