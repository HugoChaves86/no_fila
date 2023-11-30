# !Fila UFBA

## Descrição
O !Fila (NotFila) é um sistema que facilita a montagem e ajuste de grades curriculares na Universidade Federal da Bahia (UFBA) de forma assíncrona. Este sistema permite que os alunos organizem suas preferências de disciplinas e que os professores validem tais escolhas baseando-se na disponibilidade de vagas. Além disso, o sistema identifica oportunidades para trocar disciplinas entre alunos, otimizando o uso de vagas disponíveis.

## Instruções para Compilar e Executar

### Backend
1. Baixe e instale o Docker Desktop a partir do [link oficial](https://www.docker.com/products/docker-desktop/).
2. Abra o terminal e navegue até a pasta `/backend`.

   ```bash
   cd no_fila/backend
   ```

3. Execute o comando para construir a imagem Docker.

   ```bash
   docker build . -t backend
   ```

4. Inicie o serviço.

   ```bash
   docker run -p 8000:8000 backend
   ```

### Frontend
1. Abra a pasta `frontend` no terminal.

   ```bash
   cd no_fila/frontend
   ```

2. Execute para baixar as dependências.

   ```bash
   flutter pub get
   ```

3. Navegue até o arquivo `lib/main.dart` e execute o projeto.

## Membros da Equipe
- Diogo Santos
- Hugo Chaves
- Jonathan Bispo
- Rodrigo Cerqueira
- Wallace Bispo
