program filehandling;
uses crt;
type 
	mahasiswa = record
		nama : String;
		NIM  : string;
		umur : integer;
	end;
		
var
	rekam : mahasiswa;
	nama: array of string;
	f: text;
	i,pilih:integer;
	label 1;
	label 2;
procedure tambahData();
var
	x : integer;
begin
	clrscr;
	append(f);
	write('masukkan jumlah data yang ingin di tambah : '); readln(x);
	for i:= 1 to x do
		begin
			write('Nama Mahasiswa ',i,' : '); readln(nama[i]);
				writeln(f,nama[i]);
			writeln;
		end;

	close(f);
end;

procedure outputData();
begin
	clrscr;
	reset(f);
		while not eof(f) do
			begin
				readln(f,nama[i]);
				writeln('Nama Mahasiswa : ',nama[i]);
				writeln;
			end;
			close(f);
		readln;

end;
procedure inputData();
begin
	clrscr;
	writeln('Data Mahasiswa telyu');
	rewrite(f);
		for i:= 1 to 3 do
			begin
				write('Nama Mahasiswa ',i,' : '); readln(nama[i]);
				writeln(f,nama[i]);
				writeln;
			end;

	close(f);
end;

begin
	assign(f,'telyoo.txt');
	1: repeat
	clrscr;
	setlength(nama,5);
	writeln(' Menu : ');
	writeln('1. input data');
	writeln('2. output data');
	writeln('3. tambah data');
	writeln('4. keluar ');
	write('pilihan : '); readln(pilih);
	until (pilih>=1) and (pilih <=4);
	case pilih of
		1 : begin inputData(); end;
		2 : begin outputData(); end;
		3 : begin tambahData(); end;
		4 : begin goto 2; end;
	end;
	goto 1;
	2: clrscr;
	writeln(' bai bai ');

end.
