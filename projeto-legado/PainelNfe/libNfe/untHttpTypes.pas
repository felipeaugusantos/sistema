unit untHttpTypes;

interface

const
  cnstOpen = '0';                         //Manter igual em libNefe.dll, NFeImpressao.exe, api.rest.dll
  cnstHttp = '1';                         //Manter igual em libNefe.dll, NFeImpressao.exe, api.rest.dll
  cnstOpAp = '2';                         //Manter igual em libNefe.dll, NFeImpressao.exe, api.rest.dll
  cnstArqModEnvSoap =  '.\modo_soap.txt'; //Manter igual em libNefe.dll, NFeImpressao.exe, api.rest.dll

type
  TordHTTPSecureProtocol = (SPDefault, SSL2, SSL3, TLS1, TLS11, TLS12);                       //Manter igual em libNefe.dll, NFeImpressao.exe, api.rest.dll
  TmodeEnvSoap = (modeOpen, modeHttp, modeOpAp, modeNull{deixar modeNull por último sempre}); //Manter igual em libNefe.dll, NFeImpressao.exe, api.rest.dll

implementation

end.
