#!/bin/bash 
 
   #Constants
   declare MAXBOARDSIZE=9
   #variables
   position=0
   playerSymbol=''
   gamePosition=0
   # TicTacToe Board
   Board=(. . . . . . . . .)
  gamestatus=0
	
 	 function initializingBoard(){
   Board=(. . . . . . . . .)
          	for((position=1;position<=9;position++))
        	  do
               		 Board[position]=$position            
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

checkmatch(){
   if [ ${Board[$1]} != "." ] && [ ${Board[$1]} == ${Board[$2]} ] && [ ${Board[$2]} == ${Board[$3]} ]; then
    gamestatus=1
  fi
}

checkgame(){
  checkmatch 1 2 3
  checkmatch 4 5 6
  checkmatch 7 8 9
  checkmatch 3 6 9
  checkmatch 1 4 7
  checkmatch 2 5 8
  checkmatch 1 5 9
  checkmatch 3 5 7
}

       function checkingForWinner(){
	    while [ true ]
            do
 		playingGame
          	checkgame
                 if [ $gamestatus -eq 1 ]
                  then
                  echo "player won"
 break
    fi
          done
       	   
 	}  
   #function calls
	initializingBoard
	assigningSymbol
	displayBoard
	playingGame
	checkingForWinner

