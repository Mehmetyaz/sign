part of sign;

/// Copy of dart:core Map
///
/// But this Map notify any changes
class SignalMap<K, V> extends Signal<Map<K, V>> implements MapBase<K, V> {
  ///
  SignalMap(Map<K, V> value) : super(value);

  /// see dart core documentation
  factory SignalMap.from(Map other) => SignalMap(LinkedHashMap.from(other));

  /// see dart core documentation
  factory SignalMap.of(Map<K, V> other) =>
      SignalMap(LinkedHashMap<K, V>.of(other));

  /// see dart core documentation
  factory SignalMap.identity() => SignalMap(LinkedHashMap<K, V>.identity());

  /// see dart core documentation
  factory SignalMap.fromIterable(Iterable iterable,
          {K Function(dynamic element)? key,
          V Function(dynamic element)? value}) =>
      SignalMap(
          LinkedHashMap<K, V>.fromIterable(iterable, key: key, value: value));

  /// see dart core documentation
  factory SignalMap.fromIterables(Iterable<K> keys, Iterable<V> values) =>
      SignalMap(LinkedHashMap<K, V>.fromIterables(keys, values));

  /// see dart core documentation
  factory SignalMap.fromEntries(Iterable<MapEntry<K, V>> entries) =>
      SignalMap(<K, V>{}..addEntries(entries));

  @override
  Map<RK, RV> cast<RK, RV>() => value.cast<RK, RV>();

  @override
  bool containsValue(Object? value) => this.value.containsValue(value);

  @override
  bool containsKey(Object? key) => value.containsKey(key);

  /// see dart core documentation
  @override
  V? operator [](Object? key) => value[key];

  /// see dart core documentation
  @override
  void operator []=(K key, V val) {
    value[key] = val;
    sign();
  }

  /// see dart core documentation
  @override
  Iterable<MapEntry<K, V>> get entries => value.entries;

  @override
  Map<K2, V2> map<K2, V2>(
          MapEntry<K2, V2> Function(K key, V value) transform) =>
      value.map<K2, V2>(transform);

  /// see dart core documentation
  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    value.addEntries(newEntries);
    sign();
  }

  /// see dart core documentation
  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    var r = value.update(key, update, ifAbsent: ifAbsent);
    sign();
    return r;
  }

  /// see dart core documentation
  @override
  void updateAll(V Function(K key, V value) update) {
    value.updateAll(update);
    sign();
  }

  /// see dart core documentation
  @override
  void removeWhere(bool Function(K key, V value) test) {
    value.removeWhere(test);
    sign();
  }

  /// see dart core documentation
  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    var r = value.putIfAbsent(key, ifAbsent);
    sign();
    return r;
  }

  /// see dart core documentation
  @override
  void addAll(Map<K, V> other) {
    value.addAll(other);
    sign();
  }

  /// see dart core documentation
  @override
  V? remove(Object? key) {
    var r = value.remove(key);
    sign();
    return r;
  }

  /// see dart core documentation
  @override
  void clear() {
    value.clear();
    sign();
  }

  @override
  void forEach(void Function(K key, V value) action) => value.forEach(action);

  /// see dart core documentation
  @override
  Iterable<K> get keys => value.keys;

  /// see dart core documentation
  @override
  Iterable<V> get values => value.values;

  /// see dart core documentation
  @override
  int get length => value.length;

  /// see dart core documentation
  @override
  bool get isEmpty => value.isEmpty;

  /// see dart core documentation
  @override
  bool get isNotEmpty => value.isNotEmpty;
}
