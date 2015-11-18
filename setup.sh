#!/bin/bash

touch ~/.bashrc
echo "alias today='date'" >> ~/.bashrc

echo Please log out and log back in, then use 'today' to display the date

#!/bin/bash


USER1="Username" #Changeme
USER2="Username 2" #Changeme
USER1EMAIL="email@user.co" #Changeme
USER2EMAIL="email@user.com" #Changeme




if [ "$USER1" = "$USER2" ]; then 
	echo "Please change username and/or email in the script code!"
	exit
elif [ "$USER1EMAIL" = "$USER2EMAIL" ]; then
        echo "Please change username and/or email in the script code!"
	exit
fi

read -e -p "Enter the path to the repository: " -i "~/Desktop/github_" FILEPATH
echo $FILEPATH
cd $FILEPATH
echo
echo Current user is:
git config user.name
echo Current email is:
git config user.email
echo

read -e -p "Which user: $USER1 (1) or $USER2 (2): " USERNUM

if [$USERNUM == 1]; then
	git config user.name $USER
	git config user.email "$USEREMAIL"
elif [$USERNUM == 2]; then
	USER=$USER2
        USEREMAIL=$USER2EMAIL
fi

#git config user.name $USER
#git config user.email "$USEREMAIL"



