part of sign;

///
extension MultipleListenerOnList<T extends Signal> on List<T> {
  ///
  MultiSignal get multiSignal => MultiSignal(this);
}

///
extension ListenableList<T> on List<T> {
  /// Listen all changes(exclude add and remove operations)
  ///
  /// and notify only changed object
  ///
  List<Signal<T>> get signals => map<Signal<T>>((e) => e.signal).toList();

  /// Listen all changes and notify all changes
  SignalList<T> get signalList => SignalList<T>(this);
}
