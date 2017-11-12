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
type 
	hari = 
		record 
			weekday : string;
			weekend : string;
		end;
	loc = 
		record
			alamat : string;
			Kota : string;
			provinsi : string;
			negara : string;
			
		end;
	waktu =
		record
			Buka : Integer;
			tutup : Integer;
		end;

	wisata = 	
		record
			Nama : String;
			inout : string;
			indFam : string;
			harga : hari;
			lokasi : loc;
			deskripsi : string;
			jam : waktu ;
			fasilitas : array[1..100] of string;
		end;
var
	id,i,j: Integer;
	f: file of wisata;
	arWisata: array [1..1000] of wisata;
	jumlahdata:longint;
	pilih : Byte;
//==================== PROCEDURE DAN FUNCTION ====================\\
procedure menuUser();
begin
	writeln('1. Lihat Semua Wisata');
	
end;
//==================== Admin Menu dan teman teman ====================\\
function getWord1() : string;
var
  c : char;

begin
  getWord1 := '';
  read(c);
  while(c <> ' ') do 
  begin
    getWord1 := getWord1 + c;
    if(eoln) then 
    begin
      readln();
      break;
    end;
    read(c);
  end;
end;
function getWord() : string;
var
  c : char;
begin
  getWord := '';
  read(c);
  while(c <> ',') do 
  begin
    getWord := getWord + c;
    if(eoln) then 
    begin
      readln();
      break;
    end;
    read(c);
  end;
end;
procedure load;
begin
	assign(f,'wisata.dat');
	reset(f);
	while not eof(f) do
		begin
			inc(jumlahdata);
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
procedure insertData();
	var
		tmp,desk: string;
		pilihadmin:char;
begin
	repeat
		clrscr;
		inc(jumlahdata);
		write('Nama Tempat Wisata : '); readln(arWisata[jumlahdata].nama);
		write('Indoor / Outdoor : '); readln(arWisata[jumlahdata].inout);
		write('individu / Family Friendly : '); readln(arWisata[jumlahdata].indFam);
		write('Harga Weekday [Senin-Jumat] (per orang) : '); readln(arWisata[jumlahdata].harga.weekday);
		write('Harga Weekend [Sabtu-Minggu] (per orang) : '); readln(arWisata[jumlahdata].harga.weekend);
		write('Jam Buka Operasional : '); readln(arWisata[jumlahdata].jam.buka);
		write('Jam Tutup Operasional : '); readln(arWisata[jumlahdata].jam.tutup);
		write('fasilitas [pisahkan dengan koma, akhiri dengan #] : '); j:=1; tmp:=getWord;
		while tmp <> '#' do //masukin kata perkata sampai user menginput #
			begin
				arWisata[jumlahdata].fasilitas[j]:=tmp;
				tmp:=getWord;
				inc(j);
			end;
		write(' Deskripsi : '); desk:=''; tmp:=getWord1;
		while tmp <> '#' do //masukin kata perkata sampai user menginput #
			begin
				desk:=desk+' '+tmp;
				tmp:=getWord1;
			end;
		arWisata[i].deskripsi:=desk;
		writeln;
		write('Ingin nambah data wisata lagi? [Y/T]'); readln(pilihadmin);
	until (lowercase(pilihadmin)='t');
end;

procedure viewData();
	var
		tmp,flag: Integer;
begin
	clrscr;
	flag:=1;
	for i:= 1 to jumlahdata do 
		begin
			if flag <= 2 then
				begin
					inc(flag);
					writeln('#',i);
					writeln('Nama Tempat Wisata : ', arWisata[i].nama);
					writeln('Indoor / Outdoor : ', arWisata[i].inout);
					writeln('individu / Family Friendly : ', arWisata[i].indFam);
					writeln('Harga Weekday [Senin-Jumat] (per orang) : ', arWisata[i].harga.weekday);
					writeln('Harga Weekend [Sabtu-Minggu] (per orang) : ', arWisata[i].harga.weekend);
					writeln('Jam Operasional : ', arWisata[i].jam.buka,'-',arWisata[i].jam.tutup);
					write('fasilitas : '); j:=1;
						while arWisata[i].fasilitas[j] <> '' do
						begin
							write(arWisata[i].fasilitas[j],' ');
							inc(j);
						end;
					writeln;
					write('Deskripsi : ', arWisata[i].deskripsi);
					writeln;
					writeln;
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
			1 : begin insertData(); end;
			2 : begin {editData;} end;
			3 : begin {deleteData;} end;
		end;
end;

procedure menuAdmin();
begin
	jumlahdata:=0;
	load;
	repeat
	clrscr;
	writeln('Login >> Admin Menu');
	writeln('== Admin Menu ==');
	writeln('1. Insert Data');
	writeln('2. Edit Data');
	writeln('3. Delete Data');
	writeln('4. View Data');
	writeln('5. Back');
	writeln;
	write(' Pilih : '); readln(pilih);
	case pilih of
		1 : begin insertData(); end;
		2 : begin {editData();} end;
		3 : begin {deleteData();} end;
		4 : begin viewData(); end;
	end;
	until (pilih=5);
	save;
end;

//==================== PROGRAM UTAMA ====================\\
begin
	repeat
	clrscr;
	writeln('-------------------------------------------------');
	writeln('========== Selamat Datang di JaJalKuy! ==========');
	writeln('-------------------------------------------------');
	writeln(' Main Menu ');
	writeln('1.User(not yet)'); 
	writeln('2.Admin ');
	writeln('3.Log Out');
	writeln;
	write('Pilih : '); readln(id);
	case id of
		1: menuUser();
		2: menuAdmin();
	end;
	until (id=3);
	clrscr;
end.

