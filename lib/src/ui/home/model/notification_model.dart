class NotificationModel {
  String image;
  String label;
  String detail;
  String time;

  NotificationModel(this.image, this.label, this.detail,  this.time);
}

List<NotificationModel> notificationData = [
  NotificationModel(
      'assets/images/notify.jpg',
      'GONE IN A FLASH: MASKS & PEELS',
      'Save upto 30% off - Grab them before they are gone!',
      '16 hours ago'
  ),
  NotificationModel(
      'assets/images/notify1.jpg',
      'COLORBAR: FLAT 25% OFF',
      '+ FREE Makeup remover wipes & nail polish remover | Shop Now!',
      '18 hours ago'
  ),
  NotificationModel(
      'assets/images/notify2.jpg',
      'SUNDAY SAVINGS ON BESTSELLERS',
      'Grab them before they are gone!',
      '19 hours ago'
  ),
  NotificationModel(
      'assets/images/notify3.jpg',
      'IF YOU HEART IT CART IT!',
      'Your choices are the hot favorites at Nykaa!Check out now!',
      '21 hours ago'
  ),
  NotificationModel(
      'assets/images/notify4.jpg',
      'CART IT NOW BEST DEAL!',
      'Dont miss this best offer',
      '24 hours ago'
  ),
];