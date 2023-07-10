AREA MyCode, CODE, ReadOnly
ENTRY
EXPORT MyProg
	MyProg
		BL PrepareToTransport
			PrepareToTransport
			LDR r1, =Array_W
			LDR r2, =Array_R
			LDR r3, R_ROW
			ADD r3, #1
			MOV r4, #4
			BL NewRow
			
		NewRow
			SUB r3, r3, #1
			CMP r3, #0
			BEQ NewColumn
			LDR r10, [r1]STR r10,[r2]
			ADD r1, #4
			ADD r2, #24
			BL NewRow
			
		NewColumn
			LDR r2, =Array_R
			ADD r2, r4
			ADD r4, #4
			CMP r4, #28
			BEQ PrepareToScalar
			LDR r3, R_ROW
			ADD r3, #1
			BL NewRow
			
		PrepareToScalar
			LDR r1, =Array_W
			LDR r2, =Array_W
			LDR r6, =Scalar
			LDR r7, W_COL
			ADD r7, #1
			MOV r5, #0
			ADD r1, #32
			ADD r2, #96
			BL CalculateScalar
			
		CalculateScalar
			SUB r7, r7, #1
			STR r5, [r6]CMP r7, #0
			BEQ PrepareToCountAndSum
			LDR r3, [r1]
			LDR r4, [r2]
			MUL r3, r4
			ADD r5, r3
			ADD r1, #4
			ADD r2, #4
			BL CalculateScalar
			
		PrepareToCountAndSum
			LDR r1, =Array_W
			ADD r1, #28
			LDR r7, W_ROW
			ADD r7, #1
			LDR r2, =Count
			LDR r3, =Sum
			LDR r8, [r2]
			LDR r9, [r3]
			LDR r4, Bi
			LDR r5, Ci
			BL ConditionOne
			
		ConditionOne
			SUB r7, r7, #1
			CMP r7, #0
			BEQ Result
			LDR r6, [r1]
			ADD r1, #32CMP r6, r4
			BLO ConditionTwo
			BL ConditionOne
			
			ConditionTwo
			CMP r6, r5
			BLS SumAndCount
			BL ConditionOne
			SumAndCount
			ADD r8, #1
			ADD r9, r6
			BL ConditionOne
			
		Result
			STR r8, [r2]
			STR r9, [r3]
			
		ALIGN
			AREA MyData, Data, ReadOnly
			EXPORT Array_W
			EXPORT W_ROW
			EXPORT W_COL
			EXPORT R_ROW
			EXPORT R_COL
			EXPORT Bi
			EXPORT CiArray_W DCD 12, 12, -3, 48, 55, -36, 27, 1
			DCD 1, 2, 3, 4, 5, 6, 7, 2
			DCD -17, -68, 89, 20, 21, 4, 23, -53
			DCD 8, 9, 10, 11, 12, 13, 14, 15
			DCD -3, -34, 76, 31, 6, 2, -90, 80
			DCD 64, 32, 64, 21, 66, 99, 12, 0
			W_ROW DCD 6
			W_COL DCD 8
			R_ROW DCD 8
			R_COL DCD 6
			Bi DCD -42
			Ci DCD 77
			AREA MyData1, Data, ReadWrite
			EXPORT Array_R
			EXPORT Scalar
			EXPORT Count
			EXPORT Sum
			Array_R DCD 0, 0, 0, 0, 0, 0
			DCD 0, 0, 0, 0, 0, 0
			DCD 0, 0, 0, 0, 0, 0
			DCD 0, 0, 0, 0, 0, 0
			DCD 0, 0, 0, 0, 0, 0
			DCD 0, 0, 0, 0, 0, 0
			DCD 0, 0, 0, 0, 0, 0
			DCD 0, 0, 0, 0, 0, 0Scalar DCD 0
			Count DCD 0
			Sum DCD 0
			;Sum_WSPACE 4 * 2
			;Sub_WSPACE 4 * 2
END
