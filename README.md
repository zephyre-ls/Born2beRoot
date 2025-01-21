# BornToBeRoot

## 1. VirtualBox

**VirtualBox** est un environnement de virtualisation qui permet d'exécuter une machine virtuelle (VM) sur une machine physique. La VM fonctionne avec son propre système d'exploitation (OS) et bénéficie des équipements physiques de la machine hôte. Elle fonctionne de manière isolée, et ses ressources sont simulées par rapport à la machine hôte.

[Qu'est-ce qu'une machine virtuelle ?](https://www.redhat.com/fr/topics/virtualization/what-is-a-virtual-machine)

### Debian (Version stable)

https://www.debian.org/releases/index.fr.html
La distribution "stable" de Debian est la version 12.9 - Bookworm
Debut du projet sous la 12.8, mais sortie d'une version stable le 11/01/2025 donc modification de la version en cours de projet.

---

## 2. Partitionnement

Le **partitionnement** est l'opération consistant à diviser un support de stockage (comme un disque dur) en plusieurs sections, appelées partitions. Cette opération permet au système d'exploitation de gérer les informations de manière séparée et optimisée, offrant ainsi une meilleure organisation, une rapidité d'accès améliorée et une sécurité accrue.

### Types de partitions et de désignations

#### Windows
Sous Windows, les partitions sont désignées par des lettres, comme `C:`, `D:`, etc.

#### macOS
Sous macOS, les partitions sont désignées sous la forme `diskNsM`, où :
- `N` représente le numéro du support,
- `M` représente le numéro de la partition sur ce support.

#### Linux/Unix/GNU
Sous Linux, les partitions sont désignées sous la forme `sdXN`, où :
- `X` est une lettre représentant le support (par exemple `a`, `b`, `c`, etc.),
- `N` est le numéro de la partition sur ce support.

Exemple : `sdb3` représente la troisième partition du disque `b`.

---

## 3. LVM (Logical Volume Management)

**LVM** (Gestionnaire de Volumes Logiques) est un système permettant de créer et de gérer des partitions virtuelles sous Linux. Il offre une couche d'abstraction entre l'espace de stockage physique et le système d'exploitation, permettant une gestion flexible des volumes.

### Composants de LVM

- **PV (Physical Volume)** : Un disque ou une partition physique utilisé par LVM.
- **VG (Volume Group)** : Un groupe de volumes physiques.
- **LV (Logical Volume)** : Un volume logique créé dans un groupe de volumes (remplaçant les partitions traditionnelles).
- **PE (Physical Extent)** : La plus petite unité de stockage utilisée dans un volume physique.

### Commandes LVM

- `sudo pvcreate /dev/sdX` : Crée un volume physique sur un disque ou une partition.
- `sudo pvs` : Affiche les volumes physiques disponibles.
- `sudo vgcreate <nom_du_vg> /dev/sdX` : Crée un groupe de volumes.
- `sudo vgs` : Affiche les groupes de volumes, leur taille et leurs détails.
- `sudo lvcreate -L <taille> -n <nom_du_lv> <nom_du_vg>` : Crée un volume logique dans un groupe de volumes.
- `sudo lvs` : Affiche les volumes logiques créés.

---

## 5. Storage (Stockage)

![Screenshot from 2024-12-11 16-13-20](https://github.com/user-attachments/assets/bc9ae435-32ae-4820-837b-715899c59b7d)

Le stockage principal d'une machine virtuelle (VM) repose sur un **disque dur virtuel**. 

### Options de Disques durs Virtuels

#### **Solid-State Drive (SSD)**

Un SSD virtuel permet de simuler un disque SSD dans la machine virtuelle. Si cette option est activée, la machine pourra profiter des optimisations de performances propres aux SSD. Si elle est désactivée, le disque sera simulé comme un disque dur classique (HDD).

#### **Ajout d'un Disque Dur Virtuel**

Dans VirtualBox, pour ajouter un disque dur virtuel à une machine, suivez ces étapes :

1. Allez dans les paramètres de la VM (`Settings`).
2. Sélectionnez l'onglet **Storage**.
3. Cliquez sur l'icône de la disquette bleue (`+`), puis choisissez **Add Hard Disk**.
4. Vous aurez ensuite le choix entre plusieurs formats de disques :

### Formats Disponibles

- **VDI (VirtualBox Disk Image)**  
  Le format natif de VirtualBox. Il offre de meilleures performances et est recommandé si vous utilisez uniquement VirtualBox. C'est le format par défaut.

- **VHD (Virtual Hard Disk)**  
  Ce format est utilisé par Microsoft et est compatible avec d'autres hyperviseurs comme **Hyper-V** ou **Azure**. Si vous prévoyez de migrer vos VM vers d'autres hyperviseurs à l'avenir, c'est un bon choix. Cependant, dans ce projet, c'est un choix qui pourrait ne pas être optimal.

- **VMDK (Virtual Machine Disk)**  
  Le format natif de VMware, compatible avec ce système. Il offre aussi des performances élevées et est adapté si vous envisagez de travailler avec des machines virtuelles sur VMware.
    

## 6. Affichage des Partitions et Volumes (via `lsblk`)

![Screenshot from 2024-12-11 18-57-03](https://github.com/user-attachments/assets/0abc55ea-3c4b-481e-84f0-0fc788ad5a50)

`lsblk` permet d'afficher la structure des périphériques de stockage et de leurs partitions. Voici les principales informations que l'on peut obtenir :

### Explication des Colonnes

- **NAME** : Nom du périphérique ou de la partition.
- **MAJ:MIN** : Indicateurs majeurs et mineurs utilisés pour identifier le périphérique dans le système.
- **RM** : Indique si le périphérique est amovible (`1` pour amovible, `0` pour non amovible).
- **SIZE** : Taille du périphérique ou de la partition.
- **RO** : Indique si le périphérique est en lecture seule (`1` pour lecture seule, `0` sinon).
- **TYPE** : Type du périphérique (ex. : `disk`, `part`, `lvm`, `crypt`).
- **MOUNTPOINT** : Point de montage, où le périphérique ou la partition est accessible dans le système de fichiers.


### Description des Périphériques et Partitions

- **sda (8G)** : Disque principal qui contient plusieurs partitions.
  - **sda1 (467M)** : Partition montée sur `/boot`, contient le chargeur de démarrage et les fichiers nécessaires au démarrage du système.
  - **sda2 (1K)** : Une partition très petite.
  - **sda5 (7.5G)** : Partition principale, chiffrée (`sda5_crypt`), qui contient des volumes logiques gérés par LVM.
    - **sda5_crypt** : Partition chiffrée déverrouillée, contenant des volumes logiques LVM.
      - **wil--vg--root (2.8G)** : Volume logique pour le système racine (`/`), où le système d'exploitation est installé.
      - **wil--vg--swap_1 (976M)** : Volume logique pour la partition d'échange (swap), utilisée comme mémoire supplémentaire lorsque la RAM est saturée.
      - **wil--vg--home (3.8GB)** : Volume logique pour le répertoire personnel des utilisateurs (`/home`).
- **sr0 (12024M)** : Lecteur optique (CD/DVD), actuellement non monté.

## 7. Types de Partitions

![Screenshot from 2024-12-12 14-18-32](https://github.com/user-attachments/assets/e46e9830-4070-4814-bd8c-352b1b0a2859)

### 1. **ext4**
- **Description** : Système de fichiers fiable grâce à la journalisation. La journalisation enregistre les changements avant de les appliquer, ce qui permet une récupération rapide après un crash.
- **Utilisation** : Principalement utilisé pour les partitions principales du système telles que `/` et `/home`.

### 2. **ext3**
- **Description** : Ancêtre de `ext4`, il offre une bonne compatibilité avec les anciens systèmes, mais il est moins performant et optimisé.
- **Utilisation** : Utilisé dans les systèmes plus anciens ou pour des besoins de compatibilité.

### 3. **ext2**
- **Description** : Ancien système de fichiers sans journalisation, ce qui signifie moins de sécurité en cas de crash. Toutefois, il permet d'écrire moins fréquemment sur le disque.
- **Utilisation** : Idéal pour les clés USB ou des partitions spécifiques comme `/boot`. Moins de sécurité à cause de l'absence de journalisation.

### 4. **btrfs**
- **Description** : Système de fichiers moderne avec des fonctionnalités avancées telles que la compression, la gestion des snapshots et le support RAID.
- **Utilisation** : Principalement utilisé dans les serveurs ou dans des configurations expérimentales.

### 5. **JFS (Journaled File System)**
- **Description** : Développé par IBM, ce système est conçu pour les systèmes ayant une forte utilisation du processeur.
- **Avantages** : Rapide pour les fichiers volumineux.
- **Utilisation** : Utilisé dans des configurations où les performances en lecture/écriture de gros fichiers sont importantes.

### 6. **XFS**
- **Description** : Système de fichiers avancé qui gère efficacement les gros fichiers et offre une gestion avancée des données.
- **Utilisation** : Idéal pour les systèmes de stockage de données nécessitant une gestion efficace des gros fichiers.

### 7. **FAT16/FAT32**
- **Description** : Système de fichiers simple, souvent utilisé sur des supports amovibles tels que les clés USB. Il est compatible avec Windows, Mac et Linux.
- **Utilisation** : Utilisé pour des partitions partagées entre plusieurs systèmes d'exploitation.

### 8. **Swap area**
- **Description** : Partition utilisée comme mémoire virtuelle, permettant d'étendre la RAM du système.
- **Utilisation** : Toujours recommandé d'avoir une partition swap pour les systèmes qui n'ont pas assez de RAM physique.

### 9. **Physical volume for encryption**
- **Description** : Prépare une partition pour le chiffrement avec LUKS, garantissant que les données soient sécurisées par un mot de passe.
- **Utilisation** : Utilisé pour sécuriser une partition en cas de besoin de chiffrement.

### 10. **Physical volume for RAID**
- **Description** : Prépare une partition pour être utilisée dans une configuration RAID (Redundant Array of Independent Disks).
- **Utilisation** : Utilisé pour les configurations RAID où la redondance des données et la performance sont essentielles.

### 11. **Physical volume for LVM**
- **Description** : Prépare une partition pour être utilisée dans le cadre de LVM (Logical Volume Manager), permettant une gestion flexible des volumes de stockage.
- **Utilisation** : Utilisé pour gérer dynamiquement les partitions de stockage et les volumes.

### 12. **Do not use the partition**
- **Description** : Partie du disque qui n'est pas utilisée et ignorée par le système.
- **Utilisation** : Peut être laissée inutilisée si aucune partition n'est nécessaire.




## 8. Points de Montage

![Screenshot from 2024-12-12 14-36-53](https://github.com/user-attachments/assets/99b0c8b5-d027-4185-ad6e-e7ff3d12202b)

### 1. **/ (root)**
- **Description** : Racine du système de fichiers, là où tout commence. Toutes les autres partitions/points de montage se trouvent sous cette racine.
- **Rôle** : Contient le système d'exploitation, les binaires essentiels, les bibliothèques et les fichiers indispensables au démarrage.

### 2. **/boot**
- **Description** : Contient les fichiers nécessaires au démarrage du système. Séparer `/boot` des autres partitions permet de garder les fichiers de démarrage accessibles en cas de problème avec d'autres partitions.
- **Contenu** : Le noyau Linux et GRUB (le chargeur de démarrage).

### 3. **/home**
- **Description** : Dossier personnel des utilisateurs. Chaque utilisateur a son propre répertoire dans `/home`.
- **Rôle** : Permet de stocker les fichiers personnels, les paramètres de configuration des utilisateurs, etc.

### 4. **/tmp**
- **Description** : Contient les fichiers temporaires utilisés par les applications.
- **Rôle** : Améliore la sécurité et prévient les conflits d'espace disque entre les applications.

### 5. **/usr**
- **Description** : Contient les fichiers logiciels installés par le système ou par l'utilisateur.
- **Rôle** : Facilite les sauvegardes, car il contient les logiciels et les bibliothèques nécessaires au fonctionnement du système.

### 6. **/var**
- **Description** : Stocke les fichiers log, les fichiers temporaires d'applications, et les tâches en cours d'exécution.
- **Rôle** : Sert de répertoire pour les données volatiles, qui changent fréquemment (logs, caches, etc.).

### 7. **/srv**
- **Description** : Contient les données de services fournis par l'ordinateur.
- **Rôle** : Par exemple, si l'ordinateur fonctionne comme un serveur web, ce répertoire contient les fichiers partagés et accessibles à d'autres ordinateurs.

### 8. **/opt**
- **Description** : Contient les logiciels additionnels installés manuellement par l'administrateur.
- **Rôle** : Facilite l'organisation des logiciels non standards, installés en dehors des paquets fournis par le système.

### 9. **/usr/local**
- **Description** : Contient des programmes ou des fichiers spécifiques à l'utilisateur, qui ne proviennent pas du système par défaut.
- **Rôle** : Permet l'installation de logiciels ou de fichiers sans interférer avec les fichiers système.

### Conclusion
Les points de montage servent à organiser le système de fichiers, permettant un accès structuré aux différentes parties du système et facilitant ainsi la gestion, la sécurité et les sauvegardes.

## 9. Options de Montage

![Screenshot from 2024-12-12 14-49-24](https://github.com/user-attachments/assets/56c29c35-426b-47c6-aafd-435e0c63f3fa)

### 1. **discard**
- **Description** : Active les commandes TRIM sur SSD. Cela indique au SSD quels blocs ne sont plus utilisés et peuvent être effacés.
- **Avantages** : Améliore les performances et la durée de vie du disque. Cette option effectue un TRIM à chaque suppression de fichier.
- **Configuration** : Il est possible de configurer TRIM périodiquement avec une tâche cron (via `fstrim`).

### 2. **noatime**
- **Description** : Empêche la mise à jour de la date d'accès d'un fichier ou dossier lorsqu'il est lu.
- **Avantages** : Améliore les performances en réduisant le nombre d'écritures. Utile pour des systèmes où l'accès en lecture est fréquent, comme les serveurs ou bases de données.
- **Inconvénient** : Si la mise à jour de la date d'accès est nécessaire pour des raisons de sécurité, il ne faut pas utiliser cette option.

### 3. **nodiratime**
- **Description** : Similaire à `noatime`, mais s'applique spécifiquement aux répertoires (directories).
- **Avantages** : Améliore les performances en empêchant la mise à jour de la date d'accès sur les répertoires.

### 4. **relatime**
- **Description** : Met à jour la date d'accès (`atime`) d'un fichier ou dossier uniquement si la dernière mise à jour date d'avant la dernière modification ou si la dernière mise à jour de `atime` a eu lieu il y a plus de 24 heures.
- **Avantages** : Permet un compromis entre `noatime` et `atime` classique, tout en améliorant les performances.

### 5. **nodev**
- **Description** : Empêche la création ou l'utilisation de fichiers spéciaux de type périphérique (comme les blocs de disque ou les terminaux tty).
- **Avantages** : Améliore la sécurité en empêchant l'accès aux périphériques via cette partition.

### 6. **nosuid**
- **Description** : Empêche l'exécution de fichiers avec le bit SUID (Set User ID) ou SGID (Set Group ID).
- **Avantages** : Les fichiers ne peuvent pas être exécutés avec les privilèges d'un autre utilisateur, ce qui renforce la sécurité sur un système multi-utilisateurs.

### 7. **noexec**
- **Description** : Empêche l'exécution de programmes sur une partition.
- **Avantages** : Renforce la sécurité des partitions où l'exécution de programmes n'est pas nécessaire (par exemple `/home`, `/tmp`). Si un utilisateur malveillant place un script ou un programme dans `/tmp`, il ne pourra pas l'exécuter.

### 8. **ro**
- **Description** : Monte le système de fichiers en lecture seule.
- **Utilisation** : À utiliser sur des partitions où aucune modification ne doit être apportée, comme pour une sauvegarde ou un disque système protégé.

### 9. **sync**
- **Description** : Force toutes les écritures sur le disque à se produire immédiatement.
- **Avantages** : Réduit les risques de perte de données en cas de panne. 
- **Inconvénient** : Ralentit les performances d'écriture, car les écritures ne sont pas mises en cache.

### 10. **usrquota**
- **Description** : Gère les quotas pour les utilisateurs sur un système de fichiers, limitant l'espace disque qu'un utilisateur peut utiliser.
- **Avantages** : Permet de contrôler l'utilisation de l'espace disque par les utilisateurs.

### 11. **grpquota**
- **Description** : Gère les quotas de groupe sur un système de fichiers, limitant l'espace disque qu'un groupe d'utilisateurs peut utiliser.
- **Avantages** : Permet de contrôler l'utilisation de l'espace disque par un groupe d'utilisateurs.

### 12. **user_xattr**
- **Description** : Permet de stocker des attributs étendus sur un système de fichiers. Ces attributs peuvent inclure des informations supplémentaires sur les fichiers, des données spécifiques à l'utilisateur ou des métadonnées.
- **Avantages** : Permet de personnaliser la gestion des fichiers en ajoutant des informations spécifiques.

## 10. Commandes et Configuration Réseau dans VirtualBox

![Screenshot from 2024-12-11 10-51-01](https://github.com/user-attachments/assets/2b3993ab-b1b8-4b39-8a76-77bf503e2a1b)

### 1. **Enable Network Adapter**
- **Description** : Active ou désactive l'adaptateur réseau de la machine virtuelle (VM). Si désactivé, la VM n'a pas de connexion réseau.

### 2. **Attached to: NAT**
- **Description** : Définit la manière dont la VM est connectée au réseau.
- **NAT (Network Address Translation)** : L'adresse IP de l'hôte et de la VM sont les mêmes, ce qui permet à la VM de se connecter au réseau externe via l'adresse de l'hôte.

### 3. **Adapter Type**
- **Description** : Spécifie le type d'adaptateur réseau virtuel émulé par VirtualBox.

### 4. **Promiscuous Mode**
- **Description** : Définit si l'adaptateur réseau peut capturer des paquets qui ne lui sont pas destinés.
  - **Deny** : L'adaptateur ignore les paquets réseau qui ne sont pas destinés à son adresse MAC.

### 5. **MAC Address**
- **Description** : (Media Access Control) Adresse unique attribuée à l'adaptateur réseau de la VM. Elle permet de l'identifier sur le réseau.

### 6. **Cable Connected**
- **Description** : Indique si un câble réseau est branché sur cet adaptateur. Si décoché, la VM se comporte comme si elle était déconnectée du réseau.

### 7. **Port Forwarding**
- **Description** : Configure le redirectionnement des ports lorsque l'adaptateur est en mode NAT. Cela permet de rediriger un port de l'hôte vers un port spécifique de la VM, permettant ainsi l'accès aux services ou applications exécutées sur la VM depuis l'extérieur, même si elle utilise une adresse privée via NAT.
  - **Protocol** : TCP (parfois UDP)
  - **Host IP** : Si vide, cela signifie "toutes les adresses IP".
  - **Host Port** : Le port utilisé pour accéder à la VM depuis l'hôte.
  - **Guest IP** : L'adresse IP de la VM, si vide cela signifie "toutes les interfaces de la VM".
  - **Guest Port** : Le port sur lequel le service écoute dans la VM.

### Exemple de Commande SSH
- Pour accéder à un service via SSH sur la VM depuis l'hôte :
  ```bash
  ssh user@127.0.0.1 -p <HOSTPORT>
  
## 11. Périphériques de Stockage Connectés à la VM

![Screenshot from 2024-12-11 11-23-15](https://github.com/user-attachments/assets/d0f82d65-b50e-470c-a1df-f13844972dd5)

### 1. **Controller: IDE**
- **Description** : Le contrôleur IDE (Integrated Drive Electronics) est un type de contrôleur de disque plus ancien, mais toujours utilisé pour les fichiers ISO.
- **Fichier ISO Monté** : `debian-12.8.0-amd64-netinst.iso`

### 2. **Controller: SATA (Serial ATA)**
- **Description** : Le contrôleur SATA est plus moderne et rapide par rapport à IDE. Il est utilisé pour connecter des disques durs et des SSD virtuels.
- **Disque Dur Virtuel Attaché au Contrôleur SATA** : `born2root.vdi`
  - **.vdi (Virtual Disk Image)** : Contient le disque dur virtuel utilisé par cette machine.

#### Attributs du Contrôleur SATA :
- **Name** : Le nom du contrôleur SATA.
- **Type** : SATA, réglé sur AHCI (Advanced Host Controller Interface) pour optimiser les performances des disques SATA.
- **Port Count** : Le nombre de ports disponibles (1 port dans mon cas, ce qui signifie qu'un seul disque peut être connecté au contrôleur SATA).
- **Use Host I/O Cache** : 
  - **Activé** : Utilise le cache entrée-sortie de l'hôte pour améliorer les performances.
  - **Désactivé** : Utile si les disques virtuels sont lents, mais augmente le risque de corruption des données en cas d'arrêt brutal de l'hôte.

### 3. **Boutons en Bas à Gauche**
- **Vert Plus Vert** : Ajouter un nouveau contrôleur.
- **Vert Plus Rouge** : Retirer un disque ou une image sélectionnée.
- **Disquette Plus** : Ajouter un nouveau disque ou fichier ISO.
- **Disquette Sans Couleur** : Modifier les paramètres des disques ou contrôleurs.

## 12. Périphériques de Stockage Connectés à la VM

![Screenshot from 2024-12-11 10-51-13](https://github.com/user-attachments/assets/e12d49a4-7ed1-4a2c-b611-d174451a74f7)

## 13. Carte Mère (MotherBoard)

![Screenshot from 2024-12-11 11-40-19](https://github.com/user-attachments/assets/5859b50e-d1ce-463c-91bd-709dd61ad1a8)

### 1. **Base Memory**
- **Description** : Quantité de mémoire vive (RAM) allouée à la machine virtuelle (VM).

### 2. **Boot Order (Ordre de Démarrage)**
- **Description** : Ordre dans lequel la VM vérifie les périphériques pour démarrer le système.
  - **Hard Disk (Disque Dur)** : Disque dur virtuel `.vdi`.
  - **Optical** : Fichier `.iso` (par exemple, pour l'installation).
  - **Floppy (Disquette)** : Peut simuler une disquette.
  - **Network** : Démarrage via le réseau PXEboot.

### 3. **Chipset**
- **Description** : Ensemble de puces électroniques sur la carte mère permettant la communication entre les différents composants.
  - **Chipset utilisé** : PIIX3.

### 4. **TPM (Trusted Platform Module)**
- **Description** : Module de plateforme sécurisé.
  - **Actif** : Simule un TPM pour utiliser des systèmes d'exploitation récents (par exemple, Windows 11).

### 5. **Pointing Device (Dispositif de Pointage)**
- **Description** : 
  - **USB Tablet** : Simule une tablette USB pour améliorer la précision du curseur dans la VM.

### 6. **Extended Features (Fonctionnalités Étendues)**
- **Description** : Améliore la gestion des interruptions système.
  - **Activé** : Améliore les performances de gestion des interruptions.
  - **Désactivé** : Uniquement sur des systèmes d'exploitation très anciens.

### 7. **Enable Hardware Clock in UTC Time**
- **Description** : Synchronisation de l'horloge de la VM avec le temps UTC (Temps Universel Coordonné).
  - **Activé** : Permet d'éviter un décalage horaire entre l'hôte et la VM.

### 8. **Enable EFI**
- **Description** : Si activé, permet d'utiliser des systèmes qui nécessitent EFI (Extensible Firmware Interface).

### 9. **Enable Secure Boot**
- **Description** : Lié à EFI, permet d'utiliser le Secure Boot (vérification des signatures des chargeurs de démarrage).
  - **Reset Keys to Default** : Réinitialise les clés utilisées pour le Secure Boot.

---

## 14. Processeur (Processor)

### 1. **Nombre de Cœurs Alloués à la VM**
- **Description** : Définit le nombre de cœurs CPU alloués à la machine virtuelle.
  - **Conseil** : Allouer un nombre de cœurs qui laisse suffisamment de ressources à l'hôte pour éviter un ralentissement du système.

### 2. **Execution Cap**
- **Description** : Ajuste le pourcentage maximal de puissance CPU que la VM peut utiliser.
  - **100%** : La VM utilise toute la puissance des cœurs alloués.
  - **Réduction du %** : Limite la consommation CPU de la VM pour éviter qu'elle monopolise les ressources de l'hôte.

### 3. **Enable PAE/NX**
- **Description** : 
  - **PAE (Physical Address Extension)** : Permet à la VM d'accéder à plus de 4 Go de RAM sur un système 32 bits.
  - **NX (No eXecute)** : Protection mémoire qui empêche l'exécution de code malveillant dans certaines zones de la mémoire.

---

## 15. Accélération (Acceleration)

### 1. **Paravirtualization Interface**
- **Description** : Configure le type de paravirtualisation pour améliorer les performances de la VM.

### 2. **Hardware Virtualization**
- **Description** : Active la virtualisation matérielle pour améliorer la gestion de la mémoire virtuelle et l'accélération des performances.
  - **Enable Nested Paging** : Améliore la gestion de la mémoire virtuelle.

### 3. **Nested Virtualization**
- **Description** : Permet de créer une VM à l'intérieur d'une autre VM.
  - **Disponible uniquement** si le processeur prend en charge cette fonctionnalité et si VT-x/AMD-V est activé.








## .Sources
- https://doc.ubuntu-fr.org/lvm
- https://cloud.theodo.com/blog/partitionnement-disques-lvm
- https://manpages.debian.org/unstable/util-linux-locales/wall.1.fr.html
- https://www.linuxtricks.fr/pages/bienvenue-sur-linuxtricks
- https://manpages.debian.org/
- https://www.debian.org/doc/index.fr.html
- https://www.redhat.com/fr/topics/virtualization/what-is-a-virtual-machine
- https://tutobox.fr/tuto-debian-mot-de-passe-root-perdu-comment-faire
- https://www.linuxtricks.fr/wiki/sudo-utiliser-et-parametrer-sudoers
- https://stackoverflow.com/questions/47806576/username-is-not-in-the-sudoers-file-this-incident-will-be-reported
- https://www.debian.org/doc/manuals/aptitude/ch02s01s04.fr.html




