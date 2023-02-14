REM   Script: Useful_Query
REM   For getting data from the pet appointment database

CREATE SEQUENCE po_seq START WITH 1001 INCREMENT BY 1;

CREATE TABLE PET_OWNER( 
				     Client_ID     		INT			PRIMARY KEY, 
				     Name		 	VARCHAR(15)    NOT NULL, 
				     Phone			 VARCHAR(14),		 
				     Email			 VARCHAR(30), 
				     Address		             VARCHAR(30), 
				     Note			 VARCHAR(128) 
             );

CREATE TRIGGER po_trig 
BEFORE INSERT ON PET_OWNER 
FOR EACH ROW 
BEGIN 
  SELECT po_seq.NEXTVAL INTO :new.Client_ID FROM dual; 
END; 
/

CREATE SEQUENCE cut_card_seq START WITH 2001 INCREMENT BY 1;

CREATE TABLE CUT_CARD( 
				  Card_ID			   INT			PRIMARY KEY, 
				  Bath_Brush_Notes		   VARCHAR(128), 
				  Trim_Tidy_Notes		   VARCHAR(128), 
				  Full_Groom_Notes		   VARCHAR(128), 
  Nail_Clip_Notes		   VARCHAR(128), 
				  Previous_Appointment_Date  DATE, 
				  Previous_Service		   INT 
			            );

CREATE TRIGGER cut_card_trig 
BEFORE INSERT ON CUT_CARD 
FOR EACH ROW 
BEGIN 
  SELECT cut_card_seq.NEXTVAL INTO :new.Card_ID FROM dual; 
END; 
/

CREATE SEQUENCE services_seq START WITH 4001 INCREMENT BY 1;

CREATE TABLE SERVICES( 
			 	 Service_ID		INT			NOT NULL, 
				 Service		VARCHAR(20)	NOT NULL, 
				 Cost			NUMBER(7,2)		NOT NULL,	 
				 Type			VARCHAR(10), 
				 Difficulty		VARCHAR(10), 
				 PRIMARY KEY(Service_ID), 
				 CHECK (Cost >= 0) 
			           );

CREATE TRIGGER services_trig 
BEFORE INSERT ON SERVICES 
FOR EACH ROW 
BEGIN 
  SELECT services_seq.NEXTVAL INTO :new.Service_ID FROM dual; 
END; 
/

CREATE SEQUENCE pet_seq START WITH 3001 INCREMENT BY 1;

CREATE TABLE PET( 
 Pet_ID		INT			NOT NULL, 
                                     Name			VARCHAR(15)	NOT NULL,	 
 Owner_ID		INT, 
 Breed			VARCHAR(20), 
 Birthday		Date, 
 Weight		DECIMAL(10,2)	NOT NULL, 
 Cut_Card		INT, 
 Microchipped		VARCHAR(20), 
 Rabies_Vaccine	VARCHAR(20), 
 Note			VARCHAR(128), 
 PRIMARY KEY (Pet_ID), 
 FOREIGN KEY (Owner_ID) REFERENCES PET_OWNER(Client_ID) ON DELETE CASCADE,  
 FOREIGN KEY (Cut_Card) REFERENCES CUT_CARD(Card_ID) ON DELETE CASCADE, 
CHECK (Birthday >= date '2002-12-31'), 
CHECK (Weight < 100) 
);

CREATE TRIGGER pet_trig 
BEFORE INSERT ON PET 
FOR EACH ROW 
BEGIN 
  SELECT pet_seq.NEXTVAL INTO :new.Pet_ID FROM dual; 
END; 
/

CREATE SEQUENCE appt_seq START WITH 5001 INCREMENT BY 1;

CREATE TABLE APPOINTMENT( 
				        Appointment_ID	     INT		      NOT NULL, 
				        Appointment_date   DATE	      DEFAULT CURRENT_DATE, 
				        Start_Time	     VARCHAR(20)    NOT NULL, 
				        End_Time	     VARCHAR(20), 
				        Client_ID		     INT, 
				        Pet_ID		     INT		       NOT NULL, 
				        Service_id	     INT		       NOT NULL, 
				        PRIMARY KEY(Appointment_ID), 
				        FOREIGN KEY(Client_ID)  
        	  REFERENCES PET_OWNER(Client_ID) ON DELETE CASCADE, 
				        FOREIGN KEY(Pet_ID)  
  REFERENCES PET(Pet_ID) ON DELETE CASCADE, 
        FOREIGN KEY(Service_id)  
  REFERENCES SERVICES(Service_ID) ON DELETE CASCADE, 
CHECK (End_Time > Start_Time) 
			                 );

CREATE TRIGGER appt_trig 
BEFORE INSERT ON APPOINTMENT 
FOR EACH ROW 
BEGIN 
  SELECT appt_seq.NEXTVAL INTO :new.Appointment_ID FROM dual; 
END; 
/

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Thomas Hills', '(888)456-7891', 'thill91@gmail.com', '10 Street SW Kent, WA', '');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Linda Martin', '(253)318-3211', 'lmar11@hotmail.com', '222 Alberta Dr. SE Tacoma, WA', '');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Ryan MacLeod', '(253)819-3874', 'rmac74@gmail.com', '345 Lucas Rd. E Tukwilla, WA', 'Friend Discount');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Debra Thomas', '(253)498-1111', 'dtho11@iCloud.com', '8045 Yakima Ave. Tacoma, WA', '');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Kyler Robinson', '(360)941-8431', 'krob31@gmail.com', '30 House St. Olympia, WA', '');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Tabitha Leery', '(360)649-1634', 'tlee34@msn.com	88', 'Livehere Dr. Tacoma, WA', 'Met through Facebook');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Erica Simpson', '(253)946-1347', 'esim47@aol.com', '901 Tulip Dr. Puyallup, WA', '');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Jessica Rabbit', '(425)971-2314', 'jrab14@iCloud.com', '311 Radius Ln. W Tacoma, WA', 'Don''t call after 6 pm');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('Clinton Rowe', '(253)941-6167', 'crow67@hotmail.com', '69 Real Rd. Tacoma, WA', '');

INSERT INTO PET_OWNER (Name, Phone, Email, Address, Note)  
VALUES ('John Doe', '(360)645-3397', 'jdoe97@hotmail.com', '343 Halo Dr. Bellevue, WA', '');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Nail Clip', 5, 'Non-Groom', '1');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Nail Clip', 10, 'Non-Groom', '2');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Bath/Brush', 15,	'Non-Groom', '1');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Bath/Brush', 20, 'Non-Groom', '2');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Bath/Brush', 25, 'Non-Groom', '3');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Bath/Brush', 30,	'Non-Groom', '4');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Trim/Tidy', 20, 'Groom', '1');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Trim/Tidy', 25, 'Groom', '2');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Trim/Tidy', 30, 'Groom', '3');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Trim/Tidy', 35, 'Groom', '4');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Full Groom', 30, 'Groom', '1');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Full Groom', 40,	'Groom', '2');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Full Groom', 50,	'Groom', '3');

INSERT INTO SERVICES(Service, Cost, Type, Difficulty) 
VALUES ('Full Groom', 60,	'Groom', '4');

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Hypo Allergenic Shampoo', 'Use #4 Blade - C Comb', 'Use #3 Blade - B Comb', 'Hates nails being clipped', DATE '2023-01-22', 4013);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Organic Green Tea Shampoo - Might bite', 'Use #3 Blade - A Comb', 'Use #7 Blade - B Comb', 'Hates nails being clipped', DATE '2023-01-02', 4013);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Doesn''t like blowdryer', 'Use #3 Blade - B Comb', 'Use #6 Blade - B Comb', 'Hates nails being clipped', DATE '2023-12-22', 4013);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Loves to lick water', 'Use #7 Blade - A Comb', 'Use #7 Blade - C Comb', 'Pulls away', DATE '2023-02-01', 4007);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Pulls away', 'Use #6 Blade - C Comb', 'Use #6 Blade - B Comb', 'Hates nails being clipped', DATE '2023-01-27', 4007);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Likes baths', 'Use #6 Blade - B Comb', 'Use #5 Blade - B Comb', 'Hates nails being clipped', DATE '2023-01-15', 4010);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Howls', 'Use #1 Blade - C Comb', 'Use #5 Blade - C Comb', 'Has dewclaw', DATE '2023-01-07', 4011);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Owner brings shampoo', 'Use #4 Blade - C Comb', 'Use #5 Blade - B Comb', 'Hates nails being clipped', DATE '2023-01-14', 4010);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Don''t blow dry face - Use Allergenic shampoo', 'Use #6 Blade - B Comb', 'Use #3 Blade - A Comb', 'Hates nails being clipped', DATE '2023-02-04', 4012);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Owner brings shampoo', 'Use #6 Blade - A Comb', 'Use #1 Blade - A Comb', 'Might bite', DATE '2022-12-10', 4011);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Loves baths', 'Use #7 Blade - A Comb', 'Use #5 Blade - C Comb', 'Hates nails being clipped', DATE '2023-02-04', 4002);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Hates baths', 'Use #1 Blade - B Comb', 'Use #7 Blade - B Comb', 'Hates nails being clipped', DATE '2023-02-04', 4003);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Pulls away during feet', 'Use #4 Blade - B Comb', 'Use #6 Blade - C Comb', 'Ok', DATE '2023-01-08', 4002);

INSERT INTO CUT_CARD (Bath_Brush_Notes, Trim_Tidy_Notes, Full_Groom_Notes, Nail_Clip_Notes, Previous_Appointment_Date, Previous_Service) 
VALUES ('Don''t get water close to eyes, will panic', 'Use #3 Blade - A Comb', 'Use #3 Blade - A Comb', 'Ok', DATE '2022-12-18', 4009);

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Tarzan', 1001, 'Tabby', DATE '2011-1-11', 6, 2005, 'Yes', 'Yes', 'Friendly old orange cat');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Nirvana', 1002, 'Beagle-Chihuaua', DATE '2010-2-28', 15,	2001, 'Yes', 'Yes', 'Has Mastitis');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Oasis', 1002, 'Dotson', DATE '2020-4-15', 10, 2004, 'No', 'Yes', 'Separation anxiety');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Lefty', 1003, 'Frenchton', DATE'2022-6-12', 30, 2002, 'Yes', 'Yes', 'Pees when scared');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Skipper', 1003, 'Beagle', DATE '2020-9-17', 17, 2013, 'Yes', 'No', 'Great dog!');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Penny', 1004, 'Poodle', DATE '2018-8-22', 58, 2010, 'No', 'Yes', 'Allergic to chicken');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Luna', 1005, 'Calico', DATE '2016-7-25', 7, 2011, 'Yes', 'Yes', 'Tuna''s sister');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Tuna', 1005, 'Calico', DATE '2016-7-25',	12,	2012, 'Yes', 'Yes', 'Luna''s brother');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Gadhar', 1006, 'Australian Shephard', DATE '2012-12-12', 36, 2008, 'No',	'Yes', '');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Joe Dirt', 1007,	'Tabby', DATE '2017-10-31', 8, 2006, 'Yes', 'Yes', 'Might try to run away');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Lucky', 1008, 'Calico', DATE '2021-7-6', 8, 2003, 'Yes', 'Yes', 'No treats');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Scout', 1009, 'Pit Bull', DATE '2015-6-1', 47, 2009, 'No', 'Yes', 'Broke a foot 2 years ago');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Fannie', '1010', 'Pomeranian', DATE '2008-5-8',12, 2007,	'Yes', 'Yes', '');

INSERT INTO PET(Name, Owner_id, Breed, Birthday, Weight, Cut_Card, Microchipped, Rabies_Vaccine, Note) 
VALUES ('Buddy', '1010', 'Yorkie', DATE '2023-1-2', 1, 2014, 'Yes', 'No', 'Puppy');

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-10', '14:30', '15:00', 1009, 3009, 4006);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-10', '15:30', '17:00', 1007, 3006, 4014);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-11', '11:30', '14:00', 1006, 3008, 4013);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-12', '11:30', '12:30', 1001, 3005, 4004);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-12', '13:30', '15:00', 1010,	3007, 4011);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-12', '15:30', '15:45', 1002,	3001, 4002);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-18', '10:00', '10:15', 1005,	3011, 4002);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-18', '10:30' ,'12:00', 1003, 3002, 4010);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-19', '14:00', '15:45', 1004,	3010, 4008);

INSERT INTO APPOINTMENT (Appointment_Date, Start_Time, End_Time, Client_id, Pet_id, Service_id) 
VALUES (DATE '2023-2-19', '15:30', '16:00', 1008,	3003, 4001);

SQL Query 10: 


SELECT pet.name AS "Pet Name",  
       cut_card.full_groom_notes AS "Full Groom Notes"  
FROM cut_card  
JOIN pet ON cut_card.card_id = pet.cut_card  
JOIN pet_owner ON pet.owner_id = pet_owner.client_id  
WHERE pet_owner.name = 'Linda Martin' 
ORDER BY PET.NAME ASC;

SELECT PET.BREED AS "Breed",  
     COUNT(PET.BREED) AS "Numbers of pets not microchipped or not vaccinated" 
FROM PET 
WHERE PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.MICROCHIPPED = 'No') 
                OR PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.RABIES_VACCINE = 'No')) 
GROUP BY PET.BREED 
ORDER BY PET.BREED ASC;

SELECT P.NAME AS "Pet Name",  
PO.NAME AS "Owner Name",  
PO.PHONE AS "Owner Phone Number",  
PO.EMAIL AS "Owner Email" 
FROM PET P 
JOIN PET_OWNER PO 
ON PO.CLIENT_ID = P.OWNER_ID 
WHERE P.CUT_CARD IN ( 
    SELECT CARD_ID  
    FROM CUT_CARD CC  
    WHERE CC.PREVIOUS_APPOINTMENT_DATE < SYSDATE - 30 
) AND P.PET_ID NOT IN ( 
    SELECT PET_ID 
    FROM APPOINTMENT 
);

SELECT APPOINTMENT.APPOINTMENT_DATE AS "Appointment Date",                  APPOINTMENT.START_TIME AS "Start Time",  
PET.Name AS "Pet Name",  
PET_OWNER.NAME AS "Owner Name",  
PET_OWNER.PHONE AS "Owner Phone Number", 
PET_OWNER.EMAIL AS "Owner Email" 
FROM APPOINTMENT  
FULL OUTER JOIN PET 
ON APPOINTMENT.PET_ID = PET.PET_ID 
FULL OUTER JOIN PET_OWNER 
ON PET.OWNER_ID = PET_OWNER.CLIENT_ID 
WHERE APPOINTMENT.APPOINTMENT_DATE >= SYSDATE - 1  AND   APPOINTMENT.APPOINTMENT_DATE < SYSDATE + 7 
      ORDER BY "Appointment Date" ASC;

SELECT *  
FROM PET 
MINUS 
SELECT *  
FROM PET 
WHERE PET.WEIGHT >= ( SELECT AVG(PET.WEIGHT) 
                      FROM PET ) 
      OR PET.WEIGHT = (SELECT MIN(PET.WEIGHT) 
                       FROM PET);

SELECT (pet_owner.name) AS "Owner Name", email, phone, (pet.name) AS "Pet Name"  
FROM pet  
JOIN pet_owner ON client_id = owner_id  
WHERE EXTRACT(MONTH FROM birthday) = EXTRACT(MONTH FROM SYSDATE)  
    AND EXTRACT(DAY FROM birthday) = EXTRACT(DAY FROM SYSDATE);

Expected: A table containing one tuple that has the name of the pet, and all of the columns from the cut_card schema (excluding card_id). 


SELECT name, full_groom_notes, trim_tidy_notes, bath_brush_notes, nail_clip_notes, previous_appointment_date, previous_service  
FROM pet 
JOIN cut_card ON cut_card = card_id 
WHERE name = 'Lefty';

SELECT COUNT(SERVICES.SERVICE_ID) AS "Times Service Booked in the Past", 
       SERVICES.SERVICE_ID AS "Service ID", 
       SERVICES.SERVICE AS "Service Name", 
       SERVICES.COST AS "Service Cost", 
       SERVICES.TYPE AS "Service Type", 
       SERVICES.DIFFICULTY AS "Service Difficulty" 
FROM SERVICES 
JOIN APPOINTMENT ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID 
GROUP BY SERVICES.SERVICE_ID, SERVICES.SERVICE, SERVICES.COST, SERVICES.TYPE, SERVICES.DIFFICULTY 
ORDER BY COUNT(SERVICES.SERVICE_ID) DESC;

SELECT APPOINTMENT_ID, PET_OWNER.NAME AS "CLIENT NAME", EMAIL, COST 
FROM APPOINTMENT  
LEFT JOIN PET_OWNER  
ON APPOINTMENT.CLIENT_ID = PET_OWNER.CLIENT_ID 
LEFT JOIN SERVICES  
ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID;

SELECT ANAME AS "CLIENT",  "NUMBER OF PET(S)", "TOTAL APPOINTMENT(S)"  
FROM 
( 
SELECT PET_OWNER.NAME AS ANAME, COUNT(PET.PET_ID) "NUMBER OF PET(S)" 
FROM PET_OWNER  
LEFT JOIN PET  
ON CLIENT_ID = OWNER_ID 
GROUP BY PET_OWNER.NAME 
)  
 
LEFT JOIN 
( 
SELECT PET_OWNER.NAME AS BNAME, COUNT(APPOINTMENT_ID) "TOTAL APPOINTMENT(S)" 
FROM APPOINTMENT LEFT JOIN PET_OWNER 
ON PET_OWNER.CLIENT_ID = APPOINTMENT.CLIENT_ID 
GROUP BY PET_OWNER.NAME 
)  
 
ON ANAME = BNAME;

SELECT pet.name AS "Pet Name",  
       cut_card.full_groom_notes AS "Full Groom Notes"  
FROM cut_card  
JOIN pet ON cut_card.card_id = pet.cut_card  
JOIN pet_owner ON pet.owner_id = pet_owner.client_id  
WHERE pet_owner.name = 'Linda Martin' 
ORDER BY PET.NAME ASC;

SELECT PET.BREED AS "Breed",  
     COUNT(PET.BREED) AS "Numbers of pets not microchipped or not vaccinated" 
FROM PET 
WHERE PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.MICROCHIPPED = 'No') 
                OR PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.RABIES_VACCINE = 'No')) 
GROUP BY PET.BREED 
ORDER BY PET.BREED ASC;

SELECT P.NAME AS "Pet Name",  
PO.NAME AS "Owner Name",  
PO.PHONE AS "Owner Phone Number",  
PO.EMAIL AS "Owner Email" 
FROM PET P 
JOIN PET_OWNER PO 
ON PO.CLIENT_ID = P.OWNER_ID 
WHERE P.CUT_CARD IN ( 
    SELECT CARD_ID  
    FROM CUT_CARD CC  
    WHERE CC.PREVIOUS_APPOINTMENT_DATE < SYSDATE - 30 
) AND P.PET_ID NOT IN ( 
    SELECT PET_ID 
    FROM APPOINTMENT 
);

SELECT APPOINTMENT.APPOINTMENT_DATE AS "Appointment Date", APPOINTMENT.START_TIME AS "Start Time",  
PET.Name AS "Pet Name",  
PET_OWNER.NAME AS "Owner Name",  
PET_OWNER.PHONE AS "Owner Phone Number", 
PET_OWNER.EMAIL AS "Owner Email" 
FROM APPOINTMENT  
FULL OUTER JOIN PET 
ON APPOINTMENT.PET_ID = PET.PET_ID 
FULL OUTER JOIN PET_OWNER 
ON PET.OWNER_ID = PET_OWNER.CLIENT_ID 
WHERE APPOINTMENT.APPOINTMENT_DATE >= SYSDATE - 1  AND   APPOINTMENT.APPOINTMENT_DATE < SYSDATE + 7 
      ORDER BY "Appointment Date" ASC;

SELECT *  
FROM PET 
MINUS 
SELECT *  
FROM PET 
WHERE PET.WEIGHT >= ( SELECT AVG(PET.WEIGHT) 
                      FROM PET ) 
      OR PET.WEIGHT = (SELECT MIN(PET.WEIGHT) 
                       FROM PET);

SELECT pet_owner.name AS "Owner Name", email, phone, pet.name AS "Pet Name"  
FROM pet  
JOIN pet_owner ON client_id = owner_id  
WHERE EXTRACT(MONTH FROM birthday) = EXTRACT(MONTH FROM SYSDATE)  
    AND EXTRACT(DAY FROM birthday) = EXTRACT(DAY FROM SYSDATE);

Expected: A table containing one tuple that has the name of the pet, and all of the columns from the cut_card schema (excluding card_id). 


SELECT name, full_groom_notes, trim_tidy_notes, bath_brush_notes, nail_clip_notes, previous_appointment_date, previous_service  
FROM pet 
JOIN cut_card ON cut_card = card_id 
WHERE name = 'Lefty';

SELECT COUNT(SERVICES.SERVICE_ID) AS "Times Service Booked in the Past", 
       SERVICES.SERVICE_ID AS "Service ID", 
       SERVICES.SERVICE AS "Service Name", 
       SERVICES.COST AS "Service Cost", 
       SERVICES.TYPE AS "Service Type", 
       SERVICES.DIFFICULTY AS "Service Difficulty" 
FROM SERVICES 
JOIN APPOINTMENT ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID 
GROUP BY SERVICES.SERVICE_ID, SERVICES.SERVICE, SERVICES.COST, SERVICES.TYPE, SERVICES.DIFFICULTY 
ORDER BY COUNT(SERVICES.SERVICE_ID) DESC;

SELECT APPOINTMENT_ID, PET_OWNER.NAME AS "CLIENT NAME", EMAIL, COST 
FROM APPOINTMENT  
LEFT JOIN PET_OWNER  
ON APPOINTMENT.CLIENT_ID = PET_OWNER.CLIENT_ID 
LEFT JOIN SERVICES  
ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID;

SELECT ANAME AS "CLIENT",  "NUMBER OF PET(S)", "TOTAL APPOINTMENT(S)"  
FROM 
( 
SELECT PET_OWNER.NAME AS ANAME, COUNT(PET.PET_ID) "NUMBER OF PET(S)" 
FROM PET_OWNER  
LEFT JOIN PET  
ON CLIENT_ID = OWNER_ID 
GROUP BY PET_OWNER.NAME 
)  
 
LEFT JOIN 
( 
SELECT PET_OWNER.NAME AS BNAME, COUNT(APPOINTMENT_ID) "TOTAL APPOINTMENT(S)" 
FROM APPOINTMENT LEFT JOIN PET_OWNER 
ON PET_OWNER.CLIENT_ID = APPOINTMENT.CLIENT_ID 
GROUP BY PET_OWNER.NAME 
)  
 
ON ANAME = BNAME;

SELECT pet.name AS "Pet Name",  
       cut_card.full_groom_notes AS "Full Groom Notes"  
FROM cut_card  
JOIN pet ON cut_card.card_id = pet.cut_card  
JOIN pet_owner ON pet.owner_id = pet_owner.client_id  
WHERE pet_owner.name = 'Linda Martin' 
ORDER BY PET.NAME ASC;

SELECT PET.BREED AS "Breed",  
     COUNT(PET.BREED) AS "Numbers of pets not microchipped or not vaccinated" 
FROM PET 
WHERE PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.MICROCHIPPED = 'No') 
                OR PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.RABIES_VACCINE = 'No')) 
GROUP BY PET.BREED 
ORDER BY PET.BREED ASC;

SELECT P.NAME AS "Pet Name",  
PO.NAME AS "Owner Name",  
PO.PHONE AS "Owner Phone Number",  
PO.EMAIL AS "Owner Email" 
FROM PET P 
JOIN PET_OWNER PO 
ON PO.CLIENT_ID = P.OWNER_ID 
WHERE P.CUT_CARD IN ( 
    SELECT CARD_ID  
    FROM CUT_CARD CC  
    WHERE CC.PREVIOUS_APPOINTMENT_DATE < SYSDATE - 30 
) AND P.PET_ID NOT IN ( 
    SELECT PET_ID 
    FROM APPOINTMENT 
);

SELECT APPOINTMENT.APPOINTMENT_DATE AS "Appointment Date", APPOINTMENT.START_TIME AS "Start Time",  
PET.Name AS "Pet Name",  
PET_OWNER.NAME AS "Owner Name",  
PET_OWNER.PHONE AS "Owner Phone Number", 
PET_OWNER.EMAIL AS "Owner Email" 
FROM APPOINTMENT  
FULL OUTER JOIN PET 
ON APPOINTMENT.PET_ID = PET.PET_ID 
FULL OUTER JOIN PET_OWNER 
ON PET.OWNER_ID = PET_OWNER.CLIENT_ID 
WHERE APPOINTMENT.APPOINTMENT_DATE >= SYSDATE - 1  AND   APPOINTMENT.APPOINTMENT_DATE < SYSDATE + 7 
      ORDER BY "Appointment Date" ASC;

SELECT *  
FROM PET 
MINUS 
SELECT *  
FROM PET 
WHERE PET.WEIGHT >= ( SELECT AVG(PET.WEIGHT) 
                      FROM PET ) 
      OR PET.WEIGHT = (SELECT MIN(PET.WEIGHT) 
                       FROM PET);

SELECT pet_owner.name AS "Owner Name", email, phone, pet.name AS "Pet Name"  
FROM pet  
JOIN pet_owner ON client_id = owner_id  
WHERE EXTRACT(MONTH FROM birthday) = EXTRACT(MONTH FROM CURRENT_DATE)  
    AND EXTRACT(DAY FROM birthday) = EXTRACT(DAY FROM CURRENT_DATE);

Expected: A table containing one tuple that has the name of the pet, and all of the columns from the cut_card schema (excluding card_id). 


SELECT name, full_groom_notes, trim_tidy_notes, bath_brush_notes, nail_clip_notes, previous_appointment_date, previous_service  
FROM pet 
JOIN cut_card ON cut_card = card_id 
WHERE name = 'Lefty';

SELECT COUNT(SERVICES.SERVICE_ID) AS "Times Service Booked in the Past", 
       SERVICES.SERVICE_ID AS "Service ID", 
       SERVICES.SERVICE AS "Service Name", 
       SERVICES.COST AS "Service Cost", 
       SERVICES.TYPE AS "Service Type", 
       SERVICES.DIFFICULTY AS "Service Difficulty" 
FROM SERVICES 
JOIN APPOINTMENT ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID 
GROUP BY SERVICES.SERVICE_ID, SERVICES.SERVICE, SERVICES.COST, SERVICES.TYPE, SERVICES.DIFFICULTY 
ORDER BY COUNT(SERVICES.SERVICE_ID) DESC;

SELECT APPOINTMENT_ID, PET_OWNER.NAME AS "CLIENT NAME", EMAIL, COST 
FROM APPOINTMENT  
LEFT JOIN PET_OWNER  
ON APPOINTMENT.CLIENT_ID = PET_OWNER.CLIENT_ID 
LEFT JOIN SERVICES  
ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID;

SELECT ANAME AS "CLIENT",  "NUMBER OF PET(S)", "TOTAL APPOINTMENT(S)"  
FROM 
( 
SELECT PET_OWNER.NAME AS ANAME, COUNT(PET.PET_ID) "NUMBER OF PET(S)" 
FROM PET_OWNER  
LEFT JOIN PET  
ON CLIENT_ID = OWNER_ID 
GROUP BY PET_OWNER.NAME 
)  
 
LEFT JOIN 
( 
SELECT PET_OWNER.NAME AS BNAME, COUNT(APPOINTMENT_ID) "TOTAL APPOINTMENT(S)" 
FROM APPOINTMENT LEFT JOIN PET_OWNER 
ON PET_OWNER.CLIENT_ID = APPOINTMENT.CLIENT_ID 
GROUP BY PET_OWNER.NAME 
)  
 
ON ANAME = BNAME;

SELECT pet.name AS "Pet Name",  
       cut_card.full_groom_notes AS "Full Groom Notes"  
FROM cut_card  
JOIN pet ON cut_card.card_id = pet.cut_card  
JOIN pet_owner ON pet.owner_id = pet_owner.client_id  
WHERE pet_owner.name = 'Linda Martin' 
ORDER BY PET.NAME ASC;

SELECT PET.BREED AS "Breed",  
     COUNT(PET.BREED) AS "Numbers of pets not microchipped or not vaccinated" 
FROM PET 
WHERE PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.MICROCHIPPED = 'No') 
                OR PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.RABIES_VACCINE = 'No')) 
GROUP BY PET.BREED 
ORDER BY PET.BREED ASC;

SELECT P.NAME AS "Pet Name",  
PO.NAME AS "Owner Name",  
PO.PHONE AS "Owner Phone Number",  
PO.EMAIL AS "Owner Email" 
FROM PET P 
JOIN PET_OWNER PO 
ON PO.CLIENT_ID = P.OWNER_ID 
WHERE P.CUT_CARD IN ( 
    SELECT CARD_ID  
    FROM CUT_CARD CC  
    WHERE CC.PREVIOUS_APPOINTMENT_DATE < SYSDATE - 30 
) AND P.PET_ID NOT IN ( 
    SELECT PET_ID 
    FROM APPOINTMENT 
);

SELECT APPOINTMENT.APPOINTMENT_DATE AS "Appointment Date", APPOINTMENT.START_TIME AS "Start Time",  
PET.Name AS "Pet Name",  
PET_OWNER.NAME AS "Owner Name",  
PET_OWNER.PHONE AS "Owner Phone Number", 
PET_OWNER.EMAIL AS "Owner Email" 
FROM APPOINTMENT  
FULL OUTER JOIN PET 
ON APPOINTMENT.PET_ID = PET.PET_ID 
FULL OUTER JOIN PET_OWNER 
ON PET.OWNER_ID = PET_OWNER.CLIENT_ID 
WHERE APPOINTMENT.APPOINTMENT_DATE >= SYSDATE - 1  AND   APPOINTMENT.APPOINTMENT_DATE < SYSDATE + 7 
      ORDER BY "Appointment Date" ASC;

SELECT *  
FROM PET 
MINUS 
SELECT *  
FROM PET 
WHERE PET.WEIGHT >= ( SELECT AVG(PET.WEIGHT) 
                      FROM PET ) 
      OR PET.WEIGHT = (SELECT MIN(PET.WEIGHT) 
                       FROM PET);

SELECT pet_owner.name AS "Owner Name", email, phone, pet.name AS "Pet Name"  
FROM pet  
JOIN pet_owner ON client_id = owner_id  
WHERE EXTRACT(MONTH FROM birthday) = EXTRACT(MONTH FROM CURRENT_DATE)  
    AND EXTRACT(DAY FROM birthday) = EXTRACT(DAY FROM CURRENT_DATE);

SELECT name, full_groom_notes, trim_tidy_notes, bath_brush_notes, nail_clip_notes, previous_appointment_date, previous_service  
FROM pet 
JOIN cut_card ON cut_card = card_id 
WHERE name = 'Lefty';

SELECT COUNT(SERVICES.SERVICE_ID) AS "Times Service Booked in the Past", 
       SERVICES.SERVICE_ID AS "Service ID", 
       SERVICES.SERVICE AS "Service Name", 
       SERVICES.COST AS "Service Cost", 
       SERVICES.TYPE AS "Service Type", 
       SERVICES.DIFFICULTY AS "Service Difficulty" 
FROM SERVICES 
JOIN APPOINTMENT ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID 
GROUP BY SERVICES.SERVICE_ID, SERVICES.SERVICE, SERVICES.COST, SERVICES.TYPE, SERVICES.DIFFICULTY 
ORDER BY COUNT(SERVICES.SERVICE_ID) DESC;

SELECT APPOINTMENT_ID, PET_OWNER.NAME AS "CLIENT NAME", EMAIL, COST 
FROM APPOINTMENT  
LEFT JOIN PET_OWNER  
ON APPOINTMENT.CLIENT_ID = PET_OWNER.CLIENT_ID 
LEFT JOIN SERVICES  
ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID;

SELECT ANAME AS "CLIENT",  "NUMBER OF PET(S)", "TOTAL APPOINTMENT(S)"  
FROM 
( 
SELECT PET_OWNER.NAME AS ANAME, COUNT(PET.PET_ID) "NUMBER OF PET(S)" 
FROM PET_OWNER  
LEFT JOIN PET  
ON CLIENT_ID = OWNER_ID 
GROUP BY PET_OWNER.NAME 
)  
 
LEFT JOIN 
( 
SELECT PET_OWNER.NAME AS BNAME, COUNT(APPOINTMENT_ID) "TOTAL APPOINTMENT(S)" 
FROM APPOINTMENT LEFT JOIN PET_OWNER 
ON PET_OWNER.CLIENT_ID = APPOINTMENT.CLIENT_ID 
GROUP BY PET_OWNER.NAME 
)  
 
ON ANAME = BNAME;

SELECT pet.name AS "Pet Name",  
       cut_card.full_groom_notes AS "Full Groom Notes"  
FROM cut_card  
JOIN pet ON cut_card.card_id = pet.cut_card  
JOIN pet_owner ON pet.owner_id = pet_owner.client_id  
WHERE pet_owner.name = 'Linda Martin' 
ORDER BY PET.NAME ASC;

SELECT PET.BREED AS "Breed",  
     COUNT(PET.BREED) AS "Numbers of pets not microchipped or not vaccinated" 
FROM PET 
WHERE PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.MICROCHIPPED = 'No') 
                OR PET.BREED IN (SELECT PET.BREED 
                    FROM PET 
                    WHERE PET.RABIES_VACCINE = 'No') 
GROUP BY PET.BREED 
ORDER BY PET.BREED ASC;

SELECT P.NAME AS "Pet Name",  
PO.NAME AS "Owner Name",  
PO.PHONE AS "Owner Phone Number",  
PO.EMAIL AS "Owner Email" 
FROM PET P 
JOIN PET_OWNER PO 
ON PO.CLIENT_ID = P.OWNER_ID 
WHERE P.CUT_CARD IN ( 
    SELECT CARD_ID  
    FROM CUT_CARD CC  
    WHERE CC.PREVIOUS_APPOINTMENT_DATE < SYSDATE - 30 
) AND P.PET_ID NOT IN ( 
    SELECT PET_ID 
    FROM APPOINTMENT 
);

SELECT APPOINTMENT.APPOINTMENT_DATE AS "Appointment Date", APPOINTMENT.START_TIME AS "Start Time",  
PET.Name AS "Pet Name",  
PET_OWNER.NAME AS "Owner Name",  
PET_OWNER.PHONE AS "Owner Phone Number", 
PET_OWNER.EMAIL AS "Owner Email" 
FROM APPOINTMENT  
FULL OUTER JOIN PET 
ON APPOINTMENT.PET_ID = PET.PET_ID 
FULL OUTER JOIN PET_OWNER 
ON PET.OWNER_ID = PET_OWNER.CLIENT_ID 
WHERE APPOINTMENT.APPOINTMENT_DATE >= SYSDATE - 1  AND   APPOINTMENT.APPOINTMENT_DATE < SYSDATE + 7 
      ORDER BY "Appointment Date" ASC;

SELECT *  
FROM PET 
MINUS 
SELECT *  
FROM PET 
WHERE PET.WEIGHT >= ( SELECT AVG(PET.WEIGHT) 
                      FROM PET ) 
      OR PET.WEIGHT = (SELECT MIN(PET.WEIGHT) 
                       FROM PET);

SELECT pet_owner.name AS "Owner Name", email, phone, pet.name AS "Pet Name"  
FROM pet  
JOIN pet_owner ON client_id = owner_id  
WHERE EXTRACT(MONTH FROM birthday) = EXTRACT(MONTH FROM CURRENT_DATE)  
    AND EXTRACT(DAY FROM birthday) = EXTRACT(DAY FROM CURRENT_DATE);

SELECT name, full_groom_notes, trim_tidy_notes, bath_brush_notes, nail_clip_notes, previous_appointment_date, previous_service  
FROM pet 
JOIN cut_card ON cut_card = card_id 
WHERE name = 'Lefty';

SELECT COUNT(SERVICES.SERVICE_ID) AS "Times Service Booked in the Past", 
       SERVICES.SERVICE_ID AS "Service ID", 
       SERVICES.SERVICE AS "Service Name", 
       SERVICES.COST AS "Service Cost", 
       SERVICES.TYPE AS "Service Type", 
       SERVICES.DIFFICULTY AS "Service Difficulty" 
FROM SERVICES 
JOIN APPOINTMENT ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID 
GROUP BY SERVICES.SERVICE_ID, SERVICES.SERVICE, SERVICES.COST, SERVICES.TYPE, SERVICES.DIFFICULTY 
ORDER BY COUNT(SERVICES.SERVICE_ID) DESC;

SELECT APPOINTMENT_ID, PET_OWNER.NAME AS "CLIENT NAME", EMAIL, COST 
FROM APPOINTMENT  
LEFT JOIN PET_OWNER  
ON APPOINTMENT.CLIENT_ID = PET_OWNER.CLIENT_ID 
LEFT JOIN SERVICES  
ON APPOINTMENT.SERVICE_ID = SERVICES.SERVICE_ID;

SELECT ANAME AS "CLIENT",  "NUMBER OF PET(S)", "TOTAL APPOINTMENT(S)"  
FROM 
( 
SELECT PET_OWNER.NAME AS ANAME, COUNT(PET.PET_ID) "NUMBER OF PET(S)" 
FROM PET_OWNER  
LEFT JOIN PET  
ON CLIENT_ID = OWNER_ID 
GROUP BY PET_OWNER.NAME 
)  
 
LEFT JOIN 
( 
SELECT PET_OWNER.NAME AS BNAME, COUNT(APPOINTMENT_ID) "TOTAL APPOINTMENT(S)" 
FROM APPOINTMENT LEFT JOIN PET_OWNER 
ON PET_OWNER.CLIENT_ID = APPOINTMENT.CLIENT_ID 
GROUP BY PET_OWNER.NAME 
)  
 
ON ANAME = BNAME;

