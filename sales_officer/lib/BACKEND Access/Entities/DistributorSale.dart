import 'Distributor.dart';

class DistributorSale{
  final Distributor distributor;
  final double mtd;
  final double ytd;
  final double outstanding;
  final String lastOrder;

  DistributorSale(this.distributor, this.mtd, this.ytd, this.outstanding, this.lastOrder);
}