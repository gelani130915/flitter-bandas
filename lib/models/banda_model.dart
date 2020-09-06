class BandaModel {
  String id;
  String name;
  int votes;

BandaModel({
  this.id,
  this.name,
  this.votes
});

factory BandaModel.fromMap(Map<String,dynamic> obj)
  => BandaModel(
    id: obj['id'],
    name: obj['name'],
    votes: obj['votes'],
  );

}