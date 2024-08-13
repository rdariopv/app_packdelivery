class ItemPack {
  final int? id_orden;
  final String? nro_carga;
  final String? nro_factura;
  final DateTime? fecha_orden;
  final int? id_estado;
  final String? desc_estado;
  final String? detalle;
  final int? id_empresa;
  final String? desc_empresa;
  final int? id_cliente;
  final String? desc_cliente;
  final int? id_chofer;
  final String? desc_chofer;
  final int? id_carga;
  final String? desc_carga;
  final int? id_placa;
  final String? desc_placa;
  final int? id_tramo;
  final String? desc_tramo;
  final String? image;

  ItemPack({
    this.id_orden,
    this.nro_carga,
    this.nro_factura,
    this.fecha_orden,
    this.id_estado,
    this.desc_estado,
    this.detalle,
    this.id_empresa,
    this.desc_empresa,
    this.id_cliente,
    this.desc_cliente,
    this.id_chofer,
    this.desc_chofer,
    this.id_carga,
    this.desc_carga,
    this.id_placa,
    this.desc_placa,
    this.id_tramo,
    this.desc_tramo,
    this.image,
  });

  factory ItemPack.fromJson(Map<String, dynamic> json) {
    return ItemPack(
      id_orden: json['id_orden'],
      nro_carga: json['nro_carga'],
      nro_factura: json['nrofactura'],
      fecha_orden: json['fecha_orden'] != null ? DateTime.parse(json['fecha_orden']) : null,
      id_estado: json['id_estado'],
      desc_estado: json['desc_estado'],
      detalle: json['detalle'],
      id_empresa: json['id_empresa'],
      desc_empresa: json['desc_empresa'],
      id_cliente: json['id_cliente'],
      desc_cliente: json['desc_cliente'],
      id_chofer: json['id_chofer'],
      desc_chofer: json['desc_chofer'],
      id_carga: json['id_carga'],
      desc_carga: json['desc_carga'],
      id_placa: json['id_placa'],
      desc_placa: json['desc_placa'],
      id_tramo: json['id_tramo'],
      desc_tramo: json['desc_tramo'],
      image: null,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id_orden': id_orden,
      'nro_carga': nro_carga,
      'nrofactura': nro_factura,
      'fecha_orden': fecha_orden?.toIso8601String(),
      'id_estado': id_estado,
      'desc_estado': desc_estado,
      'detalle': detalle,
      'id_empresa': id_empresa,
      'desc_empresa': desc_empresa,
      'id_cliente': id_cliente,
      'desc_cliente': desc_cliente,
      'id_chofer': id_chofer,
      'desc_chofer': desc_chofer,
      'id_carga': id_carga,
      'desc_carga': desc_carga,
      'id_placa': id_placa,
      'desc_placa': desc_placa,
      'id_tramo': id_tramo,
      'desc_tramo': desc_tramo,
    };
  }
}