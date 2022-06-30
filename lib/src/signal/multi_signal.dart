part of sign;

/// Handle multiple signals and sign to slots.
class MultiSignal extends Signal<void> implements MultiSlot {
  /// Create with signals
  MultiSignal(Iterable<Signal> signals, {bool growable = true})
      : signals = List.from(signals, growable: growable),
        super(null) {
    for (var signal in signals) {
      signal.addSlot(this);
    }
  }

  @override
  List<Signal> signals;

  @override
  void dispose() {
    for (var signal in signals) {
      signal.removeSlot(this);
    }
  }

  @override
  void onValue(void value) {
    sign();
  }
}
