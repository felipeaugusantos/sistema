unit untRennerImobiliaria;

interface

uses SysUtils, Forms, Uni, Classes, untFuncoesSimples;

  function fConsultaRennerImob(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaRennerImobGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaRennerImobVenda(Sender: TForm; strCodEmp: String;
    qryCadREI: TUniQuery): String; stdcall;

  function fRetornaPrecoRennerImob(Sender: TForm; qryCadRei: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProRennerImob(qryCadRei: TUniQuery; strIteTin: String): Double;

  function fRetornaDescricaoRennerImob(qryCadRei: TUniQuery; strDesCor: String): String;

  procedure pRetornaDadosRennerImobiliaria(strIteTin: String; dicRetorno: TDicionario);


implementation

uses Data.DB,
   untFuncEspecificas,untIConfTinta,
   untTintaMaquina, untTypesSistema, untConsultas;

function fConsultaRennerImob(Sender: TForm; strCodEmp: String): String;
begin
  Result := fConsultaRennerImobVenda(Sender, strCodEmp, nil);
end;

function fConsultaRennerImobGeral(Sender: TForm; strCodEmp: String): String;
begin
  Result := fConsultaRennerImobVenda(Sender, strCodEmp, Nil);
end;

function fConsultaRennerImobVenda(Sender: TForm; strCodEmp: String;
  qryCadREI: TUniQuery): String;
  Var
    arrSel: TConsultasArray;
    Key: Char;
    qryConsulta: TUniQuery;
begin
  Key := '/';
  Result := '-1';
  iF Assigned(qryCadRei) Then
     qryConsulta := qryCadRei
  Else
    qryConsulta := fCriaQuery;
  Try
     If  fPesqCadastroTintas(Sender, conRei, qryConsulta, Key, arrSel) Then
       Result := qryConsulta.FieldByName('AUTOINCREM').AsString;
  Finally
    If Not Assigned(qryCadRei) Then
      FreeAndNil(qryConsulta);
  End

end;

function fRetornaPrecoRennerImob(Sender: TForm; qryCadRei: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
  Var

    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    strIteTin: String;
    blnUsaPreCus: Boolean;

    {*******************************************}
    {* VARIÁVEIS INTERNAS                      *}
    {****************************************MV*}
    fltPreCus: Double;
    fltUnitar: Double;
    strCodIte: String;
    strDesCor: String;
    strTabPre: String;
    strChaFor: String;
begin

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
  If (fConsultaRennerImobVenda(Sender, strCodEmp, qryCadRei) = '-1') Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('RENNER -> DESCRIÇÃO DA COR', strDesCor);

  strIteTin := qryCadRei.FieldByName('REI_CODSEQ').AsString;
  //strCodIte := fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'PROREI', '');
  strCodIte := qryCadRei.FieldByName('REI_CODITE').AsString;

  strChaFor := qryCadRei.FieldByName('REI_DESCRI').AsString + ' ' +
               qryCadRei.FieldByName('REI_REFERE').AsString + ' ' +
               qryCadRei.FieldByName('REI_UNIDAD').AsString + ' ' +
               qryCadRei.FieldByName('REI_DESCOR').AsString;

  fltPreCus := qryCadRei.FieldByName('REI_PRECUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := qryCadRei.FieldByName('REI_PRECUS').AsFloat
  Else
    fltUnitar := qryCadRei.FieldByName('REI_PREVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := qryCadRei.FieldByName('REI_PREVEN').AsFloat;

  dicRetorno['unidad'] := qryCadRei.FieldByName('REI_UNIDAD').AsString;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;

  Result := True;


end;

function fRetornaUniTraProRennerImob(qryCadRei: TUniQuery; strIteTin: String): Double;
  Var
    strCampoTrava: String;
    fltFatTrava: Double;
    strSQL: String;
    conf: IConfTinta;
begin
  conf   := fGetConfTinta('REI');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  REI_CADREI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(REI_CODSEQ) = :ITETIN ';

  With qryCadRei Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strCampoTrava := 'REI_PRE' + conf.fGet('TRAREI'); //fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TRAREI', '');
  fltFatTrava   := conf.fGetDouble('FATREI'); //fStrToFloat(fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'FATREI', ''));

  Result := fFormataFloat(qryCadRei.FieldByName(strCampoTrava).AsFloat * fltFatTrava, 4);
end;

function fRetornaDescricaoRennerImob(qryCadRei: TUniQuery; strDesCor: String): String;
begin

  Result := qryCadRei.FieldByName('REI_DESCRI').AsString + ' ' +
            qryCadRei.FieldByName('REI_REFERE').AsString + ' ' +
            qryCadRei.FieldByName('REI_DESCOR').AsString + ' ' +
            strDesCor;

end;

procedure pRetornaDadosRennerImobiliaria(strIteTin: String; dicRetorno: TDicionario);
  Var
    strSQL: String;
    qryCadRei: TUniQuery;
begin
  qryCadRei := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  REI_CADREI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(REI_CODSEQ) = :ITETIN ';

  With qryCadRei Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('REI_CODBAS').AsString;
    Close;
  End;

  FreeAndNil(qryCadRei);
end;

end.
