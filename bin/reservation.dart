import 'client.dart';
import 'room.dart';

class Reservation {
  final int id;
  final Room room;
  final String roomType;
  final Client client;
  final DateTime startDate;
  final DateTime endDate;

  Reservation(this.id, this.room, this.client,this.startDate, this.endDate, this.roomType);


   getTotalPrice(){
    if(roomType =='single'){
      int totalPrice =(endDate.day -startDate.day)*2500;
      print('Total Price ${totalPrice}');
    }else{
      int totalPrice =(endDate.day -startDate.day)*4000;
      print('Total Price ${totalPrice}');
    }

  }
}