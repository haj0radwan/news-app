class ServerExeption implements Exception {
  final String error;
  ServerExeption({required this.error});
  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }
}

class CashExeption implements Exception {
  final String error;
  CashExeption({required this.error});
}
