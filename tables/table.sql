-- public."role" definition

-- Drop table

-- DROP TABLE "role";

CREATE TABLE "role" (
	id int8 NOT NULL,
	nome varchar(255) NOT NULL,
	permissions jsonb NULL,
	CONSTRAINT role_pkey PRIMARY KEY (id)
);


-- public.usuario definition

-- Drop table

-- DROP TABLE usuario;

CREATE TABLE usuario (
	id int8 NOT NULL,
	ativo bool NOT NULL DEFAULT true,
	created_on timestamp NULL,
	email varchar(255) NOT NULL,
	email_verified bool NULL,
	nome varchar(255) NOT NULL,
	senha varchar(255) NOT NULL,
	sobrenome varchar(255) NOT NULL,
	updated_on timestamp NULL,
	username varchar(255) NOT NULL,
	CONSTRAINT usuario_pkey PRIMARY KEY (id)
);


-- public.banco definition

-- Drop table

-- DROP TABLE banco;

CREATE TABLE banco (
	id int8 NOT NULL,
	ativo bool NOT NULL DEFAULT true,
	banco varchar(255) NULL,
	created_on timestamp NULL,
	descricao varchar(255) NULL,
	tipo_conta int4 NULL,
	updated_on timestamp NULL,
	usuario_id int8 NOT NULL,
	CONSTRAINT banco_pkey PRIMARY KEY (id),
	CONSTRAINT banco_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- public.cartao definition

-- Drop table

-- DROP TABLE cartao;

CREATE TABLE cartao (
	id int8 NOT NULL,
	ativo bool NOT NULL DEFAULT true,
	bandeira varchar(255) NULL,
	created_on timestamp NULL,
	data_vencimento date NULL,
	descricao varchar(255) NULL,
	empresa_cartao varchar(255) NULL,
	limite float8 NULL,
	nome varchar(255) NOT NULL,
	tipo_cartao int4 NULL,
	updated_on timestamp NULL,
	usuario_id int8 NULL,
	CONSTRAINT cartao_pkey PRIMARY KEY (id),
	CONSTRAINT cartao_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- public.categoria_despesa definition

-- Drop table

-- DROP TABLE categoria_despesa;

CREATE TABLE categoria_despesa (
	id int8 NOT NULL,
	ativo bool NOT NULL DEFAULT true,
	cor varchar(255) NULL,
	created_on timestamp NULL,
	nome varchar(255) NOT NULL,
	updated_on timestamp NULL,
	usuario_id int8 NULL,
	CONSTRAINT categoria_despesa_pkey PRIMARY KEY (id),
	CONSTRAINT categoria_despesa_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- public.categoria_receita definition

-- Drop table

-- DROP TABLE categoria_receita;

CREATE TABLE categoria_receita (
	id int8 NOT NULL,
	ativo bool NOT NULL DEFAULT true,
	cor varchar(255) NULL,
	created_on timestamp NULL,
	nome varchar(255) NOT NULL,
	updated_on timestamp NULL,
	usuario_id int8 NULL,
	CONSTRAINT categoria_receita_pkey PRIMARY KEY (id),
	CONSTRAINT categoria_receita_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- public.comprovante definition

-- Drop table

-- DROP TABLE comprovante;

CREATE TABLE comprovante (
	uuid varchar(255) NOT NULL,
	ativo bool NULL,
	expire int8 NULL,
	payload jsonb NULL,
	requested_at int8 NULL,
	usuario_id int8 NULL,
	CONSTRAINT comprovante_pkey PRIMARY KEY (uuid),
	CONSTRAINT comprovante_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- public.despesa definition

-- Drop table

-- DROP TABLE despesa;

CREATE TABLE despesa (
	id int8 NOT NULL,
	ativo bool NOT NULL DEFAULT true,
	created_on timestamp NULL,
	data_despesa date NULL,
	descricao varchar(255) NULL,
	despesa_fixa bool NOT NULL DEFAULT false,
	updated_on timestamp NULL,
	valor float8 NOT NULL,
	categoria_despesa_id int8 NOT NULL,
	usuario_id int8 NOT NULL,
	CONSTRAINT despesa_pkey PRIMARY KEY (id),
	CONSTRAINT despesa_categoria_despesa_fkey FOREIGN KEY (categoria_despesa_id) REFERENCES categoria_despesa(id),
	CONSTRAINT despesa_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- public.planejamento definition

-- Drop table

-- DROP TABLE planejamento;

CREATE TABLE planejamento (
	id int8 NOT NULL,
	alerta_porcentagem int8 NULL,
	ativo bool NOT NULL DEFAULT true,
	created_on timestamp NULL,
	data_fim date NOT NULL,
	data_inicio date NOT NULL,
	descricao varchar(255) NULL,
	meta_gastos float8 NOT NULL,
	updated_on timestamp NULL,
	usuario_id int8 NULL,
	CONSTRAINT planejamento_pkey PRIMARY KEY (id),
	CONSTRAINT planejamento_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- public.planejamento_categoria definition

-- Drop table

-- DROP TABLE planejamento_categoria;

CREATE TABLE planejamento_categoria (
	valor_max_gasto float8 NULL,
	planejamento_id int8 NOT NULL,
	categoria_id int8 NOT NULL,
	CONSTRAINT planejamento_categoria_pkey PRIMARY KEY (categoria_id, planejamento_id),
	CONSTRAINT planejamento_categoria_categoria_despesa_fkey FOREIGN KEY (categoria_id) REFERENCES categoria_despesa(id),
	CONSTRAINT planejamento_categoria_planejamento_fkey FOREIGN KEY (planejamento_id) REFERENCES planejamento(id)
);


-- public.receita definition

-- Drop table

-- DROP TABLE receita;

CREATE TABLE receita (
	id int8 NOT NULL,
	ativo bool NOT NULL DEFAULT true,
	created_on timestamp NULL,
	descricao varchar(255) NULL,
	repetir bool NOT NULL DEFAULT false,
	updated_on timestamp NULL,
	valor float8 NOT NULL,
	categoria_receita_id int8 NOT NULL,
	usuario_id int8 NOT NULL,
	CONSTRAINT receita_pkey PRIMARY KEY (id),
	CONSTRAINT receita_categoria_receita_fkey FOREIGN KEY (categoria_receita_id) REFERENCES categoria_receita(id),
	CONSTRAINT receita_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- public.tipo_pagamento definition

-- Drop table

-- DROP TABLE tipo_pagamento;

CREATE TABLE tipo_pagamento (
	despesa_id int8 NOT NULL,
	CONSTRAINT tipo_pagamento_pkey PRIMARY KEY (despesa_id),
	CONSTRAINT tipo_pagamento_despesa_fkey FOREIGN KEY (despesa_id) REFERENCES despesa(id)
);


-- public.tipo_pagamento_cartao definition

-- Drop table

-- DROP TABLE tipo_pagamento_cartao;

CREATE TABLE tipo_pagamento_cartao (
	despesa_id int8 NOT NULL,
	cartao_id int8 NULL,
	CONSTRAINT tipo_pagamento_cartao_pkey PRIMARY KEY (despesa_id),
	CONSTRAINT fkrf46i690et3a5fewe4psqu62s FOREIGN KEY (despesa_id) REFERENCES tipo_pagamento(despesa_id),
	CONSTRAINT tipo_pagamento_cartao_cartao_fkey FOREIGN KEY (cartao_id) REFERENCES cartao(id)
);


-- public.tipo_pagamento_cartao_parcelas definition

-- Drop table

-- DROP TABLE tipo_pagamento_cartao_parcelas;

CREATE TABLE tipo_pagamento_cartao_parcelas (
	id int8 NOT NULL,
	data_pagamento_experada date NULL,
	data_pagamento_real date NULL,
	numero_parcela int8 NOT NULL,
	status_despesa int4 NOT NULL,
	valor_parcela float8 NOT NULL,
	tipo_pagamento_cartao_id int8 NOT NULL,
	CONSTRAINT tipo_pagamento_cartao_parcelas_pkey PRIMARY KEY (id),
	CONSTRAINT tipo_pagamento_moeda_fkey FOREIGN KEY (tipo_pagamento_cartao_id) REFERENCES tipo_pagamento_cartao(despesa_id)
);


-- public.tipo_pagamento_moeda definition

-- Drop table

-- DROP TABLE tipo_pagamento_moeda;

CREATE TABLE tipo_pagamento_moeda (
	dia_pagamento varchar(255) NULL,
	moeda varchar(255) NULL,
	despesa_id int8 NOT NULL,
	CONSTRAINT tipo_pagamento_moeda_pkey PRIMARY KEY (despesa_id),
	CONSTRAINT fkej6if3bndnlbn4bmjf591s7fv FOREIGN KEY (despesa_id) REFERENCES tipo_pagamento(despesa_id)
);


-- public.tipo_pagamento_moeda_log definition

-- Drop table

-- DROP TABLE tipo_pagamento_moeda_log;

CREATE TABLE tipo_pagamento_moeda_log (
	id int8 NOT NULL,
	data_pagamento_experada date NULL,
	data_pagamento_real date NULL,
	status_despesa int4 NOT NULL,
	valor_pagamento float8 NOT NULL,
	tipo_pagamento_moeda_id int8 NULL,
	CONSTRAINT tipo_pagamento_moeda_log_pkey PRIMARY KEY (id),
	CONSTRAINT tipo_pagamento_moeda_fkey FOREIGN KEY (tipo_pagamento_moeda_id) REFERENCES tipo_pagamento_moeda(despesa_id)
);


-- public.tipo_recebimento definition

-- Drop table

-- DROP TABLE tipo_recebimento;

CREATE TABLE tipo_recebimento (
	receita_id int8 NOT NULL,
	CONSTRAINT tipo_recebimento_pkey PRIMARY KEY (receita_id),
	CONSTRAINT tipo_recebimento_receita_fkey FOREIGN KEY (receita_id) REFERENCES receita(id)
);


-- public.tipo_recebimento_banco definition

-- Drop table

-- DROP TABLE tipo_recebimento_banco;

CREATE TABLE tipo_recebimento_banco (
	dia_pagamento varchar(255) NULL,
	receita_id int8 NOT NULL,
	banco_id int8 NOT NULL,
	CONSTRAINT tipo_recebimento_banco_pkey PRIMARY KEY (receita_id),
	CONSTRAINT fkjpx4a35qlcxe5wi9ilchvtiay FOREIGN KEY (receita_id) REFERENCES tipo_recebimento(receita_id),
	CONSTRAINT tipo_recebimento_banco_banco_fkey FOREIGN KEY (banco_id) REFERENCES banco(id)
);


-- public.tipo_recebimento_banco_log definition

-- Drop table

-- DROP TABLE tipo_recebimento_banco_log;

CREATE TABLE tipo_recebimento_banco_log (
	id int8 NOT NULL,
	data_recebimento_experada date NULL,
	data_recebimento_real date NULL,
	status_receita int4 NOT NULL,
	valor_recebido float8 NOT NULL,
	tipo_recebimento_banco_id int8 NOT NULL,
	CONSTRAINT tipo_recebimento_banco_log_pkey PRIMARY KEY (id),
	CONSTRAINT tipo_recebimento_banco_fkey FOREIGN KEY (tipo_recebimento_banco_id) REFERENCES tipo_recebimento_banco(receita_id)
);


-- public.tipo_recebimento_moeda definition

-- Drop table

-- DROP TABLE tipo_recebimento_moeda;

CREATE TABLE tipo_recebimento_moeda (
	dia_pagamento varchar(255) NULL,
	moeda varchar(255) NULL,
	receita_id int8 NOT NULL,
	CONSTRAINT tipo_recebimento_moeda_pkey PRIMARY KEY (receita_id),
	CONSTRAINT fks0tqqde18n3u3s2u5p81vhb4r FOREIGN KEY (receita_id) REFERENCES tipo_recebimento(receita_id)
);


-- public.tipo_recebimento_moeda_log definition

-- Drop table

-- DROP TABLE tipo_recebimento_moeda_log;

CREATE TABLE tipo_recebimento_moeda_log (
	id int8 NOT NULL,
	data_recebimento_experada date NULL,
	data_recebimento_real date NULL,
	status_receita int4 NOT NULL,
	valor_recebido float8 NOT NULL,
	tipo_recebimento_moeda_id int8 NOT NULL,
	CONSTRAINT tipo_recebimento_moeda_log_pkey PRIMARY KEY (id),
	CONSTRAINT tipo_recebimento_moeda_fkey FOREIGN KEY (tipo_recebimento_moeda_id) REFERENCES tipo_recebimento_moeda(receita_id)
);


-- public.usuario_role definition

-- Drop table

-- DROP TABLE usuario_role;

CREATE TABLE usuario_role (
	usuario_id int8 NOT NULL,
	role_id int8 NOT NULL,
	CONSTRAINT usuario_role_role_fkey FOREIGN KEY (role_id) REFERENCES role(id),
	CONSTRAINT usuario_role_usuario_fkey FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);