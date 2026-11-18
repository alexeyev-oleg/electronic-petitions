/// Wraps [value] in Unicode LEFT-TO-RIGHT ISOLATE (U+2066) … POP DIRECTIONAL
/// ISOLATE (U+2069), so numbers and codes such as "0.2.0+4", "128 / 500",
/// "+972…" or "32.795, 34.989" keep their order inside RTL (he/ar) text.
/// Paragraph direction and alignment stay unchanged.
///
/// Display only: never store or submit the wrapped string.
String ltrIsolate(String value) => '\u2066$value\u2069';
