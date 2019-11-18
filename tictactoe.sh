#!/bin/bash 
 
   #Constants
   declare MAXBOARDSIZE=9
   #variables
   position=0
   playerSymbol=''
   gamePosition=0
   # TicTacToe Board
   declare -a Board
	
 	 function initializingBoard(){
          	for((position=1;position<=9;position++))
        	do
               		 Board[position]=0            
                done 	
           }

 	 function assigningSymbol(){
     	   symbol=$((RANDOM%2))
       		if [ $symbol -eq 1 ] 
       		then
           		playerSymbol='X'
           		echo "player1 plays first "
       		else
	   		playerSymbol='O'
           		echo "player2 plays first"
       		fi
     		echo "Player has got symbol:==>$playerSymbol"
 	 }
	 function displayBoard(){
      			 echo "r\c 0 1 2"
  			 echo "0   ${Board[1]} ${Board[2]} ${Board[3]}"
  			 echo "1   ${Board[4]} ${Board[5]} ${Board[6]}"
  			 echo "2   ${Board[7]} ${Board[8]} ${Board[9]}"
       	}
 

         function playingGame(){
        	read -p "Enter ttt game postion" gamePosition
	   	Board[$gamePosition]=$playerSymbol
		displayBoard	
	} 

   #function calls
	initializingBoard
	assigningSymbol
	displayBoard
	playingGame

