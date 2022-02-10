# Moulinette-epitech

Moulinette pour norme, tests fonctionnels et fonctions bannis pour epitech 2022

## **Guide d'instalation**
```
> $ git clone
> $ cd 
> $ make install
```

## **Utilisation**
```
> $ addmouli
> $ cd tests
> $ code .
```
*Remplir les fichier de cette maniere :*
```
bloc "Nom du bloc";
    mouli "Nom du test" "Commande a executer" "Affichage de la commande" valeur_de_retour;
end;
```
*Par exemple :*
```
bloc "Basic test";
    mouli "Reverse Hello" "./reverse_string Hello" "olleH" 0;
    mouli "Reverse Salut le monde" "./reverse_string 'Salut le monde'" "ednom el tulaS" 0;
end;
bloc "Error test";
    mouli "No argument" "./reverse_string" "" 84;
end;
```
