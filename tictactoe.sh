#!/bin/bash 
 
   #Constants
   declare MAXBOARDSIZE=9
   #variables
   position=0
   playerSymbol=''
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
        else
		   playerSymbol='O'
        fi
      	echo "Player has got symbol:==>$playerSymbol"
 }
  initializingBoard
  assigningSymbol

