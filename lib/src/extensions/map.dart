part of sign;

///
extension MultipleListenerOnMap<K extends Object, V extends Signal>
    on Map<K, V> {
  ///
  MultiSignal get notifyAll => MultiSignal(values);
}

///
extension SignalExtensionOnMap<K, V> on Map<K, V> {
  /// Listen all changes(exclude add and remove operations)
  ///
  /// and notify only changed object
  ///
  Map<K, Signal<V>> get listeners =>
      map((key, value) => MapEntry(key, Signal(value)));

  /// Listen all changes and notify all changes
  SignalMap<K, V> get listenAll => SignalMap(this);
}
