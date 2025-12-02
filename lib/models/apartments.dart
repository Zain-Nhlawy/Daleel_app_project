// ignore_for_file: constant_identifier_names

enum Governorate {
  Damascus,
  Aleppo,
  Daraa,
  Latakia,
  Tartous,
  Homs,
  Hama,
  AlSwuayda,
  Quneitra,
  Raqqa,
  Hasakah,
  Idlib,
  RifDimashq,
  DeirEzzor,
}


enum City {
  // Damascus
  OldCity,
  Midan,
  Mazzeh,
  Malki,
  AbouRummaneh,
  Shaalan,
  Mazraa,
  RuknEddin,
  Barzeh,
  Qassa,
  Jaramana,
  Dummar,
  KafarSouseh,

  // Rif Dimashq
  Douma,
  Harasta,
  Jaramana_RD,
  Qudsaya,
  Sahnaya,
  AshrafiehSahnaya,
  AnNabek,
  Yabroud,
  AlTal,

  // Aleppo
  AleppoCity,
  AlHamidiyah_Aleppo,
  AlJamiliah,
  SaifDawla,
  SalahEddin,
  NewAleppo,
  Aziziyah,

  // Homs
  AlWaer,
  Inshaat,
  BabSbaa,
  Bayada,
  Adawiya,
  AlQusour,

  // Hama
  AlHamidiyah_Hama,
  AlBaroudi,
  TariqHalab,
  Mazraa_Hama,

  // Latakia
  Ashrafieh,
  Tishreen,
  AlRaml,
  AlSleibeh,
  Project7,
  Project8,
  Project10,

  // Tartous
  TartousCity,
  Safita,
  Baniyas,
  Dreikish,

  // Daraa
  DaraaCity,
  Bosra,
  Jasim,
  Inkhel,
  Tafas,

  // As-Suwayda
  SuwaydaCity,
  Shahba,
  Salkhad,

  // Quneitra
  MadinatAlBaath,
  KhanArnabeh,
  JubataAlKhashab,

  // Idlib
  IdlibCity,
  Saraqib,
  JisrAlShughur,
  Armanaz,
  Harem,

  // Raqqa
  RaqqaCity,
  AlTabqah,
  AlMansoura,

  // Deir Ezzor
  DeirEzzorCity,
  Mayadin,
  AbuKamal,

  // Hasakah
  HasakahCity,
  Qamishli,
  Amuda,
  Rmelan,
}


final Map<Governorate, List<City>> governorateCities = {
  Governorate.Damascus: [
    City.OldCity,
    City.Midan,
    City.Mazzeh,
    City.Malki,
    City.AbouRummaneh,
    City.Shaalan,
    City.Mazraa,
    City.RuknEddin,
    City.Barzeh,
    City.Qassa,
    City.Jaramana,
    City.Dummar,
    City.KafarSouseh,
  ],

  Governorate.RifDimashq: [
    City.Douma,
    City.Harasta,
    City.Jaramana_RD,
    City.Qudsaya,
    City.Sahnaya,
    City.AshrafiehSahnaya,
    City.AnNabek,
    City.Yabroud,
    City.AlTal,
  ],

  Governorate.Aleppo: [
    City.AleppoCity,
    City.AlHamidiyah_Aleppo,
    City.AlJamiliah,
    City.SaifDawla,
    City.SalahEddin,
    City.NewAleppo,
    City.Aziziyah,
  ],

  Governorate.Homs: [
    City.AlWaer,
    City.Inshaat,
    City.BabSbaa,
    City.Bayada,
    City.Adawiya,
    City.AlQusour,
  ],

  Governorate.Hama: [
    City.AlHamidiyah_Hama,
    City.AlBaroudi,
    City.TariqHalab,
    City.Mazraa_Hama,
  ],

  Governorate.Latakia: [
    City.Ashrafieh,
    City.Tishreen,
    City.AlRaml,
    City.AlSleibeh,
    City.Project7,
    City.Project8,
    City.Project10,
  ],

  Governorate.Tartous: [
    City.TartousCity,
    City.Safita,
    City.Baniyas,
    City.Dreikish,
  ],

  Governorate.Daraa: [
    City.DaraaCity,
    City.Bosra,
    City.Jasim,
    City.Inkhel,
    City.Tafas,
  ],

  Governorate.AlSwuayda: [
    City.SuwaydaCity,
    City.Shahba,
    City.Salkhad,
  ],

  Governorate.Quneitra: [
    City.MadinatAlBaath,
    City.KhanArnabeh,
    City.JubataAlKhashab,
  ],

  Governorate.Idlib: [
    City.IdlibCity,
    City.Saraqib,
    City.JisrAlShughur,
    City.Armanaz,
    City.Harem,
  ],

  Governorate.Raqqa: [
    City.RaqqaCity,
    City.AlTabqah,
    City.AlMansoura,
  ],

  Governorate.DeirEzzor: [
    City.DeirEzzorCity,
    City.Mayadin,
    City.AbuKamal,
  ],

  Governorate.Hasakah: [
    City.HasakahCity,
    City.Qamishli,
    City.Amuda,
    City.Rmelan,
  ],
};

class Apartments {
  final String apartmentHeadDescripton;
  final Governorate governorate;
  final City city; 
  final double apartmentRate;
  final double rentFee;
  final int floor;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final String publisherName;

  final String apartmentPicture;
  final List<String> apartmentPictures;

  final String description;
  final List<String> comments;

  final bool isAvailable;

  Apartments({
    required this.apartmentHeadDescripton,
    required this.governorate,
    required this.city,
    required this.apartmentRate,
    required this.rentFee,
    required this.floor,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.publisherName,
    required this.apartmentPicture,
    this.apartmentPictures = const [],
    this.description = "",
    this.comments = const [],
    this.isAvailable = true,
  });
}

