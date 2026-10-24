unit untVendasPerdidas;

interface

uses SysUtils, Classes, Uni,  Controls, untSaldoLojas;

type
  EMovVpg = class(Exception);

Procedure pIncluiMovVpg(strCodigo,
                        strCodCli,
                        strCodVen,
                        strCpfCon: String;
                        dtaDtaCad: TDate;
                        strNumDoc,
                        strEspDoc,
                        strSerie: String;
                        strOrigem: String = '');

Procedure pIncluiMovVpd(strCodigo,
                        strCodIte,
                        strDesIte,
                        strMotivo: String;
                        fltQtdIte,
                        fltUniOri,
                        fltUnitar,
                        fltTotIte: Double;
                        strObserv: String = '';
                        strCodCon: String = '';
                        fltVlrCon: Double = 0;
                        strNumCmp: String = '';
                        intNItCmp: Integer = 0;
                        dtaDtaCmp: TDateTime = 0);

 function fFaltaSaldoProjetoRepor(strCodIte: String): String;

implementation

uses untFuncoesSimples;

Procedure pIncluiMovVpg(strCodigo,
                        strCodCli,
                        strCodVen,
                        strCpfcon: String;
                        dtaDtaCad: TDate;
                        strNumDoc,
                        strEspDoc,
                        strSerie: String;
                        strOrigem: String = '');
  Var
    qryGen: TUniQuery;
Begin
  if fEmptyStr(strCodCli) then
    raise EMovVpg.Create('Código do Cliente não informado!');

  qryGen := fCriaQuery;
  With qryGen Do
  Begin

    SQL.Clear;
    SQL.Add('SELECT * FROM MOVVPG WHERE FALSE');
    Open;

    Insert;
    FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MOVVPG', VS_strCodEmp);
    FieldByName('VPG_CODEMP').AsString   := VS_strCodEmp;
    FieldByName('VPG_CODIGO').AsString   := strCodigo;
    FieldByName('VPG_CODCLI').AsString   := strCodCli;
    FieldByName('VPG_CODVEN').AsString   := strCodVen;
    FieldByName('VPG_DTACAD').AsDateTime := dtaDtaCad;
    FieldByName('VPG_DTAALT').AsDateTime := dtaDtaCad;
    FieldByName('VPG_CPFCON').AsString   := strCpfCon;

    FieldByName('VPG_NUMDOC').AsString   := strNumDoc;
    FieldByName('VPG_ESPDOC').AsString   := strEspDoc;
    FieldByName('VPG_SERIE_').AsString   := strSerie;

    If fEmptyStr(strCpfCon) Then
      FieldByName('VPG_CPFCON').Clear;

    If fEmptyStr(strOrigem) Then
      FieldByName('VPG_ORICOR').Clear
    Else
      FieldByName('VPG_ORICOR').AsString := strOrigem;

    Post;

  End;

  FreeAndNil(qryGen);
End;

Procedure pIncluiMovVpd(strCodigo,
                        strCodIte,
                        strDesIte,
                        strMotivo: String;
                        fltQtdIte,
                        fltUniOri,
                        fltUnitar,
                        fltTotIte: Double;
                        strObserv: String = '';
                        strCodCon: String = '';
                        fltVlrCon: Double = 0;
                        strNumCmp: String = '';
                        intNItCmp: Integer = 0;
                        dtaDtaCmp: TDateTime = 0);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen Do
  Begin

    SQL.Clear;
    SQL.Add('SELECT * FROM MOVVPD WHERE FALSE');
    Open;

    Insert;
    FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('MOVVPD', VS_strCodEmp);
    FieldByName('VPD_CODEMP').AsString  := VS_strCodEmp;
    FieldByName('VPD_CODIGO').AsString  := strCodigo;
    FieldByName('VPD_CODITE').AsString  := strCodIte;
    FieldByName('VPD_CODMOT').AsString  := strMotivo;
    FieldByName('VPD_DESITE').AsString  := strDesIte;
    FieldByName('VPD_QTDITE').AsFloat   := fltQtdIte;
    If fltUniOri > 0 Then
      FieldByName('VPD_UNIORI').AsFloat   := fltUniOri;
    If fltUnitar> 0 Then
      FieldByName('VPD_UNITAR').AsFloat   := fltUnitar;
    If fltTotIte > 0 Then
      FieldByName('VPD_TOTITE').AsFloat   := fltTotIte;
    FieldByName('VPD_OBSERV').AsString  := strObserv;
    FieldByName('VPD_CODCON').AsString  := strCodCon;
    FieldByName('VPD_VLRCON').AsFloat   := fltVlrCon;
    FieldByName('VPD_NUMCMP').AsString  := strNumCmp;
    FieldByName('VPD_NITCMP').AsInteger := intNItCmp;
    FieldByName('VPD_DTACMP').AsDateTime := dtaDtaCmp;
    FieldByName('VPD_RUPTUR').AsString := fFaltaSaldoProjetoRepor(strCodIte);
    Post;

  End;

  FreeAndNil(qryGen);
End;

function fFaltaSaldoProjetoRepor(strCodIte: String): String;
var
  fltSaldos: Double;
  fltSalMl: Double;
  fltCnvML: Double;
  blnEntFut: Boolean;
  blnOrdPro: Boolean;
  intCalSal: Integer;
  recSaldos: TRecSaldos;
  recSaldosML: TRecSaldos;
  objSalLoj : TSaldoLojas;
begin
  objSalLoj := TSaldoLojas.Create(Nil);

  try
    blnEntFut := fCfgSis('ENTFUT', varBoolean);
    blnOrdPro := fCfgSis('ORDPRO', varBoolean);
    intCalSal := fCfgSis('CALSAL', varInteger);

    fltSaldos := fCampoTabela('ITE_SALDOS', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
    fltSalMl := fCampoTabela('ITE_SAL_ML', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
    fltCnvML := fCampoTabela('ITE_CNV_ML', 'CADITE', ['ITE_CODITE'], [strCodIte]);

    If fltCnvML > 0 Then
      fltSaldos := fltSaldos + fltSalMl / fltCnvML;

    objSalLoj.pCalculaSaldos(Nil,
                             recSaldos,
                             recSaldosML,
                             fltSaldos,
                             VS_strCodEmp,
                             VS_strCodEmp,
                             strCodIte,
                             fltCnvML,
                             blnEntFut,
                             False,
                             blnOrdPro,
                             intCalSal);

    Result := IIF(recSaldos.fltSalDis > 0, 'N', 'S');
  finally
    FreeAndNil(objSalLoj);
  end;
end;

end.
