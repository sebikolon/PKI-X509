@ECHO OFF
SET _ORIGINDIR=%cd%

SET _INTER=intermediate
SET _INTERCONFIG=openssl_inter.cfg

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):

::  Erstellen einer Intermediate-CA ::
mkdir %_BASISPFAD%\%_INTER%
cd %_BASISPFAD%\%_INTER%

mkdir certs crl newcerts private csr
type NUL > index.txt
echo 01 > serial

:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%

echo Erfolg! Kopieren Sie nun bitte die Datei '%_INTERCONFIG%' in den Ordner '%_BASISPFAD%\%_INTER%' und passen Sie die Pfade darin an!

pause