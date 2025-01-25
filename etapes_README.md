# Born2BeRoot - Etapes d'Installation et Configuration

## 1. Installation de VirtualBox

## 2. Télécharger l'image ISO Debian (version stable)
Iso choisi : `debian-12.9.0-amd64-netinst.iso`.
- Choix de Debian par rapport à Rocky (le sujet dit que Debian est pour les débutants, je suis une débutante)
- Rocky est plus orienté entreprise
- Debian est flexible, polyvalent et libre.

### Apt / Aptitude 
- Outils pour la gestions des paquets sur les distrib Linux.
- Apt permet une gestion plus simple, il est rapide et simple d'utilisatation. Il est pas défault sur les distrib.
- Aptitude se montre plus puissant et plus interactif, mais demande un niveau avancé. Il est plus interactif avec une interface semi-graphique.

### Selinux/ Apparmor
- SELlinux (Security-Enhanced Linux)
  Founir une sécurité avec une politque strcites pour process et fichier.
-AppArmor (Application Armot)
  Fournit une sécurité basé sur des profils prédéfinis ou personnalisé pour les appli. Cette solution est plus simple à configurer.
  
## 3. Configuration de la machine virtuelle
### Paramètres initiaux :
- **Hostname** : `lduflot42`
- **Mot de passe** : `motdepasse66600`
- **Nom de domaine** : `borntoberoot`
- **Root password** : `motdepasse66600`
- **Nouvel utilisateur** : `user42`
  - **Nom d'utilisateur** : `user42`
  - **Mot de passe** : `motdepasse66600`

## 4. Partitionnement
### Partitionnement manuel :
- Sélection du disque principal (`/dev/sda`).
  - **/boot** : 487 Mo, Type : Primaire, Format : `ext4`
  - **Partition chiffrée** : 
    - Le reste de l'espace disque, Type : Logique, Volume physique pour chiffrement.
    - Passphrase : `cryptique`.
    - Nom de la partition : `sda5`, créée après la partition précédente.
    - Créez un groupe de volumes LVM nommé `lduflot`.
    - Créez les partitions suivantes : `home`, `swap`, et `root`.
  - **Fin de l'installation** : 
    - Aucun média, aucune statistique.
    - Oui à l'installation de GRUB.

## 5. Installation de `sudo`
1. **Passage en mode administrateur** :
   - Commande pour passer en mode root/administrateur :
     ```bash
     su -
     ```
   
2. **Installation de `sudo`** :
     ```bash
     apt-get install sudo
     ```

3. **Ajout utilisateur au groupe `sudo`** :
   - Ajoutez l'utilisateur `lduflot42` au groupe `sudo` pour lui accorder des droits administratifs :
     ```bash
     sudo adduser lduflot42
     ```

4. **Création d'un groupe d'accès à `sudo` pour les autres utilisateurs** :
   - Créez un groupe d'accès à `sudo` pour d'autres utilisateurs :
     ```bash
     sudo addgroup user42
     ```
## 6. Installation et configuration de SSH

### Qu'est-ce que SSH ?
SSH (Secure Shell) est un protocole réseau sécurisé permettant de se connecter à un autre ordinateur sur un réseau (local ou Internet). Il permet d'administrer un serveur à distance, d'exécuter des commandes et de transférer des fichiers en toute sécurité. SSH utilise des mécanismes de chiffrement pour protéger la communication entre le client et le serveur, empêchant ainsi l'interception des mots de passe ou des commandes. 

Le processus fonctionne avec une clé publique, que tout le monde peut lire, et une clé privée, qui sert à l'authentification lors de la connexion.

### Installation de SSH

1. **Mettre à jour les sources de paquets** :
     ```bash
     sudo apt update
     ```

2. **Installer le serveur SSH** :
   - Installez le paquet `openssh-server` :
     ```bash
     sudo apt install openssh-server
     ```

3. **Vérifier l'état du service SSH** :
     ```bash
     sudo systemctl status ssh
     ```

### Configuration du port et des restrictions

1. **Installation de `vim` pour la modification des fichiers de configuration** :
     ```bash
     sudo apt install vim
     ```

2. **Modification du fichier de configuration du serveur SSH** :
   - Ouvrir fichier de configuration principal:
     ```bash
     sudo vim /etc/ssh/sshd_config
     ```
   - Modifiez les paramètres:
     - **Port 4242** : changez le port d'écoute par défaut à 4242.
     - **PermitRootLogin no** : désactivez l'accès SSH pour l'utilisateur `root` pour des raisons de sécurité.
   
3. **Modification du fichier de configuration pour le client SSH** :
    ```bash
     sudo vim /etc/ssh/ssh_config
     ```
   - Retirez les commentaire (#) devant `Port 4242` 

5. **Redémarrer le service SSH pour appliquer les modifications** :
     ```bash
     sudo service ssh restart
     ```
   
6. **Vérifier que le service SSH fonctionne sur le port 4242** :
     ```bash
     sudo service ssh status
     ```
## 7. Configuration du Pare-feu avec UFW

### Qu'est-ce que UFW ?
UFW (Uncomplicated Firewall) est un outil de gestion de pare-feu simple pour les systèmes basés sur Linux. Il permet de contrôler le trafic réseau entrant et sortant du système. Il sert de barrière de sécurité, filtrant les types de connexions et les paquets de données autorisés ou bloqués. UFW protège ainsi le système en limitant l'accès aux connexions indésirables, autorisant seulement certaines adresses IP ou ports. Il régule également quel service ou application peut accéder à Internet ou à d'autres ordinateurs sur le réseau.

### Installation et configuration de UFW

1. **Installer UFW** :
   - Installez le paquet `ufw` :
     ```bash
     sudo apt install ufw
     ```

2. **Vérifier l'état de UFW** :

     ```bash
     sudo ufw status
     ```
   - Par défaut, UFW est désactivé. Pour l'active :
     ```bash
     sudo ufw enable
     ```

3. **Afficher des informations détaillées sur l'état de UFW** :
     ```bash
     sudo ufw status verbose
     ```

4. **Autoriser uniquement les connexions entrantes sur le port 4242** :
     ```bash
     sudo ufw allow 4242
     ```
   - Cela permet uniquement les connexions qui tentent de se connecter au serveur via ce port.

5. **Activer UFW au démarrage du système** :
     ```bash
     sudo systemctl enable ufw
     ```
[Documentation](https://doc.ubuntu-fr.org/ufw).

## 8 - Modification du HOSTNAME et Création d'un Nouvel Utilisateur

### Modification du HOSTNAME
- `hostname` : Affiche le nom actuel de l'hôte.
- `hostnamectl` : Affiche plus de détails sur l'hôte.
- Pour modifier le nom de l'hôte :
  ```bash
  sudo hostnamectl set-hostname nouveau_nom

#### Création d'un Nouvel Utilisateur

  ```bash
 useradd lduflot
  ```

### Création du Mot de Passe et Attribution des Groupes

   ```bash
   passwd lduflot
  ```

### Ajouter l'utilisateur au groupe `user42` et au groupe `sudo`

   ```bash
   sudo adduser lduflot sudo
  ```

## 9 - Politique de mot de passe

1. Modifier les paramètres de politique de mot de passe : 
sudo vim /etc/login.defs
- Expiration du mot de passe tous les 30 jours : `PASS_MAX_DAYS 30`
- Nombre minimum de jours avant de pouvoir modifier un mot de passe : `PASS_MIN_DAYS 2`
- Notification 7 jours avant que le mot de passe expire : `PASS_WARN_AGE 7`
- Longueur minimale du mot de passe (10 caractères) : `PASS_MIN_LEN 10`

  - Pour verifier : sudo chage -l useur
  - A savoir si création des useurs antérieur avant les modif password ne s'applique pas. Il faut les faire       manuellement. Ou supp et recréer les useur (c'est con)

2. Modifier les règles supplémentaires via PAM (Pluggable Authentication Module) : 
sudo vim /etc/pam.d/common-password
- Installer `libpam-pwquality` pour gérer la qualité des mots de passe : sudo apt-get install libpam-pwquality
- Exemple de règle pour les mots de passe : password requisite pam_pwquality.so dcredit=-1 ucredit=-1 lcredit=-1 minlen=10 maxrepeat=3 difok=1
Cela impose que le mot de passe ait au moins 1 chiffre, 1 majuscule, 1 minuscule, 10 caractères minimum et ne contienne pas plus de 3 caractères répétés. En outre, le mot de passe ne doit pas correspondre au nom d'utilisateur.
3. Le root doit suivre cette politique. En plus pour les autres utilisateurs : Le mot de passe devra comporter au moins 7 caractères qui ne sont pas présents dans l'ancien.
4. Pour modifier le mot de passe d'un utilisateur : passwd user42

## 10 - Archivage des commandes sudo (entrées/sorties)
1. Accéder à l'archive des commandes sudo :
sudo vim /var/log/sudo

2. Modifier le fichier sudoers pour activer l'archivage des entrées et sorties de sudo :
sudo vim /etc/sudoers
Ajouter les lignes suivantes pour activer l'archivage :
Defaults log_output
Defaults log_input
Defaults logfile= "/var/log/sudo/sudo.log"
   (Mkdir dossier sudo puis touch fichier sudo.log afin d'archiver les commandes)

4. Rencontre d'une erreur : 
sudo :/var/log/sudo exists but is not a directory 0100644
Cela signifie que /var/log/sudo est un fichier au lieu d'un répertoire. Pour le corriger, modifier le fichier pour qu'il devienne un répertoire
sudo mv /var/log/sudo /var/log/sudo.old
sudo mkdir /var/log/sudo

## 11- Nombre total d'essais autorisés pour un mot de passe lors d'une commande sudo :
Defaults passwd_tries=3
Defaults badpass_message="Tu n'as que 3 tentatives"

## 12- TTY
Defaults requiretty

## 13- Restriction du chemin utilisable par sudo :
Defaults secure_path="/usr/local/sbin:/user/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

## 14- Mise à jour de la date de changement du mot de passe :
sudo chage -m 2 root
sudo chage -M 30 root
sudo chage -l root  # Affichage des informations

## 15- SCRIPT monitoring.sh
[Lien vers le script clique ici, oui, oui.](./monitoring.sh)

## 16- Crontab
```sudo crontab -u root-e ```
Configurer le fichier
*10/ * * * * sh /home/monitoring.sh // Affichage toutes les 10 minutes
- */10 = tts les 10 mins
- 2nd * = tts les heures / plage horaire ex h-h (8-18)
- 3eme * = tts les jours du mois
- 4eme * = ts les mois
- 5eme * = tous les jours de la semaine / plage journalière ex(1-5 = du lundi au vendredi)
  
@reboot sh /home/monitoring.sh // Affichage au démarrage d'une session
Remarque = note d'une erreur, lorsque je suis sur un fichier VIM, le script apparait et cache le texte, necessité de fermé et réouvrir le fichier. Ajout d'une ligne de code dans le fichier monitoring.sh pour éviter le spam.

ss -tuln 

## 17- Récupérer la signature de la VM
- VBoxManage list vms = list vm {signature}
   


