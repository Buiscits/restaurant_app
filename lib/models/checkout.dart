


class Checkout {

  final String tableNumber;
  final String name;
  final String surname;
  final String email;
  final String customerNotes;

  Checkout({
    this.tableNumber, this.name, this.surname, this.email, this.customerNotes
  });

  List<String> elements() {
    return List<String>.from({this.tableNumber, this.name, this.surname, this.email, this.customerNotes});
  }

  Map<String, dynamic> toJson() {
    return {
      'table_number': this.tableNumber,
      'mprm_email': this.email,
      'mprm_first': this.name,
      'mprm_last': this.surname,
      'customer_note': this.customerNotes,
      'mprm_action': 'purchase',
      'mprm-gateway': 'manual',
    };
  }




}