#!/bin/bash 
 
   #Constants
   declare MAXBOARDSIZE=9
   #variables
   position=0
   # TicTacToe Board
   declare -a Board
	 function initializingBoard(){
          for((position=1;position<=9;position++))
          do
                Board[position]=0            
          done 	
       }

  initializingBoard

