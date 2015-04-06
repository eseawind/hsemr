-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 08, 2015 at 11:40 AM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `nphsemr`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `adminID` varchar(20) NOT NULL,
  `adminPassword` varchar(20) NOT NULL,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminID`, `adminPassword`) VALUES
('admin1', 'admin1'),
('admin2', 'admin2');

-- --------------------------------------------------------

--
-- Table structure for table `allergy_patient`
--

CREATE TABLE IF NOT EXISTS `allergy_patient` (
  `patientNRIC` varchar(10) NOT NULL,
  `allergy` varchar(100) NOT NULL,
  PRIMARY KEY (`patientNRIC`,`allergy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `allergy_patient`
--

INSERT INTO `allergy_patient` (`patientNRIC`, `allergy`) VALUES
('S3925683C', 'No drug allergy'),
('S4897583E', 'No drug allergy'),
('S5412345F', 'Penicillin'),
('S5903259B', 'No drug allergy'),
('S6901328A', 'No drug allergy'),
('S9136572D', 'No drug allergy');

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE IF NOT EXISTS `document` (
  `consentDatetime` datetime NOT NULL,
  `consentName` varchar(100) NOT NULL,
  `consentFile` varchar(200) NOT NULL,
  `consentStatus` tinyint(1) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  PRIMARY KEY (`consentDatetime`,`consentName`),
  KEY `scenarioID` (`scenarioID`),
  KEY `stateID` (`stateID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `document`
--

INSERT INTO `document` (`consentDatetime`, `consentName`, `consentFile`, `consentStatus`, `scenarioID`, `stateID`) VALUES
('2015-01-21 07:23:27', 'Admission Notes', 'SC5ST0-AdmissionNotes.pdf', 1, 'SC5', 'ST0'),
('2015-01-21 15:38:12', 'Admission Notes', 'SC3ST0-AdmissionNotes.pdf', 1, 'SC3', 'ST0'),
('2015-01-21 15:38:12', 'Consent for operation', 'SC3ST0-ConsentForOperation.pdf', 1, 'SC3', 'ST0'),
('2015-01-21 15:38:12', 'Inpatient Clinical Record', 'SC3ST0-InpatientClinicalNotes.pdf', 1, 'SC3', 'ST0'),
('2015-01-21 15:38:12', 'Integrated Nursing Record', 'SC3ST0-IntegratedNursingRecord.pdf', 1, 'SC3', 'ST0'),
('2015-01-26 10:35:24', 'Emergency Department Case Record', 'SC2ST0-EmergencyDepartmentCaseRecord.pdf', 1, 'SC2', 'ST0'),
('2015-02-02 09:39:38', 'Admission Notes', 'SC6ST0-AdmissionNotes.pdf', 1, 'SC6', 'ST0'),
('2015-02-03 13:02:07', 'Consent For Transfusion of Blood', 'SC5ST0-ConsentForFullBloodCount.pdf', 1, 'SC5', 'ST0'),
('2015-02-03 13:04:04', 'Consent For Operation', 'SC5ST0-ConsentFormForCoagulation.pdf', 1, 'SC5', 'ST0'),
('2015-03-05 11:32:24', 'Admission Notes', 'SC7ST0-AdmissionNotes.pdf', 1, 'SC7', 'ST0'),
('2015-03-05 11:34:29', 'Admission Notes', 'SC4ST0-AdmissionNotes.pdf', 1, 'SC4', 'ST0'),
('2015-03-05 15:38:12', 'Consent for operation', 'SC7ST0-ConsentForOperation.pdf', 1, 'SC7', 'ST0');

-- --------------------------------------------------------

--
-- Table structure for table `frequency`
--

CREATE TABLE IF NOT EXISTS `frequency` (
  `freqAbbr` varchar(100) NOT NULL,
  `freqDescription` varchar(500) NOT NULL,
  PRIMARY KEY (`freqAbbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `frequency`
--

INSERT INTO `frequency` (`freqAbbr`, `freqDescription`) VALUES
('24 hours', 'over 24 hours'),
('2x/week ', 'Twice a week'),
('3x/week', 'Three times a week'),
('4 hourly', 'every 4 hours'),
('4 hourly or PRN', 'every 4 hours or when necessary'),
('ac ', 'Before meals'),
('ad lib', 'use as much as one desires; freely'),
('ASAP', 'As soon as possible '),
('b.i.d.', 'Twice daily (not the same as q 12 °) '),
('BD', 'Twice a day '),
('BD or PRN', 'twice a day or when necessary'),
('daily', 'Everyday '),
('eod', 'Every other day or every 48 hours'),
('eom', 'Every alternate morning'),
('eon', 'Every alternate night '),
('NA', 'Not applicable'),
('od', 'on day'),
('OM', 'Every morning'),
('om (M, W, F, Sun)', 'Every morning on Mondays, Wedenesdays, Fridays and Sundays'),
('om (Tu, Th, Sat)', 'Every morning on Tuesdays, Thursdays and Saturdays'),
('ON', 'Every night'),
('once/daily', 'Once daily'),
('once/week', 'Once per week'),
('over 1hr', 'over 1 hour'),
('over 4 hours', 'over 4 hours'),
('PM', 'Afternoon'),
('PRN', 'As needed '),
('Q', 'Every'),
('q AM', 'Every morning '),
('q hr', 'Every hour '),
('q12h', 'Every 12 hourly '),
('q2h', 'Every 2 hourly'),
('q3days', 'Every 3 days or every 72 hours '),
('q3h', 'Every 3 hourly '),
('q48h', 'Every 48 hourly'),
('q4h', 'Every 4 hourly'),
('q6h', 'Every 6 hourly '),
('q8h', 'Every 8 hourly'),
('QD', 'Every day '),
('QDS or PRN', 'four times a day or when necessary'),
('QID ', 'Four times a day '),
('QOD ', 'Every other day '),
('STAT', 'Immediately (within 30 minutes)'),
('TDS', 'Three times a day'),
('TDS and 10', 'Three times a day and 10pm'),
('TDS or PRN', 'Three times a day or when necessary');

-- --------------------------------------------------------

--
-- Table structure for table `keyword`
--

CREATE TABLE IF NOT EXISTS `keyword` (
  `keywordID` int(11) NOT NULL AUTO_INCREMENT,
  `keywordDesc` varchar(500) NOT NULL,
  `fieldsToMap` varchar(100) NOT NULL,
  PRIMARY KEY (`keywordID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `keyword`
--

INSERT INTO `keyword` (`keywordID`, `keywordDesc`, `fieldsToMap`) VALUES
(1, 'Healthcare Provider’s Orders', 'doctorOrder'),
(2, 'Scenario File Name', 'scenarioName'),
(3, 'Synopsis', 'scenarioDescription'),
(4, 'Health history', 'admissionNote'),
(5, 'History/Information', 'admissionNote'),
(6, 'When learner requests results', 'doctorOrder'),
(7, 'Surgeon’s Orders', 'doctorOrder'),
(8, 'State #1', 'stateID'),
(9, 'State #2', 'stateID'),
(10, 'State #3', 'stateID'),
(11, 'State #4', 'stateID'),
(12, 'State #5', 'stateID'),
(13, 'State #6', 'stateID'),
(14, 'State #7', 'stateID'),
(15, 'State #8', 'stateID'),
(16, 'Allergy', 'allergy');

-- --------------------------------------------------------

--
-- Table structure for table `lecturer`
--

CREATE TABLE IF NOT EXISTS `lecturer` (
  `lecturerID` varchar(50) NOT NULL,
  `lecturerPassword` varchar(20) NOT NULL,
  PRIMARY KEY (`lecturerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lecturer`
--

INSERT INTO `lecturer` (`lecturerID`, `lecturerPassword`) VALUES
('lec1', 'lec1'),
('lec10', 'lec10'),
('lec2', 'lec2'),
('lec3', 'lec3'),
('lec4', 'lec4'),
('lec5', 'lec5'),
('lec6', 'lec6'),
('lec7', 'lec7'),
('lec8', 'lec8'),
('lec9', 'lec9');

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_scenario`
--

CREATE TABLE IF NOT EXISTS `lecturer_scenario` (
  `lecturerID` varchar(50) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  PRIMARY KEY (`lecturerID`,`scenarioID`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lecturer_scenario`
--

INSERT INTO `lecturer_scenario` (`lecturerID`, `scenarioID`) VALUES
('lec1', 'SC2');

-- --------------------------------------------------------

--
-- Table structure for table `medication_history`
--

CREATE TABLE IF NOT EXISTS `medication_history` (
  `medicineDatetime` datetime NOT NULL,
  `medicineBarcode` varchar(100) NOT NULL,
  `practicalGroupID` varchar(20) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  PRIMARY KEY (`medicineDatetime`,`medicineBarcode`),
  KEY `practicalGroupID` (`practicalGroupID`,`scenarioID`),
  KEY `medicineBarcode` (`medicineBarcode`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE IF NOT EXISTS `medicine` (
  `medicineBarcode` varchar(100) NOT NULL,
  `medicineName` varchar(30) NOT NULL,
  PRIMARY KEY (`medicineBarcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`medicineBarcode`, `medicineName`) VALUES
('ACTRAPIDINSULIN', 'Actrapid insulin'),
('ATORVASTATIN', 'Atorvastatin'),
('BOLUSMORPHINE', 'Bolus Morphine'),
('CALCIUMGLUCONATE', 'Calcium gluconate'),
('CODYDRAMOL', 'Codydramol'),
('CYCLIZINE', 'Cyclizine'),
('DEXSALINE', 'Dextrose Saline'),
('DIGOXIN', 'Digoxin'),
('ENALAPRIL', 'Enalapril'),
('ENOXAPARIN', 'Enoxaparin'),
('EPINE', 'Epinephrine'),
('FSULFATE', 'Ferrous sulfate'),
('HEPARIN', 'Heparin'),
('KCL', 'Potassium Chloride'),
('KETOROLAC', 'Ketorolac'),
('MOM', 'Milk of Magnesia'),
('MORPHINE', 'Morphine'),
('MORPHINEPCA', 'Morphine PCA'),
('NA', 'Not applicable'),
('NORMALSALINE', 'Normal Saline'),
('NORMALSALINEFLUSH', 'Normal Saline Flush'),
('PANTOPRAZOLE', 'Pantoprazole'),
('PRBC', 'PRBC'),
('PROCHLORPERAZINE', 'Prochlorperazine'),
('VANCOMYCIN', 'Vancomycin');

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

CREATE TABLE IF NOT EXISTS `note` (
  `noteID` int(255) NOT NULL AUTO_INCREMENT,
  `multidisciplinaryNote` varchar(15000) NOT NULL,
  `grpMemberNames` varchar(500) NOT NULL,
  `noteDatetime` datetime NOT NULL,
  `practicalGroupID` varchar(20) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  PRIMARY KEY (`noteID`),
  KEY `praticalgroupID` (`practicalGroupID`),
  KEY `ScenarioID` (`scenarioID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`noteID`, `multidisciplinaryNote`, `grpMemberNames`, `noteDatetime`, `practicalGroupID`, `scenarioID`) VALUES
(1, 'taken down hr,bp,intake, output, administer medicine', 'xuanqi, linwei, qiwei, linxuan, qiping', '2014-10-17 14:00:00', 'P02', 'SC1'),
(2, 'Administered panadol at 5.34pm', 'glad, sq, wy, grace, joce', '2014-10-27 10:47:07', 'P01', 'SC1'),
(3, 'Chemistry report despatched. Blood pressure, spo2, respiration rate, heart rate normal. ', 'a, b, c, d', '2014-10-29 10:21:54', 'P01', 'SC1');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `patientNRIC` varchar(10) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `gender` varchar(6) NOT NULL,
  `DOB` varchar(10) NOT NULL,
  PRIMARY KEY (`patientNRIC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patientNRIC`, `firstName`, `lastName`, `gender`, `DOB`) VALUES
('S3925683C', 'Ho Yin', 'Lee', 'Female', '04/12/1939'),
('S4897583E', 'Ho Yin', 'Lee', 'Male', '03/03/1948'),
('S5412345F', 'Ho Yin', 'Lee', 'Male', '01/01/1954'),
('S5903259B', 'Ho Yin', 'Lee', 'Female', '10/10/1959'),
('S6901328A', 'Ho Yin', 'Lee', 'Female', '10/10/1969'),
('S9115479G', 'Ho Yin', 'Lee', 'Male', '15/10/1991'),
('S9136572D', 'Ho Yin', 'Lee', 'Female', '01/06/1991');

-- --------------------------------------------------------

--
-- Table structure for table `practicalgroup`
--

CREATE TABLE IF NOT EXISTS `practicalgroup` (
  `practicalGroupID` varchar(20) NOT NULL,
  `practicalGroupPassword` varchar(20) NOT NULL,
  `lecturerID` varchar(20) NOT NULL,
  PRIMARY KEY (`practicalGroupID`),
  KEY `lecturerID` (`lecturerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `practicalgroup`
--

INSERT INTO `practicalgroup` (`practicalGroupID`, `practicalGroupPassword`, `lecturerID`) VALUES
('P01', 'P01', 'lec1'),
('P02', 'P02', 'lec2'),
('P03', 'P03', 'lec3'),
('P04', 'P04', 'lec4'),
('P05', 'P05', 'lec5'),
('P06', 'P06', 'lec6'),
('P07', 'P07', 'lec7'),
('P08', 'P08', 'lec8'),
('P09', 'P09', 'lec9'),
('P10', 'P10', 'lec10');

-- --------------------------------------------------------

--
-- Table structure for table `practicalgroup_report`
--

CREATE TABLE IF NOT EXISTS `practicalgroup_report` (
  `reportID` int(255) NOT NULL AUTO_INCREMENT,
  `practicalGroupID` varchar(20) NOT NULL,
  PRIMARY KEY (`reportID`,`practicalGroupID`),
  KEY `practicalGroupID` (`practicalGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE IF NOT EXISTS `prescription` (
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `doctorName` varchar(20) NOT NULL,
  `doctorOrder` varchar(767) NOT NULL,
  `freqAbbr` varchar(10) NOT NULL,
  `medicineBarcode` varchar(100) NOT NULL,
  `discontinueState` varchar(5) NOT NULL,
  `dosage` varchar(100) NOT NULL,
  `routeAbbr` varchar(10) NOT NULL,
  PRIMARY KEY (`scenarioID`,`stateID`,`doctorOrder`,`freqAbbr`),
  KEY `stateID` (`stateID`),
  KEY `freqAbbr` (`freqAbbr`),
  KEY `medicineBarcode` (`medicineBarcode`),
  KEY `dosage` (`dosage`),
  KEY `dosage_2` (`dosage`),
  KEY `routeAbbr` (`routeAbbr`),
  KEY `dosage_3` (`dosage`),
  KEY `dosage_4` (`dosage`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`scenarioID`, `stateID`, `doctorName`, `doctorOrder`, `freqAbbr`, `medicineBarcode`, `discontinueState`, `dosage`, `routeAbbr`) VALUES
('SC1', 'ST0', 'Dr.Tan/01234Z', '<br>Cyclizine 25mg IV Bolus every six hours prn nausea\n<br>Ketorolac 30mg IVP every six hours for three days\n<br>Ferrous sulfate 400mg PO twice a day with meals; begin when oral intake resumes\n<br>Milk of Magnesia 30mL PO daily prn constipation', 'NA', 'NA', '-', '-', 'N.A'),
('SC1', 'ST0', 'Dr.Tan/01234Z', '<br>NBM until passing fl atus then begin clear liquid diet and advance as tolerated\n<br>Vital signs every four hours\n<br>Out of bed to chair evening of surgery and then ambulate three times per day\n<br>Urinary catheter to bedside drainage; discontinue morning of postoperative day one\n<br>Intake and Output every shift\n<br>IV of Dextrose/Saline with KCl 20mEq per litre at 125mL/hour\n<br>AM labs: Haemoglobin and Haematocrit, Urea and Electrolytes, Creatinine, Glucose\n<br>Oxygen to maintain SpO2 greater than 92%\n<br>Incentive spirometre every hour while awake\n<br>Antiembolic stockings in situ while in bed\n<br>Morphine PCA 2mg every 10min with four hour lockout of 40mg or Bolus Morphine 2-4mg every two hours prn pain', 'NA', 'NA', '-', '-', 'N.A'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Bolus Morphine 2-4mg every two hours prn pain', 'q2h', 'BOLUSMORPHINE', '-', '2-4mg', 'N.A'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Cyclizine 25mg IV Bolus every six hours prn nausea', 'q6h', 'CYCLIZINE', '-', '25mg', 'I.V.'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Ferrous sulfate 400mg PO twice a day with meals; begin when oral intake resumes', 'BD', 'FSULFATE', '-', '400mg', 'P.O.'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'IV of Dextrose/Saline with KCL 20mEq per litre at 125 mL/hour', 'q hr', 'DEXSALINE', '-', '125 mL', 'I.V.'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Ketorolac 30mg IVP every six hours for three days', 'q6h', 'KETOROLAC', '-', '30mg', 'IVP'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Milk of Magnesia 30mL PO daily prn constipation', 'daily', 'MOM', '-', '30mL', 'P.O.'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Morphine PCA 2mg every 10min with four hour lockout of 40mg', '4 hourly', 'MORPHINEPCA', '-', '2mg', 'I.V.'),
('SC1', 'ST1', 'Dr.Tan/01234Z', 'PRBCs two units NOW', 'ASAP', 'PRBC', '-', 'two units', 'I.V.'),
('SC1', 'ST1', 'Dr.Tan/01234Z', 'PRBCs two units NOW', 'NA', 'NA', '-', '-', 'N.A'),
('SC1', 'ST3', 'Dr.Tan/01234Z', '0.9% Normal Saline at 200mL/hour\r <br>Epinephrine 1:1000 0.5mL IM STAT\r<br> Bilirubin, LDH, Haptoglobin, and Urinalysis for Haemoglobinuria', 'NA', 'NA', '-', '-', 'N.A'),
('SC1', 'ST3', 'Dr.Tan/01234Z', '0.9% Normal Saline at 200mL/hour', 'q hr', 'NORMALSALINE', '-', '200mL', 'I.V.'),
('SC1', 'ST3', 'Dr.Tan/01234Z', 'Epinephrine 1:1000 0.5mL IM STAT', 'STAT', 'EPINE', '-', '0.5mL', 'I.M.'),
('SC3', 'ST0', 'Dr.Tan/01234Z', '<br>Digoxin 125mcg PO every day <br>Heparin 5,000units SC three times a day <br>Codyramol 10/500mg 1-2 tabs PO every 4-6 hours PRN for pain <br>Morphine 5-10mg IM every 4-6 hours PRN for severe pain <br>Prochlorperazine 12.5mg IM every 4-6 hours PRN for nausea\n<br>Saline flush <br>Post gastectomy clear fluids to full liquids as tolerated <br>Physiotherpy referral for prevention of chest infection and to increase mobility\n<br>Oxygen at 2-4LPM nasal cannula to maintain SpO2 greater than 95% <br>Fluid Chart every shift\n<br>Walk with nurse \n<br>INR daily and notify physician of results\n<br>Blood Glucose', 'NA', 'NA', '-', '-', 'N.A'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Codydramol 10/500mg 1-2 tabs PO every 4-6 hours PRN for pain', 'q4h', 'CODYDRAMOL', '-', '10/500mg 1-2 tabs', 'P.O.'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Digoxin 125mcg PO every day', 'daily', 'DIGOXIN', '-', '125mcg', 'P.O.'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Heparin 5,000units SC three times a day', 'TDS', 'HEPARIN', '-', '5,000 units', 'SC'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Morphine 5-10mg IM every 4-6 hours PRN for severe pain', 'q4h', 'MORPHINE', '-', '5-10mg', 'I.M.'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Prochlorperazine 12.5mg IM every 4-6 hours PRN for nausea', 'q4h', 'PROCHLORPERAZINE', '-', '12.5mg', 'I.M.'),
('SC4', 'ST0', 'Dr.Tan/01234Z', '<br>Admit to ED \n<br>Diagnosis: syncopal episode, palpitations, epigastric pain\n<br> Start IV 1000mL 0.9% Normal Saline at full-open rate. Follow with Dextrose/Saline at 250mL/hour\n<br> STAT ECG and continuous ECG monitoring\n<br>Continuous pulse oximetry\n<br> Oxygen via nasal cannula to maintain SpO2 greater than 95% <br>Orthostatic blood pressures every four hours \n<br>STAT labs: FBC, Electolytes, Urea, Creatinine, Urinalysis, Cardiac Markers, Toxicology Screen, Serum Pregnancy Test (SPT), Lipase, Hepatitis Screen, STAT chest x-ray', 'NA', 'NA', '-', '-', 'N.A'),
('SC4', 'ST0', 'Dr.Tan/01234Z', 'Follow with Dextrose/Saline at 250mL/hour', 'q hr', 'DEXSALINE', '-', '250mL', 'I.V.'),
('SC4', 'ST0', 'Dr.Tan/01234Z', 'Start IV 1000mL 0.9% Normal Saline at full-open rate', 'ASAP', 'NORMALSALINE', '-', '1000mL', 'I.V.'),
('SC4', 'ST1', 'Dr.Tan/01234Z', '<br>KCl 60mmols IV push STAT followed by 40mmols per hour for three doses', 'NA', 'NA', '-', '-', 'N.A'),
('SC4', 'ST1', 'Dr.Tan/01234Z', 'KCl 60mmols IV push STAT followed by 40mmols per hour for three doses', 'ASAP', 'KCL', 'ST2', '60mmols', 'I.V.'),
('SC4', 'ST2', 'Dr.Tan/01234Z', '  In 500mL of  0.9% Normal Saline, infuse over four hours', 'q hr', 'NORMALSALINE', '-', '0.9%', 'I.V.'),
('SC4', 'ST2', 'Dr.Tan/01234Z', '<br>Potassium chloride 40mmols in 500mL of 0.9% Normal Saline, infuse over four hours\r\n<br>Repeat Electrolytes two hours after KCl infuses\r\n<br>Call results of laboratory', 'NA', 'NA', '-', '-', 'N.A'),
('SC4', 'ST2', 'Dr.Tan/01234Z', 'Potassium chloride 40mmols', 'q4h', 'KCL', '-', '40mmols', 'I.V.'),
('SC4', 'ST3', 'Dr.Tan/01234Z', '<br>Admit to Medical Ward\r\n<br>Diagnosis: hypokalaemia, hypotension, dehydration\r\n<br>Consult Psychiatry for evaluation of eating disorder\r\n<br>Repeat Electrolytes in AM\r\n<br>Diet: Regular diet\r\n<br>Vital signs every four hours\r\n<br>Activity: Up ad lib\r\n<br>Monitor Intake and Output\r\n<br>Infuse Dextrose Saline with KCl 40mmol at 150mL/hour', 'NA', 'NA', '-', '-', 'N.A'),
('SC4', 'ST3', 'Dr.Tan/01234Z', 'Infuse Dextrose Saline with KCl 40mmol at 150mL/hour', 'q hr', 'KCL', '-', '40mmols', 'I.V.'),
('SC5', 'ST0', 'Dr.Tan/01234Z', '<br>Vital signs every 2 hours, notify if BP less than 100/45, Temp greater than 38.9°C, HR greater than 100, RR greater than 25 \n<br>Admit bloods: FBC, Electrolytes, Urea, Creatinine, Glucose, PT/PTT, Group and cross match for 3units of packed red blood cells (PRBC), Hct in AM \n<br>Start IV 0.9% Normal Saline at 125mL/hour \n<br>Pantoprazole 80mg IV stat, then every 12 hours \n<br>Cyclizine 25mg IV every 8 hours prn nausea \n<br>Morphine 2-5mg IV every 2-3 hours prn moderate to severe pain \n<br>Diet NBM \n<br>Nasogastric tube on free drainage /monitor and record amount, type and colour \n<br>Check SpO2, if below 95%, start O2 via nasal cannula at 2LPM', 'NA', 'NA', '-', '-', 'N.A'),
('SC5', 'ST0', 'Dr.Tan/01234Z', 'Cyclizine 25mg IV every 8 hours prn nausea', 'q8h', 'CYCLIZINE', '-', '25mg', 'I.V.'),
('SC5', 'ST0', 'Dr.Tan/01234Z', 'Morphine 2-5mg IV every 2-3 hours prn moderate to severe pain', 'q2h', 'MORPHINE', '-', '2-5mg', 'I.V.'),
('SC5', 'ST0', 'Dr.Tan/01234Z', 'Pantoprazole 80mg IV stat, then every 12 hours', 'q12h', 'PANTOPRAZOLE', '-', '80mg', 'I.V.'),
('SC5', 'ST0', 'Dr.Tan/01234Z', 'Start IV 0.9% Normal Saline at 125mL/hour', 'q hr', 'NORMALSALINE', '-', '125mL', 'I.V.'),
('SC5', 'ST1', 'Dr.Tan/01234Z', 'Give 2units PRBC at 100mL/hour', 'NA', 'NA', '-', '-', 'N.A'),
('SC5', 'ST1', 'Dr.Tan/01234Z', 'Give 2units PRBC at 100mL/hour', 'q hr', 'PRBC', '-', '100mL', 'N.A'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Atorvastatin 10mg PO once daily', 'od', 'ATORVASTATIN', '-', '10mg', 'P.O.'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Codydramol (10/500mg) 1-2 tabs PO every 4-6 hours prn mild pain', 'q4h', 'CODYDRAMOL', '-', '10/500mg', 'P.O.'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Enalapril 20mg PO once daily', 'od', 'ENALAPRIL', '-', '20mg', 'P.O.'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Enoxaparin 40mg SC once daily', 'od', 'ENOXAPARIN', '-', '40mg', 'SQ'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Morphine 1-2mg every 2-4 hours IV bolus prn pain', 'q2h', 'MORPHINE', 'ST2', '1-2mg', 'I.V.'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Prochlorperazine 12.5mg IV every 6-8 hours prn nausea', 'q6h', 'PROCHLORPERAZINE', 'ST2', '12.5mg', 'I.V.'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Saline flush 0.9% Normal Saline every shift', 'TDS', 'NORMALSALINEFLUSH', 'ST2', '0.9%', 'I.V.'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Vancomycin 1g IV every 12 hours\n<br>Enalapril 20mg PO once daily\n<br>Atorvastatin 10mg PO once daily\n<br>Morphine 1-2mg every 2-4 hours IV bolus prn pain\n<br>Prochlorperazine 12.5mg IV every 6-8 hours prn nausea\n<br>Codydramol (10/500mg) 1-2 tabs PO every 4-6 hours prn mild pain\n<br>Enoxaparin 40mg SC once daily\n<br>Saline flush 0.9% Normal Saline every shift\n<br>FBC, Electrolytes, Urea, Creatinine, Glucose in AM. \n<br>Peak flow.', 'NA', 'NA', '-', '-', 'N.A'),
('SC6', 'ST0', 'Dr.Tan/01234Z', 'Vancomycin 1g IV every 12 hours', 'q12h', 'VANCOMYCIN', 'ST1', '1g', 'I.V.'),
('SC6', 'ST1', 'Dr.Tan/01234Z', '150mL/hour', 'q hr', 'NORMALSALINE', 'ST2', '150mL', 'I.V.'),
('SC6', 'ST1', 'Dr.Tan/01234Z', '<br>IV 0.9% Normal Saline 500mL STAT bolus followed by 150mL/hour\n<br>Discontinue vancomycin STAT (if not already discontinued)\n<br>Continue to hold enalapril and enoxaparin\n<br>Urinary catheter\n<br>Hourly Intake and Output\n<br>Nasogastric tube on free drainage with 4 hourly aspiration\n<br>NBM\n<br>Complete bed rest\n<br>O2 at 2LPM nasal cannula; titrate to maintain SpO2 greater than 92%\n<br>STAT Electrolytes, Urea, Creatinine, Glucose, Urinalysis, Urine osmolality, Urine sodium and call results', 'NA', 'NA', '-', '-', 'N.A'),
('SC6', 'ST1', 'Dr.Tan/01234Z', 'IV 0.9% Normal Saline 500mL STAT bolus', 'STAT', 'NORMALSALINE', 'ST2', '500mL', 'I.V.'),
('SC6', 'ST2', 'Dr.Tan/01234Z', 'Administer 10u Actrapid insulin in total volume of Dextrose 50% 50mL over 1 hour in syringe pump, repeat potassium check 1 hour after end of infusion', 'over 1hr', 'ACTRAPIDINSULIN', '-', '10u', 'I.V.'),
('SC6', 'ST2', 'Dr.Tan/01234Z', 'Calcium gluconate 10% 4.5mEq IV bolus slowly', 'STAT', 'CALCIUMGLUCONATE', '-', '10% 4.5mEq', 'I.V.'),
('SC6', 'ST2', 'Dr.Tan/01234Z', 'Discontinue IV fl uids, IV cannula\n<br>Continuous cardiac monitoring\n<br>Consult nephrologist\n<br>Dialysis access placed by renal team, in this instance. Temp-line, subclavian, femoral will be removed per protocol of unit - usually every 3 days to prevent infection\n<br>Daily weights\n<br>Calcium gluconate 10% 4.5mEq IV bolus slowly\n<br>Administer 10u Actrapid insulin in total volume of Dextrose 50% 50mL over 1 hour in syringe pump, repeat potassium check 1 hour after end of infusion\n<br>Thereafter Potassium level every 4 hours', 'NA', 'NA', '-', '-', 'N.A'),
('SC7', 'ST0', 'Dr.Tan/01234Z', '<br>IV 0.9% Normal Saline at 125mL/hour\n<br>Oxygen 4LPM via nasal cannula\nCardiac monitor\n<br>Continuous SpO2\n<br>FBC, Electrolytes, Urea, Glucose, Creatinine, Clotting screen STAT\n<br>ECG STAT\n<br>Vital signs every hour\n<br>Complete bedrest\n<br>UWSD to (-)20cm water suction\n<br>', 'NA', 'NA', '-', '-', 'N.A'),
('SC7', 'ST0', 'Dr.Tan/01234Z', 'IV 0.9% Normal Saline at 125mL/hour', 'q hr', 'NORMALSALINE', '-', '125mL', 'I.V.'),
('SC7', 'ST4', 'Dr.Tan/01234Z', '<br>Change UWSD dressing every day\n<br>Regular diet\n<br>Activity as tolerated\n<br>Discontinue oxygen\n<br>Discontinue cardiac monitor', 'NA', 'NA', '-', '-', 'N.A');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `reportID` int(255) NOT NULL AUTO_INCREMENT,
  `reportDatetime` datetime NOT NULL,
  `reportName` varchar(100) NOT NULL,
  `reportFile` varchar(200) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `initialReport` tinyint(1) NOT NULL,
  PRIMARY KEY (`reportID`),
  KEY `stateID` (`stateID`),
  KEY `scenarioID` (`scenarioID`),
  KEY `reportID` (`reportID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=38 ;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`reportID`, `reportDatetime`, `reportName`, `reportFile`, `scenarioID`, `stateID`, `initialReport`) VALUES
(1, '2014-10-29 10:16:22', 'Urea and Electrolytes', 'SC4ST3-U&E.pdf', 'SC4', 'ST3', 0),
(3, '2015-01-21 06:22:12', 'ECG', 'SC5ST0-ECG.pdf', 'SC5', 'ST0', 1),
(4, '2015-02-02 11:34:41', 'FBC', 'SC6ST0-FBC.pdf', 'SC6', 'ST0', 0),
(5, '2015-02-02 11:36:46', 'Biochemistry', 'SC6ST0-Biochemistry.pdf', 'SC6', 'ST0', 0),
(6, '2015-02-02 13:01:30', 'Biochemistry', 'SC6ST2-Chemistry_NA141_K6.7.pdf', 'SC6', 'ST2', 0),
(7, '2015-02-02 13:02:45', 'ECG', 'SC6ST2-ECG.pdf', 'SC6', 'ST2', 0),
(8, '2015-02-02 13:07:25', 'Biochemistry', 'SC6ST4-Chemistry_NA143_K4.5.pdf', 'SC6', 'ST4', 0),
(9, '2015-02-03 13:00:00', 'Coagulation', 'SC5ST1-Coagulation.pdf', 'SC5', 'ST1', 0),
(10, '2015-02-03 13:00:00', 'Haemaology', 'SC5ST1-Haemaology.pdf', 'SC5', 'ST1', 0),
(11, '2015-02-03 13:00:00', 'Request for Blood Products', 'SC5ST0-RequestForBloodAndBloodProducts.pdf', 'SC5', 'ST0', 0),
(12, '2015-02-03 13:01:00', 'Biochemistry', 'SC5ST1-Biochemistry.pdf', 'SC5', 'ST1', 0),
(13, '2015-02-03 13:01:00', 'CXR', 'SC5ST0-CXR.pdf', 'SC5', 'ST0', 1),
(14, '2015-02-03 13:01:00', 'FBC', 'SC7ST0-FBC.pdf', 'SC7', 'ST0', 1),
(15, '2015-02-03 13:01:00', 'Urea & Electrolytes', 'SC7ST0-U&E.pdf', 'SC7', 'ST0', 1),
(16, '2015-02-03 13:01:00', 'Coagulation', 'SC7ST0-Coagulation.pdf', 'SC7', 'ST0', 1),
(17, '2015-02-03 13:01:01', 'ECG', 'SC7ST0-ECG.pdf', 'SC7', 'ST0', 1),
(18, '2015-02-03 13:01:01', 'CXR', 'SC7ST0-CXR.pdf', 'SC7', 'ST0', 1),
(19, '2014-10-31 00:14:25', 'ECG', 'SC4ST0-ECG.pdf', 'SC4', 'ST0', 0),
(20, '2014-10-31 00:14:25', 'Urea and Electrolytes', 'SC4ST0-U&E.pdf', 'SC4', 'ST0', 0),
(21, '2014-10-31 00:14:25', 'CXR', 'SC4ST0-CXR.pdf', 'SC4', 'ST0', 0),
(22, '2014-10-31 00:14:25', 'ECG', 'SC3ST0-ECG.pdf', 'SC3', 'ST0', 1),
(23, '2014-10-31 00:14:25', 'Urea & Electrolytes', 'SC3ST0-U&EDespatch.pdf', 'SC3', 'ST0', 1),
(24, '2014-10-31 00:14:25', 'Urea & Electrolytes', 'SC3ST0-U&E.pdf', 'SC3', 'ST0', 0),
(25, '2014-10-31 00:14:25', 'Coagulation', 'SC3ST0-Coagulation.pdf', 'SC3', 'ST0', 1),
(26, '2014-10-31 00:14:26', 'INR', 'SC3ST0-INR.pdf', 'SC3', 'ST0', 0),
(27, '2014-10-31 00:14:26', 'FBC', 'SC3ST0-FBC.pdf', 'SC3', 'ST0', 1),
(28, '2014-10-31 00:14:26', 'CEA', 'SC3ST0-CEA.pdf', 'SC3', 'ST0', 1),
(29, '2014-10-31 00:14:26', 'Lipid Panel', 'SC3ST0-LipidPanel.pdf', 'SC3', 'ST0', 1),
(30, '2014-10-31 00:14:26', 'Histology', 'SC3ST0-Histology.pdf', 'SC3', 'ST0', 1),
(31, '2014-10-31 00:14:26', 'CXR', 'SC3ST0-CXR.pdf', 'SC3', 'ST0', 1),
(32, '2014-10-31 00:14:26', 'OGD', 'SC3ST0-OGD.pdf', 'SC3', 'ST0', 1),
(33, '2014-10-31 00:14:27', 'FBC', 'SC1ST0-FBC.pdf', 'SC1', 'ST0', 0),
(34, '2014-10-31 00:14:27', 'Urea & Electrolytes', 'SC1ST0-U&E.pdf', 'SC1', 'ST0', 0),
(35, '2014-10-31 00:14:27', 'Urinalysis', 'SC1ST3-Urinalysis.pdf', 'SC1', 'ST3', 0),
(36, '2014-10-31 00:14:27', 'Liver panel', 'SC1ST3-LiverPanel.pdf', 'SC1', 'ST3', 0),
(37, '2014-10-31 00:14:27', 'Haptoglobin', 'SC1ST3-Haptoglobin.pdf', 'SC1', 'ST3', 0);

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE IF NOT EXISTS `route` (
  `routeAbbr` varchar(10) NOT NULL,
  `routeDescription` varchar(500) NOT NULL,
  PRIMARY KEY (`routeAbbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`routeAbbr`, `routeDescription`) VALUES
('A.D', 'Right ear '),
('A.S.', 'Left ear '),
('AU', 'each ear or both ears '),
('I.D. ', 'Intradermal route '),
('I.M.', 'Intramuscular route '),
('I.T.', 'Intrathecal route '),
('I.V.', 'Intravenous route '),
('IVP', 'Intravenous push '),
('IVPB', 'Intravenous piggyback '),
('N.A', 'N.A'),
('Neb', 'Nebuliser'),
('NGT', 'Nasogastric tube '),
('O.D.', 'Right eye '),
('O.S.', 'Left eye '),
('O.U.', 'Each eye or both eyes '),
('P.O.', 'By mouth '),
('P.R.', 'By rectum '),
('S & S', 'Swish and swallow '),
('SC', 'SC route'),
('SL', 'Sublingual route'),
('SQ', 'sub q, subcut Subcutaneous route '),
('Topical', 'Topical'),
('V', 'Vaginal route ');

-- --------------------------------------------------------

--
-- Table structure for table `scenario`
--

CREATE TABLE IF NOT EXISTS `scenario` (
  `scenarioID` varchar(5) NOT NULL,
  `scenarioName` varchar(100) NOT NULL,
  `scenarioDescription` longtext NOT NULL,
  `admissionNote` longtext NOT NULL,
  `bedNumber` int(100) NOT NULL,
  PRIMARY KEY (`scenarioID`),
  KEY `bedNumber` (`bedNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scenario`
--

INSERT INTO `scenario` (`scenarioID`, `scenarioName`, `scenarioDescription`, `admissionNote`, `bedNumber`) VALUES
('SC1', 'Anaphylactic Reaction to Blood Administration', 'This simulated clinical experience was designed to expose the learner to the patient who experiences an adverse reaction to blood transfusion. The patient is first day postoperative gynecological surgery who develops the complication of hypovolemia that requires a blood transfusion. \r\n\r\nThe simulated clinical experience will automatically progress to anaphylaxis and subsequent shock states without prompt recognition of the transfusion reaction. With prompt recognition and intervention, the patient stabilises. The anaphylactic component of this simulated clinical experience may be used separately depending on learning objectives and may be overlaid on any patient or other scenario. This simulated clinical experience is intended for the learner in Semester VI.        ', 'A recently divorced, 46-year-old female, was admitted to the hospital yesterday morning for a total abdominal hysterectomy with bilateral salpingo-oophrectomy due to multiple large uterine fibroids. Over the past two years she had increasing pain that was not relieved with medication, excessively large menstrual flow, and long standing anemia refractory to standard treatment. Despite earlier recommendations from her healthcare provider to seek surgical intervention, she elected to wait due to multiple personal issues including her recent divorce and having two teenage children at home. During this time of postponing the surgery, she required two outpatient blood transfusions due to the severe anemia. Her significant preoperative lab values included a haemoglobin of 8.4 mml and a haematocrit of 32%. The morning of admission her vital signs were a heart rate of 78 bpm, blood pressure of 110/70, respiratory rate of 16, and a temperature of 37. Her blood type is A negative. Intraoperatively her estimated blood loss was 450mL. Her postoperative period has been uneventful and you are the nurse assigned to her care the following morning. The night nurse reports that the patient slept for the early part of the shift, but has been awake complaining of discomfort since 0430 hours. Her last vital signs, which were at that time, respiratory rate of 18, a heart rate of 88, blood pressure of 102/60 and a temperature of 37.4.\r\n\r\n<br><br>Healthcare Provider''s Order:\r\n<br>NBM until passing flatus then begin clear liquid diet and advance as tolerated\r\n<br>Vital signs every four hours\r\n<br>Out of bed to chair evening of surgery and then ambulate three times per day\r\n<br>Urinary catheter to bedside drainage; discontinue morning of postoperative day one\r\n<br>Intake and Output every shift\r\n<br>IV of Dextrose/Saline with KCl 20mEq per litre at 125mL/hour\r\n<br>AM labs: Haemoglobin and Haematocrit, Urea and Electrolytes, Creatinine, Glucose\r\n<br>Oxygen to maintain SpO2 greater than 92%\r\n<br>Incentive spirometre every hour while awake\r\n<br>Antiembolic stockings in situ while in bed\r\n<br>Morphine PCA 2mg every 10min with four hour lockout of 40mg or Bolus Morphine 2-4mg every two hours prn pain\r\n<br>Cyclizine 25mg IV Bolus every six hours prn nausea\r\n<br>Ketorolac 30mg IVP every six hours for three days\r\n<br>Ferrous sulfate 400mg PO twice a day with meals; begin when oral intake resumes\r\n<br>Milk of Magnesia 30mL PO daily prn constipation', 1),
('SC2', 'Basic Assessment of the Cardiac Patient', 'This simulated clinical experience allows the beginning learner to conduct a basic physical assessment of a truck driver at a health fair. Learners are expected to identify cardiac findings related to an unhealthy lifestyle. Learners are expected to obtain both subjective and objective data related to assessment of the cardiac system, recognize areas that could be addressed with health promotion, and document their findings. Common abnormal findings can also be discussed at the end of the simulated clinical experience. This simulated clinical experience is intended for learners in Semester II.', 'A 56-year-old truck driver has come to the health fair for routine screening on a hot summer day. He is dressed\ncasually in a short sleeve shirt and shorts.', 2),
('SC3', 'Basic Assessment of the Postoperative Gastrectomy Patient', 'In this simulated clinical experience, learners conduct a basic physical assessment of a three-day postoperative partial gastrectomy patient. The patient exhibits five abnormal assessment findings for learners to identify and/or document, including: absent bowel sounds, hypertension, irregular cardiac rhythm, an abdominal dressing, and oedema. The scenario has one continuous state. The simulated clinical experience also consists of a psychosocial element, which the instructor may elect to incorporate and is intended for the learner in Semester I.', 'This patient is a 76-year-old female whose chief complaint at her healthcare provider’s theatre was frequent indigestion and epigastric pain relieved by antacids. She also complained of rapid weight loss and feeling tired. After a series of tests, a biopsy was performed which confirmed stomach cancer. A partial gastrectomy was performed three days ago to remove the cancerous lesion. She is exhibiting signs of depression because of her recent diagnosis.\n\n\n<br><br> Health history: chronic gastritis, pernicious anaemia\n<br><br>Healthcare Provider’s Orders:\n<br>Digoxin 125mcg PO every day\n<br>Heparin 5,000units SC three times a day\n<br>Codyramol 10/500mg 1-2 tabs PO every 4-6 hours PRN for pain\n<br>Morphine 5-10mg IM every 4-6 hours PRN for severe pain\n<br>Prochlorperazine 12.5mg IM every 4-6 hours PRN for nausea\n<br>Saline flush\n<br>Post gastectomy clear fl uids to full liquids as tolerated\n<br>Physiotherpy referral for prevention of chest infection and to increase mobility\n<br>Oxygen at 2-4LPM nasal cannula to maintain SpO2 greater than 95%\n<br>Fluid Chart every shift\n<br>Walk with nurse\n<br>INR daily and notify physician of results\n<br>Blood Glucose', 3),
('SC4', 'Basic Dysrhythmia Recognition and Management', 'This simulated clinical experience involves a 24-year-old female university student who experiences heart palpitations, epigastric pain, muscle weakness, and a fainting episode in class. Initially she refused to go to the Emergency Department (ED), but later agreed to let a classmate drive her to the ED. Upon admission to the ED, the patient is diagnosed with a cardiac dysrhythmia. The patient states that she has been in excellent health all of her life. While waiting for the admission lab reports, the healthcare provider identifies signs of dehydration and specific physical findings associated with binge-purging bulimia nervosa. The lab report reveals severe hypokalaemia, which has resulted in destabilisation of the cardiac rhythm. The patient continues to deny purging. She remains in the ED for re-hydration, administration of IV potassium chloride, and stabilisation of the cardiac rhythm. She is admitted for psychiatric evaluation for the eating disorder and initiation of cognitive behavioural therapy. This simulated clinical experience is intended for the learner in Semester VI.', 'The patient is a 24-year-old female who is brought into the Emergency Department (ED) from the university by a classmate. The classmate states that she “slumped over in the desk and nearly passed out.” The patient insists that she didn’t pass out and that she had a “weak spell from a stomach virus. I vomited once last night.” She is listless, has severe muscle weakness, and speaks very quietly, in a low voice. She states that while in class, she noticed her heart beating “really fast and hard at times.” She stated that she feels burning-type pain in the chest and epigastric area. She denies any health problems except constipation and irregular periods. She states her last menstrual cycle was six months ago. She denies allergies. She is heterosexual and has been sexually active since secondary school. Her partners used condoms and she has had six partners. She denies tobacco use and drugs but has an occasional glass or two of wine at parties. She lives in the city with her mother and her mother’s boyfriend who is a “heavy drinker.” She states that her father is “out of her life.” She is studying fashion design and plans to graduate in two years, then move to Paris.\n\n\n<br><br>Healthcare Provider’s Orders:\n<br>Admit to ED\n<br>Diagnosis: syncopal episode, palpitations, epigastric pain\n<br>Start IV 1000mL 0.9% Normal Saline at full-open rate. Follow with Dextrose/Saline at 250mL/hour\n<br>STAT ECG and continuous ECG monitoring\n<br>Continuous pulse oximetry\n<br>Oxygen via nasal cannula to maintain SpO2 greater than 95%\n<br>Orthostatic blood pressures every four hours\n<br>STAT labs: FBC, Electolytes, Urea, Creatinine, Urinalysis, Cardiac Markers, Toxicology Screen, Serum Pregnancy\nTest (SPT), Lipase, Hepatitis Screen,\n<br>STAT chest x-ray\n', 4),
('SC5', 'GI Bleed Aspirin Abuse', 'This simulated clinical experience focuses on a 67-year-old male patient admitted to a Medical-Surgical Ward\nbecause there is no bed in the Intensive Care Unit. The Emergency Department is too busy to keep the patient there\nand he must wait for a scheduled emergency endoscopy on the Medical-Surgical Ward. The patient has a history\nof two episodes of coffee ground vomitus at home. The patient arrives on unit with a bowl of coffee ground vomitus\nand bedpan of frank bloody stool. He is hypotensive and tachycardic. Learners intervene with his condition, he\nimproves and is stabilised on the unit. Three states, all manually transitioned, are included in this simulated clinical\nexperience which is intended for the learner in Semester V.', 'A 67-year-old male was brought to the Emergency Department (ED) because he does not have a regular healthcare\nprovider by his family after complaining of severe abdominal pain. He vomited twice at home. His wife described\nthe vomitus as being “dark brown with something like coffee grounds.” The family also stated that he looked really\npale. For the past two years he has complained about his joints hurting and swelling in his hands. The patient\nstated that during the last month he had been taking four regular aspirin every 3-4 hours because he heard it helped\narthritis and was good for his heart. History: Former smoker. He is in general good health. He was last seen by his\nhealthcare provider about three years ago. He has no known allergies.<br>In the ED his baseline vital signs were: BP 146/85, RR 21 and unlaboured, Temp 36.4°C, SpO2 95% on room air.\nHis only complaint was of being “extremely tired.” An IV was started and blood specimens obtained and sent to\nthe lab. The on-call Endoscopy team has been notifi ed that an urgent endoscopy has been ordered. The urgent\nblood results found haemoglobin (Hb) 9.0 and haematocrit (Hct) 27%; other results are not back yet. Two peripheral\nIV lines with 0.9% Normal Saline solutions were started at 125mL/hour. Since the ED was extremely busy, and no\nbeds available in the Intensive Care Unit, the patient was transferred to the Medical-Surgical Ward as soon as a\nroom was available, while awaiting the emergency endoscopy team to arrive. On the way, the patient vomited.\nSpecifi c ED documentation is on the chart.\n<br><br>Healthcare Provider’s Orders:\n<br>Vital signs every 2 hours, notify if BP less than 100/45, Temp greater than 38.9°C, HR greater than 100, RR greater\nthan 25\n<br>Admit bloods: FBC, Electrolytes, Urea, Creatinine, Glucose, PT/PTT, Group and cross match for 3units of packed red blood cells (PRBC), Hct in AM\n<br>Start IV 0.9% Normal Saline at 125mL/hour\n<br>Pantoprazole 80mg IV stat, then every 12 hours\n<br>Cyclizine 25mg IV every 8 hours prn nausea\n<br>Morphine 2-5mg IV every 2-3 hours prn moderate to severe pain\n<br>Diet NBM<br>Nasogastric tube on free drainage / monitor and record amount, type and colour\n<br>Check SpO2, if below 95%, start O2 via nasal cannula at 2LPM<br>\n', 5),
('SC6', 'Acute Renal Failure', 'This simulated clinical experience presents the learner with a 61-year-old male three days postoperatively in acute renal failure (ARF) secondary to hypovolaemia, increased intra-abdominal pressure secondary to ileus and nephrotoxcity due to vancomycin administration. This patient has a low grade pyrexia, decreased urine output, nausea, and vomiting, which began during the night shift. Surgical wound cultures showed Methicillin Resistant Staphylococcus Aureus (MRSA). The patient is being barrier nursed. Fluid resuscitation fails to correct the renal problem which\nhas progressed from pre-renal to intra-renal failure. The patient develops heart failure and hyperkalaemia requiring dialysis therapy. The patient’s condition begins to improve following dialysis. This simulated clinical experience has\nfour states that transition manually and is intended for the learner in Semester V.', 'The patient is 61-year-old male with a history of hypertension and hyperlipidaemia. His home medications include enalapril, atorvastatin and child aspirin daily. He weighs 100kg and smokes one pack of cigarettes/day. He is allergic to penicillin. The patient presented to the Emergency Department three days ago with complaints of abdominal pain and yellow skin and had an emergency open cholecystectomy for obstructive jaundice. He was admitted to the Medical-Surgical Ward postoperatively. On the second postoperative day, his IV was discontinued and cannula fl ushes were ordered as well as a clear liquid diet. On the third morning, he has nausea, vomiting, absent bowel sounds, urine output 250mL/12 hour shift, and low grade pyrexia. He has not had a bowel movement. His\nsurgical wound is positive for Methicillin Resistant Staphylococcus Aureus (MRSA), which is now being treated with\nvancomycin. He is being barrier nursed.\n\n<br><br>Healthcare Provider’s Orders:\n<br>Vancomycin 1g IV every 12 hours\n<br>Enalapril 20mg PO once daily\n<br>Atorvastatin 10mg PO once daily\n<br>Morphine 1-2mg every 2-4 hours IV bolus prn pain\n<br>Prochlorperazine 12.5mg IV every 6-8 hours prn nausea\n<br>Codydramol (10/500mg) 1-2 tabs PO every 4-6 hours prn mild pain\n<br>Enoxaparin 40mg SC once daily\n<br>Saline flush 0.9% Normal Saline every shift\n<br>FBC, Electrolytes, Urea, Creatinine, Glucose in AM\n<br>Peak flow', 6),
('SC7', 'UWSD Insertion and General Ongoing Care', 'This simulated clinical experience was designed to expose the learner to the patient who experiences a pneumothorax after involvement in a road traffic accident. The patient comes directly to the Emergency Department, has a underwater sealed chest drain (UWSD) inserted followed by a complication caused by a kink in the chest tubing. After this complication is resolved, the patient is stable until the following day. The learners assess and care for the UWSD and insertion site. There are four states that manually transition. This simulated clinical experience is intended for the learner in Semester V.', 'This 24-year-old male was brought to the Emergency Department via ambulance post road traffic accident. The patient arrived 45 minutes prior to shift change. He had a seat belt on and he was restrained by the airbag. There were no other passengers in the car. The patient sustained right sided facial skin lacerations. The patient complained of muscle soreness to the chest wall; no redness was noted. He is sweaty and in apparent respiratory distress. There was no loss of consciousness in the field and he is awake and alert. The patient denies any significant prior medical\nhistory. Chest x-ray confirmed a right pneumothorax. The patient is anxious related to the accident and upcoming insertion of UWSD.\n\n<br>Healthcare Provider’s Orders:\n<br>IV 0.9% Normal Saline at 125mL/hour\n<br>Oxygen 4LPM via nasal cannula\nCardiac monitor\n<br>Continuous SpO2\n<br>FBC, Electrolytes, Urea, Glucose, Creatinine, Clotting screen STAT\n<br>ECG STAT\n<br>Vital signs every hour\n<br>Complete bedrest\n<br>UWSD to (-)20cm water suction\n<br>', 7);

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE IF NOT EXISTS `state` (
  `stateID` varchar(5) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateDescription` varchar(1000) NOT NULL,
  `patientNRIC` varchar(10) NOT NULL,
  PRIMARY KEY (`stateID`,`scenarioID`),
  KEY `patientNRIC` (`patientNRIC`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`stateID`, `scenarioID`, `stateDescription`, `patientNRIC`) VALUES
('ST0', 'SC1', 'default state', 'S6901328A'),
('ST0', 'SC2', 'default state', 'S5903259B'),
('ST0', 'SC3', 'default state', 'S3925683C'),
('ST0', 'SC4', 'default state', 'S9136572D'),
('ST0', 'SC5', 'default state', 'S4897583E'),
('ST0', 'SC6', 'default state', 'S5412345F'),
('ST0', 'SC7', 'default state', 'S9115479G'),
('ST1', 'SC1', 'Initial Assessment at 0800 Hours', 'S6901328A'),
('ST1', 'SC2', 'History and Assessment', 'S5903259B'),
('ST1', 'SC3', 'Baseline', 'S3925683C'),
('ST1', 'SC4', 'Admission to ED', 'S9136572D'),
('ST1', 'SC5', 'Admission to ward Hypotensive', 'S4897583E'),
('ST1', 'SC6', 'Initial Assessment', 'S5412345F'),
('ST1', 'SC7', 'Preparation for UWSD', 'S9115479G'),
('ST2', 'SC1', 'Initial Assessment at 0800 Hours', 'S6901328A'),
('ST2', 'SC2', 'Optional state: Abnormals', 'S5903259B'),
('ST2', 'SC4', 'Identifies Incorrect Order', 'S9136572D'),
('ST2', 'SC5', 'Condition Deteriorates', 'S4897583E'),
('ST2', 'SC6', 'Condition Deteriorating 3 Hours Later', 'S5412345F'),
('ST2', 'SC7', 'Post UWSD Insertion', 'S9115479G'),
('ST3', 'SC1', 'Blood Started at 1000 Hours', 'S6901328A'),
('ST3', 'SC4', '4 Hours After Potassium Infusion', 'S9136572D'),
('ST3', 'SC5', 'Improvement 5 HoursLater', 'S4897583E'),
('ST3', 'SC6', 'Slight Improvement 1 Hour Later', 'S5412345F'),
('ST3', 'SC7', 'Complication and Trouble Shooting', 'S9115479G'),
('ST4', 'SC1', 'Beginning Anaphylax in 30 minutes later', 'S6901328A'),
('ST4', 'SC6', 'Improvement After Dialysis', 'S5412345F'),
('ST4', 'SC7', 'Complication Resolved', 'S9115479G'),
('ST5', 'SC1', 'Mild Anaphylaxis', 'S6901328A'),
('ST5', 'SC7', 'Ongoing Management Following Day', 'S9115479G'),
('ST6', 'SC1', 'Worsening Anaphylaxis', 'S6901328A'),
('ST7', 'SC1', 'Severe Anaphylaxis', 'S6901328A'),
('ST8', 'SC1', 'Epinephrine Administered', 'S6901328A');

-- --------------------------------------------------------

--
-- Table structure for table `state_history`
--

CREATE TABLE IF NOT EXISTS `state_history` (
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `timeActivated` datetime NOT NULL,
  `lecturerID` varchar(50) NOT NULL,
  PRIMARY KEY (`timeActivated`,`lecturerID`),
  KEY `timeActivated` (`timeActivated`),
  KEY `timeActivated_2` (`timeActivated`),
  KEY `stateID` (`stateID`),
  KEY `scenarioID` (`scenarioID`),
  KEY `lecturerID` (`lecturerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vital`
--

CREATE TABLE IF NOT EXISTS `vital` (
  `vitalDatetime` datetime NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `temperature` decimal(4,2) NOT NULL,
  `RR` int(10) NOT NULL,
  `BPsystolic` int(10) NOT NULL,
  `BPdiastolic` int(10) NOT NULL,
  `HR` int(10) NOT NULL,
  `SPO` int(10) NOT NULL,
  `output` varchar(100) NOT NULL,
  `oralType` varchar(100) NOT NULL,
  `oralAmount` varchar(50) NOT NULL,
  `intravenousType` varchar(100) NOT NULL,
  `intravenousAmount` varchar(50) NOT NULL,
  `initialVital` tinyint(1) NOT NULL,
  `practicalGroupID` varchar(20) NOT NULL,
  PRIMARY KEY (`vitalDatetime`,`scenarioID`,`practicalGroupID`),
  KEY `patientNRIC` (`scenarioID`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vital`
--

INSERT INTO `vital` (`vitalDatetime`, `scenarioID`, `temperature`, `RR`, `BPsystolic`, `BPdiastolic`, `HR`, `SPO`, `output`, `oralType`, `oralAmount`, `intravenousType`, `intravenousAmount`, `initialVital`, `practicalGroupID`) VALUES
('2015-01-13 11:35:47', 'SC1', '37.00', 16, 110, 70, 88, 0, '450ml blood loss', '-', '-', '-', '-', 1, 'NA'),
('2015-01-13 11:40:46', 'SC1', '37.40', 18, 102, 60, 88, 0, '-', '-', '-', '-', '-', 1, 'NA'),
('2015-02-02 09:28:31', 'SC6', '0.00', 0, 0, 0, 0, 0, 'urine output 250mL/12 hour shift', '-', '-', '-', '-', 1, 'NA');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lecturer_scenario`
--
ALTER TABLE `lecturer_scenario`
  ADD CONSTRAINT `lecturer_scenario_ibfk_1` FOREIGN KEY (`lecturerID`) REFERENCES `lecturer` (`lecturerID`),
  ADD CONSTRAINT `lecturer_scenario_ibfk_2` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`);

--
-- Constraints for table `medication_history`
--
ALTER TABLE `medication_history`
  ADD CONSTRAINT `medication_history_ibfk_1` FOREIGN KEY (`medicineBarcode`) REFERENCES `medicine` (`medicineBarcode`),
  ADD CONSTRAINT `medication_history_ibfk_2` FOREIGN KEY (`practicalGroupID`) REFERENCES `practicalgroup` (`practicalGroupID`),
  ADD CONSTRAINT `medication_history_ibfk_3` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`);

--
-- Constraints for table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `note_ibfk_1` FOREIGN KEY (`practicalGroupID`) REFERENCES `practicalgroup` (`practicalGroupID`),
  ADD CONSTRAINT `note_ibfk_3` FOREIGN KEY (`practicalGroupID`) REFERENCES `practicalgroup` (`practicalGroupID`),
  ADD CONSTRAINT `note_ibfk_4` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`);

--
-- Constraints for table `practicalgroup`
--
ALTER TABLE `practicalgroup`
  ADD CONSTRAINT `practicalgroup_ibfk_1` FOREIGN KEY (`lecturerID`) REFERENCES `lecturer` (`lecturerID`);

--
-- Constraints for table `practicalgroup_report`
--
ALTER TABLE `practicalgroup_report`
  ADD CONSTRAINT `practicalgroup_report_ibfk_1` FOREIGN KEY (`reportID`) REFERENCES `report` (`reportID`),
  ADD CONSTRAINT `practicalgroup_report_ibfk_2` FOREIGN KEY (`practicalGroupID`) REFERENCES `practicalgroup` (`practicalGroupID`);

--
-- Constraints for table `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_3` FOREIGN KEY (`freqAbbr`) REFERENCES `frequency` (`freqAbbr`),
  ADD CONSTRAINT `prescription_ibfk_4` FOREIGN KEY (`medicineBarcode`) REFERENCES `medicine` (`medicineBarcode`),
  ADD CONSTRAINT `prescription_ibfk_5` FOREIGN KEY (`routeAbbr`) REFERENCES `route` (`routeAbbr`);

--
-- Constraints for table `state`
--
ALTER TABLE `state`
  ADD CONSTRAINT `state_ibfk_1` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`);

--
-- Constraints for table `state_history`
--
ALTER TABLE `state_history`
  ADD CONSTRAINT `state_history_ibfk_1` FOREIGN KEY (`lecturerID`) REFERENCES `lecturer` (`lecturerID`);

--
-- Constraints for table `vital`
--
ALTER TABLE `vital`
  ADD CONSTRAINT `vital_ibfk_1` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
