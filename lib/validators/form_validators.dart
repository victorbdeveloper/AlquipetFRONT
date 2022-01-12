
//TODO: ELIMINAR AL ACABAR SI NO SE HA UTILIZADO

class FormValidators {
  static String? fieldEmptyValidator(value) {
    if (value!.isEmpty) {
      return "El campo no puede estar en blanco";
    }
    return null;
  }

  static String? phoneValidator(value) {
    if (value!.isEmpty || !RegExp(r"^[0-9]{9}$").hasMatch(value)) {
      return "Teléfono no válido";
    }
    return null;
  }

  static String? onlyNumberValidator(value) {
    if (value!.isEmpty) {
      return "Solo números";
    }
    return null;
  }
}

