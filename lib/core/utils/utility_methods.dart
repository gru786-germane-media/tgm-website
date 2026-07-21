String formatName(String? name) {
  if (name == null || name.trim().isEmpty) return "No name";

  final parts = name.trim().split(' ');

  if (parts.length == 1) return parts.first;

  return "${parts.first}\n${parts.sublist(1).join(' ')}";
}

/// Returns a reordered copy of [items] with the entry matching [query]
/// (via [nameOf], case-insensitive substring match) moved to [targetIndex].
/// Returns [items] unchanged if [query] is empty or no entry matches.
List<T> reorderForDeepLink<T>({
  required List<T> items,
  required String? query,
  required String Function(T item) nameOf,
  int targetIndex = 2,
}) {
  final q = query?.trim().toLowerCase();
  if (q == null || q.isEmpty) return items;

  final matchIndex = items.indexWhere(
    (item) => nameOf(item).toLowerCase().contains(q),
  );
  if (matchIndex == -1) return items;

  final reordered = List<T>.from(items);
  final match = reordered.removeAt(matchIndex);
  reordered.insert(targetIndex.clamp(0, reordered.length), match);
  return reordered;
}
