program VmathXplorer;
uses crt,dos;
var 
	n1,n2,l1,l2:longint;
	i,c:byte;
	cmd,s0,s1,s2:string;
	a:array[0..256] of string;
	
procedure ReadCmd(s:string);
	var t:byte;
	begin
		c:=0;
		if pos(' ',s) <> 0 then
			repeat
				t:=pos(' ',s);
				a[c]:=copy(s,1,t-1);
				delete(s,1,t);
				c:=c+1;
			until pos(' ',s)=0;
		t:=length(s);
		a[c]:=copy(s,1,t);
	end;
procedure Err(l:byte);
	begin
		case l of
			0	:	write(cmd,' Is Not A Command Or An Equation.');
			1	:	write('Command Got Mistake.');
			2	:	write('Division By 0');
			3	:	write('Invalid File');
		end;
	end;
procedure Help;
	begin
		if a[1]='paint' then begin
			writeln('paint [Text] [Background]');
			writeln('Color Table');
			writeln('Black          0   DarkGray        8');
			writeln('Blue           1   LightBlue       9');
			writeln('Green          2   LightGreen      10');
			writeln('Cyan           3   LightCyan       11');
			writeln('Red            4   LightRed        12');
			writeln('Magenta        5   LightMagenta    13');
			writeln('Brown          6   Yellow          14');
			writeln('LightGray      7   White           15');
		end
		else begin
			writeln('COMMAND');
			writeln('#[FileName]                Read file (Run Program With File-Extension .mtx');			
			writeln('about                      Info');
			writeln('ckprime [Number]           Check [Number] is a prime or not');
			writeln('clrs                       Clear Screen');
			writeln('Date                       Write Date');
			writeln('exit                       Exit Program');
			writeln('help                       Help');
			writeln('paint [Text] [Background]  Change Text, Background Color');
			writeln('prime [N1] [N2]            Write prime number from [N1] to [N2]');
			writeln('print [Cau]                Print to screen');			
			writeln('stops                      Stop Screen');
			writeln('time                       Write Time');
			write('*Press Enter to Continue*');readln;
			writeln('EQUATION');
			writeln('[n1] + [n2]                Plus');
			writeln('[n1] - [n2]                Minus');
			writeln('[n1] * [n2]                Multiply');
			writeln('[n1] % [n2]                Divide (Show mod)');
			writeln('[n1] : [n2]                Divide (Show answer)');
			writeln('[n1] / [n2]                Divide (Show fraction)');
			writeln('[n1] ^ [n2]                Power');
			writeln('[n1] !                     Factorial');
			writeln('[n1]x^2+[n2]x+[n3]=0       Calculate quadratic equation');
		end
	end;
procedure Date;
	var 
		Nam,Thang,Ngay,Thu : word;
	const
		NgayThu:array[0..6] of string=('Chu Nhat','Thu Hai','Thu Ba','Thu Tu','Thu Nam','Thu Sau','Thu Bay');
	begin
	GetDate(Nam,Thang,Ngay,Thu);
	write('Ngay hom nay la: ',NgayThu[Thu],', ',Ngay,' Thang ',Thang,' Nam ',Nam,'.');
	end;
procedure Time;
	var 
		Gio,Phut,Giay,Tich : word;
	begin
		if a[1]<>'' then Err(2)
		else begin
			GetTime(Gio,Phut,Giay,Tich);
			write('Bay gio la: ',Gio,':',Phut,':',Giay,'.',Tich);
		end;
	end;
procedure Print;
	begin
		for i:=1 to c+1 do write(a[i],' ');
	end;
procedure Paint;
	var 
		MauChu,MauNen:byte;
	begin
		if (a[1]='') or (a[2]='') then write('Enter "help paint" for function detail.')
		else begin
			val(a[1],MauChu,l1);
			val(a[2],MauNen,l2);
			if (a[3]<>'') or (l1<>0) or (l2<>0) then Err(2)
			else begin
				textcolor(MauChu);
				textbackground(MauNen);
				clrscr;
			end;
		end;
	end;
function Ckprime(k:longint):boolean;
	begin
		Ckprime:=False;
		for i:=2 to k do
			if (k mod i=0) and (k=i) then Ckprime:=True;
	end;
procedure wprime;
	var
		k:longint;
	begin
		val(a[1],k,i);
		if k<2 then Err(2)
		else begin
			case Ckprime(k) of
				True	:	write(k,' is a prime');
				False	:	write(k,' is not a prime');
			end;
		end;
	end;
procedure Prime;
	begin
		val(a[1],n1,l1);val(a[2],n2,l2);
		if (n1<2) or (n1>=n2) or (l1<>0) or (l2<>0) then Err(2)
		else begin
			for i:=n1 to n2 do if Ckprime(i)=True then write(i:5);
			writeln;
		end;
	end;
function Power(x:longint;y:longint):longint;
	begin
		Power:=1;
		if y>0 then	for i:=1 to y do Power:=Power*x;
	end;
function Fact(t:longint):int64;
	begin
		Fact:=1;
		if t>0 then	for i:=1 to t do Fact:=Fact*i;
	end;
function Divide(x:longint;y:longint):longint;
	begin
		if (x=0) or (y=0) then Err(2)
		else Divide:=x div y;
	end;
function DivideMod(x:longint;y:longint):longint;
	begin
		if (x=0) or (y=0) then Err(2)
		else DivideMod:=x mod y;
	end;
function Plus(x:longint;y:longint):longint;
	begin
		Plus:=x+y;
	end;
function Minus(x:longint;y:longint):longint;
	begin
		Minus:=x-y;
	end;
function Multiply(x:longint;y:longint):longint;
	begin
		Multiply:=x*y;
	end;
function DivideFrac(x:longint;y:longint):string;
	var k:longint;
	begin
		if x mod y = 0 then begin
			str(x div y,s0);
			DivideFrac:=s0;
		end
		else begin
			if x<y then k:=x else k:=y;
			i:=1;
			repeat
				i:=i+1;
				if (x mod i=0) and (y mod i=0) then 
					begin
						x:=x div i;
						y:=y div i;
					end;
			until i=k;
			str(x,s1);
			str(y,s2);
			DivideFrac:=s1+'/'+s2;
		end;
	end;
procedure cqe2(x:real;y:real;z:real);
	var delta:real;
	begin
		delta:=(y*y-4*x*z);
		if delta<0 then write('No Soloution.')
		else if delta=0 then write('1 Solution: ',-y / (2*x))
		else if delta>0 then write('2 Solutions : x1= ',(-y+delta) / (2*x),' | x2= ',(-y-delta) / (2*x));
	end;
procedure qe2(str:string);
	var real0,real1,real2:real;
	begin
		s1:=copy(str,1,pos('x^2',str)-1);
		delete(str,1,pos('x^2',str)+2);
		s2:=copy(str,1,pos('x',str)-1);
		delete(str,1,pos('x',str));
		s0:=copy(str,1,pos('=0',str)-1);
		val(s1,real1,l1);
		val(s2,real2,l2);
		val(s0,real0,i);
		if n1=0 then Err(2) else cqe2(real1,real2,real0);		
	end;
procedure stops;
	begin
		readln;
	end;
procedure info;
	begin
		writeln('Phan Mem VMath Xplorer v0.2 Build 43');
		write('Duoc tao ra boi Winux8YT3');
	end;
procedure AlzEq;
begin
	case a[1] of
			'+'			:	write(Plus(n1,n2));
			'-'			:	write(Minus(n1,n2));
			'*'			:	write(Multiply(n1,n2));
			':'			:	write(Divide(n1,n2));
			'%'			:	write(DivideMod(n1,n2));
			'/'			:	write(DivideFrac(n1,n2));
			'^'			:	write(Power(n1,n2));
			'!'			:	write(Fact(n1));
	else Err(0);
	end;
end;
procedure AlzCmd(s:string);
	begin
		ReadCmd(s);
		val(a[0],n1,l1);
		val(a[2],n2,l2);
		case s of
			'',' '		:	help;
			'clrs'		:	clrscr;	
			'date' 		:	Date;
			'time'		:	Time;
			'about'		:	info;
			'stops'     :	stops;
		else
			case a[0] of
				'print'		:	Print;
				'paint'		:	Paint;
				'help'		:	Help;
				'ckprime'	:	wprime;
				'prime' 	:	Prime;
			else AlzEq;
			end;
		end;
		writeln;
	end;
procedure ReadFile(ten:string);
	var 
		f:text;
		ext,str:string;
		k:integer;
	begin
		{$I-}
		assign(f,ten);
		Reset(f);
		{$I+}
		if IOResult<>0 then Err(3)
		else begin
			k:=length(ten)-pos('.',ten);
			ext:=copy(ten,pos('.',ten)+1,k);
			if ext='mxc' then begin
				repeat
					readln(f,str);
					AlzCmd(str);
				until eof(f);
			end
			else
			repeat
				readln(f,str);writeln(str);
			until eof(f);
			close(f);
		end;
	end;	
procedure Welcome;
	var 
		f:text;
		r:byte;
	begin
		{$I-}
		assign(f,'Welcome.dat');
		Reset(f);
		{$I+}
		if IOResult<>0 then begin
			assign(f,'Welcome.dat');
			rewrite(f);
			writeln(f,'===========================================');
			writeln(f,'               VMath Xplorer               ');
			writeln(f,'                                           ');
			writeln(f,'               v0.2 Build 43               ');
			writeln(f,'===========================================');
			close(f);
		end;
		textbackground(1);textcolor(14);
		ReadFile('Welcome.dat');
		textbackground(0);textcolor(7);
		randomize;
		r:=random(9);
		case r of
			0	:	write('Welcome To Vmath Xplorer 0.2 Build 43 English Edition');
			1	:	write('Wanna Focus In Math? Try Now!');
			2	:	write('Comment Or Report Error In This Program At https://sourceforge.net/projects/vmath-xplorer/');
			3	:	write('Try file .mxc');
			4	:	write('{Welcome procedure exited without exitcode}');
			5	:	write('Try #');
			6	:	write('/Empty/');
			7	:	write('BIN=1101 1110 1100 0000 1101 1110 | HEX=?');
			8	:	write('...');
		end;
		writeln;
	end;
begin																									{Main}
	clrscr;
	Welcome;
	repeat
		writeln;i:=0;s1:='';s2:='';s0:='';n1:=0;n2:=0;
		write('Input/> ');readln(cmd);writeln;
		write('Output/> ');
		if pos('#',cmd)=1 then ReadFile(copy(cmd,2,length(cmd)-1))
		else if (pos('x^2',cmd)<>0) and (pos('x',cmd)<>0) and (pos('=0',cmd)<>0) then qe2(cmd)
		else AlzCmd(cmd);
	until cmd='exit';
	clrscr;info;
end.