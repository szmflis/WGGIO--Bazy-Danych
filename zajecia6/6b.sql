
-- a)
-- update dla tabeli pracownikow
-- kolumna telefon - varchar(15) - nie pomiesci dodatkowego
-- numeru kontaktowego
ALTER TABLE firma.ksiegowosc.pracownicy
ADD COLUMN telefon_pol VARCHAR;

-- zapytanie odnosnie zadania
UPDATE firma.ksiegowosc.pracownicy
SET telefon_pol = concat('(+48)', telefon)
WHERE telefon IS NOT NULL;

-- b)
UPDATE firma.ksiegowosc.pracownicy
SET telefon = concat(
        substring(telefon from 1 for 3),
        '-',
        substring(telefon from 5 for 3),
        '-',
        substring(telefon from 9 for 3)
    )
WHERE telefon IS NOT NULL;


-- c)
SELECT (id_pracownika, upper(imie), upper(nazwisko), telefon)
FROM firma.ksiegowosc.pracownicy
ORDER BY length(nazwisko) DESC LIMIT 1;

-- d)
SELECT pracownicy.id_pracownika, imie, nazwisko, md5(cast(kwota_netto as varchar))
FROM firma.ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji;

-- e)
SELECT imie, nazwisko, kwota_netto as pensja, kwota as premia
FROM ksiegowosc.pracownicy
LEFT JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.pensje on ksiegowosc.pensje.id_pensji = wynagrodzenie.id_pensji
LEFT JOIN ksiegowosc.premie ON ksiegowosc.premie.id_premii = ksiegowosc.pensje.id_premii;

-- g)

-- nadgodziny - nie umiałem ująć nadgodzin
-- we własciwym zapytaniu, wiec dodaje ją do tablicy godzin
ALTER TABLE ksiegowosc.godziny
ADD COLUMN nadgodziny INTEGER;

UPDATE  ksiegowosc.godziny
SET nadgodziny = liczba_godzin - 160
WHERE liczba_godzin > 160;

SELECT ksiegowosc.pracownicy.id_pracownika,
       concat(
           'Pracownik ', imie, ' ', nazwisko,
           ' w dniu ', w.data, ' otrzymał pensję całkowitą na kwotę ',
           p.kwota_netto + p2.kwota, ' zł, gdzie wynagrodzenie zasadnicze wyniosło: ',
           p.kwota_netto, ' zł, premia: ', p2.kwota, ' zł, nadgodziny: ', g.nadgodziny, ' zł'
           )
FROM ksiegowosc.pracownicy
LEFT JOIN ksiegowosc.wynagrodzenie w on pracownicy.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensje p ON w.id_pensji = p.id_pensji
LEFT JOIN ksiegowosc.premie p2 ON w.id_premii = p2.id_premii
LEFT JOIN ksiegowosc.godziny g on pracownicy.id_pracownika = g.id_pracownika;
