program filehandling;
uses crt,sysutils;
const
	max = 10000;
type 
	mahasiswa = record
		nama : String;
		NIM  : string;
		umur : integer;
	end;
		
var
	rekam : array[1..max] of mahasiswa;
	f: file of mahasiswa;
	i,pilih,jumlahdata:integer;
procedure deleteData;
var
	pilih: char;
	cari: string;
	ketemu:integer;
//mencari datanya
begin
	repeat
	clrscr;
	i:=0; ketemu :=0;
	write('masukkan nim yang dicari : '); readln(cari);
	while (ketemu=0)  do
	begin
		inc(i);
		if ((rekam[i].nim) = cari) then
			ketemu := i;
	end;
	writeln('data yang ini?');
		writeln('Nama : ',rekam[ketemu].nama);
		writeln('NIM : ',rekam[ketemu].nim);
		writeln('Umur : ',rekam[ketemu].umur);
	write('pilih : [y/n] : '); readln(pilih);
	until (pilih = 'y');
	//hapus datanya 
	for i:= ketemu to jumlahdata do
		begin
			rekam[i]:=rekam[i+1]
		end;
	dec(jumlahdata);
end;
	

procedure outputData;
begin
	clrscr;
		for i:= 1 to jumlahdata do 
			begin
				writeln('Nama Mahasiswa ',i,' : ',rekam[i].nama);
				writeln('NIM Mahasiswa ',i, ' : ',rekam[i].nim);
				writeln('umur Mahasiswa ',i, ' : ',rekam[i].umur);
				writeln;
				end;
		readln;
end;
procedure save;
begin
	assign(f,'Mahasiswa.dat');
	rewrite(f);
	for i:= 1 to jumlahdata do 
		write(f,rekam[i]);
	close(f);
end;
procedure load;
begin
	assign(f,'Mahasiswa.dat');
	reset(f);
	while not eof(f) do 
		begin
				inc(jumlahdata);
				read(f,rekam[jumlahdata]);
		end;
	close(f);
end;
procedure inputData;
	var
		pilih: char;
begin	
		repeat
			begin
				clrscr;
				inc(jumlahdata);
				write('Nama Mahasiswa ke ',jumlahdata,' : '); readln(rekam[jumlahdata].nama);
				write('NIM Mahasiswa ke ',jumlahdata, ' : '); readln(rekam[jumlahdata].nim);
				write('umur Mahasiswa ke ',jumlahdata, ' : '); readln(rekam[jumlahdata].umur);
				writeln;
				write('tambah data ? [y/n] : '); readln(pilih);
			end;
		until (lowercase(pilih)='n');
end;

begin
	jumlahdata:=0;
	load;
	repeat
		clrscr;
		writeln(' Menu : ');
		writeln('1. input data');
		writeln('2. output data');
		writeln('3. hapus data');
		writeln('4. keluar ');
		write('pilihan : '); readln(pilih);	
	case pilih of
		1 : begin inputData; end;
		2 : begin outputData; end;
		3 : begin deleteData; end;
	end;
		until (pilih=4);
	clrscr;
	writeln(' bai bai ');
	save;
end.
