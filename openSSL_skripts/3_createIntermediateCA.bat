@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate
SET _INTERCONFIG=openssl_inter.cfg

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):

if exist %_BASISPFAD%\%_INTER%\%_INTERCONFIG% (
    echo OK!
	cd %_BASISPFAD%
	
	echo #### Erstellen einer Intermediate-CA  #### 
	::  Kennwort: HSP2InterCA
	openssl genrsa -aes256 -out %_INTER%\private\intermediate.key.pem 4096
	::  CSR erzeugen
	openssl req -config %_INTER%\%_INTERCONFIG% -new -sha256  -key %_INTER%\private\intermediate.key.pem  -out %_INTER%\csr\intermediate.csr.pem
	::  CSR von Root CA signieren lassen
	openssl ca -config openssl.cfg -extensions v3_intermediate_ca -days 3650 -notext -md sha256  -in %_INTER%\csr\intermediate.csr.pem  -out %_INTER%\certs\intermediate.cert.pem


	::  Erstellen einer Chain Of Trust :: 
	echo #### Erstellen einer Chain Of Trust ####
	type %_INTER%\certs\intermediate.cert.pem certs\ca.cert.pem > %_INTER%\certs\ca-chain.cert.pem
	
	echo Erfolg!	
	
) else (
    echo NOTOK!
)

:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%

pause


