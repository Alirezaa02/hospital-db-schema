# Task 2
#Part a
#CREATE DATABASE HospitalDB;
USE HospitalDB;

#Part b
/* creating Doctor Table */
CREATE TABLE Doctor (
	employeeID INT PRIMARY KEY,
    aphraRegNo VARCHAR(20) UNIQUE,
    employeeName VARCHAR(50),
    specialisation VARCHAR(100)
);

/* creating patient Table */
CREATE TABLE Patient (
  patient_id INT PRIMARY KEY,
  firstname VARCHAR(50),
  surname VARCHAR(50),
  dateOfBirth date,
  gender ENUM('Female', 'Male'),
  patientAddress VARCHAR(255),
  phoneNo VARCHAR(15) CHECK (phoneNo REGEXP '^[0-9]+$'),
  emailAddress VARCHAR(100),
  attendingDoctor INT,
  FOREIGN KEY (attendingDoctor) REFERENCES Doctor(employeeID)
);

/* creating Appointment Table */
CREATE TABLE Appointment(
	Patient_id INT,
    doctor_id INT,
    appointmentTime DATETIME,
    PRIMARY KEY (Patient_id, doctor_id, appointmentTime),
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(employeeID)
);

/* creating Medication Table */
CREATE TABLE Medication ( 
	medication_id INT PRIMARY KEY,
    medicationName VARCHAR(100),
    dosage VARCHAR(50),
    dispensation ENUM('over the counter','prescription only')
);
/* creating Prescription Table */
CREATE TABLE Prescription (
	prescription_id INT PRIMARY KEY,
    prescribedTo INT,
    prescribedBy INT,
    medication_id INT,
    administrationFrequency VARCHAR(50),
    totalRepeats INT CHECK (totalRepeats BETWEEN 0 AND 5),
    remainingRepeats INT CHECK (remainingRepeats BETWEEN 0 AND 5),
    FOREIGN KEY (prescribedTo) REFERENCES Patient(Patient_id),
    FOREIGN KEY (prescribedBy) REFERENCES Doctor(employeeID),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)

);

#Part C
CREATE VIEW Pation_medicationView AS
SELECT
	p.patient_id,
    p.firstname,
    p.surname,
    pr.prescription_id,
    m.medicationName,
    m.dosage,
    m.dispensation,
    pr.administrationFrequency,
    pr.totalRepeats,
    pr.remainingRepeats
FROM
    Patient p
JOIN
    Prescription pr ON p.patient_id = pr.prescribedTo
JOIN
    Medication m ON pr.medication_id = m.medication_id;

#Part d
/* Doctor Table */
INSERT INTO Doctor (employeeID, aphraRegNo, employeeName,specialisation)
VALUES (1,'Ali02', 'Dr.Ali','pathology');

/* Patient Table */
INSERT INTO Patient (patien_id, firstname, surname, dateOfBirth, gender, patientAddress, phoneNo, emailAddress, attendingDoctor)
VALUES (23,'Sam', 'Evans','1988-05-05', 'Male','2 elizabeth st', '0424367852', 'sam.evans@gmail.com', 1);

/* Medication Table*/
INSERT INTO Medication (medication_id, medicationName, dosage, dispensation)
VALUES (210, 'panadol', '200mg', 'prescription only');

/* Prescription Table*/
INSERT INTO Prescription (prescription_id, prescribedTo, prescribedBy, medication_id, administrationFrequency, totalRepeats, remainingRepeats)
VALUES (1124,23, 1, 210, 'Twice a day', 2, 1);

/* Appointment Table*/
INSERT INTO Appointment (Patient_id, doctor_id, appointmentTime)
VALUES (23,1,'2025-06-06 06:06:00');

#Part e
-- Violates PRIMARY KEY: employeeID 1 already exists
INSERT INTO Doctor (employeeID, aphraRegNo, employeeName, specialisation)
VALUES (1, 'Ali03', 'Dr. ReAli', 'psychology');

-- Violates FOREIGN KEY: Doctor ID 999 does not exist
INSERT INTO Patient (patient_id, firstname, surname, dateOfBirth, gender, patientAddress, phoneNo, emailAddress, attendingDoctor)
VALUES (24, 'Alex', 'Ghost', '1991-09-01', 'Male', '404 Nowhere St', '0444234765', 'alex.ghost@gmail.com', 999);

-- Violates UNIQUE constraint: aphraRegNo 'Ali02' already exists
INSERT INTO Doctor (employeeID, aphraRegNo, employeeName, specialisation)
VALUES (2, 'Ali02', 'Dr. Duplicate', 'Neurology');

#Part f
CREATE ROLE administrator;
CREATE ROLE pharmacist;
CREATE ROLE receptionist;
CREATE ROLE doctor;

/* Grant Privileges to Each Role*/
#dministrator – Full Access
GRANT ALL PRIVILEGES ON HospitalDB.* TO administrator;

# Receptionist – Update Patient, Doctor, and Medication Info
GRANT SELECT, UPDATE ON HospitalDB.Patient TO receptionist;
GRANT SELECT, UPDATE ON HospitalDB.Doctor TO receptionist;
GRANT SELECT, UPDATE ON HospitalDB.Medication TO receptionist;

#Doctor – View Patient & Medication, Manage Prescriptions, Update Own Info
GRANT SELECT ON HospitalDB.Patient TO doctor;
GRANT SELECT ON HospitalDB.Medication TO doctor;
GRANT INSERT, DELETE ON HospitalDB.Prescription TO doctor;
GRANT UPDATE ON HospitalDB.Doctor TO doctor;

#Pharmacist – Add/Update Medication & Prescriptions, View Patients
GRANT SELECT ON HospitalDB.Patient TO pharmacist;
GRANT INSERT, UPDATE ON HospitalDB.Medication TO pharmacist;
GRANT INSERT, UPDATE ON HospitalDB.Prescription TO pharmacist;

#Part g
-- Revoke access to Medication table from receptionist
REVOKE SELECT, UPDATE ON HospitalDB.Medication FROM receptionist;

-- Revoke access to Prescription table from receptionist 
REVOKE SELECT, INSERT, UPDATE, DELETE ON HospitalDB.Prescription FROM receptionist;











