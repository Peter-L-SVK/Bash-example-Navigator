function jump()
{
    initial="$1 $2"
    if !([ -d "$initial" ])
    then
	initial2="$1"
	cd "$initial2"
   
    else
	cd "$initial"
    fi
}

function to_quit
{
    clear
    if ([ -f $path_to_content ])
    then
	rm $path_to_content
    fi

    if [ -f $path_to_sizes ]
    then
	rm $path_to_sizes
    fi

    if [ -f $path_to_copy_buffer ]
    then
	rm $path_to_copy_buffer
    fi
    
    exit $(true)
    EXIT_SUCCESS=$?
    echo $EXIT_SUCCESS 0
}

function copy
{
    trap '{ clear; echo "Interupted."; printf "\n"; return; }' INT
    read -p "Enter name of file to copy: " file_to_copy
    if [[ ! -e "$file_to_copy" ]]
    then
	clear
	echo "File $file_to_copy does not exist!"
	printf "\n"
	file_to_copy=""

    else
	if !([ "$file_to_copy" == "" ])
	then
	    path_for_copy=$(pwd)/$file_to_copy
	    echo "$path_for_copy" > $path_to_copy_buffer
	    clear
	    echo "File $file_to_copy has been selected."
	    printf "\n"

	else
	    clear
	    echo "Error file/directory must have a name!"
	    printf "\n"
	fi
    fi
}

function paste
{
    if [[ ! -e "$path_for_copy" ]]
    then
	clear
	echo "File $file_to_copy does not exist!"
	printf "\n"
	path_for_copy=""
	
    else
	if ([ -f "$path_to_copy_buffer" ])
	then
	    path_for_copy=$(<"$path_to_copy_buffer")
	    if !([ -f "$path_to_copy" ])
	    then
		cp -r "$path_for_copy" "$(pwd)"
		clear
		echo "File $file_to_copy has been copied"
		printf "\n"
		path_for_copy=""
		if [ -f $path_to_copy_buffer ]
		then
		    rm $path_to_copy_buffer
		fi
	    else
		clear
		echo "File $file_to_copy already exits!"
		printf "\n"
		path_for_copy=""
	    fi

	else
	    clear
	    echo "Error, no file/directory selected!"
	    printf "\n"
	fi
    fi
}

function makedir
{
    trap '{ clear; echo "Interupted."; printf "\n"; return; }' INT
    read -p "Enter name of new directory: " new_dir_name
    if [ "$new_dir_name" == "" ]
    then
	echo "Error directory must have a name!"
	printf "\n"
	until !([ "$new_dir_name" == "" ])
	do
	    read -p "Enter name of new directory: " new_dir_name
	    if [ "$new_dir_name" == "" ]
	    then
		echo "Error directory must have a name!"
		printf "\n"

	    else
		if !([ -d "$new_dir_name" ])
		then
		    mkdir "$new_dir_name"
		    clear
		    echo "Directory $new_dir_name has been created."
		    printf "\n"
		    break
		    
		else
		    clear
		    echo "Directory $new_dir_name already exits."
		    printf "\n"
		    break
		fi
	    fi
	done

    else
	if !([ -d "$new_dir_name" ])
	then
	    mkdir "$new_dir_name"
	    clear
	    echo "Directory $new_dir_name has been created."
	    printf "\n"
     
	else
	    clear
	    echo "Directory $new_dir_name already exits."
	    printf "\n"
	fi
    fi
}

function removefile
{
    trap '{ clear; echo "Interupted."; printf "\n"; return; }' INT
    read -p "Enter name of file to remove: " file_name
    if [ "$file_name" == "/" ] || [ "$file_name" == "/*" ]
    then
	clear
	echo "You can't remove an operating system!"
	printf "\n"
	return
    fi
    
    if [ "$file_name" == "" ]
    then
	echo "Error file must have a name!"
	printf "\n"
	until !([ "$file_name" == "" ])
	do
	    read -p "Enter name of file to remove: " file_name
	    if [ "$file_name" == "" ]
	    then
		echo "Error file must have a name!"
		printf "\n"

	    else
		if [ "$file_name" == "/" ] || [ "$file_name" == "/*" ]
		then
		    clear
		    echo "You can't remove an operating system!"
		    printf "\n"
		    return
		fi
		
		if [ -f "$file_name" ]
		then
		    rm "$file_name"
		    clear
		    echo "File $file_name has been deleted."
		    printf "\n"
		    break
		    
		else
		    clear
		    echo "File $file_name doesn't exit!"
		    printf "\n"
		    break
		fi
	    fi
	done
    else
	if [ "$file_name" == "/" ] || [ "$file_name" == "/*" ]
	then
	    clear
	    echo "You can't remove an operating system!"
	    printf "\n"
	    return
	fi
	
	if !([ -f "$file_name" ])
	then
	    clear
	    echo "File $file_name doesn't exit!"
	    printf "\n"
     
	else
	    rm "$file_name"
	    clear
	    echo "File $file_name has been deleted."
	    printf "\n"
	fi
    fi
}

function removedir
{
    trap '{ clear; echo "Interupted."; printf "\n"; return; }' INT
    read -p "Enter name of directory to remove: " dir_name
    if [ "$dir_name" == "" ]
    then
	echo "Error directory must have a name!"
	printf "\n"
	until !([ "$dir_name" == "" ])
	do
	    read -p "Enter name of directory to remove: " dir_name
	    if [ "$dir_name" == "" ]
	    then
		echo "Error directory must have a name!"
		printf "\n"

	    else
		if [ "$dir_name" == "/" ] || [ "$dir_name" == "/*" ]
		then
		    clear
		    echo "You can't remove an operating system!"
		    printf "\n"
		    break
		fi
		if [ -d "$dir_name" ]
		then 
		    rm -rf "$dir_name"
		    clear
		    echo "Directory $dir_name has been deleted."
		    printf "\n"
		    break
		    
		else
		    clear
		    echo "Directory $dir_name doesn't exit!"
		    printf "\n"
		    break
		fi
	    fi
	done

    else
	if [ "$dir_name" == "/" ] || [ "$dir_name" == "/*" ]
	then
	    clear
	    echo "You can't remove an operating system!"
	    printf "\n"
	    return
	fi
	
	if !([ -d "$dir_name" ])
	then
	    clear
	    echo "Directory $dir_name doesn't exit!"
	    printf "\n"
     
	else
	    rm -rf "$dir_name"
	    clear
	    echo "Directory $dir_name has been deleted."
	    printf "\n"
	fi
    fi
}

function mode_flags
{
    control='^[0-7]+$'
    while true
    do
	read -p "Enter the mode for owner (0 - 7): " mode_owner
	if ! [[ $mode_owner =~ $control ]] || [ -z "$mode_owner" ]
	then
	    clear
	    echo "Wrong value! Only 0, 1, 2, 3, 4, 5, 6, or 7."
	    printf "\n"
	    continue
	fi
	
	read -p "Enter the mode for group (0 - 7): " mode_group
	if ! [[ $mode_group =~ $control ]] || [ -z "$mode_group" ]
	then
	    clear
	    echo "Wrong value! Only 0, 1, 2, 3, 4, 5, 6, or 7."
	    printf "\n"
	    continue
	fi
	
	read -p "Enter the mode for others (0 - 7): " mode_others
	if ! [[ $mode_others =~ $control ]] || [ -z "$mode_others" ]
	then
	    clear
	    echo "Wrong value! Only 0, 1, 2, 3, 4, 5, 6, or 7."
	    printf "\n"
	    continue
	fi
	
	chmod $mode_owner$mode_group$mode_others $name
	clear
	printf "Mode of file $name changed to: %d%d%d.\n" $mode_owner $mode_group $mode_others
	printf "\n"
	break
    done
}

function change_mode
{
    trap '{ clear; echo "Interupted."; printf "\n"; return; }' INT
    while true
    do
	read -p "Enter the name of file: " name
	if [ "$name" == "" ]
	then
	    echo "Error directory must have a name!"
	    printf "\n"
	    
	else
	    if [ -d "$name" ] 
	    then
		mode_flags "$name"
		break
		
	    elif [ -f "$name" ]
	    then
		mode_flags "$name"
		break
		
	    else
		clear
		echo "$name is not valid name!"
		printf "\n"
		break
	    fi
	fi
    done
}

function move_up
{
    cd ..
    clear
}

function chandir
{
    trap '{ clear; echo "Interupted."; printf "\n"; return; }' INT
    read -p "Enter a name of directory: " dir_name
    if [ "$dir_name" == "" ]
    then
	echo "Error directory must have a name!"
	printf "\n"
	until !([ "$dir_name" == "" ])
	do
	    read -p "Enter name of new directory: " dir_name
	    if [ "$dir_name" == "" ]
	    then
		echo "Error directory must have a name!"
		printf "\n"
	    else
		if !([ -d "$dir_name" ])
		then
		    clear
		    echo "Directory $dir_name does not exist!"
		    printf "\n"
		    break
		    
		else
		    cd "$dir_name"
		    clear
		    break
		fi
	    fi
	done
	
    else
	if !([ -d "$dir_name" ])
	then
	    clear
	    echo "Directory $dir_name does not exist!"
	    printf "\n"
	    
	else
	    cd "$dir_name"
	    clear
	fi
    fi
}

function content
{
    clear
    echo "$(ls -lah)" > "$path_to_content"
    less -N "$path_to_content"
    clear
}

function list_size_content
{
    clear
    echo "$(du * -h .)" > $path_to_sizes
    less -N $path_to_sizes
    clear
}


function dnsup
{
    octet="(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])"
    ipv4="^$octet\\.$octet\\.$octet\\.$octet$"

    read -p "Enter the name of a DNS server: " dns_address
    if [ "$dns_address" == "" ]
    then
	clear
	echo "Error, a name is required!"
	return
    fi
    printf "Exit by Ctrl-C.\n"
    while true
    do
	trap '{ printf "\nQuitting."; sleep 1; clear; break; }' INT
	answer=$(dig +short "$dns_address" | head -1)
	if ([ -z "$answer" ])
	then
	    echo "---------------------------------------------------------------"
	    echo "$(date): -> $dns_address is >>DOWN<<. :-("
	else
	    if [[ $answer =~ "$ipv4" ]]
	    then
		echo "---------------------------------------------------------"
		echo "$(date): -> $dns_address is UP. :-)"
	    else
		echo "---------------------------------------------------------------"
	    fi
	fi
	sleep 1.25
    done
}

function info
{
    clear
    echo "
    Created by Peter Leukanič 2018 - 2020
    Feel free to spread and  modify. 
    Made for UNIX-like OSes in BASH.
    For help type "\"help"\".
    "
}

function hddtmp
{
    clear; printf "Temperatures of your discs are:\n $(hddtemp /dev/sd[abcdefghi])\n\n"
}

function cpusage
{
    while true
    do
	trap '{ printf "\nQuitting."; sleep 1; clear; break; }' INT
	clear
	date
	printf "\n"
	mpstat -P ALL
	printf "\n To quit press Ctrl-C!"
	sleep 1.25
    done
	  
}

function whois
{
    while true
    do
	trap '{ printf "\nQuitting."; sleep 1; clear; break; }' INT
	clear
	date
	echo""
	echo "Who is logged in?"
	echo ""
	w
	printf "\nTo quit press Ctrl-C!\n"
	sleep 1.25
    done
}
