CREATE TABLE IF NOT EXISTS cliente(
    -- coluna, tipo de dado, constraint
    nome VARCHAR(50) NOT NULL,
    id SERIAL PRIMARY KEY NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    deleted_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS profissional(
    nome VARCHAR(50) NOT NULL,
    id SERIAL PRIMARY KEY NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    cpf VARCHAR(11) UNIQUE
);

CREATE TABLE IF NOT EXISTS agendamento(
    id SERIAL PRIMARY KEY NOT NULL,
    id_cliente INT NOT NULL,
    id_profissional INT NOT NULL,
    data_marcada DATE NOT NULL,
    hora_inicio TIME,
    status VARCHAR(20) NOT NULL DEFAULT 'agendado' CHECK(status = 'agendado' OR status = 'cancelado' OR status = 'concluido'),
    FOREIGN KEY(id_cliente) REFERENCES cliente(id),
    FOREIGN KEY(id_profissional) REFERENCES profissional(id)
);

CREATE TABLE IF NOT EXISTS servico(
    id SERIAL PRIMARY KEY NOT NULL,
    duracao INT NOT NULL,
    nome VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS agendamento_servicos(
    id_agendamento INT NOT NULL,
    id_servico INT NOT NULL,
    duracao INT NOT NULL, --caso mude o valor da duracao de algum servico futuramente, nao vai mudar dos registros dos servicos que ja ocorreram
    PRIMARY KEY(id_agendamento, id_servico),
    FOREIGN KEY (id_agendamento) REFERENCES agendamento(id),
    FOREIGN KEY(id_servico) REFERENCES servico(id)
);