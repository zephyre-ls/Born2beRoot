# Born2BeRoot - Etapes d'Installation et Configuration

## 1. Installation de VirtualBox

## 2. Télécharger l'image ISO Debian (version stable)
Iso choisi : `debian-12.9.0-amd64-netinst.iso`.

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
1. Passez en mode administrateur :
   ```bash
   su -
2. Installez sudo
  ```bash
  apt-get install sudo 
