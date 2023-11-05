10 rem 1571 c64 testing
20 print"{home}{white}{clear}"
30 close1
45 open15,8,15:print#15,"i":close 15
50 print" 1571 tests with a c64":print"{down}"
60 print" 1. head 0/1 test (1541 mode)"
80 print" 2. 1571 mode test"
85 print" 3. 1571 rom check"
90 print"{down}"
95 print" insert blank disk and enter menu #":print"{down}"
105 print" head 0/1 test will format both sides"
110 print" of the disk in 1541 mode."
111 print" side 0 will be named {reverse on}side0 head0{reverse off}"
112 print" side 1 will be named {reverse on}side1 head1{reverse off}."
118 print" {down}1571 mode test will format both"
125 print" sides of the disk in 1571 mode."
135 print" the disk will be 1328 blocks and"
145 print" named {reverse on}1571ds{reverse off}."
155 print" {down}1571 rom check returns the rom version"
165 print" present in the the drive."
900 get x$:if x$<"1" or x$>"3" goto 900
910 on val(x$) goto 1000, 3000, 6000
1000 input"{home}{clear}{down}format disk y/n";y$
1003 print"{up}1541 mode check   "
1005 print"{down}testing head0..."
1020 close1:open1,8,15,"u0>m0"
1030 ify$="y" then goto 1050
1040 goto 10
1050 print"formating with h0 (664 blocks)..."
1055 close1:open1,8,15,"u0>h0"
1060 print#1,"new:side0 head 0,99"
1072 gosub 6150
1077 open 15,8,15: print#15,"m-w";chr$(106);chr$(0);chr$(1);chr$(113):close 15
2000 print"{down}{down}testing head1..."
2050 print"formating with h1 (664 blocks)..."
2052 open15,8,15:print#15,"i":close 15
2055 close1:open1,8,15,"u0>h1"
2060 print#1,"new:side1 head 1,99"
2070 gosub 6150
2080 goto 6075
3000 print"{home}{clear}{down}enabling 1571 mode"
3010 input"format disk y/n";y$
3020 if y$="y" then goto 3050
3030 goto 10
3050 print"{up}formating disk with 1328 blocks..."
3055 close1:open1,8,15,"u0>m1"
3060 print#1,"new:1571ds,99"
3070 gosub 6150
5020 goto 6075
6000 dn=8:close1:open1,dn,15,"u9":input#1,en,em$,et,es
6010 ifright$(em$,2)<>"71" then print:print"not a 1571 drive":close1:end
6020 print#1,"m-r"chr$(0)chr$(128)chr$(2):get#1,a$,b$:close1
6030 a=asc(a$+chr$(0)):b=asc(b$+chr$(0)):r$="unknown"
6040 ifa=157thenifb=30 then r$="318047-01"
6050 ifa=146thenifb=37 then r$="310654-03"
6060 ifa=242thenifb=104 then r$="310654-05"
6070 print "{clear}{home}{down}1571 dos rom revision is ";r$
6075 print"{down}":input "exit y/n";y$
6080 if y$="n" then goto 20
6090 end
6150 input#1,e,e$,t,s
6155 print "{reverse on}";e;e$;t;s"{reverse off}"
6160 close1:open1,8,15
6170 open2,8,2,"#"
6175 print"{down}read disk name..."
6180 print#1,"u1 2 0 18 0"
6190 print#1,"b-p 2 144"
6195 for i=1 to 16
6198 get#2,a$: if a$=chr$(160) then 6200
6199 print "{reverse on}";a$;:next
6200 print"{reverse off}{down}"
6210 close 2 : close1:return