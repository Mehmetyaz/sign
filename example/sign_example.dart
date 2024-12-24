import 'package:sign/sign.dart';

void main() async {
  var slot = CounterSlot();

  var counter = Counter();

  counter.addSlot(slot);

  Stream<int>.periodic(
    Duration(seconds: 1),
    (computationCount) => computationCount,
  ).listen((event) {
    counter.value = event;
  });
}

class CounterSlot with Slot<int> {
  @override
  void onValue(int value) {
    print('CounterSlot: $value');
  }
}

class Counter extends Signal<int> {
  Counter() : super(0);

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }
}
