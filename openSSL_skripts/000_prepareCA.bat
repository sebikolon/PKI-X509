@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate
SET /P _BASISPFAD= Geben Sie das Basisverzeichnis an, in dem alle Dateien abgelegt werden sollen (Z.B. C:\test):


:: Anlegen der Verzeichnisse
mkdir %_BASISPFAD%
cd %_BASISPFAD%
mkdir certs crl newcerts private csr

type NUL > index.txt
echo 01 > serial

:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%

echo Erfolg! Kopieren Sie nun bitte die Datei 'openssl.cfg' in den Ordner '%_BASISPFAD%' und passen Sie die Pfade darin an!

pause