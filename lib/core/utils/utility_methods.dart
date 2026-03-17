String formatName(String? name) {
  if (name == null || name.trim().isEmpty) return "No name";

  final parts = name.trim().split(' ');

  if (parts.length == 1) return parts.first;

  return "${parts.first}\n${parts.sublist(1).join(' ')}";
}
