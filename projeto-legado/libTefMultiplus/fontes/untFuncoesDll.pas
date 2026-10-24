unit untFuncoesDll;

interface

uses untInterfacesMultiplus, System.Classes, System.SysUtils;

function fTefMultiplus(ACnpjCliente, ACnpParceiro, APathConector, AHost: String;
  APort: Integer; blnUsaRetornoCon: Boolean; blnTeste : Boolean; strNsuHost: string=''): ITefMultiplus; stdcall;
function fProcessaRetornoCon(APathArquivoRetCon: string): IRetornoTEF; stdcall;

implementation

uses untTTefMultiplus, untTProcessaRetornoTefTxt, untTRetornoTEF;

function fTefMultiplus(ACnpjCliente, ACnpParceiro, APathConector, AHost: String;
  APort: Integer; blnUsaRetornoCon: Boolean; blnTeste : Boolean; strNsuHost: string): ITefMultiplus; stdcall;
begin
  Result := TTefMultiplus.Create(ACnpjCliente, ACnpParceiro, APathConector, AHost,
    APort, blnUsaRetornoCon, blnTeste, strNsuHost);
end;

function fProcessaRetornoCon(APathArquivoRetCon: string): IRetornoTEF; stdcall;
  var
    objProcessaRetTxt: TProcessaRetornoTefTxt;
    stlArquivoRetCon: TStringList;
    strLinha: string;
begin
  Result := TRetornoTEF.Create;
  objProcessaRetTxt := TProcessaRetornoTefTxt.Create(Result);
  stlArquivoRetCon := TStringList.Create;
  try
    stlArquivoRetCon.LoadFromFile(APathArquivoRetCon);
    for strLinha in stlArquivoRetCon do
      objProcessaRetTxt.Processar(strLinha);
  finally
    FreeAndNil(objProcessaRetTxt);
    FreeAndNil(stlArquivoRetCon);
  end;
end;

end.
