.686
.model flat,stdcall
.stack

.data
	A REAL4 4.5
	B REAL4 1.7; C variable
	D REAL4 3.8
	C1 REAL4 5.0
	C2 REAL4 36.0
	C3 REAL4 4.0
	C4 REAL4 3.0
	C5 REAL4 9.0
	C6 REAL4 7.0
	TOP REAL4 ?
	BOT REAL4 ?
	RES REAL4 ?

.code
	main:
		finit
		fld B
		fmul C1
		fld D
		fmul A
		fsub
		fld C2
		fmul D
		fsub C3
		fsqrt
		fadd
		fst TOP
		fld C4
		fld A
		fdiv C5
		fsub
		fld C6
		fmul D
		fadd
		fst BOT
		fld TOP
		fdiv BOT
		fst RES
	RET
END main
