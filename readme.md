# Turbobouffe

Console de vente de l'UTT Arena

## Quick start

Selon ton usage de _Turbobouffe_, voici les commandes dont tu auras besoin:

```sh
# Clone le dépôt. On te recommande de cloner le dépôt en ssh
# (vérifie que tu as une clé ssh et qu'elle est liée à ton compte github)
git clone --recurse-submodules git@github.com:ungdev/UA-bouffe

# Les commandes suivantes te serviront si tu veux contribuer à Turbobouffe !
# (elles installent les dépendances de turbobouffe)
# Si tu veux tester Turbobouffe en local, regarde les instructions
# d'installation dans le readme des deux composants (front & api)
cd UA-bouffe/api
pnpm i
cd ../front
pnpm i

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
