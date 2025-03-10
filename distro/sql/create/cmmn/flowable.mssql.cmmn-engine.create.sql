

CREATE TABLE ACT_CMMN_DATABASECHANGELOGLOCK (ID int NOT NULL, LOCKED bit NOT NULL, LOCKGRANTED datetime2(3), LOCKEDBY nvarchar(255), CONSTRAINT PK_ACT_CMMN_DATABASECHANGELOGLOCK PRIMARY KEY (ID))

DELETE FROM ACT_CMMN_DATABASECHANGELOGLOCK

INSERT INTO ACT_CMMN_DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0)

UPDATE ACT_CMMN_DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '192.168.68.111 (192.168.68.111)', LOCKGRANTED = '2021-11-11T16:12:59.374' WHERE ID = 1 AND LOCKED = 0

CREATE TABLE ACT_CMMN_DATABASECHANGELOG (ID nvarchar(255) NOT NULL, AUTHOR nvarchar(255) NOT NULL, FILENAME nvarchar(255) NOT NULL, DATEEXECUTED datetime2(3) NOT NULL, ORDEREXECUTED int NOT NULL, EXECTYPE nvarchar(10) NOT NULL, MD5SUM nvarchar(35), DESCRIPTION nvarchar(255), COMMENTS nvarchar(255), TAG nvarchar(255), LIQUIBASE nvarchar(20), CONTEXTS nvarchar(255), LABELS nvarchar(255), DEPLOYMENT_ID nvarchar(10))

CREATE TABLE ACT_CMMN_DEPLOYMENT (ID_ varchar(255) NOT NULL, NAME_ varchar(255), CATEGORY_ varchar(255), KEY_ varchar(255), DEPLOY_TIME_ datetime, PARENT_DEPLOYMENT_ID_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_DEPLOYMENT_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_DEPLOYMENT PRIMARY KEY (ID_))

CREATE TABLE ACT_CMMN_DEPLOYMENT_RESOURCE (ID_ varchar(255) NOT NULL, NAME_ varchar(255), DEPLOYMENT_ID_ varchar(255), RESOURCE_BYTES_ varbinary(MAX), CONSTRAINT PK_CMMN_DEPLOYMENT_RESOURCE PRIMARY KEY (ID_))

ALTER TABLE ACT_CMMN_DEPLOYMENT_RESOURCE ADD CONSTRAINT ACT_FK_CMMN_RSRC_DPL FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_CMMN_DEPLOYMENT (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_CMMN_RSRC_DPL ON ACT_CMMN_DEPLOYMENT_RESOURCE(DEPLOYMENT_ID_)

CREATE TABLE ACT_CMMN_CASEDEF (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, NAME_ varchar(255), KEY_ varchar(255) NOT NULL, VERSION_ int NOT NULL, CATEGORY_ varchar(255), DEPLOYMENT_ID_ varchar(255), RESOURCE_NAME_ varchar(4000), DESCRIPTION_ varchar(4000), HAS_GRAPHICAL_NOTATION_ bit, TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_CASEDEF_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_CASEDEF PRIMARY KEY (ID_))

ALTER TABLE ACT_CMMN_CASEDEF ADD CONSTRAINT ACT_FK_CASE_DEF_DPLY FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_CMMN_DEPLOYMENT (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_CASE_DEF_DPLY ON ACT_CMMN_CASEDEF(DEPLOYMENT_ID_)

CREATE TABLE ACT_CMMN_RU_CASE_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, BUSINESS_KEY_ varchar(255), NAME_ varchar(255), PARENT_ID_ varchar(255), CASE_DEF_ID_ varchar(255), STATE_ varchar(255), START_TIME_ datetime, START_USER_ID_ varchar(255), CALLBACK_ID_ varchar(255), CALLBACK_TYPE_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_RU_CASE_INST_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_RU_CASE_INST PRIMARY KEY (ID_))

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD CONSTRAINT ACT_FK_CASE_INST_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_CASE_INST_CASE_DEF ON ACT_CMMN_RU_CASE_INST(CASE_DEF_ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_CASE_INST_PARENT ON ACT_CMMN_RU_CASE_INST(PARENT_ID_)

CREATE TABLE ACT_CMMN_RU_PLAN_ITEM_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, CASE_DEF_ID_ varchar(255), CASE_INST_ID_ varchar(255), STAGE_INST_ID_ varchar(255), IS_STAGE_ bit, ELEMENT_ID_ varchar(255), NAME_ varchar(255), STATE_ varchar(255), START_TIME_ datetime, START_USER_ID_ varchar(255), REFERENCE_ID_ varchar(255), REFERENCE_TYPE_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_RU_PLAN_ITEM_INST_TENANT_ID_ DEFAULT '', CONSTRAINT PK_CMMN_PLAN_ITEM_INST PRIMARY KEY (ID_))

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD CONSTRAINT ACT_FK_PLAN_ITEM_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_PLAN_ITEM_CASE_DEF ON ACT_CMMN_RU_PLAN_ITEM_INST(CASE_DEF_ID_)

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD CONSTRAINT ACT_FK_PLAN_ITEM_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_PLAN_ITEM_CASE_INST ON ACT_CMMN_RU_PLAN_ITEM_INST(CASE_INST_ID_)

CREATE TABLE ACT_CMMN_RU_SENTRY_PART_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, CASE_DEF_ID_ varchar(255), CASE_INST_ID_ varchar(255), PLAN_ITEM_INST_ID_ varchar(255), ON_PART_ID_ varchar(255), IF_PART_ID_ varchar(255), TIME_STAMP_ datetime, CONSTRAINT PK_CMMN_SENTRY_PART_INST PRIMARY KEY (ID_))

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_SENTRY_CASE_DEF ON ACT_CMMN_RU_SENTRY_PART_INST(CASE_DEF_ID_)

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_SENTRY_CASE_INST ON ACT_CMMN_RU_SENTRY_PART_INST(CASE_INST_ID_)

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_PLAN_ITEM FOREIGN KEY (PLAN_ITEM_INST_ID_) REFERENCES ACT_CMMN_RU_PLAN_ITEM_INST (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_SENTRY_PLAN_ITEM ON ACT_CMMN_RU_SENTRY_PART_INST(PLAN_ITEM_INST_ID_)

CREATE TABLE ACT_CMMN_RU_MIL_INST (ID_ varchar(255) NOT NULL, NAME_ varchar(255) NOT NULL, TIME_STAMP_ datetime NOT NULL, CASE_INST_ID_ varchar(255) NOT NULL, CASE_DEF_ID_ varchar(255) NOT NULL, ELEMENT_ID_ varchar(255) NOT NULL, CONSTRAINT PK_ACT_CMMN_RU_MIL_INST PRIMARY KEY (ID_))

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD CONSTRAINT ACT_FK_MIL_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_MIL_CASE_DEF ON ACT_CMMN_RU_MIL_INST(CASE_DEF_ID_)

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD CONSTRAINT ACT_FK_MIL_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_)

CREATE NONCLUSTERED INDEX ACT_IDX_MIL_CASE_INST ON ACT_CMMN_RU_MIL_INST(CASE_INST_ID_)

CREATE TABLE ACT_CMMN_HI_CASE_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, BUSINESS_KEY_ varchar(255), NAME_ varchar(255), PARENT_ID_ varchar(255), CASE_DEF_ID_ varchar(255), STATE_ varchar(255), START_TIME_ datetime, END_TIME_ datetime, START_USER_ID_ varchar(255), CALLBACK_ID_ varchar(255), CALLBACK_TYPE_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_HI_CASE_INST_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_HI_CASE_INST PRIMARY KEY (ID_))

CREATE TABLE ACT_CMMN_HI_MIL_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, NAME_ varchar(255) NOT NULL, TIME_STAMP_ datetime NOT NULL, CASE_INST_ID_ varchar(255) NOT NULL, CASE_DEF_ID_ varchar(255) NOT NULL, ELEMENT_ID_ varchar(255) NOT NULL, CONSTRAINT PK_ACT_CMMN_HI_MIL_INST PRIMARY KEY (ID_))

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 1, '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_CASEDEF ADD DGRM_RESOURCE_NAME_ varchar(4000)

ALTER TABLE ACT_CMMN_CASEDEF ADD HAS_START_FORM_KEY_ bit

ALTER TABLE ACT_CMMN_DEPLOYMENT_RESOURCE ADD GENERATED_ bit

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LOCK_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ITEM_DEFINITION_ID_ varchar(255)

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ITEM_DEFINITION_TYPE_ varchar(255)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 2, '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD IS_COMPLETEABLE_ bit

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD IS_COMPLETEABLE_ bit

CREATE NONCLUSTERED INDEX ACT_IDX_PLAN_ITEM_STAGE_INST ON ACT_CMMN_RU_PLAN_ITEM_INST(STAGE_INST_ID_)

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD IS_COUNT_ENABLED_ bit

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD VAR_COUNT_ int

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD SENTRY_PART_INST_COUNT_ int

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 3, '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

CREATE TABLE ACT_CMMN_HI_PLAN_ITEM_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, NAME_ varchar(255), STATE_ varchar(255), CASE_DEF_ID_ varchar(255), CASE_INST_ID_ varchar(255), STAGE_INST_ID_ varchar(255), IS_STAGE_ bit, ELEMENT_ID_ varchar(255), ITEM_DEFINITION_ID_ varchar(255), ITEM_DEFINITION_TYPE_ varchar(255), CREATED_TIME_ datetime, LAST_AVAILABLE_TIME_ datetime, LAST_ENABLED_TIME_ datetime, LAST_DISABLED_TIME_ datetime, LAST_STARTED_TIME_ datetime, LAST_SUSPENDED_TIME_ datetime, COMPLETED_TIME_ datetime, OCCURRED_TIME_ datetime, TERMINATED_TIME_ datetime, EXIT_TIME_ datetime, ENDED_TIME_ datetime, LAST_UPDATED_TIME_ datetime, START_USER_ID_ varchar(255), REFERENCE_ID_ varchar(255), REFERENCE_TYPE_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_HI_PLAN_ITEM_INST_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_HI_PLAN_ITEM_INST PRIMARY KEY (ID_))

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_RU_MIL_INST_TENANT_ID_ DEFAULT ''

ALTER TABLE ACT_CMMN_HI_MIL_INST ADD TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_HI_MIL_INST_TENANT_ID_ DEFAULT ''

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 4, '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

CREATE UNIQUE NONCLUSTERED INDEX ACT_IDX_CASE_DEF_UNIQ ON ACT_CMMN_CASEDEF(KEY_, VERSION_, TENANT_ID_)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 5, '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

exec sp_rename 'ACT_CMMN_RU_PLAN_ITEM_INST.START_TIME_', 'CREATE_TIME_'

exec sp_rename 'ACT_CMMN_HI_PLAN_ITEM_INST.CREATED_TIME_', 'CREATE_TIME_'

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_AVAILABLE_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_ENABLED_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_DISABLED_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_STARTED_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_SUSPENDED_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD COMPLETED_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD OCCURRED_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD TERMINATED_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD EXIT_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ENDED_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ENTRY_CRITERION_ID_ varchar(255)

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD EXIT_CRITERION_ID_ varchar(255)

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD ENTRY_CRITERION_ID_ varchar(255)

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD EXIT_CRITERION_ID_ varchar(255)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 6, '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD SHOW_IN_OVERVIEW_ bit

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 7, '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD EXTRA_VALUE_ varchar(255)

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD EXTRA_VALUE_ varchar(255)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 8, '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD REFERENCE_ID_ varchar(255)

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD REFERENCE_TYPE_ varchar(255)

CREATE NONCLUSTERED INDEX ACT_IDX_CASE_INST_REF_ID_ ON ACT_CMMN_RU_CASE_INST(REFERENCE_ID_)

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD REFERENCE_ID_ varchar(255)

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD REFERENCE_TYPE_ varchar(255)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 9, '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD DERIVED_CASE_DEF_ID_ varchar(255)

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD DERIVED_CASE_DEF_ID_ varchar(255)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 10, '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LOCK_OWNER_ varchar(255)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 11, '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_UNAVAILABLE_TIME_ datetime

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD LAST_UNAVAILABLE_TIME_ datetime

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 12, '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LAST_REACTIVATION_TIME_ datetime

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LAST_REACTIVATION_USER_ID_ varchar(255)

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD LAST_REACTIVATION_TIME_ datetime

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD LAST_REACTIVATION_USER_ID_ varchar(255)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('14', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 13, '8:086b40b3a05596dcc8a8d7479922d494', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD BUSINESS_STATUS_ varchar(255)

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD BUSINESS_STATUS_ varchar(255)

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('16', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', GETDATE(), 14, '8:a697a222ddd99dd15b36516a252f1c63', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '6643579467')

UPDATE ACT_CMMN_DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1

