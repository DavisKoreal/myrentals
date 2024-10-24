class Feedback{
  final String feedback;
  final String name;
  final int feedbackContact;
  final int synchronized;

  const Feedback(
      {required this.feedback, required this.feedbackContact, required this.name,
        required this.synchronized});
  // Create a Recipe from JSON data
  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    feedback: json['feedback'],
    name: json['name'],
    feedbackContact: json['feedbackContact'],
    synchronized: json['synchronized'],
  );
// Convert our Recipe to JSON to make it easier when you store
// it in the database
  Map<String, dynamic> toJson() => {
    'feedback': feedback,
    'feedbackContact': feedbackContact,
    'name': name,
    'synchronized': synchronized,
  };
}