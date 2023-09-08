import 'dart:io';
import 'client.dart';
import 'double_room.dart';
import 'employee.dart';
import 'reservation.dart';
import 'room.dart';
import 'single_room.dart';

class Hotel {
  List<Client> client = [];
  List<Employee> employees = [];
  final List<Room> singleRooms;
  final List<Room> doubleRooms;
  final List<Reservation> reservations;


  Hotel(int totalRooms)
      : singleRooms = List.generate(
            (totalRooms / 2).floor(), (index) => SingleRoom(index + 1, false)),
        doubleRooms = List.generate(
            (totalRooms / 2).floor(), (index) => DoubleRoom(index + 1, false)),
        reservations = [];

  List<Room> get AvailableSingleRooms {
    List<Room> availableSingleRooms = [];
    availableSingleRooms.addAll(singleRooms.where((room) => !room.isBooked));
    return availableSingleRooms;
  }

  List<Room> get availableDoubleRooms {
    List<Room> availableDoubleRooms = [];
    availableDoubleRooms.addAll(doubleRooms.where((room) => !room.isBooked));
    return availableDoubleRooms;
  }

  Reservation? bookRoom(int roomNumber, Client client, DateTime startDate,
      DateTime endDate, String roomType) {
    Room? selectedSingleRoom =
    singleRooms.firstWhere((room) => room.number == roomNumber);

    Room? selectedDoubleRoom =
    doubleRooms.firstWhere((room) => room.number == roomNumber);

    if (roomType == 'single') {
      if (!selectedSingleRoom.isBooked) {
        selectedSingleRoom.isBooked = true;
        int reservationId = reservations.length + 1;
        Reservation reservation = Reservation(reservationId, selectedSingleRoom,
            client, startDate, endDate, roomType);
        reservations.add(reservation);
        return reservation;
      }
    } else {
      if (!selectedDoubleRoom.isBooked) {
        selectedDoubleRoom.isBooked = true;
        int reservationId = reservations.length + 1;
        Reservation reservation = Reservation(reservationId, selectedDoubleRoom,
            client, startDate, endDate, roomType);
        reservations.add(reservation);
        return reservation;
      }
    }
  }


  void clientRegister() {
    print('Enter Name:');
    String name = stdin.readLineSync()!;
    print('Enter Id:');
    String id = stdin.readLineSync()!;
    print('Enter Nationality:');
    String nationality = stdin.readLineSync()!;
    print('Enter ContactInfo:');
    String contactInfo = stdin.readLineSync()!;
    print('Enter Gender:');
    String gender = stdin.readLineSync()!;
    print('Enter age:');
    int? age = int.parse(stdin.readLineSync()!);
    int clientNum = client.length;
    try {
      client.add(
        Client(
            name: name,
            id: id,
            nationality: nationality,
            contactInfo: contactInfo,
            age: age,
            gender: gender),
      );
      print('Need to Reserve room ?? \nyes or no');
      String reserveRoom = stdin.readLineSync()!;
      if (reserveRoom == 'yes') {
        print('Please Enter Room Type \nsingle or double');
        String roomType = stdin.readLineSync()!;
        roomType == 'single'
            ? print('AvailableSingleRooms: ${AvailableSingleRooms}')
            : print('AvailableSingleRooms: ${availableDoubleRooms}');
        print('Enter Your Selected Room: ');
        int roomNum = int.parse(stdin.readLineSync()!);
        print('Please enter DateIn in the format yyyy-MM-dd:');
        String dateIn = stdin.readLineSync()!;
        print('Please enter DateOut in the format yyyy-MM-dd:');
        String dateOut = stdin.readLineSync()!;
        bookRoom(roomNum, client[clientNum], DateTime.parse(dateIn),
            DateTime.parse(dateOut), roomType);
        reservations[clientNum].getTotalPrice();
        print(
            'Success Reserve Room\n.........................................');
      } else {
        print('Thanks for register to our hotel\n.........................................');
      }
    } catch (e) {
      print(e.toString());
      return clientRegister();
    }
  }

  void displayReservation() {
    print("Current Reservations:");
    for (var reservation in reservations) {
      print(
          "Reservation ID: ${reservation.id}, Client: ${reservation.client.name}, Room: ${reservation.room.number}");
    }
    print('..........................................................');
  }

  void displayEmployee() {
    print("All Employee:");
    for (var employee in employees) {
      print(
          "Employee Name: ${employee.name}, Position: ${employee.employeePosition}, Contact Info: ${employee.contactInfo} ");
    }
    print('..........................................................');
  }

  void addEmployee() {
    print('Enter Employee Name:');
    String name = stdin.readLineSync()!;
    print('Enter Employee Id:');
    String id = stdin.readLineSync()!;
    print('Enter Employee Nationality:');
    String nationality = stdin.readLineSync()!;
    print('Enter Employee ContactInfo:');
    String contactInfo = stdin.readLineSync()!;
    print('Enter Employee positionAtHotel:');
    String employeePosition = stdin.readLineSync()!;
    print('Enter Employee Gender:');
    String gender = stdin.readLineSync()!;
    print('Enter Employee age:');
    int? age = int.parse(stdin.readLineSync()!);
    employees.add(Employee(
        employeePosition: employeePosition,
        name: name,
        id: id,
        nationality: nationality,
        contactInfo: contactInfo,
        age: age,
        gender: gender));
    print('Add Employee Success \n........................................');
  }

  void employeeValidation(String employeeName,String employeeId) {

      Employee? currentEmployee = employees.firstWhere((employee) =>
          employee.name == employeeName && employee.id == employeeId);
      if (currentEmployee.employeePosition.contains('manager')) {
        print(
            "What do you need ? \n1- All Reservation \n2-All Employee \n3-Add Employee \n4- Logout");
        int input = int.parse(stdin.readLineSync()!);
        switch (input) {
          case 1:
            displayReservation();
            return employeeValidation(employeeName, employeeId);
          case 2:
            displayEmployee();
            return employeeValidation(employeeName, employeeId);
          case 3:
            addEmployee();
            return employeeValidation(employeeName, employeeId);
          case 4:
            break;
        }
      } else if (currentEmployee.employeePosition == 'receptionist') {
        print(
            "What do you need ? \n1- All Reservation \n2-Add client \n3-Logout");
        int input = int.parse(stdin.readLineSync()!);
        switch (input) {
          case 1:
            displayReservation();
            return employeeValidation(employeeName, employeeId);
          case 2:
            clientRegister();
            return employeeValidation(employeeName, employeeId);
          case 3:
            return employeeValidation(employeeName, employeeId);
        }
      } else {
        print('You are not authorized');
      }

  }

  void clientValidation(){

  }





  void hotelPage() {
    print('Welcome to our hotel:');
    print('1- Register as Client \n2- Login as Employee \n3-Back');
    int? registerType = int.parse(stdin.readLineSync()!);
    switch (registerType) {
      case 1:
        clientRegister();
        return hotelPage();
      case 2:

        try{
          print('Enter Your Name:');
          String employeeName = stdin.readLineSync()!;
          print('Enter Your Id:');
          String employeeId = stdin.readLineSync()!;
          employeeValidation(employeeName, employeeId);
        }catch(e){
          print('wrong information,please check again');
        }
        return hotelPage();

      case 3:
        break;

      default:
        {
          print('please select correct number');
          hotelPage();
        }
    }
  }
}
