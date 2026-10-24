unit untCobrancaEletronica;

interface

uses
  System.Classes, System.SysUtils;

type
  TCobrancaEletronica = class
  private
    FAutoincrem : String;
    FstrLnkPag  : String;
    FstrEspDoc  : String;
    FstrUrlReq  : String;
    FdtaDtaRet  : TDateTime;
    FstrResRet  : String;
    FstrNumDoc  : String;
    FstrCodEmp  : String;
    FstrJsoEnv  : String;
    FdtaDtaEnv  : TDateTime;
    FintStaCod  : Integer;
    FstrCodCli  : String;
    FstrMetEnv  : String;
    FfltTotGer  : Double;
    FstrApiCob  : String;
    FstrCodCob  : String;
    FstrRotina: String;
  public
    property Autoincrem : String    read FAutoincrem;
    property strCodEmp  : String    read FstrCodEmp;
    property strNumDoc  : String    read FstrNumDoc  write FstrNumDoc;
    property strEspDoc  : String    read FstrEspDoc  write FstrEspDoc;
    property dtaDtaEnv  : TDateTime read FdtaDtaEnv  write FdtaDtaEnv;
    property strJsoEnv  : String    read FstrJsoEnv  write FstrJsoEnv;
    property strResRet  : String    read FstrResRet  write FstrResRet;
    property dtaDtaRet  : TDateTime read FdtaDtaRet  write FdtaDtaRet;
    property strUrlReq  : String    read FstrUrlReq  write FstrUrlReq;
    property strLnkPag  : String    read FstrLnkPag  write FstrLnkPag;
    property intStaCod  : Integer   read FintStaCod  write FintStaCod;
    property strCodCli  : String    read FstrCodCli  write FstrCodCli;
    property strMetEnv  : String    read FstrMetEnv  write FstrMetEnv;
    property fltTotGer  : Double    read FfltTotGer  write FfltTotGer;
    property strApiCob  : String    read FstrApiCob  write FstrApiCob;
    property strCodCob  : String    read FstrCodCob  write FstrCodCob;
    property strRotina  : String    read FstrRotina  write FstrRotina;

    procedure pGravar;
  end;

implementation

uses
  Uni, untFuncoesSimples;

{ TCobrancaEletronica }

procedure TCobrancaEletronica.pGravar;
var
  qryDados: TUniQuery;
begin
  try
    qryDados := fCriaQuery(nil);
    try
      qryDados.Close;
      qryDados.SQL.Text := 'select * from COBELT '
                         + ' where FALSE ';
      qryDados.Open;

      qryDados.Append;
      qryDados.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('COBELT', VS_strCodEmp);;
      qryDados.FieldByName('CBE_CODEMP').AsString   := VS_strCodEmp;
      qryDados.FieldByName('CBE_CODCLI').AsString   := FstrCodCli;
      qryDados.FieldByName('CBE_NUMDOC').AsString   := FstrNumDoc;
      qryDados.FieldByName('CBE_ESPDOC').AsString   := FstrEspDoc;
      qryDados.FieldByName('CBE_JSOENV').AsString   := FstrJsoEnv;
      qryDados.FieldByName('CBE_DTAENV').AsDateTime := FdtaDtaEnv;
      qryDados.FieldByName('CBE_URLREQ').AsString   := FstrUrlReq;
      qryDados.FieldByName('CBE_DTARET').AsDateTime := FdtaDtaRet;
      qryDados.FieldByName('CBE_RESRET').AsString   := FstrResRet;
      qryDados.FieldByName('CBE_LNKPAG').AsString   := FstrLnkPag;
      qryDados.FieldByName('CBE_STACOD').AsInteger  := FintStaCod;
      qryDados.FieldByName('CBE_METENV').AsString   := FstrMetEnv;
      qryDados.FieldByName('CBE_TOTGER').AsFloat    := FfltTotGer;
      qryDados.FieldByName('CBE_APICOB').AsString   := FstrApiCob;
      qryDados.FieldByName('CBE_CODCOB').AsString   := FstrCodCob;
      qryDados.FieldByName('CBE_ROTINA').AsString   := FstrRotina;
      qryDados.Post;
    finally
      FreeAndNil(qryDados);
    end;
  except
    raise;
  end;
end;

end.
