

;Evaluate position:
;	Type of opponent vs own type
;	Type of moves vs opponent type
;	If evaluation is strongly unfavoured:
;		Loop through team and find was with a stronger evaluation
;		If one exist:
;			Switch pokemon

;Select move:
;	Loop through available moves:
;		Get power
;		Apply weakness multiplier
;		If this move has highest power
;			Save it
;	Select saved move


GoodAITrainerChoosesMove:
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES
	ld a, [de]
	ld h, a
	call ReadMoveNew
	ld a, [wEnemyMovePower]
	ld c, a
.loop
	dec b
	jr z, .done
	ld a, [de]
	and a
	jr z, .done
	inc de
	call ReadMoveNew
	ld a, [wEnemyMovePower]
	cp c
	jr c, .loop
	ld c, a
	ld a, [de]
	ld h, a
	jr .loop
.done
	ld a, h
	ret
ReadMoveNew:
	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MoveEnd - Moves
	call AddNTimes
	ld de, wEnemyMoveNum
	call CopyData
	pop bc
	pop de
	pop hl
	ret
