# Moulinette-epitech

Moulinette pour norme, tests fonctionnels et fonctions bannis pour epitech 2022

## **Guide d'instalation**
```
> $ git clone git@github.com:maelbecel/moulinette-epitech.git
> $ cd moulinette-epitech
> $ make install
```

## **Utilisation**
```
> $ addmouli
```
### Remplir les fichiers contenus dans /tests de cette maniere :

*Pour les tests fonctionnels (.fonc):*
```
bloc "Nom du bloc";
    mouli "Nom du test" "Commande a executer" "Output de la commande" valeur_de_retour;
end;
```

*Pour les tests unitaires (.unit):*
```
bloc "Nom du bloc";
    unit "Nom du test" "fonction()" "Output de la fonction" valeur_de retour;
end;
```

### Par exemple :
```
> $ cat tests/reverse.fonc
bloc "Basic test";
    mouli "Reverse Hello" "./reverse_string Hello" "olleH" 0;
    mouli "Reverse Salut le monde" "./reverse_string 'Salut le monde'" "ednom el tulaS" 0;
end;
bloc "Error test";
    mouli "No argument" "./reverse_string" "" 84;
end;
```
```
> $ cat tests/operations.unit
bloc "Basic test";
    unit "Addition get" "get_somme(2,3)" "" 5;
    unit "Addition show" "show_somme(2,3)" "5" 0;
end;
bloc "Error test";
    unit "Division by 0" "get_division(12, 0)" "" 84;
end;
```
