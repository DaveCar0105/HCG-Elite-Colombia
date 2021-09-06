class Utilidades {
  bool isNumberEntero(String valor) {
    try {
      if (valor.contains('.') || valor.contains(',')) {
        return false;
      }
      if (int.parse(valor) > 0) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  bool isNumberDecimal(String valor) {
    try {
      double value = double.parse(valor);
      return true;
    } catch (e) {
      return false;
    }
  }
}
