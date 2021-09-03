/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2021/9/3 12:47:56                            */
/*==============================================================*/


drop table if exists CarClassification;

drop table if exists CarInformation;

drop table if exists CarType;

drop table if exists Commodity_orders;

drop table if exists Limited_time_promotion;

drop table if exists Vehicle_scheduling;

drop table if exists coupon;

drop table if exists network;

drop table if exists staff;

drop table if exists users;

/*==============================================================*/
/* Table: CarClassification                                     */
/*==============================================================*/
create table CarClassification
(
   Category_number      int not null,
   Category_name        varchar(20) not null,
   Category_description varchar(100),
   primary key (Category_number)
);

/*==============================================================*/
/* Table: CarInformation                                        */
/*==============================================================*/
create table CarInformation
(
   Vehicle_number       int not null,
   network_number       int,
   Model_number         int,
   License_plate_number varchar(30) not null,
   Vehicle_type         varchar(20) not null,
   Network              int not null,
   currentState         varchar(4) not null,
   primary key (Vehicle_number)
);

/*==============================================================*/
/* Table: CarType                                               */
/*==============================================================*/
create table CarType
(
   Model_number         int not null,
   Category_number      int,
   Model_name           varchar(20) not null,
   brand                varchar(20) not null,
   displacement         real,
   Gear                 varchar(20),
   Number_of_seats      int,
   Price                real,
   picture              varchar(100),
   primary key (Model_number)
);

/*==============================================================*/
/* Table: Commodity_orders                                      */
/*==============================================================*/
create table Commodity_orders
(
   Vehicle_number       int not null,
   Coupon_number        int,
   Promotion_number     int,
   use_User_number      int not null,
   Orders_No            int,
   User_number          int,
   Pick_up_network      int,
   Pick_up_time         datetime,
   Return_network       int,
   Return_time          datetime,
   Car_rental_duration  int,
   Original_amount      int,
   Settlement_amount    int,
   Use_coupon_number    int,
   Orders_status        varchar(4),
   primary key (Vehicle_number, use_User_number)
);

/*==============================================================*/
/* Table: Limited_time_promotion                                */
/*==============================================================*/
create table Limited_time_promotion
(
   Promotion_number     int not null,
   networkNumber        int not null,
   Vehicle_model        int not null,
   Promotion_discount   int not null,
   Promotion_quantity   int not null,
   Start_date           date,
   End_date             date,
   primary key (Promotion_number)
);

/*==============================================================*/
/* Table: Vehicle_scheduling                                    */
/*==============================================================*/
create table Vehicle_scheduling
(
   network_number       int not null,
   net_network_number   int not null,
   Transfer_out_node_number int,
   Transfer_in_node_number int,
   Corresponding_vehicle_number int,
   Scheduling_time      datetime,
   primary key (network_number, net_network_number)
);

alter table Vehicle_scheduling comment '

';

/*==============================================================*/
/* Table: coupon                                                */
/*==============================================================*/
create table coupon
(
   Coupon_number        int not null,
   content              varchar(100),
   Deduction_amount     int not null,
   Start_date           date not null,
   End_date             date not null,
   primary key (Coupon_number)
);

/*==============================================================*/
/* Table: network                                               */
/*==============================================================*/
create table network
(
   network_number       int not null,
   Promotion_number     int,
   network_name         varchar(50) not null,
   city                 varchar(20) not null,
   address              varchar(100),
   phone_number         varchar(20) not null,
   primary key (network_number)
);

/*==============================================================*/
/* Table: staff                                                 */
/*==============================================================*/
create table staff
(
   Employee_number      int not null,
   network_number       int,
   Car_Vehicle_number   int,
   Employee_name        varchar(20) not null,
   Login_password       varchar(20) not null,
   Network              int not null,
   Scrap_number         int,
   Vehicle_number       int,
   Operator_number      int,
   Scrap_time           datetime,
   explaintion          varchar(200),
   primary key (Employee_number)
);

alter table staff comment '

';

/*==============================================================*/
/* Table: users                                                 */
/*==============================================================*/
create table users
(
   User_number          int not null,
   name                 varchar(20) not null,
   sex                  varchar(10) not null,
   password             varchar(20) not null,
   phone_number         varchar(20) not null,
   mailbox              varchar(50),
   city                 varchar(10),
   Registration_time    datetime,
   primary key (User_number)
);

alter table CarInformation add constraint FK_Scheduling foreign key (network_number)
      references network (network_number) on delete restrict on update restrict;

alter table CarInformation add constraint FK_carBelongToType foreign key (Model_number)
      references CarType (Model_number) on delete restrict on update restrict;

alter table CarType add constraint FK_typeBelongToClassification foreign key (Category_number)
      references CarClassification (Category_number) on delete restrict on update restrict;

alter table Commodity_orders add constraint FK_Commodity_orders foreign key (Vehicle_number)
      references CarInformation (Vehicle_number) on delete restrict on update restrict;

alter table Commodity_orders add constraint FK_Commodity_orders1 foreign key (Promotion_number)
      references Limited_time_promotion (Promotion_number) on delete restrict on update restrict;

alter table Commodity_orders add constraint FK_Commodity_orders2 foreign key (Coupon_number)
      references coupon (Coupon_number) on delete restrict on update restrict;

alter table Commodity_orders add constraint FK_Commodity_orders3 foreign key (use_User_number)
      references users (User_number) on delete restrict on update restrict;

alter table Vehicle_scheduling add constraint FK_Vehicle_scheduling foreign key (network_number)
      references network (network_number) on delete restrict on update restrict;

alter table Vehicle_scheduling add constraint FK_Vehicle_scheduling2 foreign key (net_network_number)
      references network (network_number) on delete restrict on update restrict;

alter table network add constraint FK_couponBelongToNetwork foreign key (Promotion_number)
      references Limited_time_promotion (Promotion_number) on delete restrict on update restrict;

alter table staff add constraint FK_Vehicle_scrapping foreign key (Car_Vehicle_number)
      references CarInformation (Vehicle_number) on delete restrict on update restrict;

alter table staff add constraint FK_staffBelongToNetwork foreign key (network_number)
      references network (network_number) on delete restrict on update restrict;

