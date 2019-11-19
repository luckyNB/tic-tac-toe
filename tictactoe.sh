#! /bin/bash 
   #Constants
   declare MAXBOARDSIZE=9
   declare COMPUTER="O"
   declare PLAYER="X"
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
   declare -a  Board
   	tossVisibility=0
  	counter="false"
  	gameCount=0
	toss=0
 	 function initializingBoard(){
	
  	 
             for((position=1;position<=9;position++)) 
             do
              Board[$position]=""$position       
             done   
       }

 	  function assigningAndTossingForSymbol(){
     	   	 toss=$((RANDOM%2))
           	tossVisibility=1
       		if [ $toss -eq 1 ] 
       		then
      	         	 echo "player plays first"
                  	 playingGame $toss
                else
                   	echo "computer plays first"
                        playingGame $toss
               fi
		}
 
   

	 function displayBoard(){
                pos=1      		
		for((position=1;position<=3;position++))
                do
                    echo " ${Board[$pos]} ${Board[$(($pos+1))]} ${Board[$(($pos+2))]}"
  		    pos=$(($pos+3))
                done
       	}
 

     function playingGame(){
        gameFlag=$1
        while [ $counter == "false" ]
        do
          displayBoard
          if [ $gameFlag == 1 ]
          then
             echo "players turn now"
             read -p "Enter cellPosition"  cellPosition
             if [[ ${Board[$cellPosition]} == $PLAYER || ${Board[$cellPosition]} == $COMPUTER ]]       		
             then
             		echo "slot is alredy fixed Enter another Slot"
             		playingGkame $gameFlag
             else
              		Board[$cellPosition]=$PLAYER
              		checkingForWinner $PLAYER
             		gameFlag=0  
	    fi
         else
           echo "computers turn now"
           randomCellPosition=$((RANDOM%9+1))
   	 	if [[ ${Board[$randomCellPosition]} == $PLAYER || ${Board[$randomCellPosition]} == $COMPUTER ]]
        	then
              			echo "slot is already  fixed"
	          		playingGame $gameFlag
                else
                  	 Board[$randomCellPosition]=$COMPUTER
                   	 checkingForWinner $COMPUTER
                  	 gameFlag=1
                fi
           	fi
                gameCount=$(($gameCount+1))
	done
  	} 

    function horizontalCheck(){
                 loopCounter=0
                 position=1
                 while [  $loopCounter -lt 3 ] 
                 do
                   
			if [[ ${Board[$position]} -eq ${Board[$(($position+1))]} && 
                            ${Board[$(($position+1))]} -eq ${Board[$(($position+2))]} &&  ${Board[$position]} -eq $1 ]]  
                  	then  
                          displayBoard
			   exit 0	#break
			fi
                    loopCounter=$(($loopCounter+1))
                    position=$(($position+3))
                 done     
             }
		function verticalWinnerCheck(){
	 		 loopCounter=0
                 	 position=1
  		        while [  $loopCounter -lt 3 ] 
                  	do
				if [[ ${Board[$position]} -eq ${Board[$(($position+3))]} && 
                            	${Board[$(($position+3))]} -eq ${Board[$(($position+6))]} && ${Board[$position]} -eq $1 ]]   
                  		then 
                                  displayBoard
                                         exit 0  #break #exit;;				 
				#	winnerFlag=1
             		 	fi
                    		loopCounter=$(($loopCounter+1))
                    		position=$(($position+1))
                	done

	}
         function diagonalWinnerCheck(){
	          position=1
        	   	if [[ ${Board[$position]} -eq ${Board[$(($position+4))]} && 
                            ${Board[$(($position+4))]} -eq ${Board[$(($position+8))]} &&  ${Board[$position]} -eq  $1 ]] 
                	then 
                                 displayBoard
				exit 0
			elif [[ ${Board[$position+2]} -eq ${Board[$(($position+4))]} && 
                            ${Board[$(($position+4))]} -eq ${Board[$(($position+6))]} &&  ${Board[$position]} -eq $1 ]]
                  	then 
                        displayBoard
	 	        exit 0
                fi
	}  
        
	 	function gameTieCheck () {
 			if [ $gameCount -eq 9 ]
 			then
 				
 				counter="true"
 			fi
 		}

            
        function checkingForWinner(){
                 	symbol=$1
			#playingGame $symbol
                        horizontalCheck $symbol
                        verticalWinnerCheck $symbol
                        diagonalWinnerCheck $symbol
  			gameTieCheck
	}    
      
           function computerWinningFunction(){
	
	   
	
	}


           
      #function calls
	
	initializingBoard
	assigningAndTossingForSymbol
	displayBoard
      
