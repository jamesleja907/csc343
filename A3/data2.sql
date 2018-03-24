

insert into Rentalstation(code, name, address, area_code, city)
  values(1001, 'SuperCar College', '333 College St', 'M5T1P7', 'Toronto'),
        (1002, 'SuperCar Billy Bishop Airport', '200 Spadina Ave', 'M5V1A1, Toronto'),
        (1003, 'SuperCar York', '220 Eglinton St', 'M6E2G8', 'Toronto'),
        (1004, 'SuperCar East Toronto', '200 Richmond St E', 'M5A2P2', 'Toronto'),
        (1005, 'SuperCar Parliament', '200 Wellington St', 'K1A0G9' 'Toronto' ),
        (1006, 'SuperCar Ottawa Airport', '216 Airport Rd', 'K1V9B4', 'Ottawa'),
        (1007, 'SuperCar Central Station', '895 Rue Mansfield' 'H3B4G1', 'Montreal'),
        (1008, 'SuperCar North Montreal', '2351 Rue Masson', 'H1Y1V8', 'Montreal'),
        (1009, 'SuperCar West Montreal', '7000 Avenue Van Horne', 'H3S2B2', 'Montreal')


insert into Reservation(id, from_date, to_date, car_id, old_res_id, status)
    values(22001, 2017-09-01 09:00:00, 2017-09-03 17:00:00, 101, Null, 'Completed'),
          (22002, 2018-03-17 16:00:00, 2018-03-25 16:00:00, 101, Null, 'Cancelled'),
          (22003, 2018-03-19 10:00:00, 2018-03-23 20:00:00, 101, 22002, 'Confirmed'),
          (22004, 2018-03-01 08:00:00, 2018-03-10 20:00:00, 101, Null, 'Ongoing'),
          (22005, 2017-12-15 13:30:00, 2017-12-25 18:00:00, 101, Null, 'Completed'),
          (22006, 2017-11-01 06:00:00, 2017-11-04 12:00:00, 102, null, 'Completed'),
          (22007, 2018-02-23 10:00:00, 2018-03-05 17:00:00, 102, Null, 'Cancelled'),
          (22008, )



  ---- RESERVATION ----

  ID: 22007
  From Date: 2018-02-23 10:00:00
  To Date: 2018-03-05 17:00:00
  Car ID: 102
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22008
  From Date: 2018-03-10 10:00:00
  To Date: 2018-03-16 20:00:00
  Car ID: 102
  Old Reservation ID: 22007
  Status: Confirmed

  ID: 22009
  From Date: 2018-02-25 09:00:00
  To Date: 2018-03-10 21:00:00
  Car ID: 103
  Old Reservation ID: NULL
  Status: Ongoing

  ID: 22010
  From Date: 2017-12-09 14:00:00
  To Date: 2017-12-11 17:00:00
  Car ID: 103
  Old Reservation ID: NULL
  Status: Completed

  ID: 22011
  From Date: 2018-02-01 08:00:00
  To Date: 2018-02-05 16:00:00
  Car ID: 104
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22012
  From Date: 2017-12-25 09:00:00
  To Date: 2018-01-05 19:00:00
  Car ID: 106
  Old Reservation ID: NULL
  Status: Completed

  ID: 22013
  From Date: 2018-04-23 09:00:00
  To Date: 2018-05-01 14:00:00
  Car ID: 106
  Old Reservation ID: NULL
  Status: Confirmed

  ID: 22014
  From Date: 2018-02-19 08:00:00
  To Date: 2018-02-23 20:00:00
  Car ID: 107
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22015
  From Date: 2018-02-21 08:00:00
  To Date: 2018-03-10 20:00:00
  Car ID: 107
  Old Reservation ID: 22014
  Status: Ongoing

  ID: 22016
  From Date: 2017-10-09 08:00:00
  To Date: 2017-10-09 21:00:00
  Car ID: 107
  Old Reservation ID: NULL
  Status: Completed

  ID: 22017
  From Date: 2018-06-03 07:00:00
  To Date: 2018-06-20 15:00:00
  Car ID: 107
  Old Reservation ID: NULL
  Status: Confirmed

  ID: 22018
  From Date: 2018-01-14 09:00:00
  To Date: 2018-01-20 14:00:00
  Car ID: 109
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22019
  From Date: 2018-02-01 09:00:00
  To Date: 2018-02-03 16:00:00
  Car ID: 111
  Old Reservation ID: NULL
  Status: Completed

  ID: 22020
  From Date: 2018-02-26 06:00:00
  To Date: 2018-03-07 12:00:00
  Car ID: 113
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22021
  From Date: 2018-02-28 11:00:00
  To Date: 2018-03-08 23:00:00
  Car ID: 113
  Old Reservation ID: 22020
  Status: Ongoing

  ID: 22022
  From Date: 2017-07-02 09:00:00
  To Date: 2018-07-05 21:30:00
  Car ID: 113
  Old Reservation ID: NULL
  Status: Completed

  ID: 22023
  From Date: 2018-02-05 08:00:00
  To Date: 2018-02-08 18:00:00
  Car ID: 114
  Old Reservation ID: NULL
  Status: Completed

  ID: 22024
  From Date: 2018-04-02 16:00:00
  To Date: 2018-04-06 16:00:00
  Car ID: 116
  Old Reservation ID: NULL
  Status: Confirmed

  ID: 22025
  From Date: 2018-03-03 07:00:00
  To Date: 2018-03-15 23:30:00
  Car ID: 116
  Old Reservation ID: NULL
  Status: Ongoing

  ID: 22026
  From Date: 2018-01-01 07:00:00
  To Date: 2018-01-01 17:00:00
  Car ID: 118
  Old Reservation ID: NULL
  Status: Completed

  ID: 22027
  From Date: 2018-04-04 09:00:00
  To Date: 2018-04-06 15:00:00
  Car ID: 119
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22028
  From Date: 2018-02-14 13:00:00
  To Date: 2018-03-25 23:00:00
  Car ID: 119
  Old Reservation ID: NULL
  Status: Ongoing

  ID: 22029
  From Date: 2017-09-26 08:00:00
  To Date: 2017-10-03 20:00:00
  Car ID: 119
  Old Reservation ID: NULL
  Status: Completed

  ID: 22030
  From Date: 2018-03-26 10:00:00
  To Date: 2018-03-29 16:00:00
  Car ID: 123
  Old Reservation ID: NULL
  Status: Confirmed

  ID: 22031
  From Date: 2017-12-21 06:00:00
  To Date: 2017-12-28 22:00:00
  Car ID: 124
  Old Reservation ID: NULL
  Status: Completed

  ID: 22032
  From Date: 2017-09-22 16:00:00
  To Date: 2017-09-23 08:00:00
  Car ID: 126
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22033
  From Date: 2017-09-23 17:00:00
  To Date: 2017-09-23 14:00:00
  Car ID: 126
  Old Reservation ID: 22032
  Status: Completed

  ID: 22034
  From Date: 2018-01-01 22:00:00
  To Date: 2018-04-05 14:00:00
  Car ID: 127
  Old Reservation ID: NULL
  Status: Ongoing

  ID: 22035
  From Date: 2017-12-07 09:00:00
  To Date: 2017-12-13 12:00:00
  Car ID: 127
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22036
  From Date: 2018-03-24 10:00:00
  To Date: 2018-04-02 21:00:00
  Car ID: 128
  Old Reservation ID: NULL
  Status: Confirmed

  ID: 22037
  From Date: 2017-09-25 09:00:00
  To Date: 2017-09-27 20:00:00
  Car ID: 103
  Old Reservation ID: NULL
  Status: Cancelled

  ID: 22038
  From Date: 2017-09-25 09:00:00
  To Date: 2017-09-27 20:00:00
  Car ID: 104
  Old Reservation ID: 22037
  Status: Completed
