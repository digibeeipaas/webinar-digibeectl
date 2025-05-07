# Modelo de Esteira CI/CD com DigibeeCTL

Este repositório apresenta um modelo de esteira de CI/CD utilizando o **DigibeeCTL**, uma ferramenta poderosa para automação e gerenciamento de pipelines na plataforma Digibee. Este modelo foi projetado para servir como referência para equipes de DevOps que desejam integrar o DigibeeCTL em seus fluxos de trabalho.

---

## O que é o DigibeeCTL?

O **DigibeeCTL** é uma ferramenta de linha de comando (CLI) desenvolvida pela [Digibee](https://www.digibee.com/) para facilitar a interação com a plataforma Digibee. Ele permite que desenvolvedores e equipes de DevOps gerenciem pipelines, deployments e outras operações diretamente do terminal, promovendo automação e integração com esteiras de CI/CD.

### Principais funcionalidades do DigibeeCTL:

- Gerenciamento de pipelines (criação, atualização e exclusão).
- Deployments automatizados.
- Validação de especificações de fluxo (flowspecs).
- Integração com ferramentas de CI/CD como GitHub Actions, Jenkins, e outros.
- Foco em automação e práticas DevOps.

Para mais detalhes, consulte a [documentação oficial do DigibeeCTL](https://docs.digibee.com/documentation/highlights/digibeectl/getting-started).

---

## Sobre este repositório

Este repositório contém um exemplo de fluxo de CI/CD implementado com o **GitHub Actions** e o **DigibeeCTL**. Ele foi projetado para demonstrar como configurar e automatizar o ciclo de vida de deployment de um pipeline na plataforma Digibee.

### Objetivo

O objetivo deste repositório é fornecer um modelo funcional que:

1. Valide a especificação de um pipeline (flowspec) localmente.
2. Compare o flowspec local com o flowspec remoto na plataforma Digibee.
3. Realize o deploy inicial ou redeploy do pipeline, dependendo do estado atual.

---

## Estrutura do Workflow

O arquivo [`workflow.yaml`](.github/workflows/workflow.yaml) define o fluxo de trabalho de CI/CD. Abaixo está uma visão geral das etapas implementadas:

### 1. **Validação do Pipeline**

- Verifica se o arquivo de especificação do pipeline (`flowspec`) existe no repositório.
- Valida se o arquivo é um JSON válido.
- Gera um hash do flowspec local para comparação futura.

### 2. **Verificação do Flowspec**

- Obtém o flowspec remoto do pipeline na plataforma Digibee.
- Compara o hash do flowspec local com o remoto.
- Realiza uma comparação secundária (removendo espaços e formatação) caso os hashes sejam diferentes.
- Garante que o flowspec local esteja sincronizado com o remoto antes de prosseguir.

### 3. **Deploy do Pipeline**

- Verifica o estado atual do pipeline na plataforma Digibee.
- Realiza o deploy inicial caso o pipeline ainda não exista.
- Executa um redeploy caso o pipeline já esteja implantado.
- Exibe logs detalhados do processo de deploy.

---

## Como usar este repositório

### Pré-requisitos

1. **Configuração do DigibeeCTL**:

   - Instale o DigibeeCTL seguindo as instruções da [documentação oficial](https://docs.digibee.com/documentation/highlights/digibeectl/getting-started).
   - Configure as variáveis de ambiente necessárias:
     - `DIGIBEECTL_AUTH_KEY`
     - `DIGIBEECTL_SECRET_KEY`
     - `DIGIBEECTL_TOKEN_JSON`

2. **Configuração do GitHub Actions**:

   - Adicione os segredos necessários no repositório:
     - `DIGIBEECTL_AUTH_KEY`
     - `DIGIBEECTL_SECRET_KEY`
     - `DIGIBEECTL_TOKEN_JSON`

3. **Estrutura do Repositório**:
   - Certifique-se de que o arquivo de especificação do pipeline (`flowspec`) esteja localizado no caminho definido pela variável `FLOWSPEC_PATH`.

### Executando o Workflow

1. Faça um push para a branch `main` configurada no workflow:

2. O GitHub Actions executará automaticamente o workflow definido no arquivo [`workflow.yaml`](.github/workflows/workflow.yaml).

3. Acompanhe os logs no console do GitHub Actions para verificar o progresso e o resultado de cada etapa.

---

## Estrutura do Arquivo `workflow.yaml`

O arquivo [`workflow.yaml`](.github/workflows/workflow.yaml) está dividido em dois jobs principais:

### **1. Build**

- Realiza o checkout do repositório.
- Instala e configura o DigibeeCTL.
- Valida o arquivo de especificação do pipeline (`flowspec`).

### **2. Deploy**

- Realiza o checkout do repositório.
- Instala e configura o DigibeeCTL.
- Verifica o flowspec local e remoto.
- Realiza o deploy inicial ou redeploy do pipeline.

---

## Logs e Mensagens

O workflow utiliza logs detalhados para facilitar a depuração e o monitoramento. As mensagens estão organizadas em grupos para melhorar a legibilidade no console do GitHub Actions.

Exemplo de logs:

- `[INFO]`: Informações gerais sobre o progresso.
- `[SUCESSO]`: Indica que uma etapa foi concluída com sucesso.
- `[ERRO]`: Indica falhas que requerem atenção.
- `[AVISO]`: Mensagens de alerta que não interrompem o fluxo.

---

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests com melhorias ou sugestões.

---

## Referências

- [Documentação do DigibeeCTL](https://docs.digibee.com/documentation/highlights/digibeectl/getting-started)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Digibee](https://www.digibee.com/)

---

**Nota:** Este repositório é um modelo e deve ser adaptado para atender às necessidades específicas de cada projeto.
