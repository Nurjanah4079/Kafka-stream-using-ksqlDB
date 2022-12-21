CREATE SOURCE CONNECTOR jdbc_source WITH (
  'connector.class'          = 'io.confluent.connect.jdbc.JdbcSourceConnector',
  'connection.url'           = 'jdbc:postgresql://postgres:5432/postgres',
  'connection.user'          = 'postgres',
  'connection.password'      = 'password',
  'topic.prefix'             = 'jdbc_',
  'table.whitelist'          = 'customers',
  'mode'                     = 'incrementing',
  'numeric.mapping'          = 'best_fit',
  'incrementing.column.name' = 'customer_id',
  'key'                      = 'customer_id',
  'key.converter'            = 'org.apache.kafka.connect.converters.IntegerConverter');


CREATE STREAM stream_customers_tables(
    customer_id INT,
    name_customers VARCHAR,
    gender VARCHAR,
    age INT,
    region VARHCAR,
    job_classification VARCHAR, 
    balance float
) WITH (kafka_topics='jdbc', value_format='json', partitions=1);

CREATE TABLE customers_tables as
    SELECT sct.name_customers, count(*) as transaction_times, sum(balance) as total_balance 
    FROM stream_customers_tables sct
    GROUP BY sct.name_customers
    emit changes;

INSERT INTO stream_customers_tables (customer_id, name_customers, gender, age, region, job, balance) 
  VALUES (1, 'Ali', 'Male', 29, 'Wales', 'Blue Collar', 200545);
INSERT INTO stream_table (customer_id, name_customers, gender, age, region, job, balance) 
  VALUES (2, 'Nina', 'Female', 25, 'Ireland', 'Blue Collar', 98758);
INSERT INTO stream_table (customer_id, name_customers, gender, age, region, job, balance) 
  VALUES (3, 'Lily', 'Female', 32, 'England', 'White Collar', 302845);

select * from customers_tables;
