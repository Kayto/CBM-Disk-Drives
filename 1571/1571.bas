!- ========================================
!- Project    1571 Test on a C64 (CBM prg Studio)
!- Target     Commodore 64
!- Comments   BASIC Code from 1571 User Guides adapted by AdamT117, 
!-            ROM detection borrowed;
!-            https://commodore.software/downloads/download/149-miscellaneous-
!-            utilities/12217-rom-check-1571
!-            The Switch to head 1 causes a delay. Still looking into that 
!-            and disabled the head bumps that result!
!- Author     AdamT117. https://github.com/Kayto
!- ========================================
1000 rem 1571 c64 testing
1010 print"{home}{white}{clear}"
1020 close1
1030 open15,8,15:print#15,"i":close 15
1040 print" 1571 tests with a c64":print"{down}"
1050 print" 1. head 0/1 test (1541 mode)"
1060 print" 2. 1571 mode test"
1070 print" 3. 1571 rom check"
1080 print"{down}"
1090 print" insert blank disk and enter menu #":print"{down}"
1100 print" head 0/1 test will format both sides"
1110 print" of the disk in 1541 mode."
1120 print" side 0 will be named {reverse on}side0 head0{reverse off}"
1130 print" side 1 will be named {reverse on}side1 head1{reverse off}."
1140 print" {down}1571 mode test will format both"
1150 print" sides of the disk in 1571 mode."
1160 print" the disk will be 1328 blocks and"
1170 print" named {reverse on}1571ds{reverse off}."
1180 print" {down}1571 rom check returns the rom version"
1190 print" present in the the drive."
1200 get x$:if x$<"1" or x$>"3" goto 1200
1210 on val(x$) goto 1220,1400,1490
1220 input"{home}{clear}{down}format disk y/n";y$
1230 print"{up}1541 mode check   "
1240 print"{down}testing head0..."
1250 close1:open1,8,15,"u0>m0"
1260 ify$="y" then goto 1280
1270 goto 1000
1280 print"formating with h0 (664 blocks)..."
1290 close1:open1,8,15,"u0>h0"
1300 print#1,"new:side0 head 0,99"
1310 gosub 1600
1320 open 15,8,15: print#15,"m-w";chr$(106);chr$(0);chr$(1);chr$(113):close 15
1330 print"{down}{down}testing head1..."
1340 print"formating with h1 (664 blocks)..."
1350 open15,8,15:print#15,"i":close 15
1360 close1:open1,8,15,"u0>h1"
1370 print#1,"new:side1 head 1,99"
1380 gosub 1600
1390 goto 1570
1400 print"{home}{clear}{down}enabling 1571 mode"
1410 input"format disk y/n";y$
1420 if y$="y" then goto 1440
1430 goto 1000
1440 print"{up}formating disk with 1328 blocks..."
1450 close1:open1,8,15,"u0>m1"
1460 print#1,"new:1571ds,99"
1470 gosub 1600
1480 goto 1570
1490 dn=8:close1:open1,dn,15,"u9":input#1,en,em$,et,es
1500 ifright$(em$,2)<>"71" then print:print"not a 1571 drive":close1:end
1510 print#1,"m-r"chr$(0)chr$(128)chr$(2):get#1,a$,b$:close1
1520 a=asc(a$+chr$(0)):b=asc(b$+chr$(0)):r$="unknown"
1530 ifa=157thenifb=30 then r$="318047-01"
1540 ifa=146thenifb=37 then r$="310654-03"
1550 ifa=242thenifb=104 then r$="310654-05"
1560 print "{clear}{home}{down}1571 dos rom revision is ";r$
1570 print"{down}":input "exit y/n";y$
1580 if y$="n" then goto 1010
1590 end
1600 input#1,e,e$,t,s
1610 print "{reverse on}";e;e$;t;s"{reverse off}"
1620 close1:open1,8,15
1630 open2,8,2,"#"
1640 print"{down}read disk name..."
1650 print#1,"u1 2 0 18 0"
1660 print#1,"b-p 2 144"
1670 for i=1 to 16
1680 get#2,a$: if a$=chr$(160) then 1700
1690 print "{reverse on}";a$;:next
1700 print"{reverse off}{down}"
1710 close 2 : close1:return