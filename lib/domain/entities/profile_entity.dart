class ProfileEntity {
  final String name;
  final String? email;
  final String? phone;
  final String? birthdate;
  final String? address;
  final String? districtId;
  final String? cityId;
  final String? citizenId;
  final String? healthId;
  final String? tin;

  ProfileEntity({
    required this.name,
    this.email,
    this.phone,
    this.birthdate,
    this.address,
    this.districtId,
    this.cityId,
    this.citizenId,
    this.healthId,
    this.tin,
  });
}
