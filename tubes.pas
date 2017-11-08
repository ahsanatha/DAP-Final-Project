{Tempat wisata di Emerald city dikelola datanya menggunakan sebuah program.
Program tersebut mengelola data usaha wisata berdasarkan tipe wisata (outdoor, indoor), 
(individu, family friendly), harga tiket masuk sesuai dengan hari atau waktunya, dan menyediakan 
fasilitas umum seperti toilet, musholah, dan juga jenis makanan / sourvenir yang dijual ditempat 
pariwisata tersebut. Dan juga ada tidaknya fasilitas untuk para penyandang disabilitas.}

program JaJalKuy;
uses crt,sysutils;
type 

//==================== PROCEDURE DAN FUNCTION ====================\\

//==================== PROGRAM UTAMA ====================\\
begin
	writeln(']]]]]]]]]] Selamat Datang! [[[[[[[[[[');
	repeat
	write(' Login As : [1.User 2.Admin] : '); readln(id);
	until ((id=1) or (id=2));
	if id = 1 then
		menuUser()
	else
		menuAdmin();

end.

