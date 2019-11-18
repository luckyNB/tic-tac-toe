#!/bin/bash 
 
   #Constants
   declare MAXBOARDSIZE=9
   #variables
   position=0
   playerSymbol=""
   computersSymbol=""
   gamePosition=0
   gamestatus=0
   tossWinner=''
   horizontal=""
   diagonal=false
   vertical=false
winnerFlag=0
  # TicTacToe Board
   Board=(. . . . . . . . .)
   	
 	 function initializingBoard(){

  	 Board=(. . . . . . . . .)
         for((position=1;position<=$MAXBOARDSIZE;position++))
         do
               Board[position]=''$position            
         done 	
       }

 	  function assigningSymbol(){
     	   symbol=$((RANDOM%2))
       		if [ $symbol -eq 1 ] 
       		then
           		playerSymbol="X"

			computersSymbol="O"
			tossWinner=$playerSymbol
           		echo "player1 plays first "
                      	
       		else
	   		computersSymbol="X"
			playerSymbol="O"
                        tossWinner=$playerSymbol           		
			echo "Compuer plays first"
                         
       		fi 
                 #tossWinner = (($symbol -eq 1)) ? $playerSymbol : $computersSymbol;
              echo "Tosswinner = $tossWinner"
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

    
    

         function horizontalCheck(){
               loopCounter=0
               position=1
                 while [  $loopCounter -lt 3 ] 
                 do
			if [[ ${Board[$position]} -eq ${Board[$(($position+1))]} && 
                            ${Board[$(($position+1))]} -eq ${Board[$(($position+2))]} &&  ${Board[position]} != "." ]]   
                  	then 
			winnerFlag=1
			fi
                    loopCounter=$(($loopCounter+1))
                    position=$(($position+3))
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


         function verticalWinnerCheck(){
 	 loopCounter=0
               position=1
                while [  $loopCounter -lt 3 ] 
                 do
			if [[ ${Board[$position]} -eq ${Board[$(($position+3))]} && 
                            ${Board[$(($position+3))]} -eq ${Board[$(($position+6))]} &&  ${Board[position]} != "." ]]   
                  	then 
				 winnerFlag=1
             		 fi
                    loopCounter=$(($loopCounter+1))
                    position=$(($position+1))
                done

	}
         
          function diagonalWinnerCheck(){
          position=1
           	if [[ ${Board[$position]} -eq ${Board[$(($position+4))]} && 
                            ${Board[$(($position+4))]} -eq ${Board[$(($position+8))]} &&  ${Board[position]} != "." ]] 
                then 
			winnerFlag=1
		elif [[ ${Board[$position+2]} -eq ${Board[$(($position+4))]} && 
                            ${Board[$(($position+4))]} -eq ${Board[$(($position+6))]} &&  ${Board[position]} != "."  ]]
                  then 

                 winnerFlag=1
                fi

  }
           


        function checkingForWinner(){
	    while [ true ]
            do
 		playingGame
          	horizontalCheck $tossWinner
            	verticalWinnerCheck $tossWinner
           	diagonalWinnerCheck $tossWinner
                 if [[ $winnerFlag  -eq 1 ]] 
                 then
                   echo "player won"
			break
                 fi   
               displayBoard
          done
       	   
 	}  
      #function calls
	initializingBoard
	assigningSymbol
	displayBoard
	#playingGame
	checkingForWinner
	

