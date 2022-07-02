part of sign;

/// Global signal is a signal that sign to all same type generic global slots.
/// Global signal stored by generic types. And can be create only once.
///
/// If you want to create a new instance dispose the old before creating new.
class GlobalSignal<V> extends Signal<V> {
  ///
  GlobalSignal(V value) : super(value) {
    registerSignal();
  }
  //
  // @override
  // Set<GlobalSlot> get slots => super.slots.cast<GlobalSlot>();

  ///
  void registerSignal() {
    global._registerSignal(this);
  }

  /// Dispose and unregister the signal from global signal controller.
  void unregisterSignal() {
    global._unregisterSignal(this);
  }
}
