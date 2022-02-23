# Poupay Terraform

Repositório do código Terraform para construção da infraestrutura na AWS

## Getting started

## __Configurações necessárias__

Antes de começar executar o terraform é necessário colocar as credenciais da aws na máquina. Também é necessário ter o AWS CLI instalado, assim como o terraform.

As credenciais se encontram na tela em que o lab é iniciado etem um terminal aberto. No terminal, digite "cat ~/.aws/credencials" e copie o resultado.

Ao copiar as credenciais, crie, na sua máquina, o arquivo "credencials" no diretório ~/.aws, resultando assim:

- ~/.aws/credentials

E passe o que você copiou para o arquivo criado na sua máquina.
## __Comandos necessários para execução dos scripts__

### terraform init

O terraform init faz o download dos provedores e suas versões, configurados no arquivo main.tf, e prepara o diretório para o uso do terraform

### terraform plan

O terraform plan cria um plano de execução, que consiste em: 
- Ler o estado atual de qualquer objeto remoto já existente para garantir que o estado do Terraform esteja atualizado.
- Comparando a configuração atual com o estado anterior e observando quaisquer diferenças.
- Propor um conjunto de ações de mudança que devem, se aplicadas, fazer com que os objetos remotos correspondam à configuração.

### terraform apply

Aplica o plano de execução.