import 'package:sign/sign.dart';
import 'package:test/test.dart';

void main() {
  group('single', () {
    test('non-nullable signal', () {
      var signal = 0.signal;
      var signalCount = 0;
      var slot = SlotWithHandler((p0) {
        signalCount++;
        expect(p0, signal.value);
      });

      signal.addSlot(slot);

      expect(signalCount, 0);

      signal.value++;

      expect(signalCount, 1);

      signal.removeSlot(slot);

      signal.value++;

      expect(signalCount, 1);
    });
    test('nullable signal', () {
      var signal = Signal<int?>(null);
      var signalCount = 0;
      var slot = SlotWithHandler<int?>((p0) {
        signalCount++;
        expect(p0, signal.value);
      });

      signal.addSlot(slot);

      expect(signalCount, 0);

      signal.value = 1;

      expect(signalCount, 1);

      signal.value = null;

      expect(signalCount, 2);

      expect(signal.value, null);

      signal.removeSlot(slot);

      signal.value = 3;

      expect(signalCount, 2);
    });
    test('void signal', () {
      var signal = VoidSignal();
      var signalCount = 0;
      var slot = SlotWithHandler<void>((p0) {
        signalCount++;
      });

      signal.addSlot(slot);

      expect(signalCount, 0);

      signal.emit();

      expect(signalCount, 1);

      signal.emit();

      expect(signalCount, 2);

      signal.removeSlot(slot);

      signal.emit();

      expect(signalCount, 2);
    });
  });

  test('multiple', () {
    var signal1 = 0.signal;
    var signal2 = 0.signal;
    var signalCount = 0;
    var slot = SlotWithHandler((p0) {
      signalCount++;
    });
    var signal = MultiSignal([signal1, signal2]);
    signal.addSlot(slot);

    signal1.value++;
    expect(signal1.value, 1);
    expect(signalCount, 1);

    signal2.value++;
    expect(signal2.value, 1);
    expect(signalCount, 2);

    signal1.value++;
    expect(signal1.value, 2);
    expect(signalCount, 3);

    signal2.value++;
    expect(signal2.value, 2);
    expect(signalCount, 4);
  });

  test('computed single', () {
    var a = 1.signal;
    var computed = a.computed(() => a.value * 2);
    var values = <int>[];

    computed.addSlot(SlotWithHandler<int>((v) => values.add(v)));

    expect(computed.value, 2);
    a.value = 3;
    expect(computed.value, 6);
    expect(values, [6]);
  });

  test('computed', () {
    var a = 1.signal;
    var b = 2.signal;
    var computed = a.computed(() => a.value + b.value, also: [b]);
    var values = <int>[];

    computed.addSlot(
      SlotWithHandler<int>((v) {
        values.add(v);
        expect(v, computed.value);
      }),
    );

    expect(computed.value, 3);
    expect(values, isEmpty);

    a.value = 5;
    expect(computed.value, 7);
    expect(values, [7]);

    b.value = 10;
    expect(computed.value, 15);
    expect(values, [7, 15]);
  });

  group('global', () {
    test('basic', () {
      var globalSignal = 0.globalSignal;

      var signalCount = 0;

      GlobalTestSlot((v) {
        signalCount++;
        expect(v, globalSignal.value);
      });

      globalSignal.value++;
      expect(signalCount, 1);

      globalSignal.value++;
      expect(signalCount, 2);

      globalSignal.unregisterSignal();

      globalSignal.value++;

      expect(globalSignal.value, 3);
      expect(signalCount, 2);

      globalSignal.registerSignal();

      globalSignal.value++;

      expect(globalSignal.value, 4);
      expect(signalCount, 3);
    });
  });
}

class GlobalTestSlot extends GlobalSlot<int, GlobalSignal<int>> {
  ///
  GlobalTestSlot(this.handler);

  final void Function(int) handler;

  @override
  void onValue(int value) => handler(value);
}
