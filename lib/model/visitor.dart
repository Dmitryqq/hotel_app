class Visitor {
  String name;
  String documents;
  String card_number;
  String card_exp_date;
  String phone;

  Visitor(
      {this.name = null,
      this.documents = null,
      this.card_number = null,
      this.card_exp_date = null,
      this.phone = null});

  bool checkFields(){
    return [name, documents, card_number, card_exp_date, phone].contains(null);
  }
//  Visitor.empty();
}
