CREATE DATABASE COVID_Centre_New;
USE COVID_Centre_New;
DROP DATABASE COVID_Centre_New;

#TABLE 1
CREATE TABLE DOCTOR(
MBBS_No VARCHAR(20) NOT NULL,
D_fName VARCHAR(50) NOT NULL,
D_lName VARCHAR(50) NOT NULL,
Age int NOT NULL,
Gender VARCHAR(8),
District VARCHAR(30),
City VARCHAR(30) NOT NULL,
Street VARCHAR(100),
Ward_No VARCHAR(5),
Phone_No VARCHAR(10) NOT NULL,
Specialization VARCHAR(100),
Qualification VARCHAR(100),
Doctor_ID VARCHAR(20),
PRIMARY KEY(MBBS_No),
FOREIGN KEY(Doctor_ID) REFERENCES DOCTOR(MBBS_No) ON DELETE SET NULL,
FOREIGN KEY(Ward_No) REFERENCES WARD(Ward_No) ON DELETE SET NULL
);

#TABLE 2
CREATE TABLE NURSE(
Nurse_ID VARCHAR(20) NOT NULL,
N_fName VARCHAR(50) NOT NULL,
N_lName VARCHAR(50) NOT NULL,
Age int NOT NULL,
Gender VARCHAR(8),
District VARCHAR(30),
City VARCHAR(30) NOT NULL,
Street VARCHAR(100),
Designation VARCHAR(50),
Ward_No VARCHAR(5),
Phone_No VARCHAR(10) NOT NULL,
PRIMARY KEY(Nurse_ID),
FOREIGN KEY(Ward_No) REFERENCES WARD(Ward_No) 
ON DELETE SET NULL
);

#TABLE 3
CREATE TABLE LABOUR(
Labour_ID VARCHAR(20) NOT NULL,
L_fName VARCHAR(50) NOT NULL,
L_lName VARCHAR(50) NOT NULL,
Age int NOT NULL,
Gender VARCHAR(8),
District VARCHAR(30),
City VARCHAR(30) NOT NULL,
Street VARCHAR(100),
Shipt VARCHAR(50),
Designation VARCHAR(50),
Ward_No VARCHAR(5),
Phone_No VARCHAR(10) NOT NULL,
PRIMARY KEY(Labour_ID),
FOREIGN KEY(Ward_No) REFERENCES WARD(Ward_No)
ON DELETE SET NULL
);

#TABLE 4
CREATE TABLE WARD(
Ward_No VARCHAR(5) NOT NULL,
Capacity int NOT NULL,
NumOfPatients int NOT NULL,
Word_phoneNo VARCHAR(10),
PRIMARY KEY(Ward_No)
);

#TABLE 5
CREATE TABLE COVID_REPORT(
Report_ID VARCHAR(5) NOT NULL,
Patient_fName VARCHAR(50) NOT NULL,
Patient_lName VARCHAR(50) NOT NULL,
Covid_type VARCHAR(50) NOT NULL,
Doctor_ID VARCHAR(20),
Age int,
Additional_Ilness varchar(50),
PRIMARY KEY(Report_ID),
FOREIGN KEY(Doctor_ID) REFERENCES DOCTOR(MBBS_No) ON DELETE SET NULL
);

#TABLE 6
CREATE TABLE MEDICINE(
Medicine_ID VARCHAR(50) NOT NULL,
Generic_name VARCHAR(70) NOT NULL,
Purpose VARCHAR(200) NOT NULL,
Stock VARCHAR(10) NOT NULL,
PRIMARY KEY(Medicine_ID)
);

#TABLE 7
CREATE TABLE AMBULANCE(
Amb_ID VARCHAR(20) NOT NULL,
Amb_No VARCHAR(10) NOT NULL,
Capacity INT NOT NULL,
PRIMARY KEY(Amb_ID)
);

#TABLE 8
CREATE TABLE ICU(
ICU_ID VARCHAR(20) NOT NULL,
NumOfPatients int,
Doctor_InCharge VARCHAR(20) NOT NULL,
PRIMARY KEY(ICU_ID)
);

#TABLE 9
CREATE TABLE PATIENT(
Patient_ID VARCHAR(10) NOT NULL,
P_fName VARCHAR(50) NOT NULL,
P_lName VARCHAR(50) NOT NULL,
Age int NOT NULL,
Gender VARCHAR(8),
District VARCHAR(30),
City VARCHAR(30) NOT NULL,
Street VARCHAR(100),
Joined_time TIME NOT NULL,
Joined_date DATE NOT NULL,

Ward_No VARCHAR(5),
Amb_ID VARCHAR(20),
ICU_ID VARCHAR(20),

PRIMARY KEY(Patient_ID),
FOREIGN KEY(Ward_No) REFERENCES WARD(Ward_No) ON DELETE SET NULL,
FOREIGN KEY(Amb_ID) REFERENCES AMBULANCE(Amb_ID) ON DELETE SET NULL,
FOREIGN KEY(ICU_ID) REFERENCES ICU(ICU_ID) ON DELETE SET NULL
);

#TABLE 10
CREATE TABLE VACCINE(
Vaccine_ID VARCHAR(20) NOT NULL,
V_Type VARCHAR(20) NOT NULL,
V_Quality VARCHAR(50) NOT NULL,
LotsExpireDate DATE DEFAULT '2020-01-01',
PRIMARY KEY(Vaccine_ID)
);

#TABLE 11
CREATE TABLE RECIEVED_VACCINE(
Patient_ID VARCHAR(10) NOT NULL,
Vaccine_ID VARCHAR(20) NOT NULL,
VaccinatedDate DATE,
Dose VARCHAR(20),
PRIMARY KEY(Patient_ID, Vaccine_ID),
FOREIGN KEY(Patient_ID) REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE,
FOREIGN KEY(Vaccine_ID) REFERENCES VACCINE(Vaccine_ID) ON DELETE CASCADE
);

#TABLE 12
CREATE TABLE CONTRACT_LIST(
Patient_ID VARCHAR(10) NOT NULL,
C_fName VARCHAR(50) NOT NULL,
C_lName VARCHAR(50) NOT NULL,
C_Date DATE,
Residence VARCHAR(100) NOT NULL,
ContractType VARCHAR(20),
Relationship VARCHAR(50),
PRIMARY KEY(Patient_ID, C_fName, C_lName, C_Date),
FOREIGN KEY(Patient_ID) REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE
);

#TABLE 13
CREATE TABLE ILLNESS_INFORMATION(
Patient_ID VARCHAR(10) NOT NULL,
Symptoms_Name VARCHAR(50) NOT NULL,
Record_Date DATE,
Period VARCHAR(30),
Data_encored VARCHAR(20) NOT NULL,
Encorded_By VARCHAR(20) NOT NULL,
PRIMARY KEY(Patient_ID, Symptoms_Name),
FOREIGN KEY(Patient_ID) REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE
);

#TABLE 14
CREATE TABLE ADMIT_INFORMATION(
Patient_ID VARCHAR(10) NOT NULL,
Admit_name VARCHAR(20) NOT NULL,
Admit_temp VARCHAR(10),
Covid_Status BOOLEAN DEFAULT 0,
Admit_Symptoms_1 VARCHAR(100),
Admit_Symptoms_2 VARCHAR(100),
PRIMARY KEY(Patient_ID, Admit_name),
FOREIGN KEY(Patient_ID) REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE
);

#TABLE 15
CREATE TABLE CHECKED_BY(
Doctor_ID VARCHAR(20) NOT NULL,
Patient_ID VARCHAR(10) NOT NULL,
Checked_Date DATE NOT NULL,
PRIMARY KEY(Doctor_ID, Patient_ID),
FOREIGN KEY(Doctor_ID) REFERENCES DOCTOR(MBBS_No) ON DELETE CASCADE,
FOREIGN KEY(Patient_ID) REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE
);

#TABLE 16
CREATE TABLE TREATED_BY(
Nurse_ID VARCHAR(20) NOT NULL,
Patient_ID VARCHAR(10) NOT NULL,
Treated_Date DATE NOT NULL,
PRIMARY KEY(Nurse_ID, Patient_ID),
FOREIGN KEY(Nurse_ID) REFERENCES NURSE(Nurse_ID) ON DELETE CASCADE,
FOREIGN KEY(Patient_ID) REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE
);

#TABLE 17
CREATE TABLE GET_MEDICINE(
Patient_ID VARCHAR(10) NOT NULL,
Medicine_ID VARCHAR(50) NOT NULL,
PRIMARY KEY(Patient_ID, Medicine_ID),
FOREIGN KEY(Patient_ID) REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE,
FOREIGN KEY(Medicine_ID) REFERENCES MEDICINE(Medicine_ID) ON DELETE CASCADE
);

#TABLE 18
CREATE TABLE DISCHARGE_INFORMATION(
Patient_ID VARCHAR(10) NOT NULL,
Discharge_Date DATE NOT NULL,
Discharge_Temp VARCHAR(10),
Covid_Status BOOLEAN DEFAULT 0,
PRIMARY KEY(Patient_ID, Discharge_Date),
FOREIGN KEY(Patient_ID) REFERENCES PATIENT(Patient_ID) ON DELETE CASCADE
);

DROP TABLE GET_MEDICINE;
TRUNCATE TABLE admit_information;
INSERT INTO PATIENT VALUES ('P1000','Nimal','Lakshitha',28,'Male','Kandy','Katugasthota','Mavilmada road','12:20:10','2019-11-08');
SELECT * FROM PATIENT;

USE COVID_Centre_New;

##TABLE 1
/*       word        */
INSERT INTO WARD VALUES ('A10',100,78,'0552324564');
INSERT INTO WARD VALUES ('A11',150,43,'0552244446');
INSERT INTO WARD VALUES ('A12',75,50,'0554488332');
INSERT INTO WARD VALUES ('A13',140,108,'0554453002');
INSERT INTO WARD VALUES ('A14',120,75,'0555684571');
INSERT INTO WARD VALUES ('A15',145,99,'0554885992');

##TABLE 2
/*       medicine       */
INSERT INTO MEDICINE VALUES ('P01','PARACETAMOL','Fever','10 Box');
INSERT INTO MEDICINE VALUES ('P02','Vitamin C','Protect Cells against effect of Redicals','15 Box');
INSERT INTO MEDICINE VALUES ('P03','Zincovit','Diagnosis','100 Box');
INSERT INTO MEDICINE VALUES ('P04','Easibreath','clears blocked nose','150 Box');
INSERT INTO MEDICINE VALUES ('P05','Azithromycin','treat for bacteria','120 Box');

##TABLE 3
/*       Nurse      */
INSERT INTO NURSE VALUES ('N01','Nimali','Kusum',24,'Female','Badulla','Lunugala','Madakalapu Road','Licensed Vocational Nurse','A11','0766121718');
INSERT INTO NURSE VALUES ('N02','Kasun','Chamith',25,'Male','Galle','Hapugala','Wakwella Road','Registered Nurse','A11','0764857542');
INSERT INTO NURSE VALUES ('N03','Sadunika','Rathnayke',55,'Female','Badulla','Rabarwaththe','Kalubowila Road','Licensed Vocational Nurse','A10','0786721717');
INSERT INTO NURSE VALUES ('N04','Narmada','Charuni',26,'Female','Monaragala','Medagama','Bibila Road','Practice Registered Nurse','A14','0766585818');
INSERT INTO NURSE VALUES ('N05','Nikini','Maduwanthi',24,'Female','Badulla','Mahiyanganaya','Dehiaththakandiya Road','Practice Registered Nurse','A13','0761215408');
INSERT INTO NURSE VALUES ('N06','Sulochana','Nawarathne',24,'Female','Kandy','Pallekale','Mahiyanganya Road','Licensed Vocational Nurse','A15','0774153677');

##TABLE 4
/*       Labour      */
INSERT INTO LABOUR VALUES ('L01','Dilhara','Fernando',42,'Male','Kaluthara','Mathugama','Mathugama Road','8:00 am to 5:00 pm','Gardening Cleaner',NULL,'0768121714');
INSERT INTO LABOUR VALUES ('L02','Kanchana','Weerashinhe',30,'Male','Matara','Kaburugamuwa','Hospital Road','12:00 pm to 9:00 pm','Cooker',NULL,'0754874744');
INSERT INTO LABOUR VALUES ('L03','Thihara','Neyon',28,'Male','Kegall','Alawathura','Alawathura Road','5:00 pm to 6:00 am','Ward Cleaner','A10','0748121719');
INSERT INTO LABOUR VALUES ('L04','Lakru','Fernando',55,'Male','Badulla','Pinarawa','Bandarawela Road','10:00 am to 3:00 pm','Food Supplier',NULL,'0762121316');

##TABLE 5
/*       DOCTOR      */
INSERT INTO DOCTOR VALUES ('MB001','Wimalasena','Kariwasam',55,'Male','Galle','Wakwella','Wakwella Road','A15','0764568525','Cardiologist','Surgery',NULL);
INSERT INTO DOCTOR VALUES ('MB002','Dilukshan','Ravichandra',30,'Male','Badulla','Haputhale','Liptonseat Road','A11','0757443046','Pulmonologist','Emergency Medicine','MB001');
INSERT INTO DOCTOR VALUES ('MB003','Akanayake','De Silva',60,'Male','Matara','Wallasmulla','Embilipitiya Road','A12','0764568806','Otolaryngologist','Psychiatry','MB001');
INSERT INTO DOCTOR VALUES ('MB004','Keshar','Kavinda',40,'Male','Nuwara Eliya','Gegary Park','Welimada Road','A13','0762563595','Nephrologist','Pathology',NULL);

##TABLE 6
/*       Covid Report      */
INSERT INTO COVID_REPORT VALUES ('RE001','Naveen','Hasaranga','Delta','MB003',27,'Heart patient');
INSERT INTO COVID_REPORT VALUES ('RE002','Oshan','Idunil','Omicron','MB004',34,'Lung Diseases');
INSERT INTO COVID_REPORT VALUES ('RE003','Dayan','Sanjeewa','Beta','MB002',56,'Diabetes');
INSERT INTO COVID_REPORT VALUES ('RE004','Dilshan','Sandaruwan','Alpha','MB001',23, 'veez');
INSERT INTO COVID_REPORT VALUES ('RE005','Sumathipala','Nandasena','Delta','MB003',63, NULL);

##TABLE 7
/*      Ambulence   */
INSERT INTO AMBULANCE VALUES ('AM001','CD-4200',2);
INSERT INTO AMBULANCE VALUES ('AM002','MS-5342',2);
INSERT INTO AMBULANCE VALUES ('AM003','ZX-2212',3);
INSERT INTO AMBULANCE VALUES ('AM004','DC-47896',1);

##TABLE 8
/*      Vaccine   */
INSERT INTO VACCINE VALUES ('SIN001','SINOPHARM','Grade A','2023-04-01');
INSERT INTO VACCINE VALUES ('SIN002','SINOPHARM','Grade B','2023-06-01');
INSERT INTO VACCINE VALUES ('SIN003','SINOPHARM','Grade A','2023-05-01');
INSERT INTO VACCINE VALUES ('PFI001','Pfizer','Grade A','2023-04-01');
INSERT INTO VACCINE VALUES ('PFI002','Pfizer','Grade B','2023-03-01');
INSERT INTO VACCINE VALUES ('SPU001','SputnikV','Grade A','2023-06-01');

##TABLE 9
/*      ICU  */
INSERT INTO ICU VALUES ('ICU001',2,'MB002');
INSERT INTO ICU VALUES ('ICU002',1,'MB005');
INSERT INTO ICU VALUES ('ICU003',2,'MB001');

##TABLE 10
/*       patient      */
INSERT INTO PATIENT VALUES ('P001', 'Naveen', 'Hasaranga', 27, 'Male', 'Kaluthara', 'Aluthgama', 'Aluthgama Road','12:46:56','2021-07-09','A12', 'AM003','ICU003' );
INSERT INTO PATIENT VALUES ('P002', 'Oshan', 'Idunil', 34, 'Male', 'Galle', 'Unawatuna', 'Galle Road','10:20:00','2021-09-02','A10', NULL, NULL);
INSERT INTO PATIENT VALUES ('P003', 'Dayan', 'Sanjeewa', 56, 'Male', 'Colombo', 'Rajagiriya', 'Sri Jayawardeepura Mawatha ','14:46:20','2021-12-17','A15', NULL, NULL);
INSERT INTO PATIENT VALUES ('P004', 'Dilshan', 'Sandaruwan', 23, 'Male', 'Kaluthara', 'Aluthgama', 'Aluthgama Road','15:46:56','2022-01-10','A15', NULL, NULL);
INSERT INTO PATIENT VALUES ('P005', 'Sumathipala', 'Nandasena', 63, 'Male', 'Gampaha', 'Yakkala', 'Ja Ela-Ekala_Gampaha-Yakkala Hwy','08:46:56','2022-01-19','A12', NULL, NULL);
INSERT INTO PATIENT VALUES ('P006', 'Kalhara', 'Chamath', 24, 'Male', 'Kaluthara', 'Aluthgama', 'Aluthgama Road','08:46:56','2022-01-27','A12', NULL, NULL);
INSERT INTO PATIENT VALUES ('P007', 'Sanoj', 'Rashantha', 44, 'Male', 'Badulla', 'Bandarawela', 'Ambegoda Road','10:46:56','2022-01-30','A10', NULL, 'ICU001');
INSERT INTO PATIENT VALUES ('P008', 'Dilhani', 'Bandara', 24, 'Female', 'Monaragala', 'Wellawaya', 'Thanamalvila Road','03:00:56','2022-02-17','A13', NULL,'ICU001');
INSERT INTO PATIENT VALUES ('P009', 'Menuka', 'Nayanajith', 14, 'Male', 'Monaragala', 'Nannapurawa', 'Bibila Road','02:00:56','2022-04-10','A14', 'AM001','ICU002');
INSERT INTO PATIENT VALUES ('P010', 'Kalpa', 'Bandara', 84, 'Male', 'Kandy', 'Digana', 'Digana Road','12:00:56','2022-04-17','A15', NULL,NULL);
INSERT INTO PATIENT VALUES ('P011', 'Lalitha', 'Kumari', 74, 'Female', 'Monaragala', 'Dodamgolla', 'Nakkala Road','11:00:56','2022-04-21','A11', NULL,'ICU003');

##TABLE 11
/*       RECIEVED_VACCINE      */
INSERT INTO RECIEVED_VACCINE VALUES ('P002','SIN001','2022-01-05','1nd Dose');
INSERT INTO RECIEVED_VACCINE VALUES ('P003','SIN001','2021-09-23','2nd Dose');
INSERT INTO RECIEVED_VACCINE VALUES ('P005','PFI001','2022-02-15','Booster');
INSERT INTO RECIEVED_VACCINE VALUES ('P010','SPU001','2022-02-04','3nd Dose');
 
 ##TABLE 12
 /*       CONTRACT LIST     */
INSERT INTO CONTRACT_LIST VALUES ('P002','Miyusara','Ravinath','2021-09-01','Galle','1st contract','Friend');
INSERT INTO CONTRACT_LIST VALUES ('P002','Pradeep','Sandruwan','2021-09-01','Galle','1st contract','Friend');
INSERT INTO CONTRACT_LIST VALUES ('P002','Geeth','Madushan','2021-09-01','Galle','1st contract','Friend');
INSERT INTO CONTRACT_LIST VALUES ('P009','Saman','Prasanna','2022-04-07','Monaragala','2st contract','Cousin');
INSERT INTO CONTRACT_LIST VALUES ('P010','Ariyadasa','Senevirathne','2021-04-11','Anuradapuraya','1st contract',NULL);

 ##TABLE 13
 /*     ADMIT_INFORMATION    */
INSERT INTO ADMIT_INFORMATION VALUES ('P001', 'Naveen', '39',1, 'Caugh','Fever');
INSERT INTO ADMIT_INFORMATION VALUES ('P002', 'Oshan', '37',0, 'Breathing Difficulty','FeVER');
INSERT INTO ADMIT_INFORMATION VALUES ('P003', 'Dayan', '35',0, 'Shivering',NULL);
INSERT INTO ADMIT_INFORMATION VALUES ('P004', 'Dilshan', '40',0, 'Caugh','FeVER');
INSERT INTO ADMIT_INFORMATION VALUES ('P005', 'Sumathipala', '41',0, 'Caugh',NULL);
INSERT INTO ADMIT_INFORMATION VALUES ('P006', 'Kalhara', '39',0, 'Caugh','FeVER');
INSERT INTO ADMIT_INFORMATION VALUES ('P007', 'Sanoj', '38',1, 'Fever',NULL);
INSERT INTO ADMIT_INFORMATION VALUES ('P008', 'Dilhani', '39',1, 'Caugh','Fever');
INSERT INTO ADMIT_INFORMATION VALUES ('P009', 'Menuka', '29',1, 'Caugh','Fever');
INSERT INTO ADMIT_INFORMATION VALUES ('P010', 'Kalpa', '33',0, 'Caugh',NULL);
INSERT INTO ADMIT_INFORMATION VALUES ('P011', 'Lalitha', '32',1, 'Caugh','Fever');

 ##TABLE 14
 /*     CHECKED_BY    */
INSERT INTO CHECKED_BY VALUES ('MB001','P004','2022-01-11');
INSERT INTO CHECKED_BY VALUES ('MB003','P007','2022-02-01');
INSERT INTO CHECKED_BY VALUES ('MB004','P010','2022-04-18');

 ##TABLE 15
 /*     TREATED_BY    */
INSERT INTO TREATED_BY VALUES ('N03','P002','2021-09-02');
INSERT INTO TREATED_BY VALUES ('N03','P010','2022-04-17');
INSERT INTO TREATED_BY VALUES ('N05','P011','2022-04-22');

 ##TABLE 16
 /*   DISCHARGE_INFORMATION   */
INSERT INTO DISCHARGE_INFORMATION VALUES ('P001', '2021-08-01', '30',0);
INSERT INTO DISCHARGE_INFORMATION VALUES ('P005', '2022-02-01', '32',0);
INSERT INTO DISCHARGE_INFORMATION VALUES ('P006', '2022-02-05', '29',0);

 ##TABLE 17
 /*     ILLNESS_INFORMATION  */
INSERT INTO ILLNESS_INFORMATION VALUES ('P001', 'Caugh', '2021-07-09','22 days','00/22/05','MB001');
INSERT INTO ILLNESS_INFORMATION VALUES ('P005', 'Caugh', '2022-01-19','12 days','00/22/06','MB004');
INSERT INTO ILLNESS_INFORMATION VALUES ('P006', 'Caugh', '2022-01-27','09 days','00/22/05','MB007');

# ******************************************************** #

SELECT * FROM patient WHERE year(Joined_date) = '2022';
SELECT AVG(Age) FROM patient;
SELECT P_fName FROM patient WHERE ICU_ID IS NOT NULL;

# ***********  UPDATE PATIENT TABLE AND IT'S RESULT ************* #

UPDATE patient
SET Age = 65
WHERE patient_ID = "P002";

UPDATE NURSE
SET Nurse_ID = 'N05'
WHERE Nurse_ID = "N10";

DELETE FROM PATIENT WHERE Patient_ID = 'P004';

DELETE FROM ICU WHERE ICU_ID='ICU001';

UPDATE patient
SET ICU_ID = 'ICU001'
WHERE Patient_ID = 'P008';

SELECT Patient_ID AS P_ID, Age+5 AS New_Age, City As Current_city FROM patient WHERE Ward_No='A10';

SELECT * FROM NURSE WHERE Designation like '%Registered%';


CREATE VIEW view01 as SELECT * FROM patient NATURAL JOIN icu;

SELECT * FROM doctor CROSS JOIN ward;

SELECT GENDER, COUNT(patient_ID), AVG(AGE) FROM patient GROUP BY GENDER;

(SELECT P.Patient_ID, P.Gender, P.District FROM patient AS P LEFT OUTER JOIN admit_information AS AD ON P.Patient_ID = AD.Patient_ID)
UNION 
(SELECT P.Patient_ID, P.Gender, P.District FROM patient AS P RIGHT OUTER JOIN admit_information AS AD ON P.Patient_ID = AD.Patient_ID);

SELECT DISTINCT P.patient_ID, DI.patient_ID, P.Age FROM patient AS P INNER JOIN discharge_information AS DI ON P.patient_ID =DI.patient_ID;

SELECT P.patient_ID, DI.patient_ID, P.Age FROM patient AS P LEFT JOIN discharge_information AS DI ON P.patient_ID =DI.patient_ID
WHERE P.Patient_ID IS  NULL;

(SELECT P.Patient_ID, P.Gender, P.District FROM patient AS P RIGHT OUTER JOIN admit_information AS AD ON P.Patient_ID = AD.Patient_ID);



SELECT * FROM recieved_vaccine AS R NATURAL JOIN admit_information AS A;

SELECT P.patient_ID, P.P_fName FROM patient AS P NATURAL JOIN admit_information WHERE P.Patient_ID IN(SELECT P.Patient_ID FROM patient as P WHERE (P.Age>31));

SELECT P.patient_ID AS P_ID FROM patient AS P WHERE P.District='Galle' AND P.Patient_ID IN (SELECT C.patient_ID FROM  contract_list AS C where C.C_fname='Oshan');



(SELECT* from patient AS P
RIGHT OUTER JOIN discharge_information AS D
ON P.Patient_ID = D.Patient_ID)
UNION
(SELECT* from patient AS P
LEFT OUTER JOIN discharge_information AS D
ON P.Patient_ID = D.Patient_ID);


-- outer union 
SELECT * FROM PATIENT;
SELECT * FROM admit_information;
CREATE VIEW VIW1 as ((SELECT * FROM patient as P NATURAL JOIN admit_information  as A) 
UNION
(SELECT* FROM patient));

SELECT * FROM VIW1;


create index Ind_Cit on Doctor(City);
SELECT * from VIW1 LEFT JOIN admit_information using(Patient_ID) where admit_information.Patient_ID is  NULL;


SELECT D.D_fName,D.Gender from doctor as D
where Age>all(select D.Age FROM doctor AS D where D.Age IN (30));

drop index Ind_Pat on patient;
create index Ind_Pat on patient(Patient_ID);

create index Ind_Nur on nurse(N_fName);

create index Ind_Lab on labour(Street);

create index Ind_Doc on doctor(Age);


explain(SELECT P.Patient_ID, P.Gender, P.District FROM patient AS P LEFT OUTER JOIN admit_information AS AD ON P.Patient_ID = AD.Patient_ID)
UNION 
(SELECT P.Patient_ID, P.Gender, P.District FROM patient AS P RIGHT OUTER JOIN admit_information AS AD ON P.Patient_ID = AD.Patient_ID);


EXPLAIN(SELECT DISTINCT P.patient_ID, DI.patient_ID, P.Age FROM patient AS P INNER JOIN discharge_information AS DI ON P.patient_ID =DI.patient_ID);


explain(SELECT DISTINCT P.patient_ID, DI.patient_ID, P.Age FROM patient AS P INNER JOIN discharge_information AS DI ON P.patient_ID =DI.patient_ID);


