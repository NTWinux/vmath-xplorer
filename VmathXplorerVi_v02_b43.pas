program VmathXplorer;
uses crt,dos;
var 
	st1,st2,l1,l2:longint;
	i,c:byte;
	lenh,s0,s1,s2:string;
	a:array[0..256] of string;
	
procedure DocLenh(s:string);
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
procedure Loi(l:byte);
	begin
		case l of
			0	:	write(lenh,' Khong Phai La Lenh Hay Phep Tinh Toan Hoc.');
			1	:	write('Ban Da Nhap Cau Lenh Sai Chinh Ta.');
			2	:	write('Phep Chia Cho 0.');
			3	:	write('File Khong Ton Tai.');
		end;
	end;
procedure TroGiup;
	begin
		if a[1]='Son' then begin
			writeln('son [MauChu] [MauNen]');
			writeln('Bang Mau');
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
			writeln('CAU LENH');
			writeln('#[tenFile]                 Doc file (Chay Chuong Trinh voi file .mtx');			
			writeln('dungmh                     Dung man hinh');
			writeln('ktsnt [So]                 Kiem tra [So] co phai la SNT khong');
			writeln('snt [ST1] [ST2]            Viet cac so nguyen to tu [ST1] den [ST2]');
			writeln('son [MauChu] [MauNen]      Doi mau chu, mau man hinh');
			writeln('tinhgio                    Cho ra thoi gian hien tai');
			writeln('tinhngay                   Cho ra ngay hien tai');
			writeln('thoat                      Thoat khoi chuong trinh');
			writeln('thongtin                   Thong tin can thiet');
			writeln('trogiup                    Tro giup');
			writeln('viet [Cau]                 Viet ra man hinh');
			writeln('xoamh                      Xoa man hinh');
			write('*Press Enter to Continue*');readln;
			writeln('BIEU THUC');
			writeln('[st1] + [st2]              Cong');
			writeln('[st1] - [st2]              Tru');
			writeln('[st1] * [st2]              Nhan');
			writeln('[st1] % [st2]              Chia (Hien Phan Du)');
			writeln('[st1] : [st2]              Chia (Hien Thuong)');
			writeln('[st1] / [st2]              Chia (Hien Phan So)');
			writeln('[st1] ^ [st2]              Mu');
			writeln('[st1] !                    Giai Thua');
			writeln('[st1]x^2+[st2]x+[st3]=0    Tinh Phuong Trinh Bac 2');
		end
	end;
procedure TinhNgay;
	var 
		Nam,Thang,Ngay,Thu : word;
	const
		NgayThu:array[0..6] of string=('Chu Nhat','Thu Hai','Thu Ba','Thu Tu','Thu Nam','Thu Sau','Thu Bay');
	begin
	GetDate(Nam,Thang,Ngay,Thu);
	write('Ngay hom nay la: ',NgayThu[Thu],', ',Ngay,' Thang ',Thang,' Nam ',Nam,'.');
	end;
procedure TinhGio;
	var 
		Gio,Phut,Giay,Tich : word;
	begin
		if a[1]<>'' then loi(2)
		else begin
			GetTime(Gio,Phut,Giay,Tich);
			write('Bay gio la: ',Gio,':',Phut,':',Giay,'.',Tich);
		end;
	end;
procedure Viet;
	begin
		for i:=1 to c+1 do write(a[i],' ');
	end;
procedure Son;
	var 
		MauChu,MauNen:byte;
	begin
		if (a[1]='') or (a[2]='') then write('Nhap "trogiup son" de duoc huong dan cau lenh cu the.')
		else begin
			val(a[1],MauChu,l1);
			val(a[2],MauNen,l2);
			if (a[3]<>'') or (l1<>0) or (l2<>0) then Loi(2)
			else begin
				textcolor(MauChu);
				textbackground(MauNen);
				clrscr;
			end;
		end;
	end;
function KTSNT(k:longint):boolean;
	begin
		KTSNT:=False;
		for i:=2 to k do
			if (k mod i=0) and (k=i) then KTSNT:=True;
	end;
procedure VietSNT;
	var
		k:longint;
	begin
		val(a[1],k,i);
		if k<2 then loi(2)
		else begin
			case KTSNT(k) of
				True	:	write(k,' la so nguyen to');
				False	:	write(k,' khong la so nguyen to');
			end;
		end;
	end;
procedure SNT;
	begin
		val(a[1],st1,l1);val(a[2],st2,l2);
		if (st1<2) or (st1>=st2) or (l1<>0) or (l2<>0) then loi(2)
		else begin
			for i:=st1 to st2 do if KTSNT(i)=True then write(i:5);
			writeln;
		end;
	end;
function Mu(x:longint;y:longint):longint;
	begin
		Mu:=1;
		if y>0 then for i:=1 to y do Mu:=Mu*x;
	end;
function GiaiThua(t:longint):longint;
	begin
		GiaiThua:=1;
		if t>0 then	for i:=1 to t do GiaiThua:=GiaiThua*i;
	end;
function Chia(x:longint;y:longint):longint;
	begin
		if (x=0) or (y=0) then loi(2)
		else Chia:=x div y;
	end;
function ChiaDu(x:longint;y:longint):longint;
	begin
		if (x=0) or (y=0) then loi(2)
		else ChiaDu:=x mod y;
	end;
function Cong(x:longint;y:longint):longint;
	begin
		Cong:=x+y;
	end;
function Tru(x:longint;y:longint):longint;
	begin
		Tru:=x-y;
	end;
function Nhan(x:longint;y:longint):longint;
	begin
		Nhan:=x*y;
	end;
function Chiaps(x:longint;y:longint):string;
	var k:longint;
	begin
		if x mod y = 0 then begin
			str(x div y,s0);
			Chiaps:=s0;
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
			Chiaps:=s1+'/'+s2;
		end;
	end;
procedure tptb2(x:real;y:real;z:real);
	var delta:real;
	begin
		delta:=(y*y-4*x*z);
		if delta<0 then write('Phuong Trinh Vo Nghiem.')
		else if delta=0 then write('Phuong Trinh Co 1 Nghiem: ',-y / (2*x))
		else if delta>0 then write('Phuong Trinh Co 2 Nghiem: x1= ',(-y+delta) / (2*x),' | x2= ',(-y-delta) / (2*x));
	end;
procedure ptb2(xau:string);
	var real0,real1,real2:real;
	begin
		s1:=copy(xau,1,pos('x^2',xau)-1);
		delete(xau,1,pos('x^2',xau)+2);
		s2:=copy(xau,1,pos('x',xau)-1);
		delete(xau,1,pos('x',xau));
		s0:=copy(xau,1,pos('=0',xau)-1);
		val(s1,real1,l1);
		val(s2,real2,l2);
		val(s0,real0,i);
		if st1=0 then loi(2) else tptb2(real1,real2,real0);		
	end;
procedure DungMH;
	begin
	readln;
	end;
procedure info;
	begin
		writeln('Phan Mem VMath Xplorer v0.2 Build 43');
		write('Duoc tao ra boi Winux8YT3');
	end;
procedure XuLyBT;
begin
	case a[1] of
			'+'			:	write(Cong(st1,st2));
			'-'			:	write(Tru(st1,st2));
			'*'			:	write(Nhan(st1,st2));
			':'			:	write(Chia(st1,st2));
			'%'			:	write(ChiaDu(st1,st2));
			'/'			:	write(Chiaps(st1,st2));
			'^'			:	write(Mu(st1,st2));
			'!'			:	write(GiaiThua(st1));
	else loi(0);
	end;
end;
procedure XuLyLenh(s:string);
	begin
		DocLenh(s);
		val(a[0],st1,l1);
		val(a[2],st2,l2);
		case s of
			'',' '		:	trogiup;
			'xoamh'		:	clrscr;	
			'tinhngay' 	:	TinhNgay;
			'tinhgio'	:	TinhGio;
			'thongtin'	:	info;
			'dungmh'	:	DungMH;
		else
			case a[0] of
				'viet'		:	Viet;
				'son'		:	Son;
				'trogiup'	:	TroGiup;
				'ktsnt'		:	VietSNT;
				'snt' 		:	SNT;
			else XuLyBT;
			end;
		end;
		writeln;
	end;
procedure DocFile(ten:string);
	var 
		f:text;
		ext,str:string;
		k:integer;
	begin
		{$I-}
		assign(f,ten);
		Reset(f);
		{$I+}
		if IOResult<>0 then loi(3)
		else begin
			k:=length(ten)-pos('.',ten);
			ext:=copy(ten,pos('.',ten)+1,k);
			if ext='mxc' then begin
				repeat
					readln(f,str);
					XuLyLenh(str);
				until eof(f);
			end
			else
			repeat
				readln(f,str);writeln(str);
			until eof(f);
			close(f);
		end;
	end;	
procedure ChaoMung;
	var 
		f:text;
		r:byte;
	begin
		{$I-}
		assign(f,'ChaoMung.dat');
		Reset(f);
		{$I+}
		if IOResult<>0 then begin
			assign(f,'ChaoMung.dat');
			rewrite(f);
			writeln(f,'===========================================');
			writeln(f,'               VMath Xplorer               ');
			writeln(f,'                                           ');
			writeln(f,'               v0.2 Build 43               ');
			writeln(f,'===========================================');
			close(f);
		end;
		textbackground(1);textcolor(14);
		DocFile('ChaoMung.dat');
		textbackground(0);textcolor(7);
		randomize;
		r:=random(9);
		case r of
			0	:	write('Chao Mung Toi Vmath Xplorer 0.2 Build 43');
			1	:	write('Muon Tap Trung Vao Toan? Su Dung Ngay!');
			2	:	write('Comment Hoac Thong Bao Loi Trong Chuong Trinh Tai https://sourceforge.net/projects/vmath-xplorer/');
			3	:	write('Hay Thu File .mxc');
			4	:	write('{ChaoMung procedure exited without exitcode}');
			5	:	write('Hay Thu #');
			6	:	write('/Empty/');
			7	:	write('BIN=1101 1110 1100 0000 1101 1110 | HEX=?');
			8	:	write('...');
		end;
		writeln;
	end;
begin																									{Chuong Trinh Chinh}
	clrscr;
	ChaoMung;
	repeat
		writeln;i:=0;s1:='';s2:='';s0:='';st1:=0;st2:=0;
		write('Input/> ');readln(lenh);writeln;
		write('Output/> ');
		if pos('#',lenh)=1 then DocFile(copy(lenh,2,length(lenh)-1))
		else if (pos('x^2',lenh)<>0) and (pos('x',lenh)<>0) and (pos('=0',lenh)<>0) then ptb2(lenh)
		else XuLyLenh(lenh);
	until lenh='thoat';
	clrscr;info;
end.