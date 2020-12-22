insert into categoria_despesa(nome, ativo, cor, usuario_id) values ('LootBox', true, '#3cdf6b', 1);
insert into categoria_receita(nome, ativo, cor, usuario_id) values ('Empréstimo à familiares', true, '#615168', 1);
--------------------------------------Outras Coisas-----------------------------------------------
insert into banco (ativo, banco, descricao, tipo_conta, usuario_id) values (true, 'Banco Inter', 'Banco principal', 0, 1);
insert into banco (ativo, banco, descricao, tipo_conta, usuario_id) values (true, 'C6Bank', 'Banco digital secundário', 0, 1);
insert into banco (ativo, banco, descricao, tipo_conta, usuario_id) values (true, 'Nubank', 'Pagamentos principal', 0, 1);
insert into banco (ativo, banco, descricao, tipo_conta, usuario_id) values (true, 'Picpay', 'Pagamentos secundário', 0, 1);
----------
insert into cartao (ativo, bandeira, data_vencimento, descricao, empresa_cartao, limite, nome, tipo_cartao, usuario_id) 
values(true, 'Mastercard', '10', 'Crédito Banco Inter', 'Banco Inter', 3000, 'Banco Inter', 0, 1);
insert into cartao (ativo, bandeira, data_vencimento, descricao, empresa_cartao, limite, nome, tipo_cartao, usuario_id) 
values(true, 'Mastercard', '10', 'Crédito C6Bank', 'C6Bank', 7500, 'C6Bank', 0, 1);
insert into cartao (ativo, bandeira, data_vencimento, descricao, empresa_cartao, limite, nome, tipo_cartao, usuario_id) 
values(true, 'Mastercard', '21', 'Crédito Nubank', 'Nubank', 3400, 'Nubank', 0, 1);
insert into cartao (ativo, bandeira, data_vencimento, descricao, empresa_cartao, limite, nome, tipo_cartao, usuario_id) 
values(true, 'Mastercard', '0', 'Débito Picpay', 'Picpay', 0, 'Picpay', 1, 1);
--------------------------------------Planejamentos-----------------------------------------------
do $$
declare
    plan1 bigint;
    plan2 bigint;
begin
    insert into planejamento (alerta_porcentagem, ativo, data_fim, data_inicio, descricao, meta_gastos, usuario_id) 
    values(80, true, '01/11/2020', '30/11/2020', 'Planejamento Novembro', 5000, 1) returning id into plan1;
    insert into planejamento (alerta_porcentagem, ativo, data_fim, data_inicio, descricao, meta_gastos, usuario_id) 
    values(90, true, '01/12/2020', '31/12/2020', 'Planejamento Dezembro', 7000, 1) returning id into plan2;
    insert into planejamento_categoria (valor_max_gasto, planejamento_id, categoria_id) values(1000, plan1, 1);
    insert into planejamento_categoria (valor_max_gasto, planejamento_id, categoria_id) values(2000, plan1, 2);
    insert into planejamento_categoria (valor_max_gasto, planejamento_id, categoria_id) values(3000, plan1, 3);
    insert into planejamento_categoria (valor_max_gasto, planejamento_id, categoria_id) values(3500, plan2, 4);
    insert into planejamento_categoria (valor_max_gasto, planejamento_id, categoria_id) values(3500, plan2, 5);
end;
--------------------------------------Receitas----------------------------------------------------
do $$
declare
    rec1 bigint;
    rec2 bigint;
begin
    insert into receita (ativo, descricao, repetir, valor, categoria_receita_id, usuario_id) 
    values(true, 'Salário', true, 1900, 1, 1) returning id into rec1;
    insert into tipo_recebimento (receita_id) values(rec1);
    insert into tipo_recebimento_banco (dia_pagamento, receita_id, banco_id) 
    values('05', rec1, (select id from banco where banco = 'Banco Inter' limit 1));
    insert into tipo_recebimento_banco_log (data_recebimento_experada, data_recebimento_real, status_receita, valor_recebido, tipo_recebimento_banco_id) 
    values('05/11/2020', '04/11/2020', 0, 1900, rec1);
    insert into tipo_recebimento_banco_log (data_recebimento_experada, data_recebimento_real, status_receita, valor_recebido, tipo_recebimento_banco_id) 
    values('05/12/2020', '04/12/2020', 0, 1900, rec1);
    insert into tipo_recebimento_banco_log (data_recebimento_experada, data_recebimento_real, status_receita, valor_recebido, tipo_recebimento_banco_id) 
    values('05/01/2021', '', 1, 1900, rec1);

    insert into receita (ativo, descricao, repetir, valor, categoria_receita_id, usuario_id) 
    values(true, 'Dinheiro Extra', false, 200, 2, 1) returning id into rec2;
    insert into tipo_recebimento (receita_id) values(rec2);
    insert into tipo_recebimento_moeda (dia_pagamento, moeda, receita_id) values('15', 'R$', rec2);
    insert into tipo_recebimento_moeda_log 
    (data_recebimento_experada, data_recebimento_real, status_receita, valor_recebido, tipo_recebimento_moeda_id) 
    values('15/12/2020', '11/12/2020', 0, 200, rec2);
end;

--------------------------------------Despesas----------------------------------------------------
do $$
declare
    desp1 bigint;
    desp2 bigint;
    desp3 bigint;
begin
    insert into despesa (ativo, data_despesa, descricao, despesa_fixa, valor, categoria_despesa_id, usuario_id) 
    values (true, '11/11/2020', 'Placa de Vídeo', false, 5400, 3, 1) returning id into desp1;
    insert into tipo_pagamento (despesa_id) values (desp1);
    insert into tipo_pagamento_moeda (dia_pagamento, moeda, despesa_id) value s('11', 'R$', desp1);
    insert into tipo_pagamento_moeda_log (data_pagamento_experada, data_pagamento_real, status_despesa, valor_pagamento, tipo_pagamento_moeda_id)
    values('11/11/2020', '11/11/2020', 0, 5400, desp1);

    insert into despesa (ativo, data_despesa, descricao, despesa_fixa, valor, categoria_despesa_id, usuario_id) 
    values (true, '27/11/2020', 'Placa mãe', false, 1300, 3, 1) returning id into desp2;
    insert into tipo_pagamento (despesa_id) values (desp2);
    insert into tipo_pagamento_cartao (despesa_id, cartao_id) values(desp2, (select id from cartao where nome = 'Banco Inter' limit 1));
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/12/2020', '05/12/2020', 1, 0, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/01/2021', '', 2, 1, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/02/2021', '', 3, 1, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/03/2021', '', 4, 1, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/04/2021', '', 5, 1, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/05/2021', '', 6, 1, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/06/2021', '', 7, 1, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/07/2021', '', 8, 1, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/08/2021', '', 9, 1, 130, desp2);
    INSERT INTO tipo_pagamento_cartao_parcelas (data_pagamento_experada, data_pagamento_real, numero_parcela, status_despesa, valor_parcela, tipo_pagamento_cartao_id) 
    VALUES('10/09/2021', '', 10, 1, 130, desp2);
end;

