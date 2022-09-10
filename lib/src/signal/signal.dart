part of sign;

///
class Signal<V> {
  /// Create with value
  Signal(this._value);

  /// Listen any changes this and [notifiers] any changes
  Signal combineWith(List<Signal> signals) => MultiSignal(signals..add(this));

  V _value;

  /// Your value.
  /// If you use as a setter notify listeners
  V get value => _value;

  /// Your value.
  /// If you use as a setter notify listeners
  set value(V value) {
    if (value == _value) return;
    _value = value;
    emit();
  }

  /// Slots
  final Set<Slot> slots = <Slot>{};

  /// Has slot
  bool get hasSlots => slots.isNotEmpty;

  /// Add new slot
  void addSlot(Slot slot) {
    slots.add(slot);
  }

  /// Remove slot
  void removeSlot(Slot slot) {
    slots.remove(slot);
  }

  /// Clear all slots
  void clearSlots() {
    slots.clear();
  }

  /// Sign to all slots
  void emit() {
    for (var slot in slots) {
      slot.onValue(value);
    }
  }
}

/// Generate signals that don't carry any value
class VoidSignal extends Signal<void> {
  /// Create a VoidSignal
  VoidSignal() : super(null);

  @override
  set value(void value) {
    emit();
  }
}
