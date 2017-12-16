//Tempat wisata di Emerald city dikelola datanya menggunakan sebuah program.
//Program tersebut mengelola data usaha wisata berdasarkan tipe wisata (outdoor, indoor),
//(individu, family friendly), harga tiket masuk sesuai dengan hari atau waktunya, dan menyediakan
//fasilitas umum seperti toilet, musholah, dan juga jenis makanan / sourvenir yang dijual ditempat
//pariwisata tersebut. Dan juga ada tidaknya fasilitas untuk para penyandang disabilitas.

program JaJalKuy;
//==================== DICTIONARY ====================\\
uses crt,sysutils;
const
	Max = 10000;
type
	akun =
		record
			nama: string;
			uname: string;
			pass: string;
		end;
	hari =
		record
			weekday : string;
			weekend : string;
		end;
	waktu =
		record
			Buka : string;
			tutup : string;
		end;

	wisata =
		record
			Nama : String;
			inout : string;
			indFam : string;
			harga : hari;
			lokasi : string;
			deskripsi : string;
			jam : waktu ;
			fasilitas : array[1..100] of string;
		end;
type arstr = array[1..Max] of string;
var
	id,i,j: Integer;
	f: file of wisata;
	fAkun : file of akun;
	arWisata: array [1..Max] of wisata;
	arAkun: array [1..Max] of akun;
	jumlahdata,jumlahakun:longint;
	pilih : Byte;
	nama:string;

//==================== PROCEDURE DAN FUNCTION yang dibutuhkan ==========================================================================================\\
procedure tampil(i:integer);
{
	IS. Menerima Index
	FS. Menampilkan setiap data dari record arWisata indeks ke-i
}
var
	k: Integer;
begin
		writeln;
		writeln('indeks #',i);
		writeln('  Nama Tempat Wisata         : ', arWisata[i].nama);
		writeln('  Alamat tempat wisata       : ',arWisata[i].lokasi);
		writeln('  Indoor / Outdoor           : ', arWisata[i].inout);
		writeln('  Individu / Family Friendly : ', arWisata[i].indFam);
		writeln('  Harga Weekday              : ', arWisata[i].harga.weekday);
		writeln('  Harga Weekend              : ', arWisata[i].harga.weekend);
		writeln('  Jam Operasional            : ', arWisata[i].jam.buka,'-',arWisata[i].jam.tutup);
		write('  Fasilitas         : '); k:=1;
			while arWisata[i].fasilitas[k] <> '' do
				begin
					write(arWisata[i].fasilitas[k],', ');
					inc(k);
				end;
		writeln;
		write('  Deskripsi         : ', arWisata[i].deskripsi);
		writeln;
end;

procedure pilurut(var AsDesc: byte);
{
	IS. Menerima nilai melalui variable AsDesc
	FS. Mengembalikan nilai inputan terbesar atau terkecil dari inputan melalui AsDesc
}
begin
	repeat
	writeln;
	writeln('  urutkan dari : ');
	writeln('  1.Terkecil');
	writeln('  2.Terbesar');
	writeln;
	write('  Pilih : '); readln(AsDesc);
	until (AsDesc=1) or (AsDesc=2);
end;
procedure preprojam(var tmp:arstr;x:string);
{
	pre-process jam
	IS. Menerima array tmp dan string x
	FS. mengembalikan array tmp yang sudah di isi nilai jam tanpa titik ataupun titik dua
}
var 
	i,s:integer;
begin
	for i:= 1 to Max do
		tmp[i]:='';
	//pre-process
	for i:= 1 to jumlahdata do
		begin
			s:=Length(arWisata[i].jam.buka);
			j:=1;
				while (j<=s) do
				begin
					if x='buka' then
					begin
						if (arWisata[i].jam.buka[j] <> '.') and (arWisata[i].jam.buka[j] <> ':') then
							tmp[i]:=tmp[i]+arWisata[i].jam.buka[j];
					end
					else if x='tutup' then
						begin
							if (arWisata[i].jam.tutup[j] <> '.') and (arWisata[i].jam.tutup[j] <> ':') then
							tmp[i]:=tmp[i]+arWisata[i].jam.tutup[j];
						end;
					inc(j);
				end;
		end;
end;

procedure carFas();
{
	IS. -
	FS. Mencari Fasilitas di array fasilitas tiap array arWisata
}
var
	i,nFas: Integer;
	cari:string;
	ketemu,ada:boolean;
begin
	ada:=false;
	nfas:=0;
	i:=1;
	write(' Masukkan Fasilitas yang di cari (huruf kecil semua) : '); readln(cari);
	clrscr;
	while i<= jumlahdata do
		begin
			j:=1;
			ketemu:=false;
			//cari ada berapa banyak fasilitas yang terisi
			while (j<100) and (arWisata[i].fasilitas[j] <> '') do
				begin
					inc(nFas);
					inc(j);
				end;
			//cari ada gak fasilitas yang di cari
			j:=1;
			while j <= nFas do
			begin
				if lowercase(arWisata[i].fasilitas[j]) = cari then
					ketemu:=true;
				inc(j);
			end;
			//kalau ada, tampilkan. kalau ngga ya maap aja ye
			if ketemu then
				begin
					tampil(i);
					writeln;
					readln;
				end;
			ada:=ada or ketemu;
			inc(i);
		end;
	if not ada then
		begin
			writeln;
			writeln('maaf fasilitas yang anda cari tidak ada di database wisata kami :(');
		end;
	write('press any key to continue.. '); readln;
end;

procedure switchStr(var c,d:string);
{
	Menukar String
}
var
	tmp: string;
begin
	tmp:=c;
	c:=d;
	d:=tmp;
end;

procedure switchWis(var c,d:wisata);
{
	Menukar Wisata
}
var
	tmp: wisata;
begin
	tmp:=c;
	c:=d;
	d:=tmp;
end;

procedure iSort();//jam tutup //done
{
	Insertion Sort
}
var
	tmp: arstr;
	simp:wisata;
	simp1:string;
	i,sementara: integer;
	AsDesc:byte;
begin
	//pre-process
	preprojam(tmp,'tutup');
	writeln;
	pilurut(AsDesc);
	//mulai
	for i:= 2 to jumlahdata do
		begin
			simp:=arWisata[i];
			simp1:=tmp[i];
			sementara:=i;
			if AsDesc = 1 then
				begin
					while (sementara>1) and (StrToInt(tmp[sementara-1]) > StrToInt(simp1)) do
					begin
						arWisata[sementara]:=arWisata[sementara-1];
						tmp[sementara]:=tmp[sementara-1];
						dec(sementara);
					end;
				end
			else
				begin
					while (sementara>1) and (StrToInt(tmp[sementara-1]) < StrToInt(simp1)) do
					begin
						arWisata[sementara]:=arWisata[sementara-1];
						tmp[sementara]:=tmp[sementara-1];
						dec(sementara);
					end;
				end;
		arWisata[sementara]:=simp;
		tmp[sementara]:=simp1;
		end;
end;

procedure sSort();//jam buka //done
{
	Selection Sort
}
var
	i,j,huah,a,b: longint;
	tmp: arstr;
	AsDesc:byte;
begin
	//pre-process
	preprojam(tmp,'buka');
	writeln;
	pilurut(AsDesc);
	//mulai sort
	for i:= 1 to jumlahdata-1 do
		begin
			huah:=i;
			for j:= i to jumlahdata do
				begin
					a:=StrToInt(tmp[huah]);
					b:=StrToInt(tmp[j]);
					case AsDesc of
						1 : begin
								if a > b then
									huah:=j;
							end;
						2 : begin
								if a < b then
									huah:=j;
							end;
					end;
				end;
			switchWis(arWisata[huah],arWisata[i]);
			switchStr(tmp[huah],tmp[i]);
		end;
end;

procedure carJam();
{
	Cari Jam Buka
}
var
	tmp:arstr;
	x,cari:string;
	kanan, kiri, mid,lokasi:integer;
	a,b:longint;
	status:boolean;
begin
	clrscr;
	cari:='';
	preprojam(tmp,'buka');
	//sort dulu
	for i:= 1 to jumlahdata do
		begin
			for j:= 1 to jumlahdata-1 do
				begin
					if StrToInt(tmp[j]) > StrToInt(tmp[j+1]) then
						begin
							switchWis(arWisata[j],arWisata[j+1]);
							switchStr(tmp[j],tmp[j+1]);
						end; 
				end;
		end;
	//minta input
	write('masukkan Jam buka yang dicari (09.00)/(09:00) : '); readln(x);
	//preproinput
	for i:= 1 to Length(x) do
		if (x[i] <> ':') and (x[i]<>'.') then
		begin
			cari:=cari+x[i];
		end;
	//binary start
	kiri:=1;
	kanan:=jumlahdata;
	status:=false;
	while (kiri <= kanan) and (not status) do
		begin
			mid:=(kiri+kanan) div 2;
			a:=StrToInt(tmp[mid]);
			b:=StrToInt(cari);
			readln;
			if a = b then
				begin
					status:=true;
					lokasi:=mid;
				end
			else if a > b then 
					begin
						kanan:=mid-1;
					end
				else if a < b then
						begin
							kiri:=mid+1;
						end;
		end;
	if status then
		begin
			clrscr;
			writeln('data ketemu !');
			tampil(lokasi);
			readln;
		end
	else
		begin
			writeln('maaf data yang di cari tidak ada di database wisata kami :( ');
			readln;
		end;
end;

procedure bSort(x:string);//harga weekend dan weekday
{
	Bubble Sort
}
var
	i,j: integer;
	a,b:longint;
	AsDesc:byte;
begin
	clrscr;
	pilurut(AsDesc);
	for i:=1 to jumlahdata do
		begin
			for j:= 1 to jumlahdata-1 do 
				begin
					if x = 'day' then
						begin
							a:=StrToInt(arWisata[j].harga.weekday);
							b:=StrToInt(arWisata[j+1].harga.weekday);
						end
					else if x = 'end' then
						begin
							a:=StrToInt(arWisata[j].harga.weekend);
							b:=StrToInt(arWisata[j+1].harga.weekend);
						end;
					case AsDesc of 
						1 : begin
								if a > b then
									switchWis(arWisata[j],arWisata[j+1]);
							end;
						2 : begin
								if a < b then
									switchWis(arWisata[j],arWisata[j+1]);
							end;
					end;
				end;
		end;
end;


function getpass(): string;
{
	Menerima inputan dari keyboard dan akan di tampilkan sebagai karakter bintang (*) menggembalikan 
}
var
	x: char; tmp:string;
begin
	tmp:='';
	x:=readkey;
	while x <> #13 do
	begin
		write('*');
		tmp:=tmp+x;
		x:=readkey;
	end;
	getpass:=tmp;
end;

procedure loadAkun;
begin
	assign(fAkun,'akun.dat');
	reset(fAkun);
	while not eof(fAkun) do
		begin

			inc(jumlahakun);
			read(fAkun,arAkun[jumlahakun]);
		end;
	close(fAkun);
end;
procedure saveAkun;
var
	i: Integer;
begin
	assign(fAkun,'Akun.dat');
	rewrite(fAkun);
	for i:= 1 to jumlahakun do
		begin
			write(fAkun,arAkun[i]);
		end;
	close(fAkun);
end;
procedure load; {ngebuka file, mindahin data di file ke array}
begin
	assign(f,'wisata.dat');
	reset(f);
	while not eof(f) do
		begin
			inc(jumlahdata); //jumlahdata:=jumlahdata+1;
			read(f,arWisata[jumlahdata]);
		end;
	close(f);
end;
procedure save;{buka file, masukin semua array }
var
	i: Integer;
begin
	assign(f,'wisata.dat');
	rewrite(f);
	for i:= 1 to jumlahdata do
		begin
			write(f,arWisata[i]);
		end;
	close(f);
end;

//==================== Admin Menu dan teman teman nya ===================================================================================================\\
procedure cek(idx:integer; var valid : boolean);
begin
	if arWisata[idx].nama <> '' then
	begin
		valid:=true;
		writeln('data yang ini?');
		writeln;
			tampil(idx);
	end
	else 
		begin
		valid:=false;
		writeln('maaf data yang anda cari tidak ada :(');
		readln;
		end;
end;

procedure insertData(x:integer;stat:string);
	var
		pilihadmin:char; tmp:integer;
begin
	repeat
		clrscr;
		writeln;
		writeln(' === Main Menu >> Admin >> Login Admin >> Menu Admin >> Insert Data ===');
		writeln;
		write(' Nama Tempat Wisata : '); readln(arWisata[x].nama);
		write(' Alamat tempat wisata : '); readln(arWisata[x].lokasi);

		repeat
			write(' 1. Indoor / 2. Outdoor // Pilih angka  : '); readln(tmp);
		until (tmp = 1 ) or (tmp=2);
		if tmp = 1 then
			arWisata[x].inout:='Indoor'
		else
			arWisata[x].inout:='Outdoor';

		repeat
		write(' 1. Individu / 2. Family Friendly : '); readln(tmp);
		until (tmp = 1 ) or (tmp=2);
		if tmp = 1 then
			arWisata[x].indFam:='Individu'
		else
			arWisata[x].indFam:='Family Friendly';
		write(' Harga Weekday [Senin-Jumat] (per orang) : '); readln(arWisata[x].harga.weekday);
		write(' Harga Weekend [Sabtu-Minggu] (per orang) : '); readln(arWisata[x].harga.weekend);
		write(' Jam Buka (09.00)/(09:00) : '); readln(arWisata[x].jam.buka);
		write(' Jam Tutup (09.00)/(09:00) : '); readln(arWisata[x].jam.tutup);
		writeln(' Fasilitas : ');j:=0;
			while arWisata[x].fasilitas[j]<>'' do
			begin
				inc(j);
				write(j,' : '); readln(arWisata[x].fasilitas[j]);
			end;
		write(' Deskripsi : '); readln(arWisata[x].deskripsi);
		writeln;
		if stat = 'ins'then
		begin
			write('Ingin nambah data wisata lagi? [y/t] : '); readln(pilihadmin);
			if pilihadmin = 'y' then
				begin
				inc(jumlahdata);
				x:=jumlahdata;	
				end;
		end
		else if stat = 'edit' then
				begin
					writeln('== Data Baru sudah tersimpan! ==');
					readln;
					pilihadmin:='t';
				end;

	until (lowercase(pilihadmin)='t');
end;

procedure editData();
	var
		idx,i: Integer;
		pilih:char;
		valid:boolean;
begin
	clrscr;
	writeln;
	writeln(' === Main Menu >> Admin >> Login Admin >> Menu Admin >> Edit Data ===');
	writeln;
	for i:= 1 to jumlahdata do
		begin
			writeln(i,'. ',arWisata[i].nama);
		end;
		write('masukkan nomor indeks yang ingin di edit : '); readln(idx);
	clrscr;
	cek(idx,valid);
	if valid then
		begin
			write('pilih [y/t] : '); readln(pilih);
			if lowercase(pilih) = 'y' then
				begin
					insertData(idx,'edit');
				end;
		end;
end;

procedure deleteData();
var
	pilih: char;
	idx:byte;
	i:integer;
	valid:boolean;
//mencari datanya
begin
	clrscr;
	writeln;
	writeln(' === Main Menu >> Admin >> Login Admin >> Menu Admin >> Delete Data ===');
	writeln;
	for i:= 1 to jumlahdata do
		begin
			writeln(i,'. ',arWisata[i].nama);
		end;
	write('masukkan nomor indeks tempat wisata : '); readln(idx);
	clrscr;
	cek(idx,valid);
	if valid then
		begin
			write('pilih : [y/t] : '); readln(pilih);
			if pilih = 'y'then
			begin
				//hapus datanya
				for i:= idx to jumlahdata do
					begin
						arWisata[i]:=arWisata[i+1]
					end;
				dec(jumlahdata);
				writeln('== Data ke ',idx,' telah di hapus! ==')
			end;
		end;
end;


procedure viewData();
	var
		tmp,flag: Integer;
		esc:boolean;
begin
	repeat
	esc:=false;
	clrscr;
	flag:=1; i:=1;
	while i<=jumlahdata do
		begin
			if flag <= 2 then
				begin
					inc(flag);
					tampil(i);
					inc(i);
				end
			else
				begin
					flag:=1;
					writeln;
					write('press any key to continue.. '); readln;
					clrscr;
				end;
		end;
		writeln;
		writeln;
	if id=2 then
		begin	
				write('[1.Insert 2.Edit 3.Delete 4.Back] : '); readln(tmp);
				case tmp of
					1 : begin inc(jumlahdata); insertData(jumlahdata,'ins'); end;
					2 : begin editData; end;
					3 : begin deleteData; end;
					4 : begin esc:=true; end;
				end;
		end
	else if id=1 then
		begin
			writeln;
			write('press any key to continue..'); readkey;
			clrscr;
			writeln;
			writeln('   Urutkan Berdasarkan :');
			writeln('   1. Harga Weekday ');
			writeln('   2. Harga Weekend ');
			writeln('   3. Jam Buka ');
			writeln('   4. Jam Tutup');
			writeln('   5. Back');
			writeln;
			write  ('  ===>Pilih : '); readln(tmp);
			case tmp of
				1: begin bSort('day'); end;
				2: begin bSort('end'); end;
				3: begin sSort(); end;
				4: begin iSort(); end;
				5: begin esc:=true; end;
			end;
		end;
	until esc;
end;

procedure menuAdmin();
begin
	repeat
	clrscr;
	writeln;
	writeln(' === Main Menu >> Admin >> Login Admin >> Menu Admin ===');
	writeln;
	writeln('  == Admin Menu ==');
	writeln('  1. Insert Data');
	writeln('  2. Edit Data');
	writeln('  3. Delete Data');
	writeln('  4. View Data');
	writeln('  5. Back');
	writeln('  jumlah data : ',jumlahdata);
	writeln;
	write('  ===> Pilih : '); readln(pilih);
	case pilih of
		1 : begin inc(jumlahdata); insertData(jumlahdata,'ins'); end;
		2 : begin editData(); end;
		3 : begin deleteData(); end;
		4 : begin viewData(); end;
	end;
	until (pilih=5);
	save;
end;

procedure welcomeAdmin();
var
	uname,pass: string;
begin
	repeat
	clrscr;
	writeln;
	writeln(' === Main Menu >> Admin >> Login Admin ===');
	writeln('hint : uname & pass = admin. kosongkan untuk kembali' );
	writeln('  == Login Admin ==');
	writeln;
	write  ('===> Username : '); readln(uname);
	write  ('===> Password  : '); pass:=getpass;
	until ((uname = 'admin') and (pass = 'admin')) or ((uname = '') or (pass = ''));
	if ((uname = 'admin') and (pass = 'admin')) then
		menuAdmin();
end;

//==================== User Menu dan teman teman nya ====================================================================================================\\
procedure cekUser(uname,pass:string; var valid : boolean);
var
	i:longint;
	cek:boolean;
begin
	cek:=false;
	for i:=1 to jumlahakun do
		begin
		 	if (arAkun[i].uname = uname) and (arAkun[i].pass = pass) then
		 	begin
		 		cek:=true;
		 		nama:=arAkun[i].nama;
		 	end;
		 end; 
	valid := cek;
end;

procedure cariData();
var
	tmp: Integer;
begin
	repeat
	clrscr;
	writeln;
	writeln(' === Main Menu >> User >> Login >> Menu User >> Cari Data ===');
	writeln;
	writeln('  1. Cari Berdasarkan Jam Buka ');
	writeln('  2. Cari Berdasarkan Fasilitas ');
	writeln('  3. Kembali ');
	writeln;
	write  ('===> Pilih : '); readln(tmp);
	case tmp of
		1: begin carJam(); end;
		2: begin carFas(); end;
	end;
	until (tmp=3);
end;

procedure menuUser();
var
	tmp: byte;
begin
	repeat
	clrscr;
	writeln;
	writeln(' === Main Menu >> User >> Login >> Menu User ===');
	writeln;
	writeln('     Selamat Datang, ',nama);
	writeln;
	writeln('  1. Lihat Semua Wisata ');
	writeln('  2. Cari Tempat Wisata ');
	writeln('  3. Back ');
	writeln;
	write  ('===> Pilih : '); readln(tmp);
	case tmp of
		1: begin viewData(); end;
		2: begin cariData(); end;
	end;
	until (tmp=3);
end;


procedure welcomeUser();
var
	uname,pass: string;
	pilihan:integer;
	valid:boolean;
begin
	repeat
	clrscr;
	writeln;
	writeln(' === Main Menu >> User ===');
	writeln;
	writeln('     1. Login ');
	writeln('     2. Register ');
	writeln('     3. Kembali ');
	writeln;
	write  ('===> Pilih : ');readln(pilihan);
	if pilihan = 1 then
		begin
			clrscr;
			writeln(' === Main Menu >> User >> Login ===');
			writeln;
			writeln('   ==Login==    ');
			write  ('===> Username : '); readln(uname);
			write  ('===> Password : '); pass:=getpass;
			cekUser(uname,pass,valid);
			if valid then
				menuUser()
			else
				begin
					writeln;
					writeln('!!!! username atau password yang anda masukkan salah !!!!');
					write('press any key to continue..'); readkey;
				end;
		end
	else
		if pilihan = 2 then
		begin
			clrscr;
			inc(jumlahakun);
			writeln;
			writeln(' === Main Menu >> User >> Registrasi ===');
			writeln;
			writeln('  == Daftar == ');
			write  ('===> Nama Lengkap : '); readln(arAkun[jumlahakun].nama);
			write  ('===> Username : '); readln(arAkun[jumlahakun].uname);
			write  ('===> Password : '); readln(arAkun[jumlahakun].pass);
			saveAkun;
			writeln;
			writeln('Registrasi Selesai, Data tersimpan.');
			writeln;
			write('press anykey to continue.. '); readkey;
		end;
	until (pilihan = 3);
end;

//==================== PROGRAM UTAMA ====================\\
begin
	clrscr;
	//buat bikin file kalau filenya ga ada
	Assign(f, 'wisata.dat') ;
    {$I-} Reset(f) ;
    {$I+} if IOResult<>0 then Rewrite(f) ;
    close(f);
    Assign(fAkun, 'akun.dat') ;
    {$I-} Reset(fAkun) ;
    {$I+} if IOResult<>0 then Rewrite(fAkun) ;
    close(fAkun);
    //akhir dari bikin file
    jumlahdata:=0;
    load;
    loadAkun;
	repeat
	clrscr;
	writeln('--------------------------------------------------');
	writeln('=========== Selamat Datang di JalJalKuy! ==========');
	writeln('=== Aplikasi Wisata terbaik se - Emerald city! ===');
	writeln('--------------------------------------------------');
	writeln('-------------------------------------------------- ');
	writeln('|     Main Menu                                  | ');
	writeln('|     1.User                                     | ');
	writeln('|     2.Admin                                    | ');
	writeln('|     3.Log Out                                  | ');
	writeln('--------------------------------------------------');
	writeln;
	write  ('   ===> Pilih : '); readln(id);
	case id of
		1: welcomeUser();
		2: welcomeAdmin();
	end;
	until (id=3);
	clrscr;
	save;
	saveAkun;
end.