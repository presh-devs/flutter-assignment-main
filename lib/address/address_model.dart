class Address {
  final String? country, municipality, prefecture, streetAdress, apartmentNo;

  Address(
    this.country,
    this.municipality,
    this.prefecture,
    this.streetAdress,
    this.apartmentNo,
  );

  Address copyWith({
    String? country,
    String? municipality,
    String? prefecture,
    String? streetAdress,
    String? apartmentNo,
  }) {
    return Address(
      country ?? this.country,
      municipality ?? this.municipality,
      prefecture ?? this.prefecture,
      streetAdress ?? this.streetAdress,
      apartmentNo ?? this.apartmentNo,
    );
  }
}
