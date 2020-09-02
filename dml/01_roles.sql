--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------///USUARIO\\\--------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
insert into role
    (id, nome, permissions)
values
    (1, 'USUARIO',
        '{"categoriaDespesa":{"create":true,"read":true,"update":true,"delete":true},
        "categoriaReceita":{"create":true,"read":true,"update":true,"delete":true},
        "categoriaPlanejamento":{"create":true,"read":true,"update":true,"delete":true},
        "despesa":{"create":true,"read":true,"update":true,"delete":true},
        "receita":{"create":true,"read":true,"update":true,"delete":true},
        "planejamento":{"create":true,"read":true,"update":true,"delete":true},
        "cartao":{"create":true,"read":true,"update":true,"delete":true},
        "banco":{"create":true,"read":true,"update":true,"delete":true},
        "preferences":{"create":true,"read":true,"update":true,"delete":true},
        "usuario":{"create":false,"read":false,"update":false,"delete":false},
        "role":{"create":false,"read":false,"update":false,"delete":false},
        "report":{"create":false,"read":false,"update":false,"delete":false}}');
--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------///PREMIUM\\\--------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
insert into role
    (id, nome, permissions)
values
    (2, 'PREMIUM',
        '{"categoriaDespesa":{"create":true,"read":true,"update":true,"delete":true},
        "categoriaReceita":{"create":true,"read":true,"update":true,"delete":true},
        "categoriaPlanejamento":{"create":true,"read":true,"update":true,"delete":true},
        "despesa":{"create":true,"read":true,"update":true,"delete":true},
        "receita":{"create":true,"read":true,"update":true,"delete":true},
        "planejamento":{"create":true,"read":true,"update":true,"delete":true},
        "cartao":{"create":true,"read":true,"update":true,"delete":true},
        "banco":{"create":true,"read":true,"update":true,"delete":true},
        "preferences":{"create":true,"read":true,"update":true,"delete":true},
        "usuario":{"create":false,"read":false,"update":false,"delete":false},
        "role":{"create":false,"read":false,"update":false,"delete":false},
        "report":{"create":true,"read":true,"update":true,"delete":true}}');
--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------///ADMIN\\\----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
insert into role
    (id, nome, permissions)
values
    (3, 'ADMIN',
        '{"categoriaDespesa":{"create":true,"read":true,"update":true,"delete":true},
        "categoriaReceita":{"create":true,"read":true,"update":true,"delete":true},
        "categoriaPlanejamento":{"create":true,"read":true,"update":true,"delete":true},
        "despesa":{"create":true,"read":true,"update":true,"delete":true},
        "receita":{"create":true,"read":true,"update":true,"delete":true},
        "planejamento":{"create":true,"read":true,"update":true,"delete":true},
        "cartao":{"create":true,"read":true,"update":true,"delete":true},
        "banco":{"create":true,"read":true,"update":true,"delete":true},
        "preferences":{"create":true,"read":true,"update":true,"delete":true},
        "usuario":{"create":true,"read":true,"update":true,"delete":true},
        "role":{"create":true,"read":true,"update":true,"delete":true},
        "report":{"create":true,"read":true,"update":true,"delete":true}}');