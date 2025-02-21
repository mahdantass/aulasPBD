select * from actor;
create function nome_ator(id int)
returns varchar(60)
DETERMINISTIC
begin
    declare nome_completo varchar(60);
    select concat(first_name, ' ',last_name) into nome_completo from actor where actor_id = id;
    return nome_completo;
end;

select nome_ator(2);
select nome_ator(actor_id) from actor;
drop Function nome_ator;

select * from payment;
-- ex1 - crie uma função para mostrar o nome do cliente, nome do staff, total pago pelo cliente

create Function total_pago(id int) 
RETURNS VARCHAR(100) 
DETERMINISTIC 
begin 
    declare mensagem varchar(100); 
    select concat ('cliente = ', customer.first_name, 'Gerente = ',staff.first_name,'Total =', sum(payment.amount)) 
    into mensagem
    from payment
    INNER join customer using(customer_id)
    inner join staff using(staff_id)
    where payment.customer_id = id; 
    return mensagem;
end; 
select * from total_pago(1);

-- ex2 - crie uma função para mostrar o nome do cliente, nome do staff, total pago pelo cliente
-- e a comissao de 5% para o staff 1 ou 3% para o staff 2

CREATE Function resultado(id int)
RETURNS VARCHAR(100) 
DETERMINISTIC 
begin 
declare mensagem varchar(100); 
    select concat ('cliente = ', customer.first_name, 'Gerente = ',staff.first_name,
    'Total =', sum(payment.amount), 'Comissao =', 
    if (staff_id = 1, (payment.amount * 0.05), (payment.amount * 0.03)))
    into mensagem
    from payment
    INNER join customer using(customer_id)
    inner join staff using(staff_id)
    where payment.customer_id = id; 
    return mensagem;
end; 

select resultado(2);

