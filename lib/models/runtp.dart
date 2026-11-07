// ignore_for_file: camel_case_types, non_constant_identifier_names

class run {
  String? id;
  String? created_at;
  String? runWhere;
  String? runPerson;
  int? runDistance;
  String? runImageUrl;

  run({
    this.id,
    this.created_at,
    this.runWhere,
    this.runPerson,
    this.runDistance,
    this.runImageUrl,
  });
  Map<String, dynamic> toJson() => {
      'runWhere': runWhere,
      'runPerson': runPerson,
      'runDistance': runDistance,
      'runImageUrl': runImageUrl,
    };

    factory run.fromJson(Map<String, dynamic> json) => run(
      id: json['id'],
      created_at: json['created_at'],
      runWhere: json['runWhere'],
      runPerson: json['runPerson'],
      runDistance: json['runDistance'],
      runImageUrl: json['runImageUrl'],
    );
  }