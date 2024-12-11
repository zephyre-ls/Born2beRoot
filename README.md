# Born2beRoot

    C'est quoi une virtual machine ? Psk finalement à part un jour dans ta vie ou t as betement suivie un tuto tu sais pas vraiment comment ca fonctionne.

Virtual box

Environnement virtualise qui fonctionne sur une machine physique. Elle ex son propre OS et bénéficie des equipement physique de la machine. 
https://www.redhat.com/fr/topics/virtualization/what-is-a-virtual-machine
Debian version stable ?

Partition 

Partition/region/disque = section d un support de stockage, le partionnement est une operation qui consiste à diviser les sections pour que le systeme d'exploitation gère les informations de manières séparée. 
Organisation, rapidite d'acces, securite

Designation 

Windows = C: D:etc
Mac OS = diskNsM (N= numero du support, M=numero de la partition sur le support 
Linux/unix/gnu = sdXN (X= lettre qui represente le support, N=numero de la partition) ex sdb3 = troisieme partition du disque b. 

LVM

        Commandes
        sudo pvcreate / / (converti un disque ou une partition en PV)
        sudo pvs (affiche VP dispo)
        sudo vgcreate <nom_du_vg> / / (regroupement en VG)
        sudo vgs (affiche VG, taille et detail)
        sudo lvcreate -L <taille> -n <nom_du_lv> <nom_du_vg> (cree VL)
        sudo lvs (afficge VL)
        



Gestionnaire de volumes logiques pour le noyaux linux. But = fournir une couche d'abstraction entre l'espace de stockage physique et le systeme. Permet la création de partitions virtuelles.
Elements qui composent LVM =
PV (vol. physique) = disque/partition, espace de stockage physique que le confie à LVM
VG (groupe de vol.) = 
LV (vol.logique) = espace dans un VG ou l'on peut mettre un systeme de fichier (remplace les partitions).
PE (etendue physique)

sudo -i = passer le prompt en mode root (evite de retaper sudo)
adduser <i/nomutilisateuri> sudo

    Port 4242
    Settings -> Network -> Port Forwading -> new -> RULE 1 - TCP - Hostport = 4242, GuestPort = 4242
![Screenshot from 2024-12-11 10-51-13](https://github.com/user-attachments/assets/e12d49a4-7ed1-4a2c-b611-d174451a74f7)
![Screenshot from 2024-12-11 10-51-01](https://github.com/user-attachments/assets/2b3993ab-b1b8-4b39-8a76-77bf503e2a1b)

Commande
Enable Network Adapter = active/desactive adaptateur reseau VM, si desactivite = pas de connect reseau
Attached to: NAT = maniere donc la VM est connecte au reseau (NAT = Network Adress Translation) = adresse IP de l hôte et VM/same 
Adaptater type = type d'adaptateur reseau virtuel émulé pqr Virtualbox 
Promiscuous mode = définit si l'adaptateur reseau peut capturer des paquets qui ne lui sont pas destine
(Deny: adaptateur ignore les paquets reseau qui ne sont pas destine a son adresse MAC
MAC adress = (Media Access Control) attribué a l'adaptateur reseau de la VM. Adresse unique, permet de l'identifier sur le reseau
Cable connected = indique si un cable reseau est branché sur cet adapatateur. Si cache décoché = VM se compote comme si deco du reseau
Port Forwading = configure le redictionnement dest ports lorsque l'adaptateur est en NAT
Permet de rediriger un port de l hote vers un port spécifique de la VM. Permet l acces services, appli excute sur la VM depuis l ext même si utilisation adress privée via NAT.
Protocop = TCP (parfois UDP)
Host IP= si vide = "toutes les adresses IP"
Host Port = port utilise pour acces VM depuis hôte
Guest IP = adresse ip de la VM, si vide = "toutes les interfaces de la VM"
Guest Port = port sur lequel le service ecoute dans la VM 
Acces au service depuis l'hôte ssh_p n°HOSTPORT user@127.0.0.1

![Screenshot from 2024-12-11 11-23-15](https://github.com/user-attachments/assets/d0f82d65-b50e-470c-a1df-f13844972dd5)

Periph de stockage connecte a la VM
Controller:IDE 
IDE(type de controleur de disque ancien mais utilise pour les ISO)
Fichier iso monte = debian-12.8.0-amd64-netinst.iso
Controller: SATA(Serial ATA)
Controleur plus morderne et rapide par rapport à IDE, connecte disque dur et SSD virtuels 
Disque dur virtuel attache au controleur SATA = born2root.vdi : .vdi (Virtual Disk Image) qui contient le disque dur virtuel utilisé par cette machine.

Attributes = 
Name
Type SATA regle surAHCI (Advanced Host Controller Interface) optimise perf disques SATA
Port count = nbr port dispo, 1 dans mon cas (1 seul disque peut etre co au controleur SATA 
USE HostI/O Cache = activite = utilise le cache entrée sortie de l hote pour ameliorer perf
desactivite = utile si disque virtuel sont lent, mais augmente risque de corruption des donnes si l hotel s arrete brutalement

Bouton bas gauche = 
Vert plus vert = ajout nouveau controller
Vert plus rouge = retirer disque ou image select
Disquette plus = ajoute nouveau disque ou fichier ISO
Disquette sans couleur = modifie les parametres des disques ou controleurs 

![Screenshot from 2024-12-11 11-40-19](https://github.com/user-attachments/assets/5859b50e-d1ce-463c-91bd-709dd61ad1a8)

MotherBoard (Carte mere)
Base Memory = quantite de memoire vive (RAM) alloué à la VM
Boot order (ordre de demarrage) = periph que la VM verifie dans l ordre pour demarrer systeme
    Ici = Hard disk(disque dur) = disque dur virtuel .vdi
        Optical = fichier .iso
        Floppy (disquette) = peut simuler une disquette
        Network = via le reseau PXEboot
Chipset = ensemble de puces electronique sur la carte mere qui permet la communication entre les differents composants. Ici = PIIX3 
TPM (Trusted Platform Module) 
si actif = simule un TPM pour utiliser des OS recent (ex windows 11)
Pointing device (dispositif de pointage)
USB tablet = simule une tablette USB pour ameliorer la précision du curseur dans la VM 

Extended Features (Fonctionnalités étendues)
Actif = permet de mieux gérer les inrreuptions systeme
Desactivité = uniquement sur os tres ancien

Enable Hardware Clock in UTC Time
Actif = synchro horloge VM avec temps UTC(temps universel coordonné) = evite decalage horaire entre hote et VM

Enable EFI
si actif = systeme qui necessite EFI

Enable secure boot 
Lie a EFI, permet d utiliser le secure boot (verif signature des chargeurs de demmarage)
Reset keys to default = reiniatlise les cles utilise pour le secure boot 


PROCESSOR = 

Definit nombre de coeur alloué à la VM
!allouer un nbr de coeur qui laisse des ressources a l hotel == sinon ralentissement systeme, logique 
Execution CAP = ajuste pourcentage maxde puissance CPU que la VM peut utiliser
100% = vm utilise toute la puissance des coeurs qui lui sont alloués
Reduire ce % permet de limiter la conso CPU de laVM pour eviter de monopoliser les ressources de l hote 
Enable PAE/NX = PAE= VM accede a plus de 4GO de Ram sur les syst 32bits NX = protection memoire, empeche exe de code malveillant dans certaines zones memoire 

ACCELERATION = 
Paravirtualization interface = config type de para pour ameliorer perf VM 
Hardaware Virtualization = enable nested paging = ameliore gestion memoire virtuelle, accel fonctionnement

Une VM dans une autre VM ? Option avance : Nested Virtualization (dispo uniquement si le process prend en charge cette fonctionnalite et si VT-x/AMD-V est activté 

https://doc.ubuntu-fr.org/lvm
https://cloud.theodo.com/blog/partitionnement-disques-lvm


Sudo/root = 

