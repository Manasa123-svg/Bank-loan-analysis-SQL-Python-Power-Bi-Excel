

 --create table

create table bank_loan_data(
id int primary key,
address_state varchar(50),
application_type varchar(50),
emp_length	varchar(50),
emp_title varchar(100),
grade varchar(20),
home_ownership varchar(50),
issue_date date,
last_credit_pull_date date,
last_payment_date date,
loan_status varchar(50),
next_payment_date date,
member_id int,
purpose  varchar(50),
sub_grade varchar(50),
term varchar(50),
verification_status varchar(50),
annual_income float,
dti float,
installment float,
int_rate float,
loan_amount int,
total_acc int,
total_payment int
);

select * from bank_loan_data;

--Total loan applications

  select count(*) as total_loan_applications from bank_loan_data;

--MTD Loan applications

  select count(*) AS MTD_loan_applications from
  bank_loan_data
  where to_char(issue_date,'MM')='12';

 --PMTD Loan applications

  select count(*) as PMTD_Loan_applications
  from bank_loan_data
  where extract(month from issue_date)=11;

 --Total Funded amount

  select sum(loan_amount) as total_funded_amount
  from bank_loan_data;

--MTD Funded amount

  select sum(loan_amount) as MTD_Funded_amount
  from bank_loan_data
  where extract(month from issue_date)=12;

--PMTD Funded Amount

  select sum(loan_amount) as PMTD_Funded_amount
  from bank_loan_data
  where to_char(issue_date,'MM')='12';

 -- Total Amount received

   select sum(total_payment)  as total_amount_received
   from bank_loan_data;

-- MTD TOtal amount received

  select sum(total_payment) as MTD_total_amount_received
  from bank_loan_data
  where extract(month from issue_date)=12;

-- PMTD TOtam amount received

  select sum(total_payment) as PMTD_total_amount_received
  from bank_loan_data
  where extract(month from issue_date)=11; 
 
--Average intrest rate

  select Round(avg(int_rate)::numeric,4) as avg_intrest_rate
  from bank_loan_data

--Mtd avg intest rate

  select Round(avg(int_rate)::numeric,4) as MTD_avg_intrest_rate
  from bank_loan_data
  where extract(month from issue_date)=12;

--PMtd avg intest rate

  select Round(avg(int_rate)::numeric,4) as PMTD_avg_intrest_rate
  from bank_loan_data
  where extract(month from issue_date)=11;

-- Average Debt-to-Income Ratio (DTI)

   select Round(avg(dti)::numeric,4) as dti_avg_intrest_rate
   from bank_loan_data

 ----Mtd  detp_to_income avg intest rate
 

  select Round(avg(dti)::numeric,4) as dti_MTD_avg_intrest_rate
  from bank_loan_data
  where extract(month from issue_date)=12;

--PMtd  detp_to_income avg intest rate

  select Round(avg(dti)::numeric,4) as dti_PMTD_avg_intrest_rate
  from bank_loan_data
  where extract(month from issue_date)=11;

  --Good loan KIPS

  -- Good loan percentage

   select
   (count(case when loan_status in ('Fully Paid','Current') then id end) * 100.0) /count(id) as
   Good_loan_percentage
   from bank_loan_data

  -- Good loan Total loan applications

    select count(*) as good_loan_total_applications
	from bank_loan_data
	where loan_status in ('Fully Paid','Current')
	
-- Good loan funded amount

 select sum(loan_amount) as good_loan_funded_amount
 from bank_loan_data
 where loan_status in ('Fully Paid','Current')

-- Good loan total amount recived

 select sum(total_payment) as good_loan_total_amount_received
 from bank_loan_data
  where loan_status in ('Fully Paid','Current')

--Bad loan KPIS 

-- bad loan total apllications

  select count(*) as bad_loan_appications
  from bank_loan_data
  where loan_status='Charged Off'

 -- bad loan percentage

  select
  (count(case when loan_status='Charged Off' then id end) * 100.0) / count(id) as bad_loan_percentge
  from bank_loan_data


---- bad loan funded amount

 select sum(loan_amount) as bad_loan_funded_amount
 from bank_loan_data
 where loan_status ='Charged Off'

-- bad loan total amount recived

 select sum(total_payment) as bad_loan_total_amount_received
 from bank_loan_data
  where loan_status ='Charged Off'

-- loan status

  select
  loan_status,
  count(id) as total_loan_applications,
  sum(loan_amount) as Total_funded_amount,
  sum(total_payment) as Total_received_amount,
  avg(int_rate) as avg_intrest_rate,
  avg(dti) as avg_dti_rate
  from bank_loan_data
  group by loan_status;

-- MTD Loan status

  select
  loan_status,
  count(id) as total_loan_applications,
  sum(loan_amount) as Total_funded_amount,
  sum(total_payment) as Total_received_amount,
  avg(int_rate) as avg_intrest_rate,
  avg(dti) as avg_dti_rate
  from bank_loan_data
  where to_char(issue_date,'mm')='12'
  group by loan_status;

--Monthly Trends by Issue Date

select
to_char(issue_date,'mm') as month_number,
to_char(issue_date,'Month') as month_name,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by 1,2
order by month_number asc

--Regional Analysis by State

 select * from bank_loan_data;

select 
address_state,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by 1

--Loan Term Analysis

select 
term,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by 1

--Employee Length Analysis

select 
emp_length,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by 1


--Loan Purpose Breakdown

select 
purpose,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by 1

-- Home Ownership Analysis

select 
home_ownership,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by 1

--loan purpose off A grade

select 
purpose,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
where grade='A'
group by 1