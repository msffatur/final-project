function [a,b,c,d,e,f] = PickName(x)

if x == 1
    a = 'Profil Kecepatan (Beban Kosong)';
    b = 'Profil Kecepatan Akhir (Beban Kosong)';
    c = 'Profil Jarak (Beban Kosong)';
    d = 'Profil Jarak Akhir (Beban Kosong)';
    e = 'Profil Masukan Kontrol (Beban Kosong)';
    f = 'Profil Percepatan (Beban Kosong)';
elseif x == 2
    a = 'Profil Kecepatan (Beban Seperempat Penuh)';
    b = 'Profil Kecepatan Akhir (Beban Seperempat Penuh)';
    c = 'Profil Jarak (Beban Seperempat Penuh)';
    d = 'Profil Jarak Akhir (Beban Seperempat Penuh)';
    e = 'Profil Masukan Kontrol (Beban Seperempat Penuh)';
    f = 'Profil Percepatan (Beban Seperempat Penuh)';
elseif x == 3
    a = 'Profil Kecepatan (Beban Setengah Penuh)';
    b = 'Profil Kecepatan Akhir (Beban Setengah Penuh)';
    c = 'Profil Jarak (Beban Setengah Penuh)';
    d = 'Profil Jarak Akhir (Beban Setengah Penuh)';
    e = 'Profil Masukan Kontrol (Beban Setengah Penuh)';
    f = 'Profil Percepatan (Beban Setengah Penuh)';
elseif x == 4
    a = 'Profil Kecepatan (Beban Tiga Perempat Penuh)';
    b = 'Profil Kecepatan Akhir (Beban Tiga Perempat Penuh)';
    c = 'Profil Jarak (Beban Tiga Perempat Penuh)';
    d = 'Profil Jarak Akhir (Beban Tiga Perempat Penuh)';
    e = 'Profil Masukan Kontrol (Beban Tiga Perempat Penuh)';
    f = 'Profil Percepatan (Beban Tiga Perempat Penuh)';
else
    a = 'Profil Kecepatan (Beban Penuh)';
    b = 'Profil Kecepatan Akhir (Beban Penuh)';
    c = 'Profil Jarak (Beban Penuh)';
    d = 'Profil Jarak Akhir (Beban Penuh)';
    e = 'Profil Masukan Kontrol (Beban Penuh)';
    f = 'Profil Percepatan (Beban Penuh)';
end

end