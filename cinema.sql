-- ############################################ --
-- ################# DATABASE ################# --
-- ############################################ --

CREATE DATABASE IF NOT EXISTS cinema CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- ########################################## --
-- ################# TABLES ################# --
-- ########################################## --

CREATE TABLE user (
	id_user INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
	Pseudo VARCHAR(50) NOT NULL,
  FirstName VARCHAR(20),
  LastName VARCHAR(20),
  Email VARCHAR(50) NOT NULL,
  Password VARCHAR(60) NOT NULL
) engine=INNODB;

CREATE TABLE administrator (
  id_admin INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  user_id INTEGER(11) NOT NULL
  -- CONSTRAINT FK_AdminUser FOREIGN KEY (user_id) REFERENCES user(id_user) ON UPDATE CASCADE ON DELETE CASCADE
) engine=INNODB;

CREATE TABLE customer (
	id_customer INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  user_id INTEGER(11) NOT NULL
  -- CONSTRAINT FK_CustomerUser FOREIGN KEY (user_id) REFERENCES user(id_user) ON UPDATE CASCADE ON DELETE CASCADE
) engine=INNODB;

CREATE TABLE theater (
	id_theater INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Address VARCHAR(50) NOT NULL,
  Telephone VARCHAR(20) NOT NULL,
  admin_id INTEGER(11) NOT NULL
  -- CONSTRAINT FK_TheaterAdmin FOREIGN KEY (admin_id) REFERENCES administrator(id_admin) ON UPDATE CASCADE ON DELETE CASCADE
) engine=INNODB;

CREATE TABLE room (
	id_room INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  NumberOrName varchar(20),
  SeatQtyMax INTEGER(11) NOT NULL DEFAULT 200,
  theater_id INTEGER(11) NOT NULL
  -- CONSTRAINT FK_RoomTheater FOREIGN KEY (theater_id) REFERENCES theater(id_theater) ON UPDATE CASCADE ON DELETE CASCADE
) engine=INNODB;

CREATE TABLE movie (
	id_movie INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  Title VARCHAR(20) NOT NULL,
  Language VARCHAR(20) NOT NULL
) engine=INNODB;

CREATE TABLE showing (
	id_showing INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  Date DATE NOT NULL,
  Time TIME NOT NULL,
  room_id INTEGER(11) NOT NULL,
  movie_id INTEGER(11) NOT NULL
  -- CONSTRAINT FK_ShowingRoom FOREIGN KEY (room_id) REFERENCES room(id_room) ON UPDATE CASCADE ON DELETE CASCADE,
  -- CONSTRAINT FK_ShowingMovie FOREIGN KEY (movie_id) REFERENCES movie(id_movie) ON UPDATE CASCADE ON DELETE CASCADE
) engine=INNODB;

CREATE TABLE price (
	id_price INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Description VARCHAR(50) NOT NULL,
  Price DECIMAL(4,2) NOT NULL
) engine=INNODB;

CREATE TABLE reservation (
	id_reservation INTEGER(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  PaymentType VARCHAR(20) NOT NULL,
  price_id INTEGER(11) NOT NULL,
  showing_id INTEGER(11) NOT NULL,
  customer_id INTEGER(11) NOT NULL
  -- CONSTRAINT FK_ReservationPrice FOREIGN KEY (price_id) REFERENCES price(id_price) ON UPDATE CASCADE ON DELETE CASCADE,
  -- CONSTRAINT FK_ReservationShowing FOREIGN KEY (showing_id) REFERENCES showing(id_showing) ON UPDATE CASCADE ON DELETE CASCADE,
  -- CONSTRAINT FK_ReservationCustomer FOREIGN KEY (customer_id) REFERENCES customer(id_customer) ON UPDATE CASCADE ON DELETE CASCADE
) engine=INNODB;



-- ################################################ --
-- ################# CONSTRAINTES ################# --
-- ################################################ --
-- could add the constraints in the creation table also
ALTER TABLE administrator
ADD CONSTRAINT FK_AdminUser FOREIGN KEY (user_id) REFERENCES user(id_user) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE customer
ADD CONSTRAINT FK_CustomerUser FOREIGN KEY (user_id) REFERENCES user(id_user) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE theater
ADD CONSTRAINT FK_TheaterAdmin FOREIGN KEY (admin_id) REFERENCES administrator(id_admin) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE room
ADD CONSTRAINT FK_RoomTheater FOREIGN KEY (theater_id) REFERENCES theater(id_theater) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE showing
ADD CONSTRAINT FK_ShowingRoom FOREIGN KEY (room_id) REFERENCES room(id_room) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT FK_ShowingMovie FOREIGN KEY (movie_id) REFERENCES movie(id_movie) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE reservation
ADD CONSTRAINT FK_ReservationPrice FOREIGN KEY (price_id) REFERENCES price(id_price) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT FK_ReservationShowing FOREIGN KEY (showing_id) REFERENCES showing(id_showing) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT FK_ReservationCustomer FOREIGN KEY (customer_id) REFERENCES customer(id_customer) ON UPDATE CASCADE ON DELETE CASCADE;


-- ############################################## --
-- ################# PRIVILEGES ################# --
-- ############################################## --
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'lambda'@'localhost' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON cinema.* TO 'admin'@'localhost';

GRANT SELECT (`Date`, `Time`, `room_id`, `movie_id`), INSERT (`Date`, `Time`, `room_id`, `movie_id`), UPDATE (`Date`, `Time`, `room_id`, `movie_id`), DELETE ON cinema.showing TO 'manager'@'localhost';
GRANT SELECT (`Title`, `Language`), INSERT (`Title`, `Language`), UPDATE (`Title`, `Language`), DELETE ON cinema.movie TO 'manager'@'localhost';

GRANT SELECT ON cinema.* TO 'lambda'@'localhost';

-- SHOW GRANTS FOR 'admin'@'localhost';
-- SHOW GRANTS FOR 'manager'@'localhost';
-- SHOW GRANTS FOR 'lambda'@'localhost';
-- REVOKE ALL PRIVILEGES ON *.* FROM 'admin'@'localhost';
-- REVOKE ALL PRIVILEGES ON *.* FROM 'manager'@'localhost';
-- REVOKE ALL PRIVILEGES ON *.* FROM 'lambda'@'localhost';



-- ############################################ --
-- ################# ADD DATA ################# --
-- ############################################ --
-- TABLE user
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (1, 'mceaplen0', 'Merrill', 'Ceaplen', 'mceaplen0@chron.com', '$2y$10$jmUi6/Xjg8e1kpphO0IJ3O/0MNyW8olQn3m5I4Fbmv2zZVaLhlaMa');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (2, 'rnewrick1', 'Rosaline', 'Newrick', 'rnewrick1@bbb.org', '$2y$10$.GLbZno8JvABuYDWO/prO.MN9l7aYE8X5rNg8xDWjGBAElAn4K0Wy');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (3, 'bmasham2', 'Bess', 'Masham', 'bmasham2@topsy.com', '$2y$10$E2QvWUdK4l1xqPwOIeCcAuwRisISr.OfB6Q2l/ksOhdmaL0cUELBe');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (4, 'mchatwood3', 'Merl', 'Chatwood', 'mchatwood3@themeforest.net', '$2y$10$63dIR.x1psDUi2631vK1GOqRrycAMMr2cbPmgS9AimHGNy01X64X.');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (5, 'kyankeev4', 'Krisha', 'Yankeev', 'kyankeev4@mapy.cz', '$2y$10$YskEvnqqkkTQKMUcL4x2cet2XyUuNQZS/zzem/93f3VKcou0IeUbe');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (6, 'ycorby5', 'Yettie', 'Corby', 'ycorby5@cbsnews.com', '$2y$10$wFQXf9zbFwJZaFgBQQnrtuAk3noDbUan40Qy.YU1VRq51qE3DwzCC');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (7, 'jchitson6', 'Jodee', 'Chitson', 'jchitson6@vinaora.com', '$2y$10$LSN6XaZGrXcvAz1X6i1Pyub6y3c5WHMHZS4zNn89iTKCXfNIziJ1i');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (8, 'kdoone7', 'Kearney', 'Doone', 'kdoone7@wix.com', '$2y$10$1clVQVRgLAY7UxhujSdyZOx1USSKozGCMlo53lFpK/qPHvqkdLjCG');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (9, 'hcottesford8', 'Hansiain', 'Cottesford', 'hcottesford8@google.com.au', '$2y$10$yGmwnTSzhPz2pcaHhtTLe.hdEpTDIEyujteqm/aUwJijKnOTjQn3u');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (10, 'tspragg9', 'Tracee', 'Spragg', 'tspragg9@indiatimes.com', '$2y$10$5WIUeFybjfEMENuj01Tg7en7Hsb0UFPmNsDhVD/muKNswR7Uhvfde');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (11, 'kweatherhogga', 'Karlik', 'Weatherhogg', 'kweatherhogga@vk.com', '$2y$10$SjFXmu9T6lvPlsQr.6NHF.aRe4tj/DUZe7F5zrXS2KEds0X2C3FAq');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (12, 'srolinb', 'Shelden', 'Rolin', 'srolinb@taobao.com', '$2y$10$JRS0YrVqi3ZT2SFLk8sY8.brC9bPjFaJBZl4l74gSD.54SnG7cgIC');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (13, 'ejouandetc', 'Elicia', 'Jouandet', 'ejouandetc@ox.ac.uk', '$2y$10$bnaWGPSMW2sEWw6DWXd1eegOKLxUY6hzvkUBT8eu7JfaMStXDQ0oC');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (14, 'dbalmad', 'Dusty', 'Balma', 'dbalmad@who.int', '$2y$10$ItmUCzfe9VbYzW/YOfUTyuh/MtPJxNn7ro07auq3vPAyHKD3TFhwG');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (15, 'aphelane', 'Angy', 'Phelan', 'aphelane@github.com', '$2y$10$/gSFPLcCWkUpP0E.B041K.BYA5MPgIThGC8z/ltmgygV19svZGtwG');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (16, 'mshearerf', 'Marji', 'Shearer', 'mshearerf@mlb.com', '$2y$10$r4i9/noZ1mxdSqFs/IYy9OGGLNl8EtpjFgWT/oEda3ENm6XvYffo6');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (17, 'cokeefeg', 'Charmion', 'O''Keefe', 'cokeefeg@vistaprint.com', '$2y$10$n4/3lQZxI91NjPaRAOFfVOJQGMj8hLp/hceER8YEwg7z7U4VWjZti');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (18, 'amickanh', 'Ashley', 'Mickan', 'amickanh@exblog.jp', '$2y$10$yg.DbzU0qd9YtxbIsY9QFu47bOGRXrofsfoozsNnyIK9UL6PWgeaO');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (19, 'qfrickeyi', 'Querida', 'Frickey', 'qfrickeyi@booking.com', '$2y$10$HG5KfKCHwEzTa1KnIL6SqexRrqygFEhOlkUkcdfyMc0/22DzZau2y');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (20, 'hgoriolij', 'Herbert', 'Gorioli', 'hgoriolij@mysql.com', '$2y$10$AsTb1x.EqzfNIlwkG6mtWeKGNl2QnFB9KHgIuMc8/EyphxN8cDaRS');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (21, 'groakek', 'Gretna', 'Roake', 'groakek@prweb.com', '$2y$10$Kq4SVvmUltoOys1yky2wd.e5zrMLsKcL2CpiA3V73guTfv0Ig272G');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (22, 'jexeterl', 'Job', 'Exeter', 'jexeterl@cocolog-nifty.com', '$2y$10$dwssS64xSc.V16rW1OijJuraBjKCkqnL4e2VwkQDYhRYxwgwgH0zS');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (23, 'acovelym', 'Alyss', 'Covely', 'acovelym@surveymonkey.com', '$2y$10$bEsvWDFpzYx8a8T/DEGCFOX9XEdc5uFZfQtP6zrNTA24dRCNY8KDa');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (24, 'koldacren', 'Kele', 'Oldacre', 'koldacren@blogspot.com', '$2y$10$CQJWxunEcY7TseW775lo4.vFeK1BAz66LawMNAVNC7vr8buSVbErW');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (25, 'iroofeo', 'Irvine', 'Roofe', 'iroofeo@netvibes.com', '$2y$10$l0VTXrqH90duLanpuG1eZOAl9OTUfc3Bf3D/vY49zMA.axr.ZeLnG');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (26, 'lblackmoorp', 'Laney', 'Blackmoor', 'lblackmoorp@github.com', '$2y$10$2kz44JQNKW9Oy7kQiDFoWeXr3hv17nCNy01.eqQOR/edN54wWR4w6');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (27, 'lmaciociaq', 'Lari', 'Maciocia', 'lmaciociaq@free.fr', '$2y$10$pA./H29bCuV5PTyhtKjLd.WPcf5I.59lNQA0kAE3Ayakqia8LPw3W');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (28, 'lceyssenr', 'Leonid', 'Ceyssen', 'lceyssenr@umn.edu', '$2y$10$7YYAtpkSbX1etzzKRbKYAuiejt0LsAwrZiS9Rq3/Ijh/fIjyHQmBu');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (29, 'cgothliffs', 'Clair', 'Gothliff', 'cgothliffs@springer.com', '$2y$10$eeR.WWwwD9uKWuF3kQ9o.uIkTm842synADeLAEMscbuLCLawU7Fpq');
insert into user (id_user, Pseudo, FirstName, LastName, Email, Password) values (30, 'rsentancet', 'Rita', 'Sentance', 'rsentancet@furl.net', '$2y$10$YrmZPZel0550wg2ZTbhe5eMPCjSovXsZqu8/kGa0FTcuClaLQy6M.');

-- TABLE administrator
insert into administrator (id_admin, user_id) values (1, 1);
insert into administrator (id_admin, user_id) values (2, 2);
insert into administrator (id_admin, user_id) values (3, 3);
insert into administrator (id_admin, user_id) values (4, 4);
insert into administrator (id_admin, user_id) values (5, 5);

-- TABLE customer
insert into customer (id_customer, user_id) values (1, 6);
insert into customer (id_customer, user_id) values (2, 7);
insert into customer (id_customer, user_id) values (3, 8);
insert into customer (id_customer, user_id) values (4, 9);
insert into customer (id_customer, user_id) values (5, 10);
insert into customer (id_customer, user_id) values (6, 11);
insert into customer (id_customer, user_id) values (7, 12);
insert into customer (id_customer, user_id) values (8, 13);
insert into customer (id_customer, user_id) values (9, 14);
insert into customer (id_customer, user_id) values (10, 15);
insert into customer (id_customer, user_id) values (11, 16);
insert into customer (id_customer, user_id) values (12, 17);
insert into customer (id_customer, user_id) values (13, 18);
insert into customer (id_customer, user_id) values (14, 19);
insert into customer (id_customer, user_id) values (15, 20);
insert into customer (id_customer, user_id) values (16, 21);
insert into customer (id_customer, user_id) values (17, 22);
insert into customer (id_customer, user_id) values (18, 23);
insert into customer (id_customer, user_id) values (19, 24);
insert into customer (id_customer, user_id) values (20, 25);
insert into customer (id_customer, user_id) values (21, 26);
insert into customer (id_customer, user_id) values (22, 27);
insert into customer (id_customer, user_id) values (23, 28);
insert into customer (id_customer, user_id) values (24, 29);
insert into customer (id_customer, user_id) values (25, 30);

-- TABLE theater
insert into theater (id_theater, Name, Address, Telephone, admin_id) values (1, 'Stim', '5 Columbus Junction', '5908929724', 1);
insert into theater (id_theater, Name, Address, Telephone, admin_id) values (2, 'Home Ing', '605 Kensington Avenue', '2516634027', 2);
insert into theater (id_theater, Name, Address, Telephone, admin_id) values (3, 'Zathin', '766 Shasta Park', '4909717474', 3);
insert into theater (id_theater, Name, Address, Telephone, admin_id) values (4, 'Rank', '3 Canary Court', '4728897264', 4);
insert into theater (id_theater, Name, Address, Telephone, admin_id) values (5, 'Bigtax', '83 Linden Pass', '1273209978', 5);

-- TABLE room
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (1, 1, 227, 1);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (2, 2, 282, 1);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (3, 3, 216, 1);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (4, 4, 213, 1);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (5, 5, 228, 1);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (6, 6, 227, 1);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (7, 1, 229, 2);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (8, 2, 290, 2);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (9, 3, 258, 2);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (10, 4, 220, 2);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (11, 1, 228, 3);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (12, 2, 224, 3);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (13, 3, 287, 3);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (14, 4, 200, 3);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (15, 5, 222, 3);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (16, 6, 277, 3);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (17, 1, 226, 4);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (18, 2, 212, 4);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (19, 3, 299, 4);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (20, 4, 297, 4);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (21, 1, 262, 5);
insert into room (id_room, NumberOrName, SeatQtyMax, theater_id) values (22, 2, 283, 5);

-- TABLE movie
insert into movie (id_movie, Title, Language) values (1, 'Alps (Alpeis)', 'VO');
insert into movie (id_movie, Title, Language) values (2, 'Last Orders', 'VOST');
insert into movie (id_movie, Title, Language) values (3, '5th Day of Peace (Dio è con noi)', 'VPST');
insert into movie (id_movie, Title, Language) values (4, 'Everybody Wants to Be Italian', 'VF');
insert into movie (id_movie, Title, Language) values (5, 'Men with Brooms', 'VF');
insert into movie (id_movie, Title, Language) values (6, '5 Broken Cameras', 'VO');

-- TABLE showing
insert into showing (id_showing, Date, Time, room_id, movie_id) values (1, '22-01-2022', '15:37', 1, 5);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (2, '01-03-2022', '18:30', 2, 3);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (3, '31-10-2021', '14:45', 3, 5);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (4, '04-07-2022', '17:10', 4, 3);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (5, '01-02-2022', '16:53', 5, 4);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (6, '13-01-2022', '16:19', 6, 4);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (7, '24-08-2022', '18:43', 7, 1);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (8, '30-11-2021', '18:30', 8, 3);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (9, '09-06-2022', '20:33', 9, 2);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (10, '21-07-2022', '14:57', 10, 4);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (11, '30-04-2022', '15:25', 11, 6);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (12, '16-05-2022', '16:38', 12, 4);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (13, '05-04-2022', '14:35', 13, 5);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (14, '30-04-2022', '19:55', 14, 1);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (15, '10-09-2021', '13:35', 15, 2);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (16, '20-08-2022', '14:49', 16, 3);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (17, '23-02-2022', '15:55', 17, 5);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (18, '20-02-2022', '18:58', 18, 1);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (19, '04-05-2022', '20:53', 19, 3);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (20, '09-06-2022', '18:24', 20, 5);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (21, '01-02-2022', '13:17', 21, 5);
insert into showing (id_showing, Date, Time, room_id, movie_id) values (22, '25-12-2021', '16:10', 22, 3);

-- TABLE price
insert into price (id_price, Name, Description, Price) values (1, 'Régulier', 'à partir de 15 ans', '9.20');
insert into price (id_price, Name, Description, Price) values (2, 'Étudiant', 'sur présentation de preuve', '7.60');
insert into price (id_price, Name, Description, Price) values (3, 'Enfant', 'moins de 14 ans', '5.90');

-- TABLE reservation
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (1, 'onsite', 2, 15, 12);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (2, 'onsite', 1, 6, 1);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (3, 'onsite', 3, 22, 19);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (4, 'onsite', 1, 19, 3);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (5, 'onsite', 1, 4, 24);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (6, 'onsite', 1, 6, 4);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (7, 'online', 1, 7, 18);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (8, 'online', 3, 1, 1);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (9, 'online', 2, 18, 19);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (10, 'online', 1, 11, 7);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (11, 'online', 1, 12, 8);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (12, 'online', 3, 19, 9);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (13, 'online', 3, 15, 8);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (14, 'online', 2, 19, 14);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (15, 'online', 3, 9, 10);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (16, 'online', 1, 17, 3);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (17, 'online', 1, 4, 17);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (18, 'online', 3, 12, 16);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (19, 'online', 3, 21, 7);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (20, 'online', 2, 21, 18);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (21, 'onsite', 2, 11, 15);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (22, 'onsite', 3, 2, 20);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (23, 'onsite', 3, 12, 23);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (24, 'onsite', 1, 16, 19);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (25, 'onsite', 3, 11, 9);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (26, 'onsite', 3, 19, 15);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (27, 'onsite', 2, 18, 5);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (28, 'onsite', 1, 5, 2);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (29, 'onsite', 2, 13, 23);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (30, 'onsite', 3, 3, 11);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (31, 'onsite', 1, 1, 20);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (32, 'onsite', 1, 1, 20);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (33, 'online', 1, 3, 25);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (34, 'online', 2, 14, 24);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (35, 'online', 3, 3, 13);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (36, 'online', 1, 12, 9);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (37, 'online', 1, 19, 1);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (38, 'online', 3, 17, 23);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (39, 'online', 2, 17, 12);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (40, 'online', 1, 9, 13);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (41, 'onsite', 2, 9, 17);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (42, 'onsite', 2, 8, 16);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (43, 'onsite', 3, 1, 3);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (44, 'onsite', 1, 19, 1);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (45, 'onsite', 1, 22, 18);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (46, 'onsite', 1, 22, 21);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (47, 'onsite', 2, 2, 13);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (48, 'online', 3, 6, 5);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (49, 'online', 1, 15, 14);
insert into reservation (id_reservation, PaymentType, price_id, showing_id, customer_id) values (50, 'online', 2, 20, 24);
