# Mini-Social-Media

Atelier 3 : mini réseau social décentralisé sur Ethereum (réseau de test **Sepolia**).
Chaque utilisateur MetaMask peut publier un message avec une URL d'image optionnelle. Les posts sont stockés sur la blockchain et affichés dans un fil d'actualité.

## Contenu du dépôt

| Fichier | Description |
|---|---|
| `MiniSocial.sol` | Smart contract Solidity |
| `index.html` | Interface web (HTML + Web3.js via CDN) |
| `rapport.pdf` | Rapport de l'atelier |
| `screenshots/` | Captures d'écran des tests |

## Fonctionnement du contrat

- `struct Post` : `message`, `mediaUrl`, `author`, `timestamp`
- `publishPost(message, mediaUrl)` : publie un post (l'auteur est `msg.sender`)
- `getPost(index)` : lit un post (erreur si l'index est invalide)
- `getTotalPosts()` : retourne le nombre de posts

Seule l'URL de l'image est stockée on-chain, le fichier reste hors-chaîne pour économiser du gas.

## Utilisation

**Prérequis :** MetaMask, quelques ETH Sepolia (via un faucet).

1. Ouvrir [Remix IDE](https://remix.ethereum.org) et créer `MiniSocial.sol` avec le code du dépôt.
2. Compiler (Solidity 0.8.20 ou plus).
3. Dans *Deploy & Run*, choisir **Injected Provider - MetaMask** (réseau Sepolia), puis **Deploy**.
4. Copier l'adresse du contrat déployé.
5. Dans `index.html`, remplacer :
   ```js
   const CONTRACT_ADDRESS = "0xVOTRE_ADRESSE_DE_CONTRAT";
   ```
6. Ouvrir `index.html` dans le navigateur, cliquer sur **Se connecter à MetaMask**, puis publier un message.

> Si MetaMask n'est pas détecté en ouvrant le fichier directement, lancer `python -m http.server 8000` dans le dossier et ouvrir `http://localhost:8000`.

## Sécurité

- Protection XSS : l'affichage des posts utilise `textContent`, jamais `innerHTML`.
- L'URL d'image n'est acceptée que si elle commence par `http://` ou `https://`.
- L'auteur est `msg.sender` : impossible d'usurper une autre adresse.
- Limite : les données sont publiques et définitives (pas de suppression possible).

## Technologies

Solidity, Remix IDE, MetaMask, Sepolia, HTML/JavaScript, Web3.js

## Auteur

Nom Prénom, filière, année : *à compléter*
