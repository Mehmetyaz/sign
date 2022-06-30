part of sign;

/// Signal converts Stream to Signal
/// start listening on construct
class StreamSignal<T> extends Signal<T> {
  /// Use stream.toSignal()
  /// or stream.toSignalWithDefault()
  StreamSignal(Stream<T> stream, T value) : super(value) {
    _stream = stream.listen(_listen);
  }

  ///
  late StreamSubscription<T> _stream;

  // ignore: use_setters_to_change_properties
  void _listen(T event) {
    value = event;
  }

  ///
  Future<void> cancel() async => _stream.cancel();
}

///
class SignalStreamNonNullable<T> extends StreamSignal<T> {
  ///
  SignalStreamNonNullable(Stream<T> stream, T value) : super(stream, value);
}

///
class SignalStreamNullable<T> extends StreamSignal<T?> {
  ///
  SignalStreamNullable(Stream<T> stream) : super(stream, null);
}
