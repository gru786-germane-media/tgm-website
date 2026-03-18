import 'dart:js' as js;

void trackPage(String name) {
  js.context.callMethod('gtag', [
    'event',
    'page_view',
    {'page_title': name, 'page_location': name},
  ]);
}
