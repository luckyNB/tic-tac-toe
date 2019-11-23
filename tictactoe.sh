#!/bin/bash
#Constants
MAX_SIZE=9


#variables
playerPosition=0
computerPosition=0
player=''
computer=''
nonEmptyBlockCount=1
computerWinMove=false
someoneWon=false
whoPlays=false 

declare -a Board


function initializingBoard()
{
	for (( i=1; i<=$MAX_SIZE; i++ ))
	do
		Board[$i]='-'
	done
}


function assigningSymbol()
{
	firstPlay=$((RANDOM%2))

	if [ $firstPlay -eq 1 ]
	then
		whoPlays=true
		player='X'
		computer='O'
		echo "Player symobol ====>: X | Computer symbol =====>: O"
		echo "Player turn First"
	else
		player='O'
		computer='X'
		echo "Player symobol =====>: O | Computer symbol =====> : X"
		echo "Computer turn First"
	fi
}



function displayBoard()
{
	echo "_____|_____|_____"
	for ((row=1; row<=MAX_SIZE; row=$(($row+3)) ))
	do
		echo "     |     |      "
		echo "  ${Board[$row]}  |  ${Board[$row+1]}  |  ${Board[$row+2]}  "
		echo "_____|_____|_____"
	done
	echo ""
}



function playerInput()
{
	read -p "Enter  slot Number to put $player at Empty slot " playerPosition
	if [ ${Board[$playerPosition]} == '-' ]
	then
		Board[$playerPosition]=$player
	else
		echo "Slot alredy fixed please enter another slot"
		playerInput
	fi
	whoPlays=false
}

function computerInput()
{
	echo "Computer is Playing"
       sleep 1
         computerWinMove=false
          checkingForWinningOrBlockMove $computer
          checkingForWinningOrBlockMove $player
	  checkingForCorners
          checkingForCenterPosition
          checkingForSidePosition
	  whoPlays=true
}


function checkWinningMove()
{
	counter=1
	if [ $computerWinMove=false ]
	then
		for (( i=1; i<=3; i++ ))
		do
			if [[ ${Board[$counter]} == ${Board[$counter+$1+$1]} ]] && [[ ${Board[$counter+$1]} == '-' ]] && [[ ${Board[$counter]} == $3 ]]
			then
				computerPosition=$(($counter+$1))
				Board[$computerPosition]=$computer
				computerWinMove=true
				break
			elif [[  ${Board[$counter]} == ${Board[$counter+$1]} ]] && [[  ${Board[$counter+$1+$1]} == '-' ]] && [[ ${Board[$counter]} == $3 ]]
			then
				computerPosition=$(($counter+$1+$1))
				Board[$computerPosition]=$computer
				computerWinMove=true
				break
			elif [[ ${Board[$counter+$1]} == ${Board[$counter+$1+$1]} ]] && [[ ${Board[$counter]} == '-' ]] && [[ ${Board[$counter+$1]} == $3 ]]
			then
				computerPosition=$counter
				Board[$computerPosition]=$computer
				computerWinMove=true
				break
			fi
			counter=$(($counter+$2))
		done
	fi
}

function horizontalAndVerticalWinCheck()
{
	position=1
	loopCounter=1
	while [  $loopCounter -le 3 ]
	do
		if [[ ${Board[$position]} == ${Board[$position+$3]} ]] && [[  ${Board[$position+$3]}  ==  ${Board[$position+$3+$3]} ]] && [[ ${Board[$position+$3+$3]} == $1 ]]
		then
			displayBoard
			echo " $1 won the game "
			someoneWon=true
			exit
			break
		else
			position=$(( $position+$2 ))
		fi
		loopCounter=$(($loopCounter+1))
	done
}




function diagonalWinnerCheck()
{
	position=1
	loopCounter=1
	while [ $loopCounter -le 2 ]
	do
		if [[ ${Board[$position]} == ${Board[$position+4]} ]] && [[  ${Board[$position+4]}  ==  ${Board[$position+8]} ]] && [[ ${Board[$position+8]} == $1 ]]
		then
			displayBoard
			echo "  $1 won the game "
			someoneWon=true
			break
		elif [[ ${Board[$position+2]} == ${Board[$position+4]} ]] && [[  ${Board[$position+4]}  ==  ${Board[$position+6]} ]] && [[ ${Board[$position+6]} == $1 ]]
		then
			displayBoard
			echo " $1 won the game "
			someoneWon=true
			break
		fi
		loopCounter=$(($loopCounter+1))
	done
}

function checkingForWinningOrBlockMove(){
        rowValue=1
	columnValue=3
	leftDiagonalValue=4
	rightDiagonalValue=2

	checkWinningMove $rowValue $columnValue $1
	checkWinningMove $columnValue $rowValue $1
	checkWinningMove $leftDiagonalValue  $1
	checkWinningMove $rightDiagonalValue  $1

}


function checkingForCorners()
{
	 if [ $computerWinMove = false ]
   then
		for((i=1; i<=MAX_BOARD_POSITION; i=$(($i+2)) ))
		do
				if [ ${Board[$i]} == '-' ]
				then
					computerPosition=$i
            	Board[$computerPosition]=$computerSymbol
            	computerWinMove=true
            break
				fi
				if [ $i -eq 3 ]
				then
					i=$(($i+2))
				fi
		done
	fi
}


function checkingForCenterPosition()
{
	center=5
	if [[ $computerWinMove = false ]] && [[ ${boardPosition[$middle]} == '-' ]]
	then
					computerPosition=$center
               Board[$computerPosition]=$computerSymbol
               computerWinMove=true
   fi

}

function checkingForSidePosition(){
     if [[ $computerWinMove = false ]]
     then
   	for((index=2;index<=$MAX_SIZE;index=$(($index+2))))
  	do
        	if [ ${Board[$index]} == '-'  ]
        	then
                	computerPosition=$index
                	Board[$computerPosition]=$computer
                        computerWinMove=true                	
			break 
       fi
  done
  fi
}


function gameTieCheck()
{
	while [ ${Board[$nonEmptyBlockCount]} != '-' ]
	do
		if [ $nonEmptyBlockCount -eq $MAX_SIZE ]
		then
			displayBoard
			echo "Game Is Tied "
			someoneWon=true
			computerWinMove=true
			break
		else
			nonEmptyBlockCount=$(($nonEmptyBlockCount+1))
		fi
	done
}



function checkWon()
{
	symbol=$1
        
	rowValue=1
	columnValue=3
          
	horizontalAndVerticalWinCheck $symbol $columnValue $rowValue
 	horizontalAndVerticalWinCheck $symbol $rowValue $columnValue
	diagonalWinnerCheck $symbol
      
}



function ticTacToeHome(){
   while [ $someoneWon == false ]
   do
	displayBoard
	if [ $whoPlays == true ]
	then
		playerInput
		checkWon $player 
		gameTieCheck
	else
		computerInput
		checkWon $computer 
		gameTieCheck
	fi

done

}


initializingBoard
assigningSymbol
ticTacToeHome
