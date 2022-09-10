part of sign;

/// Copy of dart:core List
///
/// But this list notify any changes
class SignalList<E> extends Signal<List<E>> implements ListBase<E> {
  ///
  SignalList(List<E> list) : super(list);

  /// see dart:core documentation
  factory SignalList.filled(int length, E fill, {bool growable = false}) =>
      SignalList(List.filled(length, fill, growable: growable));

  /// see dart:core documentation
  factory SignalList.empty({bool growable = false}) =>
      SignalList(List.empty(growable: growable));

  /// see dart:core documentation
  factory SignalList.from(Iterable elements, {bool growable = true}) =>
      SignalList(List.from(elements, growable: growable));

  /// see dart:core documentation
  factory SignalList.of(Iterable<E> elements, {bool growable = true}) =>
      SignalList(List.of(elements, growable: growable));

  /// see dart:core documentation
  factory SignalList.generate(int length, E Function(int index) generator,
          {bool growable = true}) =>
      SignalList(List.generate(length, generator, growable: growable));

  /// Copy source items in given range to target
  static void copyRange<T>(SignalList<T> target, int at, List<T> source,
      [int? start, int? end]) {
    start ??= 0;
    end = RangeError.checkValidRange(start, end, source.length);
    var length = end - start;
    if (target.length < at + length) {
      throw ArgumentError.value(target, 'target',
          'Not big enough to hold $length elements at position $at');
    }
    if (!identical(source, target) || start >= at) {
      for (var i = 0; i < length; i++) {
        target.value[at + i] = source[start + i];
      }
    } else {
      for (var i = length; --i >= 0;) {
        target.value[at + i] = source[start + i];
      }
    }
    target.emit();
  }

  /// Write to target from source in given range
  static void writeIterable<T>(
      SignalList<T> target, int at, Iterable<T> source) {
    RangeError.checkValueInInterval(at, 0, target.length, 'at');
    var index = at;
    var targetLength = target.length;
    for (var element in source) {
      if (index == targetLength) {
        throw IndexError(targetLength, target);
      }
      target.value[index] = element;
      index++;
    }
    target.emit();
  }

  @override
  List<R> cast<R>() => value.cast<R>();

  /// see dart:core documentation
  @override
  List<T> map<T>(T Function(E e) f) => value.map(f).toList();

  /// see dart:core documentation
  @override
  E operator [](int index) => value[index];

  /// see dart:core documentation
  @override
  void operator []=(int index, E val) {
    value[index] = val;
    emit();
    return;
  }

  /// see dart:core documentation
  @override
  set first(E val) {
    value.first = val;
    emit();
  }

  /// see dart:core documentation
  @override
  set last(E val) {
    value.last = val;
    emit();
  }

  /// see dart:core documentation
  @override
  int get length => value.length;

  /// see dart:core documentation
  @override
  set length(int newLength) {
    value.length = newLength;
    emit();
  }

  /// see dart:core documentation
  @override
  bool get isNotEmpty => value.isNotEmpty;

  /// see dart:core documentation
  @override
  bool get isEmpty => value.isEmpty;

  /// see dart:core documentation
  @override
  E get first => value.first;

  /// see dart:core documentation
  @override
  E get last => value.last;

  /// see dart:core documentation
  @override
  void add(E val) {
    value.add(val);
    emit();
  }

  /// see dart:core documentation
  @override
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    emit();
  }

  @override
  Iterable<E> get reversed => value.reversed;

  @override
  void sort([int Function(E a, E b)? compare]) {
    value.sort(compare);
    emit();
  }

  /// see dart:core documentation
  @override
  void shuffle([Random? random]) {
    value.shuffle(random);
    emit();
  }

  @override
  int indexOf(covariant E element, [int start = 0]) =>
      value.indexOf(element, start);

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) =>
      value.indexWhere(test, start);

  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) =>
      value.lastIndexWhere(test, start);

  @override
  int lastIndexOf(covariant E element, [int? start]) =>
      value.lastIndexOf(element, start);

  /// see dart:core documentation
  @override
  void clear() {
    value.clear();
    emit();
  }

  /// see dart:core documentation
  @override
  void insert(int index, E element) {
    value.insert(index, element);
    emit();
  }

  /// see dart:core documentation
  @override
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    emit();
  }

  /// see dart:core documentation
  @override
  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    emit();
  }

  /// see dart:core documentation
  @override
  bool remove(Object? val) {
    var r = value.remove(val);
    emit();
    return r;
  }

  /// see dart:core documentation
  @override
  E removeAt(int index) {
    var r = value.removeAt(index);
    emit();
    return r;
  }

  /// see dart:core documentation
  @override
  E removeLast() {
    var r = value.removeLast();
    emit();
    return r;
  }

  /// see dart:core documentation
  @override
  void removeWhere(bool Function(E element) test) {
    value.removeWhere(test);
    emit();
  }

  /// see dart:core documentation
  @override
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    emit();
  }

  /// see dart:core documentation
  @override
  List<E> operator +(List<E> other) {
    var r = value + other;
    emit();
    return r;
  }

  @override
  SignalList<E> sublist(int start, [int? end]) =>
      SignalList(value.sublist(start, end));

  @override
  Iterable<E> getRange(int start, int end) => value.getRange(start, end);

  /// see dart:core documentation
  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    emit();
  }

  /// see dart:core documentation
  @override
  void removeRange(int start, int end) {
    value.removeRange(start, end);
    emit();
  }

  /// see dart:core documentation
  @override
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    emit();
  }

  /// see dart:core documentation
  @override
  void replaceRange(int start, int end, Iterable<E> replacements) {
    value.replaceRange(start, end, replacements);
    emit();
  }

  @override
  Map<int, E> asMap() => value.asMap();

  @override
  bool any(bool Function(E element) test) => value.any(test);

  @override
  bool contains(Object? element) => value.contains(element);

  @override
  E elementAt(int index) => value.elementAt(index);

  @override
  bool every(bool Function(E element) test) => value.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) f) =>
      value.expand<T>(f);

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) =>
      value.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) =>
      value.fold<T>(initialValue, combine);

  @override
  Iterable<E> followedBy(Iterable<E> other) => value.followedBy(other);

  @override
  void forEach(void Function(E element) action) => value.forEach(action);

  @override
  Iterator<E> get iterator => value.iterator;

  @override
  String join([String separator = '']) => value.join(separator);

  @override
  E lastWhere(bool Function(E element) test, {E Function()? orElse}) =>
      value.lastWhere(test, orElse: orElse);

  @override
  E reduce(E Function(E previousValue, E element) combine) =>
      value.reduce(combine);

  @override
  E get single => value.single;

  @override
  E singleWhere(bool Function(E element) test, {E Function()? orElse}) =>
      value.singleWhere(test, orElse: orElse);

  @override
  Iterable<E> skip(int count) => value.skip(count);

  @override
  Iterable<E> skipWhile(bool Function(E element) test) => value.skipWhile(test);

  @override
  Iterable<E> take(int count) => value.take(count);

  @override
  Iterable<E> takeWhile(bool Function(E element) test) => value.takeWhile(test);

  @override
  List<E> toList({bool growable = true}) => value.toList(growable: growable);

  @override
  Set<E> toSet() => value.toSet();

  @override
  Iterable<E> where(bool Function(E element) test) => value.where(test);

  @override
  Iterable<T> whereType<T>() => value.whereType<T>();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SignalList<E> && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
