-- init.sql
-- Executado como superusuário após a criação do banco de dados inicial.

-- 1. CRIAÇÃO DO BANCO DE DADOS E USUÁRIO
-- O entrypoint do Docker já criou o usuário (${POSTGRES_USER}) e o banco (${POSTGRES_DB})
-- com as credenciais injetadas. Aqui, garantimos que o usuário tenha a senha correta.

ALTER USER ${POSTGRES_USER} WITH PASSWORD '${POSTGRES_PASSWORD}';

-- 2. CONECTAR AO BANCO DE DADOS
\c ${POSTGRES_DB}

-- 3. CRIAÇÃO DOS SCHEMAS DENTRO DO BANCO CBKT

-- Cria o schema 'auth'
CREATE SCHEMA IF NOT EXISTS auth AUTHORIZATION ${POSTGRES_USER};

-- Cria o schema 'cadastro'
CREATE SCHEMA IF NOT EXISTS cadastro AUTHORIZATION ${POSTGRES_USER};

-- 4. DEFINIR O CAMINHO DE BUSCA (search_path)
-- Isso garante que as aplicações encontrem as tabelas sem precisar especificar o schema
ALTER DATABASE ${POSTGRES_DB} SET search_path TO auth, cadastro, public;

-- Opcional: Garantir que os schemas sejam de propriedade do usuário principal (o que já foi feito na criação)
ALTER SCHEMA auth OWNER TO ${POSTGRES_USER};
ALTER SCHEMA cadastro OWNER TO ${POSTGRES_USER};