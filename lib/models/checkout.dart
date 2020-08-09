


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




}