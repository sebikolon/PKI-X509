@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate
SET _INTERCONFIG=openssl_inter.cfg

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):
SET /P _CERTNAME= Geben Sie den Namen des neuen Zertifikats an (Z.B. server):

::  Erstellen eines Server-Zertifikats :: 
echo #### Erstellen eines Server-Zertifikats ####
cd %_BASISPFAD%

:: Workaround: Erstellen einer index.txt.attr-Datei
echo unique_subject = yes/no > %_INTER%\index.txt.attr

:: Erstellen eines Schlüsselpaars
openssl genrsa  -out %_INTER%\private\%_CERTNAME%.key.pem 2048
:: Erstellen einer CSR
openssl req -config %_INTER%\%_INTERCONFIG%  -key %_INTER%\private\%_CERTNAME%.key.pem  -new -sha256 -out %_INTER%\csr\%_CERTNAME%.csr.pem
:: Ausstellen eines Zertifikats auf Basis der CSR
openssl ca -config %_INTER%\%_INTERCONFIG%  -extensions server_cert -days 375 -notext -md sha256  -in %_INTER%\csr\%_CERTNAME%.csr.pem  -out %_INTER%\certs\%_CERTNAME%.cert.pem

::  Erzeugen einer CRL :: 
if exist %_INTER%\crlnumber (
    echo NOTHING TO DO.
) else (
	echo #### Erzeugen einer CRL ####
    echo 1000 > %_INTER%\crlnumber
	openssl ca -config %_INTER%\%_INTERCONFIG%  -gencrl -out %_INTER%\crl\intermediate.crl.pem
)

:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%

echo Erfolg!

pause
