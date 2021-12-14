# rheinische-post-pdf-downloader
Shell-Script zum Herunterladen der Tagesausgabe der Rheinischen Post als PDF (ePaper).

Als Kunde der Rheinischen Post mit Zugang zum ePaper kann man die aktuelle Zeitung in digitaler Form in der App oder auf der Internetseite lesen.
Darüber hinaus besteht auch die Möglichkeit die gesamte Ausgabe als PDF herunterzuladen, was nützlich sein kann um zum Beispiel die Zeitung auf beliebigen Endgeräten lesen zu können.

Um den Prozess des legalen Herunterladens dieses PDFs zu vereinfachen, habe ich dieses Script geschrieben.

### Aufruf
`
./getPDF.sh <ausgabe> <email> <password>
`
### Beispiel
`
./getPDF.sh rheinische-post-goch max@mustermann.de VqMaGjGUys@kk8D3cVLmEMzy9Bt6vQM4q2chLLtN3UETfhsbtRCj3PZf
`

## Was macht das Script?
- Initialer Aufruf von https://epaper.rp-online.de
- Ablage von benötigten Cookies und merken eines [CSRF-Tokens](https://en.wikipedia.org/wiki/Cross-site_request_forgery)
- Einloggen auf https://epaper.rp-online.de 
- Ermittlung der Id der aktuellen Ausgabe
- Download des PDF
- Ausloggen

## Requirements
- gültiges digial Abo und Logindaten
- bash
- curl
- grep
- head
- sed
