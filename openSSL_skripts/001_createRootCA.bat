@ECHO OFF
SET _ORIGINDIR=%cd%
SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):

::SET /P CA_KEY_PASSWORD= Geben Sie ein Kennwort für das neue Schlüsselpaar an:

if exist %_BASISPFAD%\openssl.cfg (
    echo OK!
	
	cd %_BASISPFAD%
	::  Erstellen der Root-CA :: 
	echo #### Erstellen der Root-CA #### 
	openssl genrsa -aes256 -out private\ca.key.pem 4096
	
	openssl req -config openssl.cfg  -key private\ca.key.pem  -new -x509 -days 7300 -sha256 -extensions v3_ca  -out certs\ca.cert.pem 
	cd ..
	
) else (
    echo NOTOK!
)

:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%

echo Erfolg!

pause



