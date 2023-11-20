extension IterableExtensions<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test, {E? Function()? orElse}) {
    final E? Function() ifNotFound = orElse ?? () => null;
    if (isEmpty) {
      return ifNotFound.call();
    }
    return cast<E?>().firstWhere((e) => test(e as E), orElse: ifNotFound);
  }
}
