
create or replace function func_verify_pagamento() returns trigger as $body$
  declare
  	v_repetir bool;
  begin
	 if old.status_despesa = 1 or old.status_despesa = 2 then 
	 	if new.status_despesa = 0 then 
	 		select d.despesa_fixa into v_repetir
	 		from despesa d
	 		inner join tipo_pagamento tp on tp.despesa_id = d.id 
	 		inner join tipo_pagamento_moeda tpm on tpm.despesa_id = tp.despesa_id 
	 		inner join tipo_pagamento_moeda_log tpml on tpml.tipo_pagamento_moeda_id = tpm.despesa_id 
	 		where tpml.id = new.id;
	 		if v_repetir then 
	 			insert into tipo_pagamento_moeda_log (id, data_pagamento_experada, data_pagamento_real, status_despesa, 
	 			valor_pagamento, tipo_pagamento_moeda_id) 
	 			VALUES(nextval('tipo_pagamento_moeda_log_sequence_pkey'), old.data_pagamento_experada + '1 month'::interval,
	 			null, 1, old.valor_pagamento, old.tipo_pagamento_moeda_id);
	 		end if;
	 	end if;
	 end if;
    return new;
  end;
$body$ language plpgsql;

create or replace function func_verify_recebimento_banco() returns trigger as $body$
  declare
  	v_repetir bool;
  begin
	 if old.status_receita = 1 or old.status_receita = 2 then 
	 	if new.status_receita = 0 then 
	 		select r.repetir into v_repetir
	 		from receita r
	 		inner join tipo_recebimento tr on tr.receita_id = r.id 
	 		inner join tipo_recebimento_banco trb on trb.receita_id = tr.receita_id 
	 		inner join tipo_recebimento_banco_log trbl on trbl.tipo_recebimento_banco_id = trb.receita_id 
	 		where trbl.id = new.id;
	 		if v_repetir then 
		 		insert into tipo_recebimento_banco_log (id, data_recebimento_experada, data_recebimento_real, status_receita, 
		 		valor_recebido, tipo_recebimento_banco_id) VALUES(nextval('tipo_recebimento_banco_log_sequence_pkey'), 
		 		old.data_recebimento_experada + '1 month'::interval, null, 1, null, old.tipo_recebimento_banco_id);
	 		end if;
	 	end if;
	 end if;
    return new;
  end;
$body$ language plpgsql;

create or replace function func_verify_recebimento_moeda() returns trigger as $body$
  declare
  	v_repetir bool;
  begin
 	if old.status_receita = 1 or old.status_receita = 2 then 
	 	if new.status_receita = 0 then 
	 		select r.repetir into v_repetir
	 		from receita r
	 		inner join tipo_recebimento tr on tr.receita_id = r.id 
	 		inner join tipo_recebimento_moeda trm on trm.receita_id = tr.receita_id 
	 		inner join tipo_recebimento_moeda_log trml on trml.tipo_recebimento_banco_id = trm.receita_id 
	 		where trml.id = new.id;
	 		if v_repetir then 
		 		insert into tipo_recebimento_moeda_log (id, data_recebimento_experada, data_recebimento_real, status_receita, 
		 		valor_recebido, tipo_recebimento_banco_id) VALUES(nextval('tipo_recebimento_moeda_log_sequence_pkey'), 
		 		old.data_recebimento_experada + '1 month'::interval, null, 1, null, old.tipo_recebimento_banco_id);
	 		end if;
	 	end if;
	 end if;
    return new;
  end;
$body$ language plpgsql;

create trigger trg_bu_pagamento_moeda
    before update on tipo_pagamento_moeda_log
    for each row
    execute procedure func_verify_pagamento();

create trigger trg_bu_recebimento_banco
    before update on tipo_recebimento_banco_log
    for each row
    execute procedure func_verify_recebimento_banco();
  
   create trigger trg_bu_recebimento_moeda
    before update on tipo_recebimento_moeda_log
    for each row
    execute procedure func_verify_recebimento_moeda();