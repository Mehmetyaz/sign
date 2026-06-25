part of '../sign_base.dart';

// ignore: unintended_html_in_doc_comment
/// Global slot for [T] GlobalSignal<V>.
abstract class GlobalSlot<V, T extends GlobalSignal> with Slot<V> {
  /// Global slot constructor.
  ///
  /// After construct, the slot will be added to global signal controller.
  GlobalSlot() {
    global._registerSlot(this, T);
  }

  /// Unregister this slot
  void dispose() {
    global._unregisterSlot(this, T);
  }
}
