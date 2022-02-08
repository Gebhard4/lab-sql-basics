use bank;

#Q1
select client_id from client
where district_id = 1
limit 5;

#Q2
select max(client_id) from client 
where district_id = 72;

#Q3
select amount from loan
order by amount asc
limit 3;

#Q4
select distinct(status) from loan
order by status asc;

#Q5
select loan_id from loan
where max(payments);

select loan_id, payments
from loan
order by payments desc
limit 1;

#Q6
select account_id, amount from loan
order by account_id asc
limit 5;

#Q7
select account_id from loan
where duration = 60
order by amount asc;

#Q8
select distinct(k_symbol) from `order`;

#Q9
select order_id from `order`
where account_id = 34;

#Q10
select distinct(account_id) from `order`
where order_id between 29540 and 29560;

#Q11
select distinct(amount) from `order`
where account_to = 30067122;

#Q12
select trans_id, `date`, `type`,  amount from trans
where account_id = 793
order by `date` desc
limit 10;

#Q13
#In the client table, of tricts ith a istric_id lower than 10, how many clients are from each district_id? 
#Show the results sorted by the district_id in ascending order.

select count(client_id) as num_of_clients, district_id from client
where district_id < 10
group by district_id
order by district_id asc;

#Q14
select count(card_id) from card;

select count(card_id), `type` from card
group by `type`
order by count(card_id) desc;

#Q15

select account_id, sum(amount) from loan
group by account_id
order by sum(amount) desc
limit 10;

#Q16
select * from loan
where `date`< '930907'
group by `date`
order by `date` desc;

#Q17
#In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. 
#You can ignore days without any loans in your output.

select duration, date, count(loan_id) from loan
where date between '971201' and '971231'
group by date, duration
order by date, duration asc;

#Q18
#In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). 
#Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.

select account_id, type, sum(amount) from trans
where account_id = 396
group by type
order by type asc;

#Q19
#From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer

select account_id, 
case
	when type = "PRIJEM" then "incoming"
    when type = "VYDAJ" then "outgoing"
end
as transaction_type,
 round(sum(amount)) as total_amount from trans
where account_id = 396
group by type
order by type asc;

#Q20
#From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.

select account_id, 
round(case
	when trans.type = "PRIJEM" then amount
    else 0
    end) as 'incoming',
    
    when type = "VYDAJ" then "outgoing"
end
as transaction_type,
 round(sum(amount)) as total_amount from trans
where account_id = 396
group by type
order by type asc;
 
 
 #Q21
# Continuing with the previous example, rank the top 10 account_ids based on their difference.

select account_id,
	round(sum(case
				when trans.type = "PRIJEM" then amount
                when trans.type = "VYDAJ" then -amount
                else 0
			end)) as 'total_amount'
from trans
group by account_id
order by total_amount desc
limit 10;