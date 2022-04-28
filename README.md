# Validação de leiaute de arquivos

As especificações _Frictionless_ utilizam uma filosofia de _“small pieces, loosely joined”_ no sentido que as várias especificações podem ser utilizadas individualmente e combinadas para atacar casos de uso mais complexos.
Em particular, a especificação [_Table Schema_](https://specs.frictionlessdata.io/table-schema/) permite a construção de fluxos de validação de arquivos que devem respeitar um _leiaute_ pré-estabelecido, um caso de uso normal no setor público.

O resultado das validações está disponível no arquivo [`reports.html`](https://htmlpreview.github.io/?github.com/transparencia-mg/validacao-leiaute/blob/main/report.html)

## Instalação, configuração e uso

Para execução deste fluxo de validação é necessário as seguintes ferramentas:

- `make`
- `python` (execute `pip install -r requirements.txt` para instalação das dependências `frictionless-py` e `livemark`)

Para executar a validação execute na linha de comando:

```bash
make all
```