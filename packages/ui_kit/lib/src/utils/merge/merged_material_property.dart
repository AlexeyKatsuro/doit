import 'package:flutter/material.dart' show MaterialStateProperty, MaterialState;

import 'mergeable.dart';

extension MergeReplacePropertyExt<T> on MaterialStateProperty<T> {
  MaterialStateProperty<T> merge(MaterialStateProperty<T?>? other, [MergeFunction<T?>? merge]) {
    if (other == null || other == this) return this;
    return MergedMaterialProperty<T?>(this, other, merge) as MaterialStateProperty<T>;
  }

  MaterialStateProperty<T?> mergeTo(MaterialStateProperty<T?>? other, [MergeFunction<T?>? merge]) {
    if (other == null) return this;
    return other.merge(this, merge);
  }
}

/// A class that allows merging between two nullable MaterialStateProperty.
class MergedMaterialProperty<T> implements MaterialStateProperty<T?> {
  const MergedMaterialProperty(this.a, this.b, [this.mergeFunction]);

  final MaterialStateProperty<T>? a;
  final MaterialStateProperty<T>? b;
  final MergeFunction<T?>? mergeFunction;

  @override
  T? resolve(Set<MaterialState> states) {
    final T? resolvedA = a?.resolve(states);
    final T? resolvedB = b?.resolve(states);
    if (mergeFunction == null) {
      return resolvedB ?? resolvedA;
    }
    return mergeFunction!(resolvedA, resolvedB);
  }
}
