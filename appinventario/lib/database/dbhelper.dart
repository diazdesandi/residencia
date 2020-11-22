class Articulo {
  int id;
  String codigo;

  Articulo(this.id, this.codigo);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'codigo': codigo,
    };
    return map;
  }

  Articulo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    codigo = map['codigo'];
  }
}
