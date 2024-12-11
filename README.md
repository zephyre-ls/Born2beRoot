# Born2beRoot

    C'est quoi une virtual machine ? 

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

https://doc.ubuntu-fr.org/lvm
https://cloud.theodo.com/blog/partitionnement-disques-lvm
![Screenshot from 2024-12-11 10-51-13](https://github.com/user-attachments/assets/e12d49a4-7ed1-4a2c-b611-d174451a74f7)
![Screenshot from 2024-12-11 10-51-01](https://github.com/user-attachments/assets/2b3993ab-b1b8-4b39-8a76-77bf503e2a1b)

Sudo/root = 

