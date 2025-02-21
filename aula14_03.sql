select * from actor;

select * from customer;

select
    customer.customer_id as codigo,
    customer.first_name as Nome,
    customer.last_name as Sobrenome,
    address.address as endereco,
    address.district as Bairro
from customer
    inner join address using (address_id)
order by customer.first_name;


select * from list_cliente;

update customer set first_name = 'ADAM_2' where customer_id = 367;

Select * from payment;
-- Crie uma view com codigo do cliente, nome do cliente, valor pago, 5% de comissao para staff = 1 ou 3%
-- de comissao para staff = 2, nome do staff, deve esta em ordem por nome do cliente

select
    payment.customer_id as 'Codigo_do_cliente',
    customer.first_name as Nome_cliente,
    payment.amount as Valor,
    case payment.staff_id
        when 1 then (payment.amount * 0.05)
        when 2 then (payment.amount * 0.03)
    end as Comissao,
    staff.first_name as Gerente
from payment
    INNER join customer USING (customer_id)
    inner join staff using (staff_id)
ORDER BY customer.first_name;


select * from comissao_paga;
-- Incluir a comissao na tabela do staff, e corrigir a view comissao_paga para que capture
-- o percentual da comissao da tabela do staff
select * from staff;

alter table staff add COLUMN comis decimal(5, 2);

update staff set comis = 0.05 where staff_id = 1;

update staff set comis = 0.03 where staff_id = 2;

drop view comissao_paga;

create view comissao_paga as
select
    payment.customer_id as 'Codigo_do_cliente',
    customer.first_name as Nome_cliente,
    payment.amount as Valor,
    (payment.amount * staff.comis) as Comissao,
    staff.first_name as Gerente
from payment
    INNER join customer USING (customer_id)
    inner join staff using (staff_id)
ORDER BY customer.first_name;

select * from comissao_paga;

-- Crie uma view para listar as locações realizadas no mes e o valor de cada locação
select now();

select MONTH(now());

select * from rental;

update rental
set
    rental_date = now()
where
    date(rental_date) = '2005-05-24';

select
    rental_id,
    customer_id,
    rental_date
from rental
where (
        month(rental_date) = month(now())
    )
    and (
        YEAR(rental_date) = YEAR(now())
    );