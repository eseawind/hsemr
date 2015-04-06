-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 25, 2015 at 07:11 AM
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
('2014-12-17 02:07:02', 'Oesophagogastroduodenoscopy and Biopsy', 'Oesophagogastroduodenoscopy_and_Biopsy.pdf', 1, 'SC3', 'ST0'),
('2015-01-21 07:23:27', 'Admission Notes', 'SC5ST0-AdmissionNotes.pdf', 1, 'SC5', 'ST0');

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
('od', 'on day'),
('OM', 'Every morning'),
('om (M, W, F, Sun)', 'Every morning on Mondays, Wedenesdays, Fridays and Sundays'),
('om (Tu, Th, Sat)', 'Every morning on Tuesdays, Thursdays and Saturdays'),
('ON', 'Every night'),
('once/week', 'Once per week'),
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
('q48h', 'very 48 hourly'),
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
('lec2', 'lec2'),
('lec3', 'lec3'),
('lec4', 'lec4'),
('lec5', 'lec5');

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
  `routeAbbr` varchar(10) NOT NULL,
  PRIMARY KEY (`medicineBarcode`,`routeAbbr`),
  KEY `routeAbbr` (`routeAbbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`medicineBarcode`, `medicineName`, `routeAbbr`) VALUES
('BSMORPHINE', 'Bolus Morphine', 'N.A'),
('CODYRAMOL', 'Codyramol', 'P.O.'),
('CYCLIZINE', 'Cyclizine', 'I.V.'),
('DEXSALINE', 'Dextrose Saline', 'I.V.'),
('DIGOXIN', 'Digoxin', 'P.O.'),
('EPINE', 'Epinephrine', 'N.A'),
('FSULFATE', 'Ferrous sulfate', 'P.O.'),
('HEPARIN', 'Heparin', 'N.A'),
('KCL', 'Potassium Chloride', 'I.V.'),
('KETOROLAC', 'Ketorolac', 'IVP'),
('MOM', 'Milk of Magnesia', 'P.O.'),
('MORPHINE', 'Morphine', 'I.V.'),
('MORPHINE', 'Morphine', 'P.R.'),
('MORPHINEPCA', 'Morphine PCA', 'N.A'),
('PANTOPRAZOLE', 'Pantoprazole', 'I.V.'),
('PRBC', 'PRBC', 'N.A'),
('PROCHLORPERAZINE', 'Prochlorperazine', 'I.M.'),
('SALINE', 'Normal Saline', 'I.V.');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_prescription`
--

CREATE TABLE IF NOT EXISTS `medicine_prescription` (
  `medicineBarcode` varchar(100) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `freqAbbr` varchar(10) NOT NULL,
  `dosage` varchar(100) NOT NULL,
  PRIMARY KEY (`medicineBarcode`,`scenarioID`,`stateID`,`freqAbbr`),
  KEY `scenarioID` (`scenarioID`),
  KEY `stateID` (`stateID`),
  KEY `freqAbbr` (`freqAbbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine_prescription`
--

INSERT INTO `medicine_prescription` (`medicineBarcode`, `scenarioID`, `stateID`, `freqAbbr`, `dosage`) VALUES
('BSMORPHINE', 'SC1', 'ST0', 'q2h', '2-4mg'),
('CODYRAMOL', 'SC3', 'ST0', 'q4h', '10/500mg'),
('CYCLIZINE', 'SC1', 'ST0', 'q6h', '25mg'),
('CYCLIZINE', 'SC5', 'ST0', 'q8h', '25mg'),
('DEXSALINE', 'SC1', 'ST0', 'q hr', '10mg'),
('DEXSALINE', 'SC4', 'ST0', 'q hr', '250mL'),
('DIGOXIN', 'SC3', 'ST0', 'daily', '125mcg'),
('EPINE', 'SC1', 'ST3', 'q hr', '0.5mL'),
('FSULFATE', 'SC1', 'ST0', 'BD', '400mg'),
('HEPARIN', 'SC3', 'ST0', 'TDS', '5000 units'),
('KCL', 'SC4', 'ST1', 'ASAP', '60mmols'),
('KCL', 'SC4', 'ST1', 'q hr', '40mmols'),
('KCL', 'SC4', 'ST2', 'q4h', '40mmols'),
('KCL', 'SC4', 'ST3', 'q hr', '40mmols'),
('KETOROLAC', 'SC1', 'ST0', 'q6h', '30mg'),
('MOM', 'SC1', 'ST0', 'daily', '30mL'),
('MORPHINE', 'SC3', 'ST0', 'q4h', '5-10mg'),
('MORPHINE', 'SC5', 'ST0', 'q2h', '2-5mg'),
('MORPHINEPCA', 'SC1', 'ST0', '4 hourly', '2mg'),
('PANTOPRAZOLE', 'SC5', 'ST0', 'q12h', '80mg'),
('PRBC', 'SC1', 'ST1', 'ASAP', 'two units'),
('PRBC', 'SC5', 'ST1', 'q hr', '100mL'),
('PROCHLORPERAZINE', 'SC3', 'ST0', 'q4h', '12.5mg'),
('SALINE', 'SC1', 'ST3', 'q hr', '200mL'),
('SALINE', 'SC4', 'ST0', 'ASAP', '1000mL'),
('SALINE', 'SC5', 'ST0', 'q hr', '125mL');

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

CREATE TABLE IF NOT EXISTS `note` (
  `noteID` int(11) NOT NULL AUTO_INCREMENT,
  `multidisciplinaryNote` varchar(15000) NOT NULL,
  `grpMemberNames` varchar(500) NOT NULL,
  `noteDatetime` datetime NOT NULL,
  `practicalGroupID` varchar(20) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  PRIMARY KEY (`noteID`),
  KEY `praticalgroupID` (`practicalGroupID`),
  KEY `ScenarioID` (`scenarioID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`noteID`, `multidisciplinaryNote`, `grpMemberNames`, `noteDatetime`, `practicalGroupID`, `scenarioID`) VALUES
(1, 'taken down hr,bp,intake, output, administer medicine', 'xuanqi, linwei, qiwei, linxuan, qiping', '2014-10-17 14:00:00', 'P02', 'SC1'),
(2, 'testestest', 'tingting, shiqi, weiyi, gladys, jocelyn, grace', '2014-10-21 11:25:00', 'P03', 'SC1'),
(3, 'Administered panadol at 5.34pm', 'glad, sq, wy, grace, joce', '2014-10-27 10:47:07', 'P01', 'SC1'),
(4, 'Chemistry report despatched. Blood pressure, spo2, respiration rate, heart rate normal. ', 'a, b, c, d', '2014-10-29 10:21:54', 'P01', 'SC1'),
(5, 'Hi hi 5 nov', 'grace Test ', '2014-11-05 15:53:25', 'P01', 'SC4');

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
('S5903259B', 'Ho Yin', 'Lee', 'Female', '10/10/1959'),
('S6901328A', 'Ho Yin', 'Lee', 'Female', '10/10/1969'),
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
('P02', 'P02', 'lec1'),
('P03', 'P03', 'lec2'),
('P04', 'P04', 'lec3'),
('P05', 'P05', 'lec5'),
('P06', 'P06', 'lec4'),
('P07', 'P07', 'lec5'),
('P08', 'P08', 'lec3'),
('P09', 'P09', 'lec4');

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE IF NOT EXISTS `prescription` (
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `doctorName` varchar(20) NOT NULL,
  `doctorOrder` varchar(500) NOT NULL,
  `freqAbbr` varchar(10) NOT NULL,
  `medicineBarcode` varchar(100) NOT NULL,
  PRIMARY KEY (`scenarioID`,`stateID`,`doctorOrder`,`freqAbbr`),
  KEY `stateID` (`stateID`),
  KEY `freqAbbr` (`freqAbbr`),
  KEY `medicineBarcode` (`medicineBarcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`scenarioID`, `stateID`, `doctorName`, `doctorOrder`, `freqAbbr`, `medicineBarcode`) VALUES
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Bolus Morphine 2-4mg every two hours prn pain', 'q2h', 'BSMORPHINE'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Cyclizine 25mg IV Bolus every six hours prn nausea', 'q6h', 'CYCLIZINE'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Ferrous sulfate 400mg PO twice a day with meals; begin when oral intake resumes', 'BD', 'FSULFATE'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'IV of Dextrose/Saline with KCL 20mEq per litre at 125 mL/hour', 'q hr', 'DEXSALINE'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Ketorolac 30mg IVP every six hours for three days', 'q6h', 'KETOROLAC'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Milk of Magnesia 30mL PO daily prn constipation', 'daily', 'MOM'),
('SC1', 'ST0', 'Dr.Tan/01234Z', 'Morphine PCA 2mg every 10min with four hour lockout of 40mg', '4 hourly', 'MORPHINEPCA'),
('SC1', 'ST1', 'Dr.Tan/01234Z', 'PRBCs two units NOW', 'ASAP', 'PRBC'),
('SC1', 'ST3', 'Dr.Tan/01234Z', '0.9% Normal Saline at 200mL/hour', 'q hr', 'SALINE'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Codyramol 10/500mg 1-2 tabs PO every 4-6 hours PRN for pain', 'q4h', 'CODYRAMOL'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Digoxin 125mcg PO every day', 'daily', 'DIGOXIN'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Heparin 5,000units SC three times a day', 'TDS', 'HEPARIN'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Morphine 5-10mg IM every 4-6 hours PRN for severe pain', 'q4h', 'MORPHINE'),
('SC3', 'ST0', 'Dr.Tan/01234Z', 'Prochlorperazine 12.5mg IM every 4-6 hours PRN for nausea', 'q4h', 'PROCHLORPERAZINE'),
('SC4', 'ST0', 'Dr.Tan/01234Z', 'Follow with Dextrose/Saline at 250mL/hour', 'q hr', 'DEXSALINE'),
('SC4', 'ST0', 'Dr.Tan/01234Z', 'Start IV 1000mL 0.9% Normal Saline at full-open rate', 'ASAP', 'SALINE'),
('SC4', 'ST1', 'Dr.Tan/01234Z', 'Followed by 40mmols per hour for three doses', 'q hr', 'MOM'),
('SC4', 'ST1', 'Dr.Tan/01234Z', 'KCl 60mmols IV push STAT', 'ASAP', 'KCL'),
('SC4', 'ST2', 'Dr.Tan/01234Z', 'Infuse Dextrose Saline with KCl 40mmol at 150mL/hour', 'q hr', 'DEXSALINE'),
('SC4', 'ST2', 'Dr.Tan/01234Z', 'Potassium chloride 40mmols in 500mL of 0.9% Normal Saline, infuse over four hours', 'q4h', 'KCL'),
('SC5', 'ST0', 'Dr.Tan/01234Z', 'Cyclizine 25mg IV every 8 hours prn nausea', 'q8h', 'CYCLIZINE'),
('SC5', 'ST0', 'Dr.Tan/01234Z', 'Morphine 2-5mg IV every 2-3 hours prn moderate to severe pain', 'q2h', 'MORPHINE'),
('SC5', 'ST0', 'Dr.Tan/01234Z', 'Pantoprazole 80mg IV stat, then every 12 hours', 'q12h', 'PANTOPRAZOLE'),
('SC5', 'ST0', 'Dr.Tan/01234Z', 'Start IV 0.9% Normal Saline at 125mL/hour', 'q hr', 'SALINE'),
('SC5', 'ST1', 'Dr.Tan/01234Z', 'Give 2units PRBC at 100mL/hour', 'q hr', 'PRBC');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `reportDatetime` datetime NOT NULL,
  `reportName` varchar(100) NOT NULL,
  `reportFile` varchar(200) NOT NULL,
  `dispatchStatus` tinyint(1) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `initialReport` tinyint(1) NOT NULL,
  PRIMARY KEY (`reportDatetime`,`reportName`),
  KEY `stateID` (`stateID`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`reportDatetime`, `reportName`, `reportFile`, `dispatchStatus`, `scenarioID`, `stateID`, `initialReport`) VALUES
('2014-10-28 14:00:00', 'Admission form-Post Gastre', 'Admissionform.pdf', 0, 'SC3', 'ST0', 0),
('2014-10-29 10:16:22', 'Chemistry NA140 K3.0', 'Chemistry_NA140_K3.0.pdf', 0, 'SC4', 'ST3', 0),
('2014-10-30 10:00:00', 'Emergency Department Case Record', 'EmergencyDepartmentCaseRecord.pdf', 0, 'SC2', 'ST0', 0),
('2014-10-31 00:14:25', 'Chemistry NA130 K2.0', 'Chemistry_NA130_K2.0.pdf', 0, 'SC4', 'ST1', 0),
('2015-01-21 06:22:12', 'Chemistry', 'SC5ST1-Chemistry.pdf', 0, 'SC5', 'ST1', 0),
('2015-01-21 08:28:41', 'Coagulation', 'SC5ST1-Coagulation.pdf', 0, 'SC5', 'ST1', 0),
('2015-01-21 11:41:26', 'Full Blood Count', 'SC5ST1-FullBloodCount.pdf', 0, 'SC5', 'ST1', 0);

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
  `scenarioStatus` tinyint(1) NOT NULL,
  `admissionNote` longtext NOT NULL,
  `bedNumber` int(100) NOT NULL,
  PRIMARY KEY (`scenarioID`),
  KEY `bedNumber` (`bedNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scenario`
--

INSERT INTO `scenario` (`scenarioID`, `scenarioName`, `scenarioDescription`, `scenarioStatus`, `admissionNote`, `bedNumber`) VALUES
('SC1', 'Anaphylactic Reaction to Blood Administration', 'This simulated clinical experience was designed to expose the learner to the patient who experiences an adverse reaction to blood transfusion. The patient is first day postoperative gynecological surgery who develops the complication of hypovolemia that requires a blood transfusion. \n\nThe simulated clinical experience will automatically progress to anaphylaxis and subsequent shock states without prompt recognition of the transfusion reaction. With prompt recognition and intervention, the patient stabilises. The anaphylactic component of this simulated clinical experience may be used separately depending on learning objectives and may be overlaid on any patient or other scenario. This simulated clinical experience is intended for the learner in Semester VI.        ', 0, 'A recently divorced, 46-year-old female, was admitted to the hospital yesterday morning for a total abdominal hysterectomy with bilateral salpingo-oophrectomy due to multiple large uterine fibroids. Over the past two years she had increasing pain that was not relieved with medication, excessively large menstrual flow, and long standing anemia refractory to standard treatment. Despite earlier recommendations from her healthcare provider to seek surgical intervention, she elected to wait due to multiple personal issues including her recent divorce and having two teenage children at home. During this time of postponing the surgery, she required two outpatient blood transfusions due to the severe anemia. Her significant preoperative lab values included a haemoglobin of 8.4 mml and a haematocrit of 32%. The morning of admission her vital signs were a heart rate of 78 bpm, blood pressure of 110/70, respiratory rate of 16, and a temperature of 37°C. Her blood type is A negative. Intraoperatively her estimated blood loss was 450mL. Her postoperative period has been uneventful and you are the nurse assigned to her care the following morning. The night nurse reports that the patient slept for the early part of the shift, but has been awake complaining of discomfort since 0430 hours. Her last vital signs, which were at that time, respiratory rate of 18, a heart rate of 88, blood pressure of 102/60 and a temperature of 37.4°C.\r\n\r\n<br><br>Healthcare Provider''s Order:\r\n<br>NBM until passing flatus then begin clear liquid diet and advance as tolerated\r\n<br>Vital signs every four hours\r\n<br>Out of bed to chair evening of surgery and then ambulate three times per day\r\n<br>Urinary catheter to bedside drainage; discontinue morning of postoperative day one\r\n<br>Intake and Output every shift\r\n<br>IV of Dextrose/Saline with KCl 20mEq per litre at 125mL/hour\r\n<br>AM labs: Haemoglobin and Haematocrit, Urea and Electrolytes, Creatinine, Glucose\r\n<br>Oxygen to maintain SpO2 greater than 92%\r\n<br>Incentive spirometre every hour while awake\r\n<br>Antiembolic stockings in situ while in bed\r\n<br>Morphine PCA 2mg every 10min with four hour lockout of 40mg or Bolus Morphine 2-4mg every two hours prn pain\r\n<br>Cyclizine 25mg IV Bolus every six hours prn nausea\r\n<br>Ketorolac 30mg IVP every six hours for three days\r\n<br>Ferrous sulfate 400mg PO twice a day with meals; begin when oral intake resumes\r\n<br>Milk of Magnesia 30mL PO daily prn constipation', 1),
('SC2', 'Basic Assessment of the Cardiac Patient', 'This simulated clinical experience allows the beginning learner to conduct a basic physical assessment of a truck driver at a health fair. Learners are expected to identify cardiac findings related to an unhealthy lifestyle. Learners are expected to obtain both subjective and objective data related to assessment of the cardiac system, recognize areas that could be addressed with health promotion, and document their findings. Common abnormal findings can also be discussed at the end of the simulated clinical experience. This simulated clinical experience is intended for learners in Semester II.', 0, 'A 56-year-old truck driver has come to the health fair for routine screening on a hot summer day. He is dressed\ncasually in a short sleeve shirt and shorts.', 2),
('SC3', 'Basic Assessment of the Postoperative Gastrectomy Patient', 'In this simulated clinical experience, learners conduct a basic physical assessment of a three-day postoperative partial gastrectomy patient. The patient exhibits five abnormal assessment findings for learners to identify and/or document, including: absent bowel sounds, hypertension, irregular cardiac rhythm, an abdominal dressing, and oedema. The scenario has one continuous state. The simulated clinical experience also consists of a psychosocial element, which the instructor may elect to incorporate and is intended for the learner in Semester I.', 0, 'This patient is a 76-year-old female whose chief complaint at her healthcare provider’s theatre was frequent indigestion and epigastric pain relieved by antacids. She also complained of rapid weight loss and feeling tired. After a series of tests, a biopsy was performed which confirmed stomach cancer. A partial gastrectomy was performed three days ago to remove the cancerous lesion. She is exhibiting signs of depression because of her recent diagnosis.\r\n\r\n\r\n<br><br> Health history: chronic gastritis, pernicious anaemia\r\n<br><br>Healthcare Provider’s Orders:\r\n<br>Digoxin 125mcg PO every day\r\n<br>Heparin 5,000units SC three times a day\r\n<br>Codyramol 10/500mg 1-2 tabs PO every 4-6 hours PRN for pain\r\n<br>Morphine 5-10mg IM every 4-6 hours PRN for severe pain\r\n<br>Prochlorperazine 12.5mg IM every 4-6 hours PRN for nausea\r\n<br>Saline flush\r\n<br>Post gastectomy clear fl uids to full liquids as tolerated\r\n<br>Physiotherpy referral for prevention of chest infection and to increase mobility\r\n<br>Oxygen at 2-4LPM nasal cannula to maintain SpO2 greater than 95%\r\n<br>Fluid Chart every shift\r\n<br>Walk with nurse\r\n<br>INR daily and notify physician of results\r\n<br>Blood Glucose', 3),
('SC4', 'Basic Dysrhythmia Recognition and Management', 'This simulated clinical experience involves a 24-year-old female university student who experiences heart palpitations, epigastric pain, muscle weakness, and a fainting episode in class. Initially she refused to go to the Emergency Department (ED), but later agreed to let a classmate drive her to the ED. Upon admission to the ED, the patient is diagnosed with a cardiac dysrhythmia. The patient states that she has been in excellent health all of her life. While waiting for the admission lab reports, the healthcare provider identifies signs of dehydration and specific physical findings associated with binge-purging bulimia nervosa. The lab report reveals severe hypokalaemia, which has resulted in destabilisation of the cardiac rhythm. The patient continues to deny purging. She remains in the ED for re-hydration, administration of IV potassium chloride, and stabilisation of the cardiac rhythm. She is admitted for psychiatric evaluation for the eating disorder and initiation of cognitive behavioural therapy. This simulated clinical experience is intended for the learner in Semester VI.', 1, 'The patient is a 24-year-old female who is brought into the Emergency Department (ED) from the university by a classmate. The classmate states that she “slumped over in the desk and nearly passed out.” The patient insists that she didn’t pass out and that she had a “weak spell from a stomach virus. I vomited once last night.” She is listless, has severe muscle weakness, and speaks very quietly, in a low voice. She states that while in class, she noticed her heart beating “really fast and hard at times.” She stated that she feels burning-type pain in the chest and epigastric area. She denies any health problems except constipation and irregular periods. She states her last menstrual cycle was six months ago. She denies allergies. She is heterosexual and has been sexually active since secondary school. Her partners used condoms and she has had six partners. She denies tobacco use and drugs but has an occasional glass or two of wine at parties. She lives in the city with her mother and her mother’s boyfriend who is a “heavy drinker.” She states that her father is “out of her life.” She is studying fashion design and plans to graduate in two years, then move to Paris.\n\n\n<br><br>Healthcare Provider’s Orders:\n<br>Admit to ED\n<br>Diagnosis: syncopal episode, palpitations, epigastric pain\n<br>Start IV 1000mL 0.9% Normal Saline at full-open rate. Follow with Dextrose/Saline at 250mL/hour\n<br>STAT ECG and continuous ECG monitoring\n<br>Continuous pulse oximetry\n<br>Oxygen via nasal cannula to maintain SpO2 greater than 95%\n<br>Orthostatic blood pressures every four hours\n<br>STAT labs: FBC, Electolytes, Urea, Creatinine, Urinalysis, Cardiac Markers, Toxicology Screen, Serum Pregnancy\nTest (SPT), Lipase, Hepatitis Screen,\n<br>STAT chest x-ray\n', 4),
('SC5', 'GI Bleed Aspirin Abuse', 'This simulated clinical experience focuses on a 67-year-old male patient admitted to a Medical-Surgical Ward\nbecause there is no bed in the Intensive Care Unit. The Emergency Department is too busy to keep the patient there\nand he must wait for a scheduled emergency endoscopy on the Medical-Surgical Ward. The patient has a history\nof two episodes of coffee ground vomitus at home. The patient arrives on unit with a bowl of coffee ground vomitus\nand bedpan of frank bloody stool. He is hypotensive and tachycardic. Learners intervene with his condition, he\nimproves and is stabilised on the unit. Three states, all manually transitioned, are included in this simulated clinical\nexperience which is intended for the learner in Semester V.', 0, 'A 67-year-old male was brought to the Emergency Department (ED) because he does not have a regular healthcare\nprovider by his family after complaining of severe abdominal pain. He vomited twice at home. His wife described\nthe vomitus as being “dark brown with something like coffee grounds.” The family also stated that he looked really\npale. For the past two years he has complained about his joints hurting and swelling in his hands. The patient\nstated that during the last month he had been taking four regular aspirin every 3-4 hours because he heard it helped\narthritis and was good for his heart. History: Former smoker. He is in general good health. He was last seen by his\nhealthcare provider about three years ago. He has no known allergies.<br>In the ED his baseline vital signs were: BP 146/85, RR 21 and unlaboured, Temp 36.4°C, SpO2 95% on room air.\nHis only complaint was of being “extremely tired.” An IV was started and blood specimens obtained and sent to\nthe lab. The on-call Endoscopy team has been notifi ed that an urgent endoscopy has been ordered. The urgent\nblood results found haemoglobin (Hb) 9.0 and haematocrit (Hct) 27%; other results are not back yet. Two peripheral\nIV lines with 0.9% Normal Saline solutions were started at 125mL/hour. Since the ED was extremely busy, and no\nbeds available in the Intensive Care Unit, the patient was transferred to the Medical-Surgical Ward as soon as a\nroom was available, while awaiting the emergency endoscopy team to arrive. On the way, the patient vomited.\nSpecifi c ED documentation is on the chart.<br><br>Healthcare Provider’s Orders:<br>Vital signs every 2 hours, notify if BP less than 100/45, Temp greater than 38.9°C, HR greater than 100, RR greater\nthan 25<br>Admit bloods: FBC, Electrolytes, Urea, Creatinine, Glucose, PT/PTT, Group and cross match for 3units of packed\nred blood cells (PRBC), Hct in AM<br>Start IV 0.9% Normal Saline at 125mL/hour<br>Pantoprazole 80mg IV stat, then every 12 hours<br>Cyclizine 25mg IV every 8 hours prn nausea<br>Morphine 2-5mg IV every 2-3 hours prn moderate to severe pain<br>Diet NBM<br>Nasogastric tube on free drainage / monitor and record amount, type and colour<br>Check SpO2, if below 95%, start O2 via nasal cannula at 2LPM<br>\n', 5);

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE IF NOT EXISTS `state` (
  `stateID` varchar(5) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateDescription` varchar(1000) NOT NULL,
  `stateStatus` tinyint(1) NOT NULL,
  `patientNRIC` varchar(10) NOT NULL,
  PRIMARY KEY (`stateID`,`scenarioID`),
  KEY `patientNRIC` (`patientNRIC`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`stateID`, `scenarioID`, `stateDescription`, `stateStatus`, `patientNRIC`) VALUES
('ST0', 'SC1', 'default state', 0, 'S6901328A'),
('ST0', 'SC2', 'default state', 0, 'S5903259B'),
('ST0', 'SC3', 'default state', 0, 'S3925683C'),
('ST0', 'SC4', 'default state', 1, 'S9136572D'),
('ST0', 'SC5', 'default state', 0, 'S4897583E'),
('ST1', 'SC1', 'Initial Assessment at 0800 Hours', 0, 'S6901328A'),
('ST1', 'SC2', 'History and Assessment', 0, 'S5903259B'),
('ST1', 'SC3', 'Baseline', 0, 'S3925683C'),
('ST1', 'SC4', 'Admission to ED', 0, 'S9136572D'),
('ST1', 'SC5', 'Admission to ward\r\nHypotensive', 0, 'S4897583E'),
('ST2', 'SC1', 'Blood Started at 1000 Hours', 0, 'S6901328A'),
('ST2', 'SC2', 'Optional state: Abnormals', 0, 'S5903259B'),
('ST2', 'SC4', 'Identifies Incorrect Order', 0, 'S9136572D'),
('ST2', 'SC5', 'Condition Deteriorates', 0, 'S4897583E'),
('ST3', 'SC1', 'Beginning Anaphylax in 30 minutes later', 0, 'S6901328A'),
('ST3', 'SC4', '4 Hours After Potassium Infusion', 0, 'S9136572D'),
('ST3', 'SC5', 'Improvement 5 Hours\r\nLater', 0, 'S4897583E'),
('ST4', 'SC1', 'Mild Anaphylaxis', 0, 'S6901328A'),
('ST5', 'SC1', 'Worsening Anaphylaxis', 0, 'S6901328A'),
('ST6', 'SC1', 'Severe Anaphylaxis', 0, 'S6901328A'),
('ST7', 'SC1', 'Epinephrine Administered', 0, 'S6901328A'),
('ST8', 'SC1', 'Complete Recovery', 0, 'S6901328A');

-- --------------------------------------------------------

--
-- Table structure for table `state_history`
--

CREATE TABLE IF NOT EXISTS `state_history` (
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `timeActivated` datetime NOT NULL,
  PRIMARY KEY (`timeActivated`),
  KEY `timeActivated` (`timeActivated`),
  KEY `timeActivated_2` (`timeActivated`),
  KEY `stateID` (`stateID`),
  KEY `scenarioID` (`scenarioID`)
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
  PRIMARY KEY (`vitalDatetime`,`scenarioID`),
  KEY `patientNRIC` (`scenarioID`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vital`
--

INSERT INTO `vital` (`vitalDatetime`, `scenarioID`, `temperature`, `RR`, `BPsystolic`, `BPdiastolic`, `HR`, `SPO`, `output`, `oralType`, `oralAmount`, `intravenousType`, `intravenousAmount`, `initialVital`) VALUES
('2015-01-13 11:35:47', 'SC1', '37.00', 16, 110, 70, 78, 0, '450ml blood loss', '', '', '', '', 1),
('2015-01-13 11:40:46', 'SC1', '37.40', 18, 102, 60, 88, 0, '', '', '', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vital_history`
--

CREATE TABLE IF NOT EXISTS `vital_history` (
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
  `practicalGroupID` varchar(20) NOT NULL,
  PRIMARY KEY (`vitalDatetime`,`scenarioID`),
  KEY `practicalGroupID` (`practicalGroupID`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `allergy_patient`
--
ALTER TABLE `allergy_patient`
  ADD CONSTRAINT `allergy_patient_ibfk_1` FOREIGN KEY (`patientNRIC`) REFERENCES `patient` (`patientNRIC`);

--
-- Constraints for table `medication_history`
--
ALTER TABLE `medication_history`
  ADD CONSTRAINT `medication_history_ibfk_1` FOREIGN KEY (`medicineBarcode`) REFERENCES `medicine` (`medicineBarcode`),
  ADD CONSTRAINT `medication_history_ibfk_2` FOREIGN KEY (`practicalGroupID`) REFERENCES `practicalgroup` (`practicalGroupID`),
  ADD CONSTRAINT `medication_history_ibfk_3` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`);

--
-- Constraints for table `medicine`
--
ALTER TABLE `medicine`
  ADD CONSTRAINT `medicine_ibfk_1` FOREIGN KEY (`routeAbbr`) REFERENCES `route` (`routeAbbr`);

--
-- Constraints for table `medicine_prescription`
--
ALTER TABLE `medicine_prescription`
  ADD CONSTRAINT `medicine_prescription_ibfk_1` FOREIGN KEY (`medicineBarcode`) REFERENCES `medicine` (`medicineBarcode`),
  ADD CONSTRAINT `medicine_prescription_ibfk_4` FOREIGN KEY (`freqAbbr`) REFERENCES `frequency` (`freqAbbr`);

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
-- Constraints for table `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_4` FOREIGN KEY (`medicineBarcode`) REFERENCES `medicine` (`medicineBarcode`),
  ADD CONSTRAINT `prescription_ibfk_3` FOREIGN KEY (`freqAbbr`) REFERENCES `frequency` (`freqAbbr`);

--
-- Constraints for table `state`
--
ALTER TABLE `state`
  ADD CONSTRAINT `state_ibfk_1` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`),
  ADD CONSTRAINT `state_ibfk_2` FOREIGN KEY (`patientNRIC`) REFERENCES `patient` (`patientNRIC`);

--
-- Constraints for table `vital`
--
ALTER TABLE `vital`
  ADD CONSTRAINT `vital_ibfk_1` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`);

--
-- Constraints for table `vital_history`
--
ALTER TABLE `vital_history`
  ADD CONSTRAINT `vital_history_ibfk_7` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`),
  ADD CONSTRAINT `vital_history_ibfk_2` FOREIGN KEY (`practicalGroupID`) REFERENCES `practicalgroup` (`practicalGroupID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
