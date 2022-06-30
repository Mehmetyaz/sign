part of sign;

/// Global signal is a signal that sign to all same type generic global slots.
/// Global signal stored by generic types. And can be create only once.
///
/// If you want to create a new instance dispose the old before creating new.
class GlobalSignal<V> extends Signal<V> {
  ///
  GlobalSignal(V value) : super(value) {
    global._registerSignal(this);
  }

  @override
  Set<GlobalSlot> get slots => super.slots.cast<GlobalSlot>();

  /// Dispose and unregister the signal from global signal controller.
  void dispose() {
    clearSlots();
    global._unregisterSignal(this);
  }
}
