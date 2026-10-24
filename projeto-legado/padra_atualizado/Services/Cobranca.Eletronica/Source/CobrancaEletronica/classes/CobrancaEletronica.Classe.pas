unit CobrancaEletronica.Classe;

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

    procedure pGravar;
  end;

implementation

uses
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Uni;


{ TCobrancaEletronica }

procedure TCobrancaEletronica.pGravar;
var
  LQryDados : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  try
    LQryDados := fCriaQuery;
    try
      LQryDados.Close;
      LQryDados.SQL.Text := 'SELECT * FROM COBELT '
                          + ' WHERE FALSE ';
      LQryDados.Open;

      LQryDados.Append;
      LQryDados.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('COBELT', VS_strCodEmp);;
      LQryDados.FieldByName('CBE_CODEMP').AsString   := VS_strCodEmp;
      LQryDados.FieldByName('CBE_CODCLI').AsString   := FstrCodCli;
      LQryDados.FieldByName('CBE_NUMDOC').AsString   := FstrNumDoc;
      LQryDados.FieldByName('CBE_ESPDOC').AsString   := FstrEspDoc;
      LQryDados.FieldByName('CBE_JSOENV').AsString   := FstrJsoEnv;
      LQryDados.FieldByName('CBE_DTAENV').AsDateTime := FdtaDtaEnv;
      LQryDados.FieldByName('CBE_URLREQ').AsString   := FstrUrlReq;
      LQryDados.FieldByName('CBE_DTARET').AsDateTime := FdtaDtaRet;
      LQryDados.FieldByName('CBE_RESRET').AsString   := FstrResRet;
      LQryDados.FieldByName('CBE_LNKPAG').AsString   := FstrLnkPag;
      LQryDados.FieldByName('CBE_STACOD').AsInteger  := FintStaCod;
      LQryDados.FieldByName('CBE_METENV').AsString   := FstrMetEnv;
      LQryDados.FieldByName('CBE_TOTGER').AsFloat    := FfltTotGer;
      LQryDados.FieldByName('CBE_APICOB').AsString   := FstrApiCob;
      LQryDados.FieldByName('CBE_CODCOB').AsString   := FstrCodCob;
      LQryDados.Post;
    finally
      {$IFNDEF LINUX} LQryDados.Free; {$ENDIF LINUX}
    end;
  except
    raise;
  end;
end;

end.
