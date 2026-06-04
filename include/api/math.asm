; ----- Math functions -----

; APISubtractWord -- 0225
; 
; Subtracts `de` from `hl`.
; 
; @param	hl	Number to subtract from.
; @param	de	Number to subtract.
; 
; @return	hl		Subtraction result
; @return	zflag	Set if `hl` == `de`
; @return	cflag	Set if `hl` <  `de`
APISubtractWord:: ; 0225
	jp $2000
	
	
; APICompareWord -- 0228
; 
; Sets flags as if subtracting `de` from `hl`, 
; but preserves both register pairs.
; 
; @param	hl		Number to subtract from.
; @param	de		Number to subtract.
; 
; @return	zflag	Set if `hl` == `de`
; @return	cflag	Set if `hl` <  `de`
APICompareWord:: ; 0228
	jp $200a
	

; push de
; d = a
; a = 0
; for b in range(8, 0, b--)
; 	a <<= 1
; 	c <<= 1
; 	c |= carry
; 	if carry
; 		a += d
; 	endif
; endfor
; pop de

; APISmallMultiply -- 022B
; 
; `a` *= `c`
; `c` will be the returned the same as it was passed.
; 
; @param	a	8-bit multiplicand.
; @param	c	8-bit multiplier.
; 
; @return	a	8-bit product.
APISmallMultiply:: ; 022b
	jp $2012
	
	
; hl = 0
; de = a
; for b in range(8, 0, b--)
; 	hl <<= 1
; 	c <<= 1
; 	c |= carry
; 	if carry
; 		hl += de
; 	endif
; endfor

; APIFullMultiply -- 022E
; 
; `hl` = `a` * `c`
; `c` will be the returned the same as it was passed.
; 
; @param	a	8-bit multiplicand.
; @param	c	8-bit multiplier.
; 
; @return	hl	16-bit product.
APIFullMultiply:: ; 022e
	jp $2023

	
; hl = 0
; for a in range(16, 0, a--)
; 	hl <<= 1
; 	de <<= 1
; 	if carry
; 		hl += bc
; 	endif
; endfor

; APIWordMultiply -- 0231
; 
; `hl` = `bc` * `de`
; `de` will be 0 on return, unlike the 8-bit multiplications!
; 
; @param	bc	16-bit multiplicand.
; @param	de	16-bit multiplier.
; 
; @return	hl	16-bit product.
APIWordMultiply:: ; 0231
	jp $2035
	
	
; hl = a
; for b in range(8, 0, b--)
; 	hl <<= 1
; 	if h >= c
; 		h -= c
; 		l++
; 	endif
; endfor

; APIByteDivide -- 0234
; 
; Returns `a` / `c` as `h` R `l`.
; 
; @param	a	Dividend
; @param	c	Divisor
; 
; @return	h	Quotient
; @return	l	Remainder
APIByteDivide:: ; 0234
	jp $2046
	
; e = 0
; b = 16
; for b in range(16, 0, b--)
; 	ehl <<= 1
; 	if e >= c
; 		e -= c
; 		l++
; 	endif
; endfor
; h = e

; APIWordDivide -- 0237
; 
; Returns `hl` / `c` as `h` R `l`.
; 
; @param	hl	Dividend
; @param	c	Divisor
; 
; @return	h	Quotient
; @return	l	Remainder
APIWordDivide:: ; 0237
	jp $2057
	
	
; a += $40
; ; fall thru to APISine

; APICosine -- 023A
; 
; Computes the cosine of an angle.
; 
; @param	a	Input angle, in 256ths of a full rotation.
; @param	d	Scale
; 
; @return	hl	Cosine output, as `h`.`l` (Q8.8 fixed-point).
APICosine:: ; 023a
	jp $206a
	
	

; push af
; 			a &= %0111_1111
; 			a *= 2
; 			bc = (a & %0111_1111) << 1
; hl = $208F + ((a & %0111_1111) << 1)
; c = [hl++]
; if bit 0, [hl]
; 	hl = d << 8
; else
; 	hl = APIFullMultiply(d, c)
; endif
; 
; pop af
; if (bit 7, a) == 0 
; 	return
; endif
; 
; hl = ((-l) - (h + ((-l) + (l != 0))) << 8) + (-l)
; return hl

; APISine -- 023D
; 
; Computes the sine of an angle.
; 
; @param	a	Input angle, in 256ths of a full rotation.
; @param	d	Scale
; 
; @return	hl	Sine output, as `h`.`l` (Q8.8 fixed-point).
APISine:: ; 023d
	jp $206c
	
	
; return APIFullMultiply(APIRandom(), a) >> 8

; APIRandomRange -- 0240
;
; Returns a pseudorandom byte in range [0,a) (exclusive)
; 
; @param	a	Multiplier
;
; @return	a	Pseudorandom byte in range [0,a)
APIRandomRange:: ; 0240
	jp $218f
	
; push bc, de, hl
; a = (swap($21C7[[$FFA7]]) | $21C7[[$FFA8]]) + [$FF8B]
; push af
; [$FFA7] += 3
; [$FFA7] &= %0000_1111
; [$FFA8]--
; [$FFA8] &= %0000_1111
; pop af, hl, de, bc
; return a

; APIRandom -- 0243
;
; Returns a pseudorandom byte in range [0,255]
;
; @return	a	Pseudorandom byte in range [0,255]
APIRandom:: ; 0243
	jp $2198
