@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate
SET _INTERCONFIG=openssl_inter.cfg

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):
SET /P _CERTNAME= Geben Sie den Namen des OCSP-Responder-Zertifikats an (Z.B. 'ocsp.gesundplus.de'):

::  Erstellen eines User-Zertifikats :: 
echo #### Erstellen eines OCSP-Zertifikats ####
cd %_BASISPFAD%

:: Erstellen eines Schlüsselpaars
openssl genrsa -aes256 -out %_INTER%/private/%_CERTNAME%.key.pem 4096

:: Erstellen einer CSR
openssl req -config %_INTER%/%_INTERCONFIG% -new -sha256      -key %_INTER%/private/%_CERTNAME%.key.pem  -out %_INTER%/csr/%_CERTNAME%.csr.pem
	  
:: Ausstellen eines Zertifikats auf Basis der CSR  
openssl ca -config %_INTER%/%_INTERCONFIG%       -extensions ocsp -days 375 -notext -md sha256       -in %_INTER%/csr/%_CERTNAME%.csr.pem       -out %_INTER%/certs/%_CERTNAME%.cert.pem
	  
:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%
echo Erfolg!
pause
