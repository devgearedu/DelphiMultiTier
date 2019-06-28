DROP TABLE "FDQA_all_types";

CREATE TABLE "FDQA_all_types" (
  ttinyint tinyint(4) default '0',
  tbit bit default '0',
  tbool bool default '0',
  tsmallint smallint(6) default '0',
  tmediumint mediumint(9) default '0',
  tint int(11) default '0',
  tinteger int(11) default '0',
  tbigint bigint(20) default '0',
  treal real default '0',
  tdouble double default '0',
  tfloat float default '0',
  tdecimal decimal(19,4) default '0',
  tnumeric numeric(10,0) default '0',
  tchar char(100) default '',
  tvarchar varchar(100) default '',
  tdate date default '0000-00-00',
  ttime time default '00:00:00',
  tyear year(4),
  ttimestamp timestamp(14),
  tdatetime datetime default '0000-00-00 00:00:00',
  ttinyblob tinyblob,
  tblob blob,
  tmediumblob mediumblob,
  tlongblob longblob,
  ttinytext tinytext,
  ttext text,
  tmediumtext mediumtext,
  tlongtext longtext
);

DROP TABLE "FDQA_tabwithpk";

CREATE TABLE "FDQA_tabwithpk" (
  f1 int(11) NOT NULL default '0',
  f2 varchar(2000),
  CONSTRAINT PK_tabwithpk PRIMARY KEY  (f1)
);

DROP TABLE "FDQA_numbers";

CREATE TABLE "FDQA_numbers" (
  dtByte tinyint unsigned(3) default '0',
  dtSByte tinyint(3) default '0',
  dtInt16 smallint(5) default '0',
  dtInt32 int(10) default '0',
  dtInt64 decimal(19,0) default '0',
  dtUInt16 smallint unsigned(5) default '0',
  dtUInt32 int unsigned(10) default '0',
  dtUInt64 decimal unsigned(20,0) default '0',
  dtDouble double default '0',
  dtCurrency double default '0',
  dtBCD decimal(18,4) default '0.0000',
  dtFmtBCD decimal(18,4) default '0.0000'
); 

DROP TABLE "FDQA_novalstable";

CREATE TABLE "FDQA_novalstable" (
  id int(11) default '2000',
  name varchar(100) default 'hello'
);

DROP TABLE "FDQA_WString";

CREATE TABLE "FDQA_WString" (
  widestring nvarchar(2000) NULL
);

DROP TABLE "FDQA_transtable";

CREATE TABLE "FDQA_transtable" (
  id int(11) NOT NULL default '2000',
  name varchar(100) default 'hello',
  CONSTRAINT PK_transtable PRIMARY KEY  (id)
);

DROP TABLE "FDQA_map1";

CREATE TABLE "FDQA_map1" (
  id1 int(11) NOT NULL default '0',
  name1 varchar(20) NOT NULL default '',
  CONSTRAINT PK_map1 PRIMARY KEY  (id1)
);

DROP TABLE "FDQA_map2";

CREATE TABLE "FDQA_map2" (
  id2 int(11) NOT NULL default '0',
  name2 varchar(20) NOT NULL default ''
);

DROP TABLE "FDQA_map3";

CREATE TABLE "FDQA_map3" (
  id3 int(11) NOT NULL default '0',
  name3 varchar(20) NOT NULL default ''
);

DROP TABLE "FDQA_map4";

CREATE TABLE "FDQA_map4" (
  id4 int(11) NOT NULL default '0',
  name4 varchar(20) NOT NULL default ''
); 

DROP TABLE "FDQA_locktable";

CREATE TABLE "FDQA_locktable" (
  id int(11) NOT NULL default '0',
  name varchar(100) NOT NULL default ''
);

DROP TABLE "FDQA_batch_test";

CREATE TABLE "FDQA_batch_test" (
  tint int(11) default '0',
  tstring varchar(100) default '',
  tblob blob
); 

DROP TABLE "FDQA_Maxlength";

CREATE TABLE "FDQA_Maxlength" (
  str varchar(255),
  memos text,
  widestr text,
  blobs blob
); 

DROP TABLE "FDQA_blob";

CREATE TABLE "FDQA_blob" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  blobdata longblob
);

DROP TABLE "FDQA_details_autoinc";

DROP TABLE "FDQA_master_autoinc";

CREATE TABLE "FDQA_master_autoinc" (
  id1 INTEGER PRIMARY KEY AUTOINCREMENT,
  name1 varchar(20) default '',
  CONSTRAINT UK_master_autoinc UNIQUE (name1)
);

CREATE TABLE "FDQA_details_autoinc" (
  id2 INTEGER PRIMARY KEY AUTOINCREMENT,
  fk_id1 int(11) NOT NULL default '0',
  name2 varchar(20) NOT NULL default '',
  CONSTRAINT FK_detautoinc_mastautoinc
  FOREIGN KEY (fk_id1)
  REFERENCES FDQA_master_autoinc (id1) ON DELETE CASCADE
);

DROP TABLE "FDQA_identity_tab";
 
CREATE TABLE "FDQA_identity_tab" (
  auto INTEGER PRIMARY KEY AUTOINCREMENT,
  descr varchar(50)
);

DROP TABLE "FDQA_ascii_types";

CREATE TABLE "FDQA_ascii_types" (
  atString varchar(5) default '',
  atFloat double default '0',
  atNumber tinyint(4) default '0',
  atBool tinyint(1) default '0',
  atLongInt int(11) default '0',
  atDate date default '0000-00-00',
  atTime time default '00:00:00',
  atDateTime datetime default '0000-00-00 00:00:00',
  atBlob blob,
  atMemo text
); 

DROP TABLE "FDQA_db_types";

CREATE TABLE "FDQA_db_types" (
  ftString varchar(100) default '',
  ftSmallInt smallint(6) default '0',
  ftInteger int(11) default '0',
  ftWord smallint unsigned (5) default '0',
  ftBoolean tinyint(1) default '0',
  ftFloat double default '0',
  ftCurrency decimal(19,4) default '0.0000',
  ftBCD decimal(19,4) default '0.0000',
  ftDate date default '0000-00-00',
  ftTime time default '00:00:00',
  ftDateTime datetime default '0000-00-00 00:00:00',
  ftBytes tinyblob,
  ftBlob blob,
  ftMemo text
); 

DROP TABLE "FDQA_bcd";

CREATE TABLE "FDQA_bcd" (
  ftCurrency money default '0.0000',
  ftBCD decimal(19,4) default '0.0000',
  ftFmtBCD decimal(22,4) default '0.0000'
);

DROP TABLE "FDQA_timestamp";

CREATE TABLE "FDQA_timestamp" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  fnull timestamp(14) default CURRENT_TIMESTAMP
); 

DROP TABLE "FDQA_parambind";

CREATE TABLE "FDQA_parambind" (
  p1 varchar(50),
  p2 varchar(50),
  p3 varchar(50),
  p4 varchar(50)
); 

DROP TABLE "FDQA_ForAsync";

CREATE TABLE "FDQA_ForAsync" (
  id int,
  name varchar(20)
);

DROP VIEW "FDQA_V_Test";

CREATE VIEW "FDQA_V_Test" AS
SELECT p.ProductID, p.ProductName, p.UnitPrice * p.UnitsInStock as TotalPrice,
  c.CategoryID, c.CategoryID as CID, c.CategoryName
FROM "Products" p left join "Categories" c on p.CategoryID = c.CategoryID;

/*
REM -------------------
REM FireDAC Speed Tester
REM -------------------
*/

DROP TABLE FDQA_Products;

CREATE TABLE FDQA_Products (
  ProductID            INT NOT NULL PRIMARY KEY,
  ProductName          VARCHAR(100),
  FromDate             DATE,
  SupplierID           INT,
  CategoryID           INT,
  QuantityPerUnit      VARCHAR(20),
  UnitPrice            MONEY,
  UnitsInStock         INT,
  UnitsOnOrder         INT,
  OnDate               DATE
);

DROP TABLE FDQA_Categories;

CREATE TABLE FDQA_Categories (
  CategoryID           INT NOT NULL PRIMARY KEY,
  CategoryName         VARCHAR(15),
  Description          TEXT
);

DROP TABLE FDQA_OrderDetails;

CREATE TABLE FDQA_OrderDetails (
  OrderID              INT NOT NULL PRIMARY KEY,
  OnDate               DATE,
  ProductID            INT,
  UnitPrice            MONEY,
  Quantity             SMALLINT,
  Discount             REAL,
  Notes                VARCHAR(100)
);

DROP TABLE "FDQA_FK_tab";

CREATE TABLE "FDQA_FK_tab" (
 id int NOT NULL PRIMARY KEY,
 fk_id int NULL,
 CONSTRAINT FK_FDQA_FK_tab FOREIGN KEY (fk_id) REFERENCES "FDQA_FK_tab"(id)
);
