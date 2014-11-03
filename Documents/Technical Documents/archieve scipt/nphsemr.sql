-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 21, 2014 at 02:54 PM
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
('admin1', 'admin1');

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
('S2315479I', 'batrium'),
('S2315479I', 'seafood');

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
  `lecturerID` varchar(20) NOT NULL,
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
('lec5', 'lec5'),
('lec6', 'lec6');

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE IF NOT EXISTS `medicine` (
  `medicineBarcode` varchar(10) NOT NULL,
  `medicineName` varchar(30) NOT NULL,
  `dosage` varchar(10) NOT NULL,
  `medicineDatetime` datetime NOT NULL,
  `routeAbbr` varchar(10) NOT NULL,
  PRIMARY KEY (`medicineBarcode`),
  KEY `routeAbbr` (`routeAbbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`medicineBarcode`, `medicineName`, `dosage`, `medicineDatetime`, `routeAbbr`) VALUES
('E35435', 'Epinephrine', '200mL', '2014-10-21 01:00:00', 'I.V.'),
('G12334', 'Cough Syrup', '2 spoons', '2014-10-20 04:00:00', 'AU'),
('G24342', 'Panadol', '2 pills', '2014-10-19 13:00:00', 'P.O.');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_prescription`
--

CREATE TABLE IF NOT EXISTS `medicine_prescription` (
  `medicineBarcode` varchar(10) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `freqAbbr` varchar(10) NOT NULL,
  PRIMARY KEY (`medicineBarcode`,`scenarioID`,`stateID`,`freqAbbr`),
  KEY `scenarioID` (`scenarioID`),
  KEY `stateID` (`stateID`),
  KEY `freqAbbr` (`freqAbbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medicine_prescription`
--

INSERT INTO `medicine_prescription` (`medicineBarcode`, `scenarioID`, `stateID`, `freqAbbr`) VALUES
('G12334', 'SC1', 'ST1', '2x/week ');

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

CREATE TABLE IF NOT EXISTS `note` (
  `noteID` int(11) NOT NULL AUTO_INCREMENT,
  `multidisciplinaryNote` varchar(15000) NOT NULL,
  `grpMemberNames` varchar(500) NOT NULL,
  `noteDatetime` datetime NOT NULL,
  `practicalGroupID` varchar(5) NOT NULL,
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
(2, 'testestest', 'shiqi, weiyi, gladys, jocelyn, grace', '2014-10-20 16:00:00', 'P01', 'SC1'),
(3, 'testestest', 'tingting, shiqi, weiyi, gladys, jocelyn, grace', '2014-10-21 11:25:00', 'P03', 'SC2');

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
  `wardID` varchar(6) NOT NULL,
  `bedNumber` int(30) NOT NULL,
  PRIMARY KEY (`patientNRIC`),
  KEY `wardID` (`wardID`),
  KEY `bedNumber` (`bedNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patientNRIC`, `firstName`, `lastName`, `gender`, `DOB`, `wardID`, `bedNumber`) VALUES
('S2315479I', 'Ho Yin', 'Lee', 'female', '10/10/1938', 'ward 2', 2),
('S7843522B', 'Mei Mei', 'Tan', 'female', '10/10/1968', 'ward 2', 1);

-- --------------------------------------------------------

--
-- Table structure for table `practicalgroup`
--

CREATE TABLE IF NOT EXISTS `practicalgroup` (
  `practicalGroupID` varchar(5) NOT NULL,
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
('P05', 'P05', 'lec4'),
('P06', 'P06', 'lec4'),
('P07', 'P07', 'lec5'),
('P08', 'P08', 'lec6'),
('P09', 'P09', 'lec6');

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE IF NOT EXISTS `prescription` (
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  `doctorName` varchar(20) NOT NULL,
  `doctorOrder` varchar(1000) NOT NULL,
  `freqAbbr` varchar(10) NOT NULL,
  PRIMARY KEY (`scenarioID`,`stateID`,`freqAbbr`),
  KEY `stateID` (`stateID`),
  KEY `freqAbbr` (`freqAbbr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`scenarioID`, `stateID`, `doctorName`, `doctorOrder`, `freqAbbr`) VALUES
('SC1', 'ST1', 'Dr Fong Pei Yin', 'PRBCs two units NOW', 'ASAP'),
('SC1', 'ST2', 'Dr Fong Pei Yin', 'ECG ', 'ac ');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `reportDatetime` datetime NOT NULL,
  `reportName` varchar(30) NOT NULL,
  `reportFile` varchar(200) NOT NULL,
  `dispatchStatus` tinyint(1) NOT NULL,
  `scenarioID` varchar(5) NOT NULL,
  `stateID` varchar(5) NOT NULL,
  PRIMARY KEY (`reportDatetime`,`reportName`,`scenarioID`,`stateID`),
  KEY `stateID` (`stateID`),
  KEY `scenarioID` (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`reportDatetime`, `reportName`, `reportFile`, `dispatchStatus`, `scenarioID`, `stateID`) VALUES
('2014-10-20 14:00:00', 'Chemistry', 'http://exampleChemistry', 1, 'SC1', 'ST1'),
('2014-10-21 17:00:00', 'FBC', 'http://exampleFBC', 1, 'SC1', 'ST1');

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
  `scenarioDescription` longtext NOT NULL,
  `scenarioStatus` tinyint(1) NOT NULL,
  `admissionNote` mediumtext NOT NULL,
  PRIMARY KEY (`scenarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scenario`
--

INSERT INTO `scenario` (`scenarioID`, `scenarioName`, `scenarioDescription`, `scenarioStatus`, `admissionNote`) VALUES
('SC1', 'ECS UK Anaphylactic Reaction', 'This simulated clinical experience was designed to expose the learner to the patient who experiences an adverse reaction to blood transfusion. The patient is first day postoperative gynecological surgery who develops the complication of hypovolemia that requires a blood transfusion. The simulated clinical experience will automatically progress to anaphylaxis and subsequent shock states without prompt recognition of the transfusion reaction. With prompt recognition and intervention, the patient stabilises. The anaphylactic component of this simulated clinical experience may be used separately depending on learning objectives and may be overlaid on any patient or other scenario. This simulated clinical experience is intended for the learner in Semester VI.', 1, 'A recently divorced, 46-year-old female, was admitted to the hospital yesterday morning for a total abdominal hysterectomy with bilateral salpingo-oophrectomy due to multiple large uterine fi broids. Over the past two years she had increasing pain that was not relieved with medication, excessively large menstrual fl ow, and long standing anemia refractory to standard treatment. Despite earlier recommendations from her healthcare provider to seek surgical intervention, she elected to wait due to multiple personal issues including her recent divorce and having two teenage children at home. During this time of postponing the surgery, she required two outpatient blood transfusions due to the severe anemia. Her signifi cant preoperative lab values included a haemoglobin of 8.4 mml and a haematocrit of 32%. The morning of admission her vital signs were a heart rate of 78 bpm, blood pressure of 110/70, respiratory rate of 16, and a temperature of 37°C. Her blood type is A negative. Intraoperatively her estimated blood loss was 450mL. Her postoperative period has been uneventful and you are the nurse assigned to her care the following morning. The night nurse reports that the patient slept for the early part of the shift, but has been awake complaining of discomfort since 0430 hours. Her last vital signs, which were at that time, respiratory rate of 18, a heart rate of 88, blood pressure of 102/60 and a temperature of 37.4°C.'),
('SC2', 'another scenario', 'testtest', 0, 'testesttest');

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
('ST0', 'SC1', 'just admitted', 1, 'S2315479I'),
('ST0', 'SC2', 'hello test', 0, 'S7843522B'),
('ST1', 'SC1', 'Initial Assessment at 0800 Hours', 0, 'S2315479I'),
('ST2', 'SC1', 'Blood Started at 1000 Hours', 0, 'S2315479I'),
('ST3', 'SC1', 'Beginning Anaphylax in 30 minutes later', 0, 'S2315479I'),
('ST4', 'SC1', 'Mild Anaphylaxis', 0, 'S2315479I'),
('ST5', 'SC1', 'Worsening Anaphylaxis', 0, 'S2315479I');

-- --------------------------------------------------------

--
-- Table structure for table `vital`
--

CREATE TABLE IF NOT EXISTS `vital` (
  `vitalDatetime` datetime NOT NULL,
  `patientNRIC` varchar(10) NOT NULL,
  `temperature` decimal(4,2) NOT NULL,
  `RR` int(10) NOT NULL,
  `BPsystolic` int(10) NOT NULL,
  `BPdiastolic` int(10) NOT NULL,
  `HR` int(10) NOT NULL,
  `SPO` int(10) NOT NULL,
  `output` varchar(50) NOT NULL,
  `oralType` varchar(100) NOT NULL,
  `oralAmount` varchar(30) NOT NULL,
  `intravenousType` varchar(100) NOT NULL,
  `intravenousAmount` varchar(30) NOT NULL,
  PRIMARY KEY (`vitalDatetime`,`patientNRIC`),
  KEY `patientNRIC` (`patientNRIC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vital`
--

INSERT INTO `vital` (`vitalDatetime`, `patientNRIC`, `temperature`, `RR`, `BPsystolic`, `BPdiastolic`, `HR`, `SPO`, `output`, `oralType`, `oralAmount`, `intravenousType`, `intravenousAmount`) VALUES
('2014-10-11 15:00:00', 'S2315479I', '37.50', 45, 92, 52, 100, 92, '50', 'water', '50', 'saline', '100');

-- --------------------------------------------------------

--
-- Table structure for table `ward`
--

CREATE TABLE IF NOT EXISTS `ward` (
  `wardID` varchar(6) NOT NULL,
  `bedNumber` int(30) NOT NULL,
  `availabilityStatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`wardID`,`bedNumber`),
  KEY `bedNumber` (`bedNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ward`
--

INSERT INTO `ward` (`wardID`, `bedNumber`, `availabilityStatus`) VALUES
('ward 1', 1, 1),
('ward 1', 2, 0),
('ward 1', 3, 0),
('ward 1', 4, 0),
('ward 2', 1, 1),
('ward 2', 2, 0),
('ward 2', 3, 0),
('ward 2', 4, 0),
('ward 3', 1, 1),
('ward 3', 2, 0),
('ward 3', 3, 0),
('ward 3', 4, 0),
('ward 4', 1, 1),
('ward 4', 2, 0),
('ward 4', 3, 0),
('ward 4', 4, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `allergy_patient`
--
ALTER TABLE `allergy_patient`
  ADD CONSTRAINT `allergy_patient_ibfk_1` FOREIGN KEY (`patientNRIC`) REFERENCES `patient` (`patientNRIC`);

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
  ADD CONSTRAINT `medicine_prescription_ibfk_2` FOREIGN KEY (`scenarioID`) REFERENCES `prescription` (`scenarioID`),
  ADD CONSTRAINT `medicine_prescription_ibfk_3` FOREIGN KEY (`stateID`) REFERENCES `prescription` (`stateID`),
  ADD CONSTRAINT `medicine_prescription_ibfk_4` FOREIGN KEY (`freqAbbr`) REFERENCES `frequency` (`freqAbbr`);

--
-- Constraints for table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `note_ibfk_1` FOREIGN KEY (`practicalgroupID`) REFERENCES `practicalgroup` (`practicalgroupID`),
  ADD CONSTRAINT `note_ibfk_2` FOREIGN KEY (`scenarioID`) REFERENCES `scenario` (`scenarioID`),
  ADD CONSTRAINT `note_ibfk_3` FOREIGN KEY (`practicalGroupID`) REFERENCES `practicalgroup` (`practicalGroupID`);

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`bedNumber`) REFERENCES `ward` (`bedNumber`),
  ADD CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`wardID`) REFERENCES `ward` (`wardID`);

--
-- Constraints for table `practicalgroup`
--
ALTER TABLE `practicalgroup`
  ADD CONSTRAINT `practicalgroup_ibfk_1` FOREIGN KEY (`lecturerID`) REFERENCES `lecturer` (`lecturerID`);

--
-- Constraints for table `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`scenarioID`) REFERENCES `state` (`scenarioID`),
  ADD CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`stateID`) REFERENCES `state` (`stateID`),
  ADD CONSTRAINT `prescription_ibfk_3` FOREIGN KEY (`freqAbbr`) REFERENCES `frequency` (`freqAbbr`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`stateID`) REFERENCES `state` (`stateID`),
  ADD CONSTRAINT `report_ibfk_3` FOREIGN KEY (`scenarioID`) REFERENCES `state` (`scenarioID`);

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
  ADD CONSTRAINT `vital_ibfk_1` FOREIGN KEY (`patientNRIC`) REFERENCES `patient` (`patientNRIC`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
