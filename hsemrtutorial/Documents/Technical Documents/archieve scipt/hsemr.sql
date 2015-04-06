-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 19, 2014 at 02:24 PM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `hsemr`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `adminID` varchar(10) NOT NULL,
  `adminPassword` varchar(10) NOT NULL,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminID`, `adminPassword`) VALUES
('admin1', 'admin1');

-- --------------------------------------------------------

--
-- Table structure for table `allergy_patient`
--

CREATE TABLE IF NOT EXISTS `allergy_patient` (
  `patientNRIC` varchar(9) NOT NULL,
  `allergy` varchar(500) NOT NULL,
  PRIMARY KEY (`patientNRIC`,`allergy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `allergy_patient`
--

INSERT INTO `allergy_patient` (`patientNRIC`, `allergy`) VALUES
('S7843522B', 'seafood');

-- --------------------------------------------------------

--
-- Table structure for table `bed`
--

CREATE TABLE IF NOT EXISTS `bed` (
  `bedNumber` varchar(5) NOT NULL,
  `wardID` smallint(6) NOT NULL,
  `availabilityStatus` varchar(20) NOT NULL,
  PRIMARY KEY (`bedNumber`,`wardID`),
  KEY `wardID` (`wardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bed`
--

INSERT INTO `bed` (`bedNumber`, `wardID`, `availabilityStatus`) VALUES
('B1', 1, 'occupied'),
('B2', 1, 'available'),
('B3', 1, 'available'),
('B4', 1, 'available'),
('B5', 1, 'available'),
('B6', 1, 'available');

-- --------------------------------------------------------

--
-- Table structure for table `frequency`
--

CREATE TABLE IF NOT EXISTS `frequency` (
  `freqAbbr` varchar(10) NOT NULL,
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
('4 hourly o', 'every 4 hours or when necessary'),
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
('om (M, W, ', 'Every morning on Mondays, Wedenesdays, Fridays and Sundays'),
('om (Tu, Th', 'Every morning on Tuesdays, Thursdays and Saturdays'),
('ON', 'Every night'),
('once/week', 'Once per week'),
('over 4 hou', 'over 4 hours'),
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
  `lecturerID` varchar(10) NOT NULL,
  `lecturerPassword` varchar(10) NOT NULL,
  PRIMARY KEY (`lecturerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lecturer`
--

INSERT INTO `lecturer` (`lecturerID`, `lecturerPassword`) VALUES
('lec1', 'lec1');

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE IF NOT EXISTS `medicine` (
  `medicineBarCode` varchar(10) NOT NULL,
  `medicineName` varchar(20) NOT NULL,
  `medicineDosage` varchar(10) NOT NULL,
  `routeAbbr` varchar(10) NOT NULL,
  PRIMARY KEY (`medicineBarCode`),
  KEY `routeAbbr` (`routeAbbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`medicineBarCode`, `medicineName`, `medicineDosage`, `routeAbbr`) VALUES
('E35435', 'Epinephrine', '200mL', 'I.V.'),
('G12334', 'Cough Syrup', '2 spoons', 'AU'),
('G24342', 'Panadol', '2 pills', 'P.O.');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_prescription`
--

CREATE TABLE IF NOT EXISTS `medicine_prescription` (
  `medicineBarCode` varchar(10) NOT NULL,
  `patientNRIC` varchar(9) NOT NULL,
  `freqAbbr` varchar(10) NOT NULL,
  `prescriptionDate` varchar(30) NOT NULL,
  PRIMARY KEY (`medicineBarCode`,`patientNRIC`,`freqAbbr`,`prescriptionDate`),
  KEY `freqAbbr` (`freqAbbr`),
  KEY `patientNRIC` (`patientNRIC`),
  KEY `prescriptionDate` (`prescriptionDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine_prescription`
--

INSERT INTO `medicine_prescription` (`medicineBarCode`, `patientNRIC`, `freqAbbr`, `prescriptionDate`) VALUES
('E35435', 'S7843522B', '2x/week ', '2014-09-06 17:31:42');

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

CREATE TABLE IF NOT EXISTS `note` (
  `noteID` smallint(6) NOT NULL AUTO_INCREMENT,
  `multidisciplinaryNote` varchar(10000) NOT NULL,
  `tutorialGroup` varchar(10) NOT NULL,
  `grpMemberName` varchar(500) NOT NULL,
  `noteDate` varchar(30) NOT NULL,
  `nurseID` varchar(10) NOT NULL,
  PRIMARY KEY (`noteID`),
  KEY `nurseID` (`nurseID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`noteID`, `multidisciplinaryNote`, `tutorialGroup`, `grpMemberName`, `noteDate`, `nurseID`) VALUES
(1, 'taken down hr,bp,intake, output, administer medicine', 'T78', 'xuanqi, linwei, qiwei, linxuan, qiping', 'Fri Sep 19 22:18:02 SGT 2014', 'nurse1');

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE IF NOT EXISTS `nurse` (
  `nurseID` varchar(10) NOT NULL,
  `nursePassword` varchar(10) NOT NULL,
  PRIMARY KEY (`nurseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nurse`
--

INSERT INTO `nurse` (`nurseID`, `nursePassword`) VALUES
('nurse1', 'nurse1');

-- --------------------------------------------------------

--
-- Table structure for table `nurse_patient`
--

CREATE TABLE IF NOT EXISTS `nurse_patient` (
  `nurseID` varchar(10) NOT NULL,
  `patientNRIC` varchar(9) NOT NULL,
  PRIMARY KEY (`nurseID`,`patientNRIC`),
  KEY `patientNRIC` (`patientNRIC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nurse_patient`
--

INSERT INTO `nurse_patient` (`nurseID`, `patientNRIC`) VALUES
('nurse1', 'S7843522B');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `patientNRIC` varchar(9) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `gender` varchar(6) NOT NULL,
  `DOB` varchar(10) NOT NULL,
  `maritalStatus` varchar(10) NOT NULL,
  `weight` double NOT NULL,
  `height` double NOT NULL,
  `occupation` varchar(20) DEFAULT NULL,
  `race` varchar(20) NOT NULL,
  `religion` varchar(20) DEFAULT NULL,
  `nationality` varchar(20) NOT NULL,
  `wardID` smallint(6) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`patientNRIC`),
  KEY `wardID` (`wardID`),
  KEY `wardID_2` (`wardID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patientNRIC`, `firstName`, `lastName`, `gender`, `DOB`, `maritalStatus`, `weight`, `height`, `occupation`, `race`, `religion`, `nationality`, `wardID`) VALUES
('S7843522B', 'James', 'Tan', 'Male', '10/10/1978', 'Single', 65, 178, 'student', 'chinese', 'christian', 'singaporean', 1);

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE IF NOT EXISTS `prescription` (
  `patientNRIC` varchar(9) NOT NULL,
  `prescriptionDate` varchar(30) NOT NULL,
  `doctorName` varchar(20) NOT NULL,
  `doctorOrder` varchar(1000) NOT NULL,
  `freqAbbr` varchar(10) NOT NULL,
  PRIMARY KEY (`patientNRIC`,`prescriptionDate`,`freqAbbr`),
  KEY `freqAbbr` (`freqAbbr`),
  KEY `prescriptionDate` (`prescriptionDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`patientNRIC`, `prescriptionDate`, `doctorName`, `doctorOrder`, `freqAbbr`) VALUES
('S7843522B', '2014-09-06 17:31:42', 'Lee Ann', 'PRBCs two units NOW', 'ASAP');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `reportName` varchar(20) NOT NULL,
  `reportFile` varchar(100) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  PRIMARY KEY (`reportName`,`scenarioID`,`stateID`),
  KEY `scenarioID` (`scenarioID`),
  KEY `stateID` (`stateID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`reportName`, `reportFile`, `scenarioID`, `stateID`) VALUES
('Chemistry', 'http://exampleChemistry', 'SC1', 'ST1'),
('FBC', 'http://exampleFBC', 'SC1', 'ST2');

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
  `scenarioDescription` mediumtext NOT NULL,
  `status` varchar(11) NOT NULL,
  `admissionInfo` mediumtext NOT NULL,
  PRIMARY KEY (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scenario`
--

INSERT INTO `scenario` (`scenarioID`, `scenarioName`, `scenarioDescription`, `status`, `admissionInfo`) VALUES
('SC1', 'ECS UK Anaphylactic Reaction', 'This simulated clinical experience was designed to expose the learner to the patient who experiences an adverse reaction to blood transfusion. The patient is first day postoperative gynecological surgery who develops the complication of hypovolemia that requires a blood transfusion. The simulated clinical experience will automatically progress to anaphylaxis and subsequent shock states without prompt recognition of the transfusion reaction. With prompt recognition and intervention, the patient stabilises. The anaphylactic component of this simulated clinical experience may be used separately depending on learning objectives and may be overlaid on any patient or other scenario. This simulated clinical experience is intended for the learner in Semester VI.', 'activated', 'A recently divorced, 46-year-old female, was admitted to the hospital yesterday morning for a total abdominal hysterectomy with bilateral salpingo-oophrectomy due to multiple large uterine fi broids. Over the past two years she had increasing pain that was not relieved with medication, excessively large menstrual fl ow, and long standing anemia refractory to standard treatment. Despite earlier recommendations from her healthcare provider to seek surgical intervention, she elected to wait due to multiple personal issues including her recent divorce and having two teenage children at home. During this time of postponing the surgery, she required two outpatient blood transfusions due to the severe anemia. Her signifi cant preoperative lab values included a haemoglobin of 8.4 mml and a haematocrit of 32%. The morning of admission her vital signs were a heart rate of 78 bpm, blood pressure of 110/70, respiratory rate of 16, and a temperature of 37°C. Her blood type is A negative. Intraoperatively her estimated blood loss was 450mL. Her postoperative period has been uneventful and you are the nurse assigned to her care the following morning. The night nurse reports that the patient slept for the early part of the shift, but has been awake complaining of discomfort since 0430 hours. Her last vital signs, which were at that time, respiratory rate of 18, a heart rate of 88, blood pressure of 102/60 and a temperature of 37.4°C.'),
('SC2', 'EGREG', 'RGRE', 'deactivated', 'RGREH'),
('SC3', 'RGRG', 'ger', 'deactivated', 'egeger');

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE IF NOT EXISTS `state` (
  `stateID` varchar(5) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `RR` varchar(10) NOT NULL,
  `BP` varchar(10) NOT NULL,
  `HR` varchar(10) NOT NULL,
  `SPO` varchar(10) NOT NULL,
  `intake` varchar(50) NOT NULL,
  `output` varchar(50) NOT NULL,
  `temperature` decimal(4,2) DEFAULT NULL,
  `stateDescription` varchar(10000) NOT NULL,
  `patientNRIC` varchar(9) NOT NULL,
  PRIMARY KEY (`stateID`,`scenarioID`),
  KEY `patientNRIC` (`patientNRIC`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`stateID`, `scenarioID`, `RR`, `BP`, `HR`, `SPO`, `intake`, `output`, `temperature`, `stateDescription`, `patientNRIC`) VALUES
('ST1', 'SC1', '20', '90/52', '100', '92%', 'fruits', '50mL/hour, clear yellow urine', '37.60', 'Initial Assessment at 0800 Hours', 'S7843522B'),
('ST2', 'SC1', '', '', '', '', '', '', NULL, 'Blood Started at 1000 Hours', 'S7843522B'),
('ST3', 'SC1', '', '', '', '', '', '', NULL, 'Beginning Anaphylax in 30 minutes later', 'S7843522B'),
('ST4', 'SC1', '', '', '', '', '', '', NULL, 'Mild Anaphylaxis', 'S7843522B'),
('ST5', 'SC1', '', '', '', '', '', '', NULL, 'Worsening Anaphylaxis', 'S7843522B');

-- --------------------------------------------------------

--
-- Table structure for table `ward`
--

CREATE TABLE IF NOT EXISTS `ward` (
  `wardID` smallint(6) NOT NULL AUTO_INCREMENT,
  `wardType` varchar(10) NOT NULL,
  PRIMARY KEY (`wardID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ward`
--

INSERT INTO `ward` (`wardID`, `wardType`) VALUES
(1, 'Class A'),
(2, 'Class B'),
(3, 'Class C');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `allergy_patient`
--
ALTER TABLE `allergy_patient`
  ADD CONSTRAINT `allergy_patient_ibfk_1` FOREIGN KEY (`patientNRIC`) REFERENCES `patient` (`patientNRIC`);

--
-- Constraints for table `bed`
--
ALTER TABLE `bed`
  ADD CONSTRAINT `bed_ibfk_1` FOREIGN KEY (`wardID`) REFERENCES `ward` (`wardID`);

--
-- Constraints for table `medicine`
--
ALTER TABLE `medicine`
  ADD CONSTRAINT `medicine_ibfk_1` FOREIGN KEY (`routeAbbr`) REFERENCES `route` (`routeAbbr`);

--
-- Constraints for table `medicine_prescription`
--
ALTER TABLE `medicine_prescription`
  ADD CONSTRAINT `medicine_prescription_ibfk_6` FOREIGN KEY (`prescriptionDate`) REFERENCES `prescription` (`prescriptionDate`),
  ADD CONSTRAINT `medicine_prescription_ibfk_1` FOREIGN KEY (`medicineBarCode`) REFERENCES `medicine` (`medicineBarCode`),
  ADD CONSTRAINT `medicine_prescription_ibfk_3` FOREIGN KEY (`freqAbbr`) REFERENCES `frequency` (`freqAbbr`),
  ADD CONSTRAINT `medicine_prescription_ibfk_5` FOREIGN KEY (`patientNRIC`) REFERENCES `prescription` (`patientNRIC`);

--
-- Constraints for table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `note_ibfk_1` FOREIGN KEY (`nurseID`) REFERENCES `nurse` (`nurseID`);

--
-- Constraints for table `nurse_patient`
--
ALTER TABLE `nurse_patient`
  ADD CONSTRAINT `nurse_patient_ibfk_1` FOREIGN KEY (`nurseID`) REFERENCES `nurse` (`nurseID`),
  ADD CONSTRAINT `nurse_patient_ibfk_2` FOREIGN KEY (`patientNRIC`) REFERENCES `patient` (`patientNRIC`);

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`wardID`) REFERENCES `ward` (`wardID`);

--
-- Constraints for table `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`patientNRIC`) REFERENCES `patient` (`patientNRIC`),
  ADD CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`freqAbbr`) REFERENCES `frequency` (`freqAbbr`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`scenarioID`) REFERENCES `state` (`scenarioID`),
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`stateID`) REFERENCES `state` (`stateID`);

--
-- Constraints for table `state`
--
ALTER TABLE `state`
  ADD CONSTRAINT `state_ibfk_2` FOREIGN KEY (`patientNRIC`) REFERENCES `patient` (`patientNRIC`),
  ADD CONSTRAINT `state_ibfk_3` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
