import 'package:sign/sign.dart';

void main() {
  var globalCounter = GlobalCounter();

  GlobalCountSlot('a');
  GlobalCountSlot('b');
  GlobalCountSlot('c');
  GlobalCountSlot('d');
  GlobalCountSlot('e');

  Stream<int>.periodic(const Duration(seconds: 1), (c) => c).listen((event) {
    globalCounter.value = event;
  });
}

class GlobalCountSlot extends GlobalSlot<int, GlobalCounter> {
  GlobalCountSlot(this.name);

  String name;

  @override
  void onValue(int value) {
    print('GlobalCountSlot :  $name : $value');
  }
}

class GlobalCounter extends GlobalSignal<int> {
  GlobalCounter() : super(0);

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }
}
