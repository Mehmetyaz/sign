part of sign;

/// Slot for multiple signals.
///
/// This slot not produce signals. Only listen multiple signals.
// abstract class MultiSlot extends Slot<void> {
//   /// Listen multiple slots
//   MultiSlot(this.signals) {
//     for (var signal in signals) {
//       signal.addSlot(this);
//     }
//   }
//
//   /// Signals
//   List<Signal> signals;
//
//   /// Unregister this slot
//   void dispose() {
//     for (var signal in signals) {
//       signal.removeSlot(this);
//     }
//   }
//
//   @override
//   void onValue(void value);
// }
