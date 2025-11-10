class AddReviewRequest {
  final String id;
  final String name;
  final String review;

  AddReviewRequest({
    required this.id,
    required this.name,
    required this.review,
  });

  factory AddReviewRequest.fromJson(Map<String, dynamic> json) =>
      AddReviewRequest(
        id: json['id'],
        name: json['name'],
        review: json['review'],
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'review': review};
}
