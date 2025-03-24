const String currencySymbol = '৳';
const serverkey = 'AAAAwIdeEQ0:APA91bEoimrVujImyMVsd9dykW2StHnZsILWSpZOmiPZSlV2pJsqFSRzdgYCDDqQkBlrjKe5DHjtNqoyoTrQUq_4w45a0BpA8UhRZ45AEZjxUh3pg_j7TxZ35VVYxiTs_DMaO9BJgaLN';
const cities = [
  'Dhaka',
  'Chittagong',
  'Rajshahi',
  'Khulna',
  'Barishal',
  'Sylhet',
  'Comilla',
  'Noakhali',
  'Faridpur',
  'Rangpur',
  'Gopalgonj'
];

abstract class OrderStatus {
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
  static const String returned = 'Returned';
}

abstract class PaymentMethod {
  static const String cod = 'Cash on Delivery';
  static const String online = 'Online Payment';
}

abstract class NotificationType {
  static const String comment = 'New Comment';
  static const String order = 'New Order';
  static const String user = 'New User';
}
