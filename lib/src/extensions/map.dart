part of sign;

///
extension MultipleListenerOnMap<K extends Object, V extends Signal>
    on Map<K, V> {
  ///
  MultiSignal get multiSignal => MultiSignal(values);
}

///
extension SignalExtensionOnMap<K, V> on Map<K, V> {
  /// Listen all changes(exclude add and remove operations)
  ///
  /// and notify only changed object
  ///
  Map<K, Signal<V>> get signals =>
      map((key, value) => MapEntry(key, Signal(value)));

  /// Listen all changes and notify all changes
  SignalMap<K, V> get signalMap => SignalMap(this);
}
