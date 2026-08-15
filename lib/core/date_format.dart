/// Formatacao de datas sem dependencia externa (Flutter puro).
const List<String> _meses = [
  'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
  'jul', 'ago', 'set', 'out', 'nov', 'dez',
];

/// Ex.: 14/08/2026
String dataBr(DateTime d) {
  final dd = d.day.toString().padLeft(2, '0');
  final mm = d.month.toString().padLeft(2, '0');
  return '$dd/$mm/${d.year}';
}

/// Ex.: 14 de ago de 2026
String dataExtenso(DateTime d) {
  return '${d.day} de ${_meses[d.month - 1]} de ${d.year}';
}
