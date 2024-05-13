class Patient {
  String nama_pasien;
  String umur;
  String keluhan;

  Patient({
    required this.nama_pasien,
    required this.umur,
    required this.keluhan, 
  });

  Map<String, dynamic> toJson() {
    return {
      'nama_pasien': nama_pasien,
      'umur': umur,
      'keluhan': keluhan,
    };
  }
}
