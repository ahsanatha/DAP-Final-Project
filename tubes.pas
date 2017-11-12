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

	wisata = 	
		record
			Nama : String;
			inout : string;
			indFam : string;
			harga : hari;
			lokasi : string;
			deskripsi : string;
			harga : longint;
		end;
var
	id: Integer;
	f: file of wisata;
	arWisata: array of [1..10000] of wisata;
//==================== PROCEDURE DAN FUNCTION ====================\\
procedure menuUser();
begin
	writeln('1. Lihat Semua Wisata');
	
end;
//==================== Admin Menu dan teman teman ====================\\
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
begin
	repeat
		clrscr;
		write('Nama Tempat Wisata : '); readln(arWisata[i].nama);
		write('Indoor / Outdoor : '); readln(arWisata[i].inout);
		write('individu / Family Friedly : ') readln(arWisata[i].)
	until pilih='n';
end;
procedure menuAdmin();
begin
	buat;
	load;
	repeat
	writeln('Login >> Admin Menu');
	writeln('== Admin Menu ==');
	writeln('1. Insert Data');
	writeln('2. Edit Data');
	writeln('3. Delete Data');
	writeln('4. View Data');
	writeln('5. Back');
	writeln;
	write(' Pilih : '); readln(pilih);
	until (pilih >= 1) and (pilih <= 5);
	case pilih of
		1 : begin insertData(); end;
		2 : begin editData(); end;
		3 : begin deleteData(); end;
		4 : begin viewData(); end;
	end;


end;

//==================== PROGRAM UTAMA ====================\\
begin
	repeat
	clrscr;
	writeln(']]]]]]]]]] Selamat Datang di JaJalKuy! [[[[[[[[[[');
	write(' Login As : [1.User(not yet) 2.Admin] : '); readln(id);
	until ((id=1) or (id=2));
	if id = 1 then
		menuUser()
	else
		menuAdmin();

end.

