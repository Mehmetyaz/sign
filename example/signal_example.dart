import 'package:sign/sign.dart';

void main() async {
  var slot = VoidSlot();

  var counter = VoidSignal();

  counter.addSlot(slot);

  Stream<int>.periodic(Duration(seconds: 1)).listen((event) {
    counter.value = null;
  });
}

class VoidSlot extends Slot<void> {
  @override
  void onValue(void value) {
    print('VoidSlot');
  }
}

// class VoidSignal extends Signal<void> {
//   VoidSignal() : super(0);
// }

class CounterSlot extends Slot<int> {
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
