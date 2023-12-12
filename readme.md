# Turbobouffe
[![Build status](https://github.com/ungdev/UA-bouffe/actions/workflows/ci.yml/badge.svg)](https://github.com/ungdev/UA-bouffe/actions/workflows/ci.yml)

Console de vente de l'UTT Arena

## Quick start

Selon ton usage de _Turbobouffe_, voici les commandes dont tu auras besoin:

```sh
# Clone le dépôt. On te recommande de cloner le dépôt en ssh
# (vérifie que tu as une clé ssh et qu'elle est liée à ton compte github)
git clone --recurse-submodules git@github.com:ungdev/UA-bouffe

# Les commandes suivantes te serviront si tu veux contribuer à Turbobouffe !
# (elles installent les dépendances de turbobouffe)
# N'hésite pas à regarder les instructions dans les readme des 2 composants
cd UA-bouffe/api
pnpm i
cp .env.example .env
cd ../front
pnpm i
cp .env.example .env
# Pour créer le seed.sql à importer dans la db:
cd ..
node ./seed/collector.mjs
# Ensuite importer le seed.sql se trouvant dans le dossier actuel pour créer la DB
mysql < seed.sql
# Vous pouvez maintenant exécuter le front et l'api en faisant la commande suivant dans chacun des 2 dossiers:
pnpm dev


# Les commandes suivantes te serviront si tu veux faire tourner Turbobouffe !
# Installe docker ! On te met une commande si tu utilises linux.
# Sinon regarde sur https://docs.docker.com/engine/install/
# (on te donne aussi la commande pour installer docker-compose.
# Plus de précisions ici: https://docs.docker.com/compose/install/)
curl -fsSL https://get.docker.com | bash
# Docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# Lance Turbobouffe !
docker-compose up
```
