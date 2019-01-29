CREATE TABLE customer (
    customer_no        NUMBER(8) NOT NULL,
    customer_name      VARCHAR2(30) NOT NULL,
    customer_address   VARCHAR2(100),
    po_number          NUMBER(5),
    tax_number         NUMBER(5),
    tax_exempt         VARCHAR2(2)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customer_no );


INSERT INTO CUSTOMER VALUES(30086,'SPEED RACER','243 S WABASH AVE CHICAGO IL 60604',NULL,NULL,'N');

INSERT INTO CUSTOMER VALUES(2250,'JIM SHOE','1 E JACKSON BLVD CHICAGO IL 60604',NULL,NULL,'N');







CREATE TABLE customer_phone (
    phone_no               VARCHAR2(20) NOT NULL,
    work_phone             VARCHAR2(20) NOT NULL,
    fax                    VARCHAR2(20),
    ext                    NUMBER(5),
    customer_customer_no   NUMBER(8) NOT NULL
);

ALTER TABLE customer_phone ADD CONSTRAINT customer_phone_pk PRIMARY KEY ( customer_customer_no );

ALTER TABLE customer_phone
    ADD CONSTRAINT customer_phone_customer_fk FOREIGN KEY ( customer_customer_no )
        REFERENCES customer ( customer_no );



INSERT INTO CUSTOMER_PHONE  VALUES('(312)555-1212','(000)000-0000','(000)000-0000',NULL,30086);

INSERT INTO CUSTOMER_PHONE  VALUES('(312)362-8381','(000)000-0000','(000)000-0000',NULL,2250);







CREATE TABLE payment (
    card_type              VARCHAR2(5),
    creditcard_no          VARCHAR2(20),
    card_exp               VARCHAR2(10),
    check_no               VARCHAR2(10),
    cash                   NUMBER(5,2),
    customer_customer_no   NUMBER(8) NOT NULL
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( customer_customer_no );

ALTER TABLE payment
    ADD CONSTRAINT payment_customer_fk FOREIGN KEY ( customer_customer_no )
        REFERENCES customer ( customer_no );


INSERT INTO PAYMENT VALUES('MC','XXXX-XXXX-XXXX-0866','11/04',0,0.00,30086);

INSERT INTO PAYMENT VALUES('MC','NULL','00/00',0,0.00,2250);







CREATE TABLE shop (
    shop_name   VARCHAR2(30) NOT NULL,
    address     VARCHAR2(100) NOT NULL,
    phone_no    VARCHAR2(20),
    fax         VARCHAR2(20),
    tax_id      VARCHAR2(5),
    console     NUMBER(5),
    rate        VARCHAR2(20)
);


ALTER TABLE shop ADD CONSTRAINT shop_pk PRIMARY KEY ( shop_name );



INSERT INTO SHOP VALUES('CHICAGO HARLEY-DAVIDSON. INC','6868 N WESTERN AVE. CHICAGO IL 60645','(773)338-6868','(773)338-8868','IL',010,0.8750);

INSERT INTO SHOP VALUES('CHICAGO H-D SHOP','2929 PATRIOT BLVD GLENVIEW IL 60026','(847)412-2929','(847)412-6868','IL',020,0.8250);





CREATE TABLE shop_employee (
    sold_by          VARCHAR2(5),
    shop_shop_name   VARCHAR2(30) NOT NULL
);

ALTER TABLE shop_employee ADD CONSTRAINT shop_employee_pk PRIMARY KEY ( shop_shop_name );

ALTER TABLE shop_employee
    ADD CONSTRAINT shop_employee_shop_fk FOREIGN KEY ( shop_shop_name )
        REFERENCES shop ( shop_name );


INSERT INTO SHOP_EMPLOYEE VALUES('RPF','CHICAGO HARLEY-DAVIDSON. INC');

INSERT INTO SHOP_EMPLOYEE VALUES('EOS','CHICAGO H-D SHOP');






CREATE TABLE item (
    item_number      VARCHAR2(20) NOT NULL,
    description      VARCHAR2(50),
    retail_price     NUMBER(10,5),
    discount         NUMBER(10,5),
    shop_shop_name   VARCHAR2(50) NOT NULL
);

ALTER TABLE item ADD CONSTRAINT item_pk PRIMARY KEY ( item_number );

ALTER TABLE item
    ADD CONSTRAINT item_shop_fk FOREIGN KEY ( shop_shop_name )
        REFERENCES shop ( shop_name );


INSERT INTO ITEM VALUES('69112-95B','HORN KIT CHROM',79.95,15.99,'CHICAGO HARLEY-DAVIDSON. INC');

INSERT INTO ITEM VALUES('16554-92A','CYLINDER SILVER',139.95,41.99,'CHICAGO H-D SHOP');

INSERT INTO ITEM VALUES('22698-01','SE XL 883/1200 PIS',279.95,83.99,'CHICAGO H-D SHOP');

INSERT INTO ITEM VALUES('59263-79','REFLECTOR',2.50,NULL,'CHICAGO H-D SHOP');

INSERT INTO ITEM VALUES('59988-72A','REFLECTOR RED',4.20,NULL,'CHICAGO H-D SHOP');

INSERT INTO ITEM VALUES('70404-99Y','SWITCH ASSY R.H',21.80,NULL,'CHICAGO H-D SHOP');

INSERT INTO ITEM VALUES('M0737.M','DECAL TAIL SECT',5.95,NULL,'CHICAGO H-D SHOP');

INSERT INTO ITEM VALUES('17048-98','GASKET KIT EXHA',7.95,1.99,'CHICAGO H-D SHOP');

INSERT INTO ITEM VALUES('17056-01','KIT HEAD GASKET',24.95,6.24,'CHICAGO H-D SHOP');







CREATE TABLE invoice (
    invoice_number                 NUMBER(10) NOT NULL,
    date_and_time                  DATE,
    deposit_down_pmt               NUMBER(3,2),
    deposit_pmts_applied           NUMBER(3,2),
    layaway_pmt_made               NUMBER(3,2),
    layaway_pmt_applied            NUMBER(3,2),
    shipping_charges               NUMBER(3,2),
    flat_charge                    NUMBER(3,2),
    deductibles                    NUMBER(3,2),
    payment_customer_customer_no   NUMBER(8) NOT NULL,
    shop_shop_name                 VARCHAR2(30) NOT NULL
);

ALTER TABLE invoice ADD CONSTRAINT invoice_pk PRIMARY KEY ( invoice_number );

ALTER TABLE invoice
    ADD CONSTRAINT invoice_payment_fk FOREIGN KEY ( payment_customer_customer_no )
        REFERENCES payment ( customer_customer_no );

ALTER TABLE invoice
    ADD CONSTRAINT invoice_shop_fk FOREIGN KEY ( shop_shop_name )
        REFERENCES shop ( shop_name );




INSERT INTO INVOICE VALUES(346221,TO_DATE('10/11/2003 12:31:00PM','MM/DD/YYYY HH:MI:SSPM'),0.00,0.00,0.00,0.00,0.00,0.00,0.00,30086,'CHICAGO HARLEY-DAVIDSON. INC');

INSERT INTO INVOICE VALUES(36107,TO_DATE('11/11/2006 03:16:00PM','MM/DD/YYYY HH:MI:SSPM'),0.00,0.00,0.00,0.00,0.00,0.00,0.00,2250,'CHICAGO H-D SHOP');

INSERT INTO INVOICE VALUES(38804,TO_DATE('12/04/2006 06:45:00PM','MM/DD/YYYY HH:MI:SSPM'),0.00,0.00,0.00,0.00,0.00,0.00,0.00,2250,'CHICAGO H-D SHOP');






CREATE TABLE invoice_item (
    invoice_invoice_number   NUMBER(10) NOT NULL,
    item_item_number         VARCHAR2(20) NOT NULL,
    del_qty                  NUMBER(10,5),
    so_qty                   NUMBER(10,5)
);

ALTER TABLE invoice_item ADD CONSTRAINT invoice_item_pk PRIMARY KEY ( invoice_invoice_number,
                                                                      item_item_number );

ALTER TABLE invoice_item
    ADD CONSTRAINT invoice_item_invoice_fk FOREIGN KEY ( invoice_invoice_number )
        REFERENCES invoice ( invoice_number );

ALTER TABLE invoice_item
    ADD CONSTRAINT invoice_item_item_fk FOREIGN KEY ( item_item_number )
        REFERENCES item ( item_number );



INSERT INTO INVOICE_ITEM VALUES( 346221,'69112-95B',1.00,NULL);

INSERT INTO INVOICE_ITEM VALUES( 36107,'16554-92A',2.00,NULL);

INSERT INTO INVOICE_ITEM VALUES( 36107,'22698-01',1.00,NULL);

INSERT INTO INVOICE_ITEM VALUES( 36107,'59263-79',NULL,5);

INSERT INTO INVOICE_ITEM VALUES( 36107,'59988-72A',NULL,2);

INSERT INTO INVOICE_ITEM VALUES( 36107,'70404-99Y',NULL,1);

INSERT INTO INVOICE_ITEM VALUES( 36107,'M0737.M',NULL,2);

INSERT INTO INVOICE_ITEM VALUES( 38804,'17048-98',1.00,NULL);

INSERT INTO INVOICE_ITEM VALUES( 38804,'17056-01',1.00,NULL);










QUERIES

1) How many parts did Jim Shoe purchase in November, 2006?

SELECT CUSTOMER.CUSTOMER_NAME, COUNT(INVOICE_ITEM.ITEM_ITEM_NUMBER) AS NUMBER_OF_PARTS, INVOICE.DATE_AND_TIME                                  
FROM CUSTOMER, PAYMENT, INVOICE, INVOICE_ITEM
WHERE CUSTOMER.CUSTOMER_NO = PAYMENT.CUSTOMER_CUSTOMER_NO 
AND PAYMENT.CUSTOMER_CUSTOMER_NO = INVOICE.PAYMENT_CUSTOMER_CUSTOMER_NO
AND INVOICE.INVOICE_NUMBER = INVOICE_ITEM.INVOICE_INVOICE_NUMBER
GROUP BY CUSTOMER.CUSTOMER_NAME, INVOICE.DATE_AND_TIME
HAVING CUSTOMER_NAME = 'JIM SHOE' 
AND   DATE_AND_TIME BETWEEN '01-NOV-06' AND '30-NOV-06';



