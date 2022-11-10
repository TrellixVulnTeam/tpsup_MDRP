/* 
to setup test tables: 
   sql tptest@tpdbmysql file tptrace_test_db.sql 
   sql tptest@tpdbmssql file tptrace_test_db.sql 
*/



DROP TABLE if exists orders;
CREATE TABLE orders (
   -- OrderId INT NOT NULL AUTO_INCREMENT,
   OrderId VARCHAR(20),
   Symbol VARCHAR(20),
   -- Sid INT(6),  -- this works in mysql but not in mssql
   Sid INT, 
   OrderQty INT,
   FilledQty INT,
   LastPrice DECIMAL(12,4),   -- don't use FLOAT because 'where Price = 135.35' not working
   LastQty INT, 
   AvgPrice DECIMAL(12,4), 
   SenderComp VARCHAR(10), 
   SenderSub VARCHAR(10), 
   TargetComp VARCHAR(10), 
   TargetSub VARCHAR(10), 
   CreateTime DATETIME,
   -- LastUpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,--non-mssql
   LastUpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
   TradeDate DATE, 
   -- PRIMARY KEY (`OrderId`) --non-mssql
   PRIMARY KEY (OrderId)
);
-- ALTER TABLE orders AUTO_INCREMENT=1000000;


INSERT INTO orders VALUES (
   'ORD-0001',
   'IBM',    
   400001,
   4500,
   1000,
   136.01,
   400,
   135.75,
   'BLKC',
   'StatArb',
   'TCOM',
   'VWAP',
   '2021-11-29 09:57:40',
   '2021-11-29 10:34:05',
   '2021-11-29'
);





INSERT INTO orders VALUES (
   'ORD-0002',
   'TSLA',    
   400002,
   14500,
   9500,
   1159.07,
   3700,
   1560.20,
   'RETC',
   'MM',
   'TCOM',
   'VWAP',
   '2021-11-29 09:29:40',
   '2021-11-29 11:34:05',
   '2021-11-29'
);





INSERT INTO orders VALUES (
   'ORD-0003',
   'HD',    
   400003,
   26700,
   5900,
   35.89,
   5900,
   35.67,
   'VERI',
   'SNAP',
   'TCOM',
   'VWAP',
   '2021-11-29 09:30:40',
   '2021-11-29 10:44:51',
   '2021-11-29'
);

select * from orders;

DROP TABLE if exists trades;
CREATE TABLE trades (
   -- TradeId INT NOT NULL AUTO_INCREMENT,
   TradeId VARCHAR(20),
   OrderId VARCHAR(20),
   Symbol VARCHAR(20),
   -- Sid INT(6), --non-mssql
   Sid INT,
   OrderQty INT, 
   Qty INT,
   Price DECIMAL(12,4), 
   SenderComp VARCHAR(10), 
   SenderSub VARCHAR(10), 
   TargetComp VARCHAR(10), 
   TargetSub VARCHAR(10), 
   CreateTime DATETIME,
   -- LastUpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,--non-mssql
   LastUpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
   TradeDate DATE, 
   -- PRIMARY KEY (`TradeId`) --non-mssql
   PRIMARY KEY (TradeId)
);
-- ALTER TABLE trades AUTO_INCREMENT=2000000;



INSERT INTO trades VALUES (
   'TRD-0001',
   'ORD-0001',    
   'IBM',    
   400001,
   4500,
   600,
   135.35,
   'BLKC',
   'StatArb',
   'TCOM',
   'VWAP',
   '2021-11-29 09:57:59',
   '2021-11-29 10:58:00',
   '2021-11-29'
);





INSERT INTO trades VALUES (
   'TRD-0002',
   'ORD-0001',    
   'IBM',    
   400001,
   4500,
   400,
   136.01,
   'BLKC',
   'StatArb',
   'TCOM',
   'VWAP',
   '2021-11-29 09:57:59',
   '2021-11-29 11:15:04',
   '2021-11-29'
);





INSERT INTO trades VALUES (
   'TRD-0003',
   'ORD-0002',    
   'TSLA',    
   400002,
   14500,
   4800,
   1159.01,
   'RETC',
   'MM',
   'TCOM',
   'VWAP',
   '2021-11-29 09:29:40',
   '2021-11-29 09:34:05',
   '2021-11-29'
);





INSERT INTO trades VALUES (
   'TRD-0004',
   'ORD-0002',    
   'TSLA',    
   400002,
   14500,
   3700,
   1162.07,
   'RETC',
   'MM',
   'TCOM',
   'VWAP',
   '2021-11-29 09:29:40',
   '2021-11-29 10:34:05',
   '2021-11-29'
);





INSERT INTO trades VALUES (
   'TRD-0005',
   'ORD-0003',    
   'HD',    
   400003,
   26700,
   5900,
   35.89,
   'VERI',
   'SNAP',
   'TCOM',
   'VWAP',
   '2021-11-29 09:30:40',
   '2021-11-29 10:44:51',
   '2021-11-29'
);

select * from trades;

DROP TABLE if exists booking;
CREATE TABLE booking (
   -- BookId INT NOT NULL AUTO_INCREMENT,
   BookId VARCHAR(20),
   TradeId VARCHAR(20),
   OrderId VARCHAR(20),
   Symbol VARCHAR(20),
   -- Sid INT(6), --non-mssql
   Sid INT,
   OrderQty INT, 
   Qty INT,
   Price DECIMAL(12,4), 
   SenderComp VARCHAR(10), 
   SenderSub VARCHAR(10), 
   TargetComp VARCHAR(10), 
   TargetSub VARCHAR(10), 
   CreateTime DATETIME,
   -- LastUpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,--non-mssql
   LastUpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
   TradeDate DATE, 
   -- PRIMARY KEY (`BookId`) --non-mssql
   PRIMARY KEY (BookId)
);
-- ALTER TABLE booking AUTO_INCREMENT=3000000;


INSERT INTO booking VALUES (
   'BKG-0001',
   'TRD-0001',
   'ORD-0001',    
   'IBM',    
   400001,
   4500,
   600,
   135.35,
   'BLKC',
   'StatArb',
   'TCOM',
   'VWAP',
   '2021-11-29 09:57:59',
   '2021-11-29 10:58:00',
   '2021-11-29'
);




INSERT INTO booking VALUES (
   'BKG-0002',
   'TRD-0002',
   'ORD-0001',    
   'IBM',    
   400001,
   4500,
   400,
   136.01,
   'BLKC',
   'StatArb',
   'TCOM',
   'VWAP',
   '2021-11-29 09:57:59',
   '2021-11-29 11:15:04',
   '2021-11-29'
);




INSERT INTO booking VALUES (
   'BKG-0003',
   'TRD-0003',
   'ORD-0002',    
   'TSLA',    
   400002,
   14500,
   4800,
   1159.01,
   'RETC',
   'MM',
   'TCOM',
   'VWAP',
   '2021-11-29 09:29:40',
   '2021-11-29 09:34:05',
   '2021-11-29'
);




INSERT INTO booking VALUES (
   'BKG-0004',
   'TRD-0004',
   'ORD-0002',    
   'TSLA',    
   400002,
   14500,
   3700,
   1162.07,
   'RETC',
   'MM',
   'TCOM',
   'VWAP',
   '2021-11-29 09:29:40',
   '2021-11-29 10:34:05',
   '2021-11-29'
);




INSERT INTO booking VALUES (
   'BKG-0005',
   'TRD-0005',
   'ORD-0003',    
   'HD',    
   400003,
   26700,
   5900,
   35.89,
   'VERI',
   'SNAP',
   'TCOM',
   'VWAP',
   '2021-11-29 09:30:40',
   '2021-11-29 10:44:51',
   '2021-11-29'
);

select * from booking;

DROP TABLE if exists securities;
CREATE TABLE securities (
   -- Sid INT(6), --non-mssql
   Sid INT, 
   Symbol VARCHAR(10),
   Cusip VARCHAR(9),
   Isin  VARCHAR(11),
   Sedol VARCHAR(9),
   IsActive VARCHAR(2),
   -- LastUpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,--non-mssql
   LastUpdateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
   -- PRIMARY KEY (`Sid`)
   PRIMARY KEY (Sid)
);
-- ALTER TABLE securities AUTO_INCREMENT=40000;


INSERT INTO securities VALUES (
   400001,
   'IBM',    
   'IBMCusip',    
   'IBMIsin',    
   'IBMSedol',
   'Y',
   '2021-11-29 10:44:51'
);

INSERT INTO securities VALUES (
   400002,
   'TSLA',    
   'TSLACusip',    
   'TSLAIsin',    
   'TSLASedol',
   'Y',
   '2021-11-29 10:44:51'
);

INSERT INTO securities VALUES (
   400003,
   'HD',    
   'HDCusip',    
   'HDIsin',    
   'HDSedol',
   'Y',
   '2021-11-29 10:44:51'
);

select * from securities;

DROP TABLE if exists actions;
CREATE TABLE actions (
   -- Id INT NOT NULL AUTO_INCREMENT, --non-mssql
   Id INT,
   MsgId VARCHAR(20),
   STATUS VARCHAR(20),
   FilledQty INT,
   -- PRIMARY KEY (`Id`) --non-mssql
   PRIMARY KEY (Id)
);
-- ALTER TABLE orders AUTO_INCREMENT=100001; --non-mssql

INSERT INTO actions VALUES (
   100001,
   'ORD-0001',
   null,
   null
);
INSERT INTO actions VALUES (
   100002,
   'ORD-0001',
   'SENT',    
   null
);
INSERT INTO actions VALUES (
   100003,
   'ORD-0001',
   'PARTIAL',
   600
);
INSERT INTO actions VALUES (
   100004,
   'ORD-0001',
   'COMPLETED',
   1000
);
select * from actions;
