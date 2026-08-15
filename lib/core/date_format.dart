const List<String> _meses = [
  'jan',
  'fev',
  'mar',
  'abr',
  'mai',
  'jun',
  'jul',
  'ago',
  'set',
  'out',
  'nov',
  'dez',
];

String dataBr(DateTime d) {
  final dd = d.day.toString().padLeft(2, '0');
  final mm = d.month.toString().padLeft(2, '0');
  return '$dd/$mm/${d.year}';
}

String dataExtenso(DateTime d) {
  return '${d.day} de ${_meses[d.month - 1]} de ${d.year}';
}

String dataHoraBr(DateTime d) {
  final hh = d.hour.toString().padLeft(2, '0');
  final min = d.minute.toString().padLeft(2, '0');
  return '${dataBr(d)} as $hh:$min';
}
