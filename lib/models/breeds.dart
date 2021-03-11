class BreedsModel {
  MainBreeds mainBreeds;
  String status;

  BreedsModel({
    this.mainBreeds,
    this.status,
  });


  factory BreedsModel.fromJson(Map<String, dynamic> parsedJson) {
    return BreedsModel(
        mainBreeds: MainBreeds.fromJson(parsedJson["message"]), 
        status: parsedJson["status"]
    );
  }
}

class MainBreeds {
  List affenpinscher;
  List african;
  List airedale;
  List akita;
  List appenzeller;
  List australian;
  List basenji;
  List beagle;
  List bluetick;
  List borzoi;
  List bouvier;
  List boxer;
  List brabancon;
  List briard;
  List buhund;
  List bulldog;
  List bullterrier;
  List cairn;
  List cattledog;
  List chihuahua;
  List chow;
  List clumber;
  List cockapoo;
  List collie;
  List coonhound;
  List corgi;
  List cotondetulear;
  List dachshund;
  List dalmatian;
  List dane;
  List deerhound;
  List dhole;
  List dingo;
  List doberman;
  List elkhound;
  List entlebucher;
  List eskimo;
  List finnish;
  List frise;
  List germanshepherd;
  List greyhound;
  List groenendael;
  List havanese;
  List hound;
  List husky;
  List keeshond;
  List kelpie;
  List komondor;
  List kuvasz;
  List labrador;
  List leonberg;
  List lhasa;
  List malamute;
  List malinois;
  List maltese;
  List mastiff;
  List mexicanhairless;
  List mix;
  List mountain;
  List newfoundland;
  List otterhound;
  List ovcharka;
  List papillon;
  List pekinese;
  List pembroke;
  List pinscher;
  List pitbull;
  List pointer;
  List pomeranian;
  List poodle;
  List pug;
  List puggle;
  List pyrenees;
  List redbone;
  List retriever;
  List ridgeback;
  List rottweiler;
  List saluki;
  List samoyed;
  List schipperke;
  List schnauzer;
  List setter;
  List sheepdog;
  List shiba;
  List shihtzu;
  List spaniel;
  List springer;
  List stbernard;
  List terrier;
  List vizsla;
  List waterdog;
  List weimaraner;
  List whippet;
  List wolfhound;

  MainBreeds({
    this.affenpinscher,
    this.african,
    this.airedale,
    this.akita,
    this.appenzeller,
    this.australian,
    this.basenji,
    this.beagle,
    this.bluetick,
    this.borzoi,
    this.bouvier,
    this.boxer,
    this.brabancon,
    this.briard,
    this.buhund,
    this.bulldog,
    this.bullterrier,
    this.cairn,
    this.cattledog,
    this.chihuahua,
    this.chow,
    this.clumber,
    this.cockapoo,
    this.collie,
    this.coonhound,
    this.corgi,
    this.cotondetulear,
    this.dachshund,
    this.dalmatian,
    this.dane,
    this.deerhound,
    this.dhole,
    this.dingo,
    this.doberman,
    this.elkhound,
    this.entlebucher,
    this.eskimo,
    this.finnish,
    this.frise,
    this.germanshepherd,
    this.greyhound,
    this.groenendael,
    this.havanese,
    this.hound,
    this.husky,
    this.keeshond,
    this.kelpie,
    this.komondor,
    this.kuvasz,
    this.labrador,
    this.leonberg,
    this.lhasa,
    this.malamute,
    this.malinois,
    this.maltese,
    this.mastiff,
    this.mexicanhairless,
    this.mix,
    this.mountain,
    this.newfoundland,
    this.otterhound,
    this.ovcharka,
    this.papillon,
    this.pekinese,
    this.pembroke,
    this.pinscher,
    this.pitbull,
    this.pointer,
    this.pomeranian,
    this.poodle,
    this.pug,
    this.puggle,
    this.pyrenees,
    this.redbone,
    this.retriever,
    this.ridgeback,
    this.rottweiler,
    this.saluki,
    this.samoyed,
    this.schipperke,
    this.schnauzer,
    this.setter,
    this.sheepdog,
    this.shiba,
    this.shihtzu,
    this.spaniel,
    this.springer,
    this.stbernard,
    this.terrier,
    this.vizsla,
    this.waterdog,
    this.weimaraner,
    this.whippet,
    this.wolfhound,
  });

  factory MainBreeds.fromJson(Map<String, List> json) {
    return {
      affenpinscher: List.from(json[""]),
      african: 
    };
  }
