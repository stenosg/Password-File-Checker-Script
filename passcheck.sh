#!/bin/bash

# George Stenos
# The following script checks to make sure that the passed in file is correctly in password format. If it is a password file, then the script will go through to make sure there are no multiple user names and UIDS. The script will exit and display the error whether it's multiple declarations of user_names and/or UID's. Script will end if file is not in password format.
FILE=$1
IFS=":"
counter=0
cntruid=0
uid_str=""
uid_ck=""
usr_str=""
usr_ck=""


checkerx=0
if [ ! -f $FILE ];
then
	echo "FILE $FILE does not exist"
	exit
fi

#The following if statement will return true if a line that is not in the following format is found in the provided file
if  grep -w -E -q -v '^([a-z]+[:][x][:][0-9]+[:][0-9]+[:][A-Za-z -]*[:][/][a-z]*[/][a-z]*[:][/][a-z]+[/][a-z]+)' $FILE;
then
	echo "File is not a password file in format similar to /etc/passwd"
	exit
fi


while read line;
do
    
	usr_ck=$line
	uid_ck=$line
	
	
     
	set -- $line 	
	array=( $line )
	
	
	temp=$(grep ${array[0]} $FILE | wc -l)
	temp2=$(grep ${array[2]} $FILE | wc -l)
	
				
	
  
	
done <$FILE




echo $usr_ck
if [ $temp -ge 1 ] && [ $temp2 -ge 1 ]; #Prints out there were more than 2 peopl with same username
then   
	echo "DUP_USERNAME " $usr_ck
	echo "DUP_UID " $uid_ck
	exit
fi


echo $usr_ck
if [ $temp -ge 1 ]; #Prints out there were more than 2 peopl with same username
then   
	echo "DUP_USERNAME " $usr_ck
	exit
fi

if [ $temp2 -ge 1 ]; #Prints out there were more than 2 peopl with same username
then   
	echo "DUP_UID " $uid_ck
	exit
fi












