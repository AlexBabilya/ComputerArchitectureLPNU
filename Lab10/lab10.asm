AREA myCode, CODE, READONLY

	MyProg
	EXPORT MyProg
		LDR r0, =a
		VLDM r0, {s0-s2}VMOV.F32 s3, s1
		VMUL.F32 s3, s2
		VCMP.F32 s0 , s3
		BHI FirstSolution
		B SecondlSolution
		
		FirstSolution
		VMOV.F32 s10, #30
		VMOV.F32 s8, #6
		VADD.F32 s10, s8
		VMUL.F32 s10 , s2
		VMOV.F32 s9, #4
		VSUB.F32 s10, s9
		VABS.F32 s10, s10
		VSQRT.F32 s10, s10
		VMOV.F32 s9, s2
		VMUL.F32 s9 , s0
		VSUB.F32 s10, s9
		VMOV.F32 s9, #5
		VMUL.F32 s9, s1
		VADD.F32 s10, s9
		B StoreResult
		
	SecondlSolution
		VMOV.F32 s10, s2
		VMOV.F32 s8, #7
		VMUL.F32 s10, s8
		VMOV.F32 s9, s0
		VMOV.F32 s8, #9
		VDIV.F32 s9, s8
		VSUB.F32 s10, s9
		VMOV.F32 s8, #3
		VADD.F32 s10, s8
		VABS.F32 s10, s10VSQRT.F32 s10, s10
		VSTM r0, {s6-s9}
		
	ALIGN
		AREA MyData, DATA, ReadOnly
		EXPORT a
		EXPORT c
		EXPORT d
		
		a DCFS 4.5
		c DCFS 1.7
		d DCFS 3.8
END
