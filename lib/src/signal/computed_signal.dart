part of sign;

/// A [Signal] that derives [value] from dependency signals via [compute].
class ComputedSignal<V> extends Signal<V> implements Slot<void> {
  ComputedSignal._(Iterable<Signal> dependencies, this._compute)
      : _dependencies = List<Signal>.from(dependencies),
        super(_compute()) {
    for (final dep in _dependencies) {
      dep.addSlot(this);
    }
  }

  final List<Signal> _dependencies;
  final V Function() _compute;

  @override
  void onValue(void value) {
    final next = _compute();
    if (next == this.value) return;
    this.value = next;
  }

  /// Stops listening to dependencies.
  void dispose() {
    for (final dep in _dependencies) {
      dep.removeSlot(this);
    }
  }
}
