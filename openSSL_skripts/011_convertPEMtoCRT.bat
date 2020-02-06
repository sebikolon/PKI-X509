@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate
SET _INTERCONFIG=openssl_inter.cfg

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):
SET /P _CERTNAME= Geben Sie den Namen des zu konvertierenden Zertifikats an (Z.B. server):

::  Erstellen eines Server-Zertifikats :: 
echo #### Konvertieren des Zertifikats ####

openssl x509 -outform der -in %_BASISPFAD%\%_INTER%\certs\%_CERTNAME%.cert.pem -out %_BASISPFAD%\%_INTER%\certs\%_CERTNAME%.crt

:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%

echo Erfolg!

pause
