# Aconta: app de iPhone e site para o PC

Tudo grátis e sem Mac: o GitHub compila o app num Mac da nuvem, o Sideloadly instala no iPhone e o Supabase guarda os dados para o celular e o PC ficarem sincronizados.

Conteúdo da pasta:

| Arquivo | Para que serve |
|---|---|
| `www/index.html` | o Aconta (o mesmo app no iPhone e no PC) |
| `www/config.js` | onde você cola os dados do Supabase |
| `supabase.sql` | cria o banco de dados na nuvem |
| `.github/workflows/ios.yml` | compila o `Aconta.ipa` para o iPhone |
| `.github/workflows/pages.yml` | publica o site para usar no PC |
| `resources/` | desenho do ícone e da tela de abertura (viram imagem na compilação) |

---

## 1. Nuvem (Supabase), uns 5 minutos

1. Crie uma conta em **supabase.com** e clique em **New project**. Nome: `Aconta`. Região: **South America (São Paulo)**. Crie uma senha do banco e guarde.
2. No menu lateral, abra **SQL Editor › New query**, cole todo o conteúdo de `supabase.sql` e clique em **Run**.
3. Abra **Authentication › Sign In / Providers › Email** e **desligue "Confirm email"**. Assim a conta funciona na hora, sem e-mail de confirmação.
4. Clique em **Connect**, no topo do projeto, e copie a **Project URL** e a **publishable key** (começa com `sb_publishable_`). Ela também fica em **Settings › API Keys**.
5. Abra `www/config.js` num editor de texto (o Bloco de Notas serve) e cole os dois valores entre as aspas:

```js
window.ACONTA_CONFIG = {
  supabaseUrl: "https://abcdxyz.supabase.co",
  supabaseAnonKey: "sb_publishable_..."
};
```

> No plano gratuito, o Supabase pausa um projeto que fica 7 dias sem uso. Usando o Aconta no dia a dia isso não acontece. Se acontecer, entre no painel do Supabase e clique em **Restore**.

## 2. GitHub, uns 5 minutos

1. Crie uma conta em **github.com** e clique em **New repository**. Nome: `aconta`. Marque **Public** (assim os Macs da nuvem e o site saem de graça) e clique em **Create repository**.
2. Na página do repositório, clique em **uploading an existing file** e arraste **todo o conteúdo** desta pasta, inclusive a pasta `.github`. Clique em **Commit changes**.
3. Confira se a pasta `.github/workflows` apareceu no repositório. Se não apareceu (alguns navegadores ignoram pastas que começam com ponto), clique em **Add file › Create new file**, digite o nome `.github/workflows/ios.yml`, cole o conteúdo do arquivo e salve. Repita para o `pages.yml`.

## 3. Site para o PC

1. No repositório, abra **Settings › Pages** e, em **Source**, escolha **GitHub Actions**.
2. Abra a aba **Actions**, clique em **Site para o PC** e depois em **Run workflow**.
3. Em 1 ou 2 minutos o site fica no ar em `https://SEU-USUARIO.github.io/aconta/`.
4. No Chrome, para virar um app no PC: menu **⋮ › Transmitir, salvar e compartilhar › Instalar página como app**.

## 4. App do iPhone (.ipa)

1. Na aba **Actions**, clique em **App iPhone (.ipa)** e depois em **Run workflow**. Leva uns 10 minutos.
2. Quando ficar verde, abra a execução e, em **Artifacts**, baixe **Aconta-ipa**. Descompacte e você terá o `Aconta.ipa`.
3. No **Sideloadly**: conecte o iPhone, arraste o `Aconta.ipa`, informe seu Apple ID e clique em **Start**.
4. No iPhone, em **Ajustes › Geral › VPN e Gerenciamento de Dispositivo**, confie no seu Apple ID.
5. Na primeira vez que tocar no orbe, permita **Microfone** e **Reconhecimento de Fala**.

> Com Apple ID gratuito, o app vale por 7 dias. É só reinstalar pelo Sideloadly (ou ativar o refresh automático dele). Seus dados não se perdem, porque ficam na nuvem.

## 5. Primeiro uso

1. Abra o Aconta no iPhone, toque na **engrenagem**, informe um e-mail e uma senha e toque em **Criar conta**.
2. No site do PC, toque na engrenagem e use **Entrar** com o mesmo e-mail e senha.
3. Pronto. Toque no orbe e diga: *"gastei 45 reais na padaria e 32 de uber no pix"*.

## Atualizar o app depois

Quando alterar algum arquivo no GitHub (por exemplo, um novo `www/index.html`), o site e o `.ipa` são gerados de novo sozinhos. Para o iPhone, basta baixar o novo `.ipa` e instalar por cima com o Sideloadly. Os dados continuam.
