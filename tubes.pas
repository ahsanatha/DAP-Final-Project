//Tempat wisata di Emerald city dikelola datanya menggunakan sebuah program.
//Program tersebut mengelola data usaha wisata berdasarkan tipe wisata (outdoor, indoor),
//(individu, family friendly), harga tiket masuk sesuai dengan hari atau waktunya, dan menyediakan
//fasilitas umum seperti toilet, musholah, dan juga jenis makanan / sourvenir yang dijual ditempat
//pariwisata tersebut. Dan juga ada tidaknya fasilitas untuk para penyandang disabilitas.

//7.	Spesifikasi struktur data yang wajib digunakan:
//	a.	Terdapat pengunaan tipe data bentukan/record
//	b.	Terdapat array untuk tipe data bentukan atau array didalam tipe bntukan
//	c.	Terdapat proses penyimpanan data kedalam file DAT (*.dat) atau TEXT (*.txt)
//
//8.	Fungsionalitas minimum (POIN PENILAIAN)
//	a.	Terdapat menu untuk yang mengelola data aplikasi. Ada insert, delete, edit/update and View dari
//		data yang ada di dalam aplikasi.
//	b.	Data menyesuaikan topiknya yang telah ditentukan. Data disimpan kedalam file ekstensi *.DAT,
//		kemudian file tersebut di load lagi ketika akan digunakan.
//	(Hint: https://www.tutorialspoint.com/pascal/pascal_files_handling.htm ).
//	c.	Terdapat menu searching data yang akan ditampilkan terhadap suatu kategori (terdapat pilihan
//		kategori, minimal 2 kategori, pencarian maximum dan minimum di anggap 1 kategori). Misalnya dosen
//		mencari mahasiswa yang memiliki kategori jumlah kehadirannya paling sedikit.
//	d.	Terdapat menu lihat data yang sudah terurut berdasarkan suatu kategori (terdapat pilihan kategori,
//		minimal 3 kategori, masing-masing menggunakan bubble sort, selection dan insertion sort).
//		Misalnya data pasien yang ingin ditampilkan oleh admin terurut berdasarkan kategori tanggal.
//	e.	Penggunaan Error Handing karena kesalahan input adalah OPSIONAL.

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
var
	id,i,j: Integer;
	f: file of wisata;
	fAkun : file of akun;
	arWisata: array [1..Max] of wisata;
	arAkun: array [1..Max] of akun;
	jumlahdata,jumlahakun:longint;
	pilih : Byte;

//==================== PROCEDURE DAN FUNCTION yang dibutuhkan ====================\\

function getpass(): string;
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
begin
	assign(fAkun,'Akun.dat');
	rewrite(fAkun);
	for i:= 1 to jumlahakun do
		begin
			write(fAkun,arAkun[i]);
		end;
	close(fAkun);
end;
procedure load;
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
procedure save;
begin
	assign(f,'wisata.dat');
	rewrite(f);
	for i:= 1 to jumlahdata do
		begin
			write(f,arWisata[i]);
		end;
	close(f);
end;
//==================== User Menu dan teman teman nya ====================\\
procedure cekUser(uname,pass:string; var valid : boolean);
var
	i:longint;
	cek:boolean;
begin
	cek:=false;
	for i:=1 to jumlahakun do
		begin
		 	if (arAkun[i].uname = uname) and (arAkun[i].pass = pass) then
		 		cek:=true;
		 end; 
	valid := cek;
end;
procedure menuUser();
begin
	clrscr;
	writeln('1. Lihat Semua Wisata');
	writeln('2. Cari Tempat wisata');
	writeln('3.	Urutkan Berdasarkan');
	writeln('4. History Booking Wisata');
	readln;
end;

procedure welcomeUser();
var
	uname,pass: string;
	pilihan:integer;
	valid:boolean;
begin
	loadAkun;
	repeat
	clrscr;
	writeln('1. Login ');
	writeln('2. Register ');
	writeln;
	write('pilih : ');readln(pilihan);
	until (pilihan = 1 ) or (pilihan = 2);
	if pilihan = 1 then
		begin
			clrscr;
			writeln('==Login==');
			write('Username : '); readln(uname);
			write('Password : '); pass:=getpass;
			cekUser(uname,pass,valid);
			if valid then
				menuUser()
			else
				writeln('username atau password yang anda masukkan salah ');
				write('press any key to continue..'); readkey;
		end
	else
		begin
			clrscr;
			inc(jumlahakun);
			writeln('==Daftar==');
			write('Nama Lengkap : '); readln(arAkun[jumlahakun].nama);
			write('Username : '); readln(arAkun[jumlahakun].uname);
			write('Password : '); readln(arAkun[jumlahakun].pass);
			saveAkun;
			writeln('done');
			write('press anykey to continue.. '); readkey;
		end;
end;
//==================== Admin Menu dan teman teman nya ====================\\
procedure cek(idx:integer);
begin
	writeln('data yang ini?');
	writeln;
		writeln('indeks #',idx);
				writeln('Nama Tempat Wisata : ', arWisata[idx].nama);
				writeln('Indoor / Outdoor : ', arWisata[idx].inout);
				writeln('individu / Family Friendly : ', arWisata[idx].indFam);
				writeln('Harga Weekday [Senin-Jumat] (per orang) : ', arWisata[idx].harga.weekday);
				writeln('Harga Weekend [Sabtu-Minggu] (per orang) : ', arWisata[idx].harga.weekend);
				writeln('Jam Operasional : ', arWisata[idx].jam.buka,'-', arWisata[idx].jam.tutup);
				write('fasilitas : '); j:=1;
					while arWisata[idx].fasilitas[j] <> '' do
						begin
							write(arWisata[idx].fasilitas[j],', ');
							inc(j);
						end;
				writeln;
				writeln('Deskripsi : ', arWisata[idx].deskripsi);
				writeln;
end;

procedure insertData(x:integer);
	var
		pilihadmin:char; tmp:integer;
begin
	repeat
		clrscr;
		write('Nama Tempat Wisata : '); readln(arWisata[x].nama);
		write('Alamat tempat wisata : '); readln(arWisata[x].lokasi);

		repeat
			write('1. Indoor / 2. Outdoor // Pilih angka  : '); readln(tmp);
		until (tmp = 1 ) or (tmp=2);
		if tmp = 1 then
			arWisata[x].inout:='Indoor'
		else
			arWisata[x].inout:='Outdoor';

		repeat
		write('1. Individu / 2. Family Friendly : '); readln(tmp);
		until (tmp = 1 ) or (tmp=2);
		if tmp = 1 then
			arWisata[x].indFam:='Individu'
		else
			arWisata[x].indFam:='Family Friendly';
		write('Harga Weekday [Senin-Jumat] (per orang) : '); readln(arWisata[x].harga.weekday);
		write('Harga Weekend [Sabtu-Minggu] (per orang) : '); readln(arWisata[x].harga.weekend);
		write('Jam Buka Operasional [jam.menit] : '); readln(arWisata[x].jam.buka);
		write('Jam Tutup Operasional [jam.menit] : '); readln(arWisata[x].jam.tutup);
		writeln('fasilitas : ');
			repeat
				inc(j);
				write(j,' : '); readln(arWisata[x].fasilitas[j]);
			until (arWisata[x].fasilitas[j]='');
		write(' Deskripsi : '); readln(arWisata[x].deskripsi);
		writeln;
		write('Ingin nambah data wisata lagi? [Y/T] : '); readln(pilihadmin);
		if pilihadmin = 'y' then
			inc(jumlahdata);
	until (lowercase(pilihadmin)='t');
end;

procedure editData();
	var
		idx: Integer;
		pilih:char;
begin
	writeln;
		write('masukkan nomor indeks yang ingin di edit : '); readln(idx);
	clrscr;
	cek(idx);
	write('pilih [y/t] : '); readln(pilih);
	if lowercase(pilih) = 'y' then
		begin
			insertData(idx);
		end;
end;

procedure deleteData();
var
	pilih: char;
	idx:byte;
//mencari datanya
begin
	write('masukkan nomor indeks tempat wisata : '); readln(idx);
	clrscr;
	cek(idx);
	write('pilih : [y/t] : '); readln(pilih);
	if pilih = 'y'then
	begin
		//hapus datanya
		for i:= idx to jumlahdata do
			begin
				arWisata[i]:=arWisata[i+1]
			end;
		dec(jumlahdata);
	end;
end;


procedure viewData();
	var
		tmp,flag: Integer;
begin
	clrscr;
	flag:=1; i:=1;
	while i<=jumlahdata do
		begin
			if flag <= 2 then
				begin
					inc(flag);
					writeln('indeks #',i);
					writeln('Nama Tempat Wisata : ', arWisata[i].nama);
					writeln('Alamat tempat wisata : ',arWisata[i].lokasi);
					writeln('Indoor / Outdoor : ', arWisata[i].inout);
					writeln('individu / Family Friendly : ', arWisata[i].indFam);
					writeln('Harga Weekday [Senin-Jumat] (per orang) : ', arWisata[i].harga.weekday);
					writeln('Harga Weekend [Sabtu-Minggu] (per orang) : ', arWisata[i].harga.weekend);
					writeln('Jam Operasional : ', arWisata[i].jam.buka,'-',arWisata[i].jam.tutup);
					write('fasilitas : '); j:=1;
						while arWisata[i].fasilitas[j] <> '' do
						begin
							write(arWisata[i].fasilitas[j],', ');
							inc(j);
						end;
					writeln;
					write('Deskripsi : ', arWisata[i].deskripsi);
					writeln;
					writeln;
					inc(i);
				end
			else
				begin
					flag:=1;
					write('press any key to continue.. '); readln;
					clrscr;
				end;
		end;
		writeln;
	write('[1.Insert 2.Edit 3.Delete 4.Back] : '); readln(tmp);
		case tmp of
			1 : begin inc(jumlahdata); insertData(jumlahdata); end;
			2 : begin editData; end;
			3 : begin deleteData; end;
		end;
end;

procedure menuAdmin();
begin
	jumlahdata:=0;
	load;
	repeat
	clrscr;
	writeln('Login >> Admin Menu');
	writeln;
	writeln('== Admin Menu ==');
	writeln('1. Insert Data');
	writeln('2. Edit Data');
	writeln('3. Delete Data');
	writeln('4. View Data');
	writeln('5. Back');
	writeln('jumlah data : ',jumlahdata);
	writeln;
	write(' Pilih : '); readln(pilih);
	case pilih of
		1 : begin inc(jumlahdata); insertData(jumlahdata); end;
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
	writeln('==Login Admin==');
	write(' Username : '); readln(uname);
	write(' Password  : '); pass:=getpass;
	until ((uname = 'admin') and (pass = 'admin')) or ((uname = '') and (pass = ''));
	if ((uname = 'admin') and (pass = 'admin')) then
		menuAdmin();
end;
//==================== PROGRAM UTAMA ====================\\
begin
	clrscr;
	Assign(f, 'wisata.dat') ;
    {$I-} Reset(f) ;
    {$I+} if IOResult<>0 then Rewrite(f) ;
    close(f);
    Assign(fAkun, 'akun.dat') ;
    {$I-} Reset(fAkun) ;
    {$I+} if IOResult<>0 then Rewrite(fAkun) ;
    close(fAkun);

	repeat
	clrscr;
	writeln('-------------------------------------------------');
	writeln('========== Selamat Datang di JaJalKuy! ==========');
	writeln('-------------------------------------------------');
	writeln(' Main Menu ');
	writeln('1.User');
	writeln('2.Admin ');
	writeln('3.Log Out');
	writeln;
	write('Pilih : '); readln(id);
	case id of
		1: welcomeUser();
		2: welcomeAdmin();
	end;
	until (id=3);
	clrscr;
end.
