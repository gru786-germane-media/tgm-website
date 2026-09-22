const Map<String, String> _germanTransliterations = {
  'ä': 'ae',
  'ö': 'oe',
  'ü': 'ue',
  'ß': 'ss',
  'Ä': 'Ae',
  'Ö': 'Oe',
  'Ü': 'Ue',
};

/// Converts a blog title into a URL-friendly, hyphenated slug.
/// e.g. "How to Grow Your Business!" -> "how-to-grow-your-business"
String slugify(String title) {
  var result = title;
  _germanTransliterations.forEach((from, to) {
    result = result.replaceAll(from, to);
  });

  result = result
      .toLowerCase()
      .replaceAll(RegExp(r"[^a-z0-9]+"), '-')
      .replaceAll(RegExp(r"-+"), '-')
      .replaceAll(RegExp(r"^-|-$"), '');

  return result;
}
