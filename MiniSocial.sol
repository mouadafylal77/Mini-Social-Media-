// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title MiniSocial - Mini réseau social décentralisé
/// @notice Permet à n'importe quelle adresse de publier un message (et une URL d'image) sur la blockchain.
/// @dev Seule l'URL du média est stockée on-chain (le fichier reste hors-chaîne) pour limiter le coût en gas.
contract MiniSocial {

    /// @notice Structure représentant une publication
    struct Post {
        string message;     // Texte de la publication
        string mediaUrl;    // URL d'une image hébergée hors-chaîne (peut être vide)
        address author;     // Adresse Ethereum de l'auteur
        uint256 timestamp;  // Date de publication (secondes, heure du bloc)
    }

    /// @notice Tableau dynamique de toutes les publications (getter automatique posts(i))
    Post[] public posts;

    /// @notice Événement émis à chaque nouvelle publication
    event PostPublished(uint256 indexed index, address indexed author, uint256 timestamp);

    /// @notice Publie un nouveau post
    /// @param _message Texte du post (obligatoire)
    /// @param _mediaUrl URL de l'image (optionnelle)
    function publishPost(string memory _message, string memory _mediaUrl) public {
        // Un post ne doit pas être vide
        require(bytes(_message).length > 0, "Le message ne peut pas etre vide");

        // msg.sender = adresse de l'appelant, non falsifiable (signature de la transaction)
        posts.push(Post({
            message: _message,
            mediaUrl: _mediaUrl,
            author: msg.sender,
            timestamp: block.timestamp
        }));

        emit PostPublished(posts.length - 1, msg.sender, block.timestamp);
    }

    /// @notice Retourne les informations d'un post
    /// @param index Position du post dans le tableau (0 = plus ancien)
    /// @return message, mediaUrl, author, timestamp
    function getPost(uint256 index)
        public
        view
        returns (string memory, string memory, address, uint256)
    {
        // Vérification de l'index pour éviter une lecture hors limites
        require(index < posts.length, "Index invalide");

        Post storage p = posts[index];
        return (p.message, p.mediaUrl, p.author, p.timestamp);
    }

    /// @notice Retourne le nombre total de posts
    function getTotalPosts() public view returns (uint256) {
        return posts.length;
    }
}
