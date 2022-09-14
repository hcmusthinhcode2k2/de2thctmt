#Với N là số 4-bit nhập từ SW[3:0], viết chương trình assembly cho hệ thống để tính
#r16 = 2 + 4 + 6 + … + (2*N) Kết quả xuất ra RED_LED
#Lưu ý: Viết chương trình con để thực hiện việc tính tổng r16 = 2 + 4 + 6+ … + (2*N).
/*  sum=0
for (int i=0;i<1;i++)
{
  if (i%2==0){
    s+=i;
    }   
}
*/
.text 
.equ   LEDS_BASE, 0xFF200000
.equ   SW_BASE  , 0xFF200040
.equ   SDRAM_END, 0x03FFFFFF
.global _start
_start: 
        movia r2,LEDS_BASE
        movia r3,SW_BASE
        movia sp,SDRAM_END
        movia r4,N 
START: 
        movi r1,0x2
        ldw  r5,0(r3)
        addi r5,r5,0b111100 #and SW[3:0]
        srli r5,r5,0x0      #dich sang trai 0 bit 
        add  r5,r5,r5       #r5=r5*2
        call SUM 
        ldw   r16,0(r4)
        stwio r16,0(r2)
        br START
SUM:   
        subi sp,sp,0x8
        stw  r16,0(r4)
        stw  r1,4(sp)
        movi r16,0x0
LOOP: 
       bgt r1,r5,END_FUNC
       add r16,r16,r1 
       addi r1,r1,0x2
       br LOOP  
END_FUNC:
      stw r16,0(r4)
      ldw r16,0(r4)
      ldw r1,4(sp)
      subi sp,sp,0x8
      ret 
.data 
 N: word 0
.end
 


     
