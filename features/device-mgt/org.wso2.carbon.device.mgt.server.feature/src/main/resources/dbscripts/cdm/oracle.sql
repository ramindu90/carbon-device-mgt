/* SQLINES EVALUATION VERSION TRUNCATES VARIABLE NAMES AND COMMENTS. */
/* OBTAIN A LICENSE AT WWW.SQLINES.COM FOR FULL CONVERSION. THANK YOU. */

CREATE TABLE DM_DEVICE_TYPE (
     ID NUMBER(10) NOT NULL,
     NAME VARCHAR2(300) DEFAULT NULL,
     PRIMARY KEY (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_DEVICE_TYPE_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_DEVICE_TYPE_seq_tr
 BEFORE INSERT ON DM_DEVICE_TYPE FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_DEVICE_TYPE_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_DEVICE (
     ID                    NUMBER(10) NOT NULL,
     DESCRIPTION           CLOB DEFAULT NULL,
     NAME                  VARCHAR2(100) DEFAULT NULL,
     DEVICE_TYPE_ID        NUMBER(10) DEFAULT NULL,
     DEVICE_IDENTIFICATION VARCHAR2(300) DEFAULT NULL,
     TENANT_ID NUMBER(10) DEFAULT 0,
     PRIMARY KEY (ID),
     CONSTRAINT fk_DM_DEVICE_DM_DEVICE_TYPE2 FOREIGN KEY (DEVICE_TYPE_ID )
     REFERENCES DM_DEVICE_TYPE (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_DEVICE_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_DEVICE_seq_tr
 BEFORE INSERT ON DM_DEVICE FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_DEVICE_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_OPERATION (
    ID NUMBER(10) NOT NULL,
    TYPE VARCHAR2(50) NOT NULL,
    CREATED_TIMESTAMP TIMESTAMP(0) NOT NULL,
    RECEIVED_TIMESTAMP TIMESTAMP(0) NULL,
    OPERATION_CODE VARCHAR2(1000) NOT NULL,
    PRIMARY KEY (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_OPERATION_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_OPERATION_seq_tr
 BEFORE INSERT ON DM_OPERATION FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_OPERATION_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_CONFIG_OPERATION (
    OPERATION_ID NUMBER(10) NOT NULL,
    OPERATION_CONFIG  BLOB DEFAULT NULL,
    PRIMARY KEY (OPERATION_ID),
    CONSTRAINT fk_dm_operation_config FOREIGN KEY (OPERATION_ID) REFERENCES
    DM_OPERATION (ID)
);

CREATE TABLE DM_COMMAND_OPERATION (
    OPERATION_ID NUMBER(10) NOT NULL,
    ENABLED CHAR(1) DEFAULT FALSE NOT NULL,
    PRIMARY KEY (OPERATION_ID),
    CONSTRAINT fk_dm_operation_command FOREIGN KEY (OPERATION_ID) REFERENCES
    DM_OPERATION (ID)
);

CREATE TABLE DM_POLICY_OPERATION (
    OPERATION_ID NUMBER(10) NOT NULL,
    ENABLED NUMBER(10) DEFAULT 0 NOT NULL,
    OPERATION_DETAILS BLOB DEFAULT NULL,
    PRIMARY KEY (OPERATION_ID),
    CONSTRAINT fk_dm_operation_policy FOREIGN KEY (OPERATION_ID) REFERENCES
    DM_OPERATION (ID)
);

CREATE TABLE DM_PROFILE_OPERATION (
    OPERATION_ID NUMBER(10) NOT NULL,
    ENABLED NUMBER(10) DEFAULT 0 NOT NULL,
    OPERATION_DETAILS BLOB DEFAULT NULL,
    PRIMARY KEY (OPERATION_ID),
    CONSTRAINT fk_dm_operation_profile FOREIGN KEY (OPERATION_ID) REFERENCES
    DM_OPERATION (ID)
);

CREATE TABLE DM_ENROLMENT (
    ID NUMBER(10) NOT NULL,
    DEVICE_ID NUMBER(10) NOT NULL,
    OWNER VARCHAR2(50) NOT NULL,
    OWNERSHIP VARCHAR2(45) DEFAULT NULL,
    STATUS VARCHAR2(50) NULL,
    DATE_OF_ENROLMENT TIMESTAMP(0) DEFAULT NULL,
    DATE_OF_LAST_UPDATE TIMESTAMP(0) DEFAULT NULL,
    TENANT_ID NUMBER(10) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_dm_device_enrolment FOREIGN KEY (DEVICE_ID) REFERENCES
    DM_DEVICE (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_ENROLMENT_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_ENROLMENT_seq_tr
 BEFORE INSERT ON DM_ENROLMENT FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_ENROLMENT_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_ENROLMENT_OPERATION_MAPPING (
    ID NUMBER(10) NOT NULL,
    ENROLMENT_ID NUMBER(10) NOT NULL,
    OPERATION_ID NUMBER(10) NOT NULL,
    STATUS VARCHAR2(50) NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_dm_device_operation_mapping_device FOREIGN KEY (ENROLMENT_ID) REFERENCES
    DM_ENROLMENT (ID),
    CONSTRAINT fk_dm_device_operation_mapping_operation FOREIGN KEY (OPERATION_ID) REFERENCES
    DM_OPERATION (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_ENROLMENT_OPERATION_MAPPING_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_ENROLMENT_OPERATION_MAPPING_seq_tr
 BEFORE INSERT ON DM_ENROLMENT_OPERATION_MAPPING FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_ENROLMENT_OPERATION_MAPPING_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_DEVICE_OPERATION_RESPONSE (
    ID NUMBER(10) NOT NULL,
    DEVICE_ID NUMBER(10) NOT NULL,
    OPERATION_ID NUMBER(10) NOT NULL,
    OPERATION_RESPONSE BLOB DEFAULT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_dm_device_operation_response_device FOREIGN KEY (DEVICE_ID) REFERENCES
    DM_DEVICE (ID),
    CONSTRAINT fk_dm_device_operation_response_operation FOREIGN KEY (OPERATION_ID) REFERENCES
    DM_OPERATION (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_DEVICE_OPERATION_RESPONSE_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_DEVICE_OPERATION_RESPONSE_seq_tr
 BEFORE INSERT ON DM_DEVICE_OPERATION_RESPONSE FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_DEVICE_OPERATION_RESPONSE_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

--- POLICY RELA... *** SQLINES FOR EVALUATION USE ONLY ***




CREATE  TABLE DM_PROFILE (
  ID NUMBER(10) NOT NULL ,
  PROFILE_NAME VARCHAR2(45) NOT NULL ,
  TENANT_ID NUMBER(10) NOT NULL ,
  DEVICE_TYPE_ID NUMBER(10) NOT NULL ,
  CREATED_TIME TIMESTAMP(0) NOT NULL ,
  UPDATED_TIME TIMESTAMP(0) NOT NULL ,
  PRIMARY KEY (ID) ,
  CONSTRAINT DM_PROFILE_DEVICE_TYPE
    FOREIGN KEY (DEVICE_TYPE_ID )
    REFERENCES DM_DEVICE_TYPE (ID )
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_PROFILE_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_PROFILE_seq_tr
 BEFORE INSERT ON DM_PROFILE FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_PROFILE_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/





CREATE  TABLE DM_POLICY (
  ID NUMBER(10) NOT NULL ,
  NAME VARCHAR2(45) DEFAULT NULL ,
  DESCRIPTION VARCHAR2(1000) NULL,
  TENANT_ID NUMBER(10) NOT NULL ,
  PROFILE_ID NUMBER(10) NOT NULL ,
  OWNERSHIP_TYPE VARCHAR2(45) NULL,
  COMPLIANCE VARCHAR2(100) NULL,
  PRIORITY NUMBER(10) NOT NULL,
  ACTIVE NUMBER(10) NOT NULL,
  UPDATED NUMBER(10) NULL,
  PRIMARY KEY (ID) ,
  CONSTRAINT FK_DM_PROFILE_DM_POLICY
    FOREIGN KEY (PROFILE_ID )
    REFERENCES DM_PROFILE (ID )
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_POLICY_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_POLICY_seq_tr
 BEFORE INSERT ON DM_POLICY FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_POLICY_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/




CREATE  TABLE DM_DEVICE_POLICY (
  ID NUMBER(10) NOT NULL ,
  DEVICE_ID NUMBER(10) NOT NULL ,
  ENROLMENT_ID NUMBER(10) NOT NULL,
  DEVICE BLOB NOT NULL,
  POLICY_ID NUMBER(10) NOT NULL ,
  PRIMARY KEY (ID) ,
  CONSTRAINT FK_POLICY_DEVICE_POLICY
    FOREIGN KEY (POLICY_ID )
    REFERENCES DM_POLICY (ID )
   ,
  CONSTRAINT FK_DEVICE_DEVICE_POLICY
    FOREIGN KEY (DEVICE_ID )
    REFERENCES DM_DEVICE (ID )
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_DEVICE_POLICY_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_DEVICE_POLICY_seq_tr
 BEFORE INSERT ON DM_DEVICE_POLICY FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_DEVICE_POLICY_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/




CREATE  TABLE DM_DEVICE_TYPE_POLICY (
  ID NUMBER(10) NOT NULL ,
  DEVICE_TYPE_ID NUMBER(10) NOT NULL ,
  POLICY_ID NUMBER(10) NOT NULL ,
  PRIMARY KEY (ID) ,
  CONSTRAINT FK_DEVICE_TYPE_POLICY
    FOREIGN KEY (POLICY_ID )
    REFERENCES DM_POLICY (ID )
   ,
  CONSTRAINT FK_DEVICE_TYPE_POLICY_DEVICE_TYPE
    FOREIGN KEY (DEVICE_TYPE_ID )
    REFERENCES DM_DEVICE_TYPE (ID )
);





CREATE  TABLE DM_PROFILE_FEATURES (
  ID NUMBER(10) NOT NULL,
  PROFILE_ID NUMBER(10) NOT NULL,
  FEATURE_CODE VARCHAR2(30) NOT NULL,
  DEVICE_TYPE_ID NUMBER(10) NOT NULL,
  TENANT_ID NUMBER(10) NOT NULL ,
  CONTENT BLOB DEFAULT NULL NULL,
  PRIMARY KEY (ID),
  CONSTRAINT FK_DM_PROFILE_DM_POLICY_FEATURES
    FOREIGN KEY (PROFILE_ID)
    REFERENCES DM_PROFILE (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_PROFILE_FEATURES_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_PROFILE_FEATURES_seq_tr
 BEFORE INSERT ON DM_PROFILE_FEATURES FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_PROFILE_FEATURES_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/




CREATE  TABLE DM_ROLE_POLICY (
  ID NUMBER(10) NOT NULL ,
  ROLE_NAME VARCHAR2(45) NOT NULL ,
  POLICY_ID NUMBER(10) NOT NULL ,
  PRIMARY KEY (ID) ,
  CONSTRAINT FK_ROLE_POLICY_POLICY
    FOREIGN KEY (POLICY_ID )
    REFERENCES DM_POLICY (ID )
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_ROLE_POLICY_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_ROLE_POLICY_seq_tr
 BEFORE INSERT ON DM_ROLE_POLICY FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_ROLE_POLICY_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/




CREATE  TABLE DM_USER_POLICY (
  ID NUMBER(10) NOT NULL ,
  POLICY_ID NUMBER(10) NOT NULL ,
  USERNAME VARCHAR2(45) NOT NULL ,
  PRIMARY KEY (ID) ,
  CONSTRAINT DM_POLICY_USER_POLICY
    FOREIGN KEY (POLICY_ID )
    REFERENCES DM_POLICY (ID )
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_USER_POLICY_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_USER_POLICY_seq_tr
 BEFORE INSERT ON DM_USER_POLICY FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_USER_POLICY_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/


 CREATE  TABLE DM_DEVICE_POLICY_APPLIED (
  ID NUMBER(10) NOT NULL ,
  DEVICE_ID NUMBER(10) NOT NULL ,
  ENROLMENT_ID NUMBER(10) NOT NULL,
  POLICY_ID NUMBER(10) NOT NULL ,
  POLICY_CONTENT BLOB NULL ,
  TENANT_ID NUMBER(10) NOT NULL,
  APPLIED NUMBER(3) NULL ,
  CREATED_TIME TIMESTAMP(0) NULL ,
  UPDATED_TIME TIMESTAMP(0) NULL ,
  APPLIED_TIME TIMESTAMP(0) NULL ,
  PRIMARY KEY (ID) ,
  CONSTRAINT FK_DM_POLICY_DEVCIE_APPLIED
    FOREIGN KEY (DEVICE_ID )
    REFERENCES DM_DEVICE (ID )
   ,
  CONSTRAINT FK_DM_POLICY_DEVICE_APPLIED_POLICY
    FOREIGN KEY (POLICY_ID )
    REFERENCES DM_POLICY (ID )
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_DEVICE_POLICY_APPLIED_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_DEVICE_POLICY_APPLIED_seq_tr
  BEFORE INSERT ON DM_DEVICE_POLICY_APPLIED FOR EACH ROW
  WHEN (NEW.ID IS NULL)
 BEGIN
 SELECT DM_DEVICE_POLICY_APPLIED_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/



CREATE TABLE DM_CRITERIA (
  ID NUMBER(10) NOT NULL,
  TENANT_ID NUMBER(10) NOT NULL,
  NAME VARCHAR2(50) NULL,
  PRIMARY KEY (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_CRITERIA_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_CRITERIA_seq_tr
 BEFORE INSERT ON DM_CRITERIA FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_CRITERIA_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/



CREATE TABLE DM_POLICY_CRITERIA (
  ID NUMBER(10) NOT NULL,
  CRITERIA_ID NUMBER(10) NOT NULL,
  POLICY_ID NUMBER(10) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT FK_CRITERIA_POLICY_CRITERIA
    FOREIGN KEY (CRITERIA_ID)
    REFERENCES DM_CRITERIA (ID)
   ,
  CONSTRAINT FK_POLICY_POLICY_CRITERIA
    FOREIGN KEY (POLICY_ID)
    REFERENCES DM_POLICY (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_POLICY_CRITERIA_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_POLICY_CRITERIA_seq_tr
 BEFORE INSERT ON DM_POLICY_CRITERIA FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_POLICY_CRITERIA_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_POLICY_CRITERIA_PROPERTIES (
  ID NUMBER(10) NOT NULL,
  POLICY_CRITERION_ID NUMBER(10) NOT NULL,
  PROP_KEY VARCHAR2(45) NULL,
  PROP_VALUE VARCHAR2(100) NULL,
  CONTENT BLOB NULL ,
  PRIMARY KEY (ID),
  CONSTRAINT FK_POLICY_CRITERIA_PROPERTIES
    FOREIGN KEY (POLICY_CRITERION_ID)
    REFERENCES DM_POLICY_CRITERIA (ID)
    ON DELETE CASCADE
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_POLICY_CRITERIA_PROPERTIES_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_POLICY_CRITERIA_PROPERTIES_seq_tr
 BEFORE INSERT ON DM_POLICY_CRITERIA_PROPERTIES FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_POLICY_CRITERIA_PROPERTIES_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_POLICY_COMPLIANCE_STATUS (
  ID NUMBER(10) NOT NULL,
  DEVICE_ID NUMBER(10) NOT NULL,
  ENROLMENT_ID NUMBER(10) NOT NULL,
  POLICY_ID NUMBER(10) NOT NULL,
  TENANT_ID NUMBER(10) NOT NULL,
  STATUS NUMBER(10) NULL,
  LAST_SUCCESS_TIME TIMESTAMP(0) NULL,
  LAST_REQUESTED_TIME TIMESTAMP(0) NULL,
  LAST_FAILED_TIME TIMESTAMP(0) NULL,
  ATTEMPTS NUMBER(10) NULL,
  PRIMARY KEY (ID),
  CONSTRAINT DEVICE_ID_UNIQUE UNIQUE (DEVICE_ID),
  CONSTRAINT FK_POLICY_COMPLIANCE_STATUS_POLICY
    FOREIGN KEY (POLICY_ID)
    REFERENCES DM_POLICY (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_POLICY_COMPLIANCE_STATUS_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_POLICY_COMPLIANCE_STATUS_seq_tr
 BEFORE INSERT ON DM_POLICY_COMPLIANCE_STATUS FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_POLICY_COMPLIANCE_STATUS_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/


CREATE TABLE DM_POLICY_CHANGE_MGT (
  ID NUMBER(10) NOT NULL,
  POLICY_ID NUMBER(10) NOT NULL,
  DEVICE_TYPE_ID NUMBER(10) NOT NULL,
  TENANT_ID NUMBER(10) NOT NULL,
  PRIMARY KEY (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_POLICY_CHANGE_MGT_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_POLICY_CHANGE_MGT_seq_tr
 BEFORE INSERT ON DM_POLICY_CHANGE_MGT FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_POLICY_CHANGE_MGT_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/


CREATE TABLE DM_POLICY_COMPLIANCE_FEATURES (
  ID NUMBER(10) NOT NULL,
  COMPLIANCE_STATUS_ID NUMBER(10) NOT NULL,
  TENANT_ID NUMBER(10) NOT NULL,
  FEATURE_CODE VARCHAR2(15) NOT NULL,
  STATUS NUMBER(10) NULL,
  PRIMARY KEY (ID),
  CONSTRAINT FK_COMPLIANCE_FEATURES_STATUS
    FOREIGN KEY (COMPLIANCE_STATUS_ID)
    REFERENCES DM_POLICY_COMPLIANCE_STATUS (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_POLICY_COMPLIANCE_FEATURES_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_POLICY_COMPLIANCE_FEATURES_seq_tr
 BEFORE INSERT ON DM_POLICY_COMPLIANCE_FEATURES FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_POLICY_COMPLIANCE_FEATURES_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_ENROLMENT (
    ID NUMBER(10) NOT NULL,
    DEVICE_ID NUMBER(10) NOT NULL,
    OWNER VARCHAR2(50) NOT NULL,
    OWNERSHIP VARCHAR2(45) DEFAULT NULL,
    STATUS VARCHAR2(50) NULL,
    DATE_OF_ENROLMENT TIMESTAMP(0) DEFAULT NULL,
    DATE_OF_LAST_UPDATE TIMESTAMP(0) DEFAULT NULL,
    TENANT_ID NUMBER(10) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_dm_device_enrolment FOREIGN KEY (DEVICE_ID) REFERENCES
    DM_DEVICE (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_ENROLMENT_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_ENROLMENT_seq_tr
 BEFORE INSERT ON DM_ENROLMENT FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_ENROLMENT_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_APPLICATION (
    ID NUMBER(10) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    APP_IDENTIFIER VARCHAR2(50) NOT NULL,
    PLATFORM VARCHAR2(50) DEFAULT NULL,
    CATEGORY VARCHAR2(50) NULL,
    VERSION VARCHAR2(50) NULL,
    TYPE VARCHAR2(50) NULL,
    LOCATION_URL VARCHAR2(100) DEFAULT NULL,
    IMAGE_URL VARCHAR2(100) DEFAULT NULL,
    APP_PROPERTIES BLOB NULL,
    TENANT_ID NUMBER(10) NOT NULL,
    PRIMARY KEY (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_APPLICATION_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_APPLICATION_seq_tr
 BEFORE INSERT ON DM_APPLICATION FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_APPLICATION_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

CREATE TABLE DM_DEVICE_APPLICATION_MAPPING (
    ID NUMBER(10) NOT NULL,
    DEVICE_ID NUMBER(10) NOT NULL,
    APPLICATION_ID NUMBER(10) NOT NULL,
    TENANT_ID NUMBER(10) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_dm_device FOREIGN KEY (DEVICE_ID) REFERENCES
    DM_DEVICE (ID),
    CONSTRAINT fk_dm_application FOREIGN KEY (APPLICATION_ID) REFERENCES
    DM_APPLICATION (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_DEVICE_APPLICATION_MAPPING_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_DEVICE_APPLICATION_MAPPING_seq_tr
 BEFORE INSERT ON DM_DEVICE_APPLICATION_MAPPING FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT DM_DEVICE_APPLICATION_MAPPING_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

-- POLICY RELAT... *** SQLINES FOR EVALUATION USE ONLY ***

-- NOTIFICATION... *** SQLINES FOR EVALUATION USE ONLY ***
CREATE TABLE DM_NOTIFICATION (
    NOTIFICATION_ID NUMBER(10) NOT NULL,
    DEVICE_ID NUMBER(10) NOT NULL,
    OPERATION_ID NUMBER(10) NOT NULL,
    TENANT_ID NUMBER(10) NOT NULL,
    STATUS VARCHAR2(10) NULL,
    DESCRIPTION VARCHAR2(100) NULL,
    PRIMARY KEY (NOTIFICATION_ID),
    CONSTRAINT fk_dm_device_notification FOREIGN KEY (DEVICE_ID) REFERENCES
    DM_DEVICE (ID),
    CONSTRAINT fk_dm_operation_notification FOREIGN KEY (OPERATION_ID) REFERENCES
    DM_OPERATION (ID)
);

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_NOTIFICATION_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER DM_NOTIFICATION_seq_tr
 BEFORE INSERT ON DM_NOTIFICATION FOR EACH ROW
 WHEN (NEW.NOTIFICATION_ID IS NULL)
BEGIN
 SELECT DM_NOTIFICATION_seq.NEXTVAL INTO :NEW.NOTIFICATION_ID FROM DUAL;
END;
/
-- NOTIFICATION... *** SQLINES FOR EVALUATION USE ONLY ***

-- TO:DO - Remo... *** SQLINES FOR EVALUATION USE ONLY ***
--Insert into D... *** SQLINES FOR EVALUATION USE ONLY ***
--Insert into D... *** SQLINES FOR EVALUATION USE ONLY ***
