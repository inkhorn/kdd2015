CREATE TABLE object (
course_id VARCHAR(50) NOT NULL,
module_id VARCHAR(50) NOT NULL,
category VARCHAR(50),
children VARCHAR(100),
tstart DATETIME);

CREATE TABLE enrollment_test (
enrollment_id BIGINT NOT NULL,
username VARCHAR(50),
course_id VARCHAR(50) NOT NULL,
PRIMARY KEY(enrollment_id));

CREATE TABLE enrollment_train (
enrollment_id BIGINT NOT NULL PRIMARY KEY,
username VARCHAR(50),
course_id VARCHAR(50));

CREATE TABLE log_train (
enrollment_id BIGINT NOT NULL,
tstamp DATETIME,
source VARCHAR(15),
logged_event VARCHAR(15),
vobject VARCHAR(50) NOT NULL,
FOREIGN KEY (enrollment_id) REFERENCES enrollment_train(enrollment_id));

CREATE TABLE log_test (
enrollment_id BIGINT NOT NULL,
tstamp DATETIME,
source VARCHAR(15),
logged_event VARCHAR(15),
vobject VARCHAR(50),
FOREIGN KEY (enrollment_id) REFERENCES enrollment_test(enrollment_id));

CREATE TABLE truth_train (
enrollment_id BIGINT NOT NULL,
dropped_out BINARY,
FOREIGN KEY (enrollment_id) REFERENCES enrollment_train(enrollment_id));

LOAD DATA INFILE '/media/altHD/KDD2015/enrollment_test.csv' INTO TABLE enrollment_test FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA INFILE '/media/altHD/KDD2015/enrollment_train.csv' INTO TABLE enrollment_train FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA INFILE '/media/altHD/KDD2015/log_train.csv' INTO TABLE log_train FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA INFILE '/media/altHD/KDD2015/log_test.csv' INTO TABLE log_test FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA INFILE '/media/altHD/KDD2015/truth_train.csv' INTO TABLE truth_train FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
LOAD DATA INFILE '/media/altHD/KDD2015/object.csv' INTO TABLE object FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

UPDATE enrollment_train
SET course_id = REPLACE(course_id, '\r', '');

UPDATE enrollment_test
SET course_id = REPLACE(course_id, '\r', '');
