class Utilidades{

  bool isNumberEntero(String valor){
    if(valor.contains('.') || valor.contains(',')){
      return false;
    }
    if(int.parse(valor)>0){
      return true;
    }

    return false;

  }
}