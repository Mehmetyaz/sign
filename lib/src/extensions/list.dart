part of sign;

///
extension MultipleListenerOnList<T extends Signal> on List<T> {
  ///
  MultiSignal get notifyAll => MultiSignal(this);
}

///
extension ListenableList<T> on List<T> {
  /// Listen all changes(exclude add and remove operations)
  ///
  /// and notify only changed object
  ///
  List<Signal<T>> get listeners => map<Signal<T>>((e) => e.toSignal()).toList();

  /// Listen all changes and notify all changes
  SignalList<T> get listenAll => SignalList<T>(this);
}
