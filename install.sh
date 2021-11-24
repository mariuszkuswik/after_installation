#!/bin/bash

##############################

# Nazwa pliku z lista programow
list_file="plik.txt" 

# Sprawdzane managery paczek 
manpac[0]="dpkg"
manpac[1]="rpm"

# Managery instalacji, muszą być w tej samej kolejności co managery paczek
instpac[0]="apt"
instpac[1]="yum"

##############################



# Sprawdź dostępny manager paczek
package_manager=`apropos "package manager" | cut -f 1 -d " " | head -n 1 `


boolean=0
count=0



# Sprawdź czy manager paczek zgadza się z podanym 
function check_manager () { 
    if [ "$package_manager" == "$1" ]
    then 
        # Przypisz NUMER managera paczek do zmiennej
        pac_number="$2"
        boolean=1

    else
        echo "'$1' Nie został znaleziony w systemie"
    fi
}

# Instalacja programow 
function installation () { 
    cat "$list_file" | while read package
    do 
        # Instalacja 
        "${instpac["$pac_num"]}" install "$package" -y
    done
    

}


# MAIN
##############################

# Dopóki nie zostanie odnaleziony manager paczek oraz nie przkroczymy długości tabclicy wykonuj 
while [ $boolean -ne 1 ] && [ "$count" -lt "${#manpac[@]}" ]
do 

    # Funkcja sprawdzająca czy zainstalowany zgadza się z podanym managerem 
    # Drugim parametrem jest obecny numer, potrzebne do uzywania tablicy
    check_manager "${manpac["$count"]}" $count

    count=$((count=count+1))
    
done

# Uruchomienie funkcji instalującej programy 
installation


############################
