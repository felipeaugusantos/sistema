unit untProdutosAcabados;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms,
  Dialogs,
  untFuncoesSimples,
  untConsultas,
{$ENDIF}
  SysUtils, Uni, Classes, untConstantes;

{$IFNDEF LINUX}
  function fRetornaPrecoProdAcabados(Sender: TForm; qryCadAca: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  function fConsultaProdAcabadosGeral(Sender: TForm; strCodEmp: String; btnConfirmaVisivel: Boolean = True): String; stdcall;
  function fConsultaProdAcabadosVenda(Sender: TForm; strCodEmp: String; qryCadAca: TUniQuery; strOpcDoc: String; opcConsulta: TOpcConsultaProdutoAcabado = ocaPadrao): String; stdcall;
{$ENDIF}
  function fRetornaPrecoProdAcabadoPorCodigo(strCodAca, strEmpAca: String; Var dicRetorno: TDicionario): Boolean; stdcall;

implementation

uses  DB, untTypesSistema;

{$IFNDEF LINUX}
function fRetornaPrecoProdAcabados(Sender: TForm; qryCadAca: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
var
  strCodEmp: String;
  fltUnitar: Double;
  fltPreCus: Double;
  strCodIte: String;
  strDesCor: String;
  strOpcDoc: String;
  blnUsaPreCus: Boolean;
  blnUsaPreMed: Boolean;
  opcConsulta: TOpcConsultaProdutoAcabado;
  fltPreMed: Double;
  fltPreUlt: Double;
  fltImpUlt: Double;
  intCont: Integer;
begin
  Result := False;
  strCodEmp := dicRetorno['codemp'];
  strOpcDoc := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  blnUsaPreMed := IfNull(dicRetorno['usapremed'], False);
  opcConsulta := IfNull(dicRetorno['opcConsulta'], ocaPadrao);

  If (fConsultaProdAcabadosVenda(Sender, strCodEmp, qryCadAca, strOpcDoc, opcConsulta) = '-1') Then
  Begin
    Exit;
  End;

  fltUnitar := qryCadAca.FieldByName('ACA_PREVE' + IfNull(dicRetorno['tabpre'], '1')).AsFloat;

  For intCont := 1 To Length(VS_strTabPrc) Do
    dicRetorno['preve' + IntToStr(intCont)] := qryCadAca.FieldByName('ACA_PREVE' + IntToStr(intCont)).AsFloat;

  If fltUnitar = 0 Then
    fltUnitar := qryCadAca.FieldByName('ACA_PREVEN').AsFloat;

  fltPreCus := qryCadAca.FieldByName('ACA_PRECUS').AsFloat;
  strCodIte := qryCadAca.FieldByName('ACA_CODITE').AsString;
  strDesCor := qryCadAca.FieldByName('ACA_DESCRI').AsString;

  fltPreMed := qryCadAca.FieldByName('ACA_PREMED').AsFloat;
  fltPreUlt := qryCadAca.FieldByName('ACA_PREULT').AsFloat;
  fltImpUlt := qryCadAca.FieldByName('ACA_IMPULT').AsFloat;

  If blnUsaPreCus Then
    fltUnitar := fltPreCus
  else if blnUsaPreMed then
    fltUnitar := fltPreMed;

  dicRetorno['outval'] := qryCadAca.FieldByName('ACA_OUTVAL').AsFloat;
  dicRetorno['icmsai'] := qryCadAca.FieldByName('ACA_ICMSAI').AsFloat;
  dicRetorno['impfed'] := qryCadAca.FieldByName('ACA_IMPFED').AsFloat;
  dicRetorno['desope'] := qryCadAca.FieldByName('ACA_DESOPE').AsFloat;

  dicRetorno['premed'] := fltPreMed;
  dicRetorno['impult'] := fltImpUlt;
  dicRetorno['preult'] := fltPreUlt;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prvtin'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prctin'] := qryCadAca.FieldByName('ACA_COMLIQ').AsFloat; //fltPreCus;
  dicRetorno['codaca'] := qryCadAca.FieldByName('ACA_CODACA').AsString;
  dicRetorno['empaca'] := qryCadAca.FieldByName('ACA_CODEMP').AsString;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['saldos'] := qryCadAca.FieldByName('ACA_SALDOS').AsFloat;
  dicRetorno['itetin'] := '';
  dicRetorno['chafor'] := '';

  Result := True;
end;
{$ENDIF}

function fRetornaPrecoProdAcabadoPorCodigo(strCodAca, strEmpAca: String;
  Var dicRetorno: TDicionario): Boolean;
var
  strSQL      : String;
  strCodEmp   : String;
  strCodIte   : String;
  strDesCor   : String;
  strOpcDoc   : String;
  fltUnitar   : Double;
  fltPreCus   : Double;
  intCont     : Integer;
  blnUsaPreCus: Boolean;
  qryCadAca   : TUniQuery;
  fltPreMed: Double;
  fltPreUlt: Double;
  fltImpUlt: Double;
begin
  Result := False;
  qryCadAca := nil;
  Try
    Try
      pAtuTabPrc;

      qryCadAca    := fCriaQuery(Nil);
      strCodEmp    := dicRetorno['codemp'];
      strOpcDoc    := dicRetorno['opcdoc'];
      blnUsaPreCus := dicRetorno['usaprecus'];

      strSQL := '';
      strSQL := strSQL + 'SELECT          ';
      strSQL := strSQL + '  A.ACA_CODACA, ';
      strSQL := strSQL + '  A.ACA_CODEMP, ';
      strSQL := strSQL + '  G.ACA_PREVEN, ';

      For intCont := 1 To Length(VS_strTabPrc) Do
        strSQL := strSQL + '	ACA_PREVE' + IntToStr(intCont) + ', ';

      strSQL := strSQL + '  G.ACA_PRECUS, ';
      strSQL := strSQL + '  G.ACA_SALDOS, ';
      strSQL := strSQL + '  G.ACA_PREMED, ';
      strSQL := strSQL + '  G.ACA_PREULT, ';
      strSQL := strSQL + '  G.ACA_IMPULT, ';

      strSQL := strSQL + '  G.ACA_OUTVAL, ';
      strSQL := strSQL + '  G.ACA_ICMSAI, ';
      strSQL := strSQL + '  G.ACA_IMPFED, ';
      strSQL := strSQL + '  G.ACA_DESOPE, ';
      strSQL := strSQL + '  G.ACA_COMLIQ, ';

      strSQL := strSQL + '  A.ACA_CODITE, ';
      strSQL := strSQL + '  A.ACA_DESCRI  ';
      strSQL := strSQL + 'FROM            ';
      strSQL := strSQL + '	CADACA A      ';
      strSQL := strSQL + '  JOIN ACAGER G ON G.ACA_CODACA = A.ACA_CODACA AND ';
      strSQL := strSQL + '                   G.ACA_CODEMP = A.ACA_CODEMP     ';
      strSQL := strSQL + 'WHERE           ';
      strSQL := strSQL + '	    G.ACA_EMPEST = :CODEMP ';
      strSQL := strSQL + '  AND A.ACA_CODACA = :CODACA ';
      strSQL := strSQL + '  AND A.ACA_CODEMP = :EMPACA ';

      With qryCadAca Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODACA').AsString := strCodAca;
        ParamByName('EMPACA').AsString := strEmpAca;
        Open;

        fltUnitar := FieldByName('ACA_PREVE' + IfNull(dicRetorno['tabpre'], '1')).AsFloat;

        If fltUnitar = 0 Then
          fltUnitar := FieldByName('ACA_PREVEN').AsFloat;

        fltPreCus := FieldByName('ACA_PRECUS').AsFloat;
        strCodIte := FieldByName('ACA_CODITE').AsString;
        strDesCor := FieldByName('ACA_DESCRI').AsString;

        fltPreMed := qryCadAca.FieldByName('ACA_PREMED').AsFloat;
        fltPreUlt := qryCadAca.FieldByName('ACA_PREULT').AsFloat;
        fltImpUlt := qryCadAca.FieldByName('ACA_IMPULT').AsFloat;


        If blnUsaPreCus Then
          fltUnitar := fltPreCus;

        dicRetorno['premed'] := fltPreMed;
        dicRetorno['impult'] := fltImpUlt;
        dicRetorno['preult'] := fltPreUlt;

        dicRetorno['outval'] := qryCadAca.FieldByName('ACA_OUTVAL').AsFloat;
        dicRetorno['icmsai'] := qryCadAca.FieldByName('ACA_ICMSAI').AsFloat;
        dicRetorno['impfed'] := qryCadAca.FieldByName('ACA_IMPFED').AsFloat;
        dicRetorno['desope'] := qryCadAca.FieldByName('ACA_DESOPE').AsFloat;

        dicRetorno['unitar'] := fltUnitar;
        dicRetorno['prvtin'] := fltUnitar;
        dicRetorno['precus'] := fltPreCus;
        dicRetorno['prctin'] := qryCadAca.FieldByName('ACA_COMLIQ').AsFloat; //fltPreCus;
        dicRetorno['codaca'] := qryCadAca.FieldByName('ACA_CODACA').AsString;
        dicRetorno['empaca'] := qryCadAca.FieldByName('ACA_CODEMP').AsString;
        dicRetorno['desaca'] := qryCadAca.FieldByName('ACA_DESCRI').AsString;
        dicRetorno['codite'] := strCodIte;
        dicRetorno['descor'] := strDesCor;
        dicRetorno['saldos'] := qryCadAca.FieldByName('ACA_SALDOS').AsFloat;
        dicRetorno['itetin'] := '';
        dicRetorno['chafor'] := '';
      End;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadAca) then FreeAndNil(qryCadAca);
  End;
end;

{$IFNDEF LINUX}
function fConsultaProdAcabadosGeral(Sender: TForm; strCodEmp: String; btnConfirmaVisivel: Boolean = True): String;
var
  qryConsulta: TUniQuery;
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  Result := '-1';
  qryConsulta := fCriaQuery(Nil);
  chrKey:= '/';
  Try
    Try
      if fPesqProdutosAcabados(Sender, qryConsulta, chrKey, arrSel, False, False, '', btnConfirmaVisivel) Then
      Begin
        If (Not qryConsulta.IsEmpty) Then
          Result := qryConsulta.FieldByName('AUTOINCREM').AsString;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function fConsultaProdAcabadosVenda(Sender: TForm; strCodEmp: String;
  qryCadAca: TUniQuery; strOpcDoc: String; opcConsulta: TOpcConsultaProdutoAcabado = ocaPadrao): String;
var
  chrKey: Char;
  arrSel: TConsultasArray;
  strSQL: String;
  intCont: Integer;
begin
  Result := '-1';

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;
  chrkey := '/';
  Try
    Try
      pAtuTabPrc;
      If fPesqProdutosAcabados(Sender, qryCadAca, chrKey, arrSel, IIf(opcConsulta = ocaComSaldo, True, False), False, strCodEmp) Then
        If (Not qryCadAca.IsEmpty) Then
          Result := qryCadAca.FieldByName('AUTOINCREM').AsString;

      If Result <> '-1' Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  A.ACA_CODACA, ';
        strSQL := strSQL + '  A.ACA_CODEMP, ';
        strSQL := strSQL + '  ACA_PREVEN, ';

        For intCont := 1 To Length(VS_strTabPrc) Do
        Begin
          strSQL := strSQL + '	ACA_PREVE' + IntToStr(intCont) + ', ';
        End;

        strSQL := strSQL + '  ACA_PRECUS, ';
        strSQL := strSQL + '  ACA_SALDOS, ';
        strSQL := strSQL + '  ACA_PREMED, ';
        strSQL := strSQL + '  ACA_PREULT, ';
        strSQL := strSQL + '  ACA_IMPULT, ';
        strSQL := strSQL + '  ACA_CODITE, ';

        strSQL := strSQL + '  ACA_OUTVAL, ';
        strSQL := strSQL + '  ACA_ICMSAI, ';
        strSQL := strSQL + '  ACA_IMPFED, ';
        strSQL := strSQL + '  ACA_DESOPE, ';
        strSQL := strSQL + '	ACA_COMLIQ, ';

        strSQL := strSQL + '  ACA_DESCRI ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '	CADACA A ';
        strSQL := strSQL + 'JOIN	ACAGER G ON G.ACA_CODACA = A.ACA_CODACA AND ';
        strSQL := strSQL + '                  G.ACA_CODEMP = A.ACA_CODEMP ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '	G.ACA_EMPEST = ' + QuotedStr(strCodEmp);
        strSQL := strSQL + '  AND A.AUTOINCREM = :AUTINC ';

        qryCadAca.Close;
        qryCadAca.SQL.Clear;
        qryCadAca.SQL.Add(strSQL);
        qryCadAca.ParamByName('AUTINC').AsString := Result;
        qryCadAca.Open;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;

end;
{$ENDIF}

end.
