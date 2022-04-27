# Validação de leiaute de arquivos

As especificações _Frictionless_ utilizam uma filosofia de _“small pieces, loosely joined”_ no sentido que as várias especificações podem ser utilizadas individualmente e combinadas para atacar casos de uso mais complexos.
Em particular, a especificação [_Table Schema_](https://specs.frictionlessdata.io/table-schema/) permite a construção de fluxos de validação de arquivos que devem respeitar um _leiaute_ pré-estabelecido, um caso de uso normal no setor público.

Como exemplo, vamos usar um caso de uso real da Diretoria de Transparência Ativa para atendimento do pedido de acesso à informação [1520 000015202013](https://github.com/transparencia-mg/pedidos-esic/blob/master/Respostas/1520_000015202013-atualizacao-dataset-compras.md) realizado em conjunto com o NUCC/CGE. 

Mais detalhes do projeto original [aqui](https://github.com/transparencia-mg/age7-compras).

## Validações

### Processo de Compra

```yaml report
descriptor: reports/dm_processo.json
```

### Empenho da Despesa

```yaml report
descriptor: reports/dm_empenho_desp.json
```

## Instalação, configuração e uso

Para execução deste fluxo de validação é necessário as seguintes ferramentas:

- `make`
- `rsync`
- `python` (execute `pip install -r requirements.txt` para instalação das dependências `frictionless-py` e `livemark`)

Para executar a validação execute na linha de comando:

```bash
make all
```

## Apêndice

Comandos para limpeza dos arquivos `archive/bad/` que não respeitam o item 7 da [RFC 4180](https://datatracker.ietf.org/doc/html/rfc4180)

> 7. If double-quotes are used to enclose fields, then a double-quote appearing inside a field must be escaped by preceding it with another double quote. For example:
> 
> `"aaa","b""bb","ccc"`

```bash
sed -e '27482 s/""ABNT 14.865""/""ABNT 14.865"""/' \
    -e '209039 s/Papa""/Papa"/' \
    -e '318551 s/Adm.Pública""/Adm.Pública"""/' \
    data-raw/dm_processo.csv > data-clean/dm_processo.csv


sed -e '2,7 s/$/"/' data-raw/dm_empenho_desp.csv > data-clean/dm_empenho_desp.csv
```
