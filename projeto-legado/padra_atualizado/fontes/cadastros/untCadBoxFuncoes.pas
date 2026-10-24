unit untCadBoxFuncoes;

interface

uses
  System.SysUtils, System.Math, Uni;

function fBoxExiste(ACodBox: String; ACodEmp: String = ''): Boolean;
function fBoxDisponivel(ACodBox: String; ACodEmp: String = ''): Boolean; Overload;
function fBoxDisponivel(ACodBox, ANumDoc, AEspDoc, AEmpDoc: String; ACodEmp: String = ''): Boolean; Overload;
function fGetBoxDisponiveis(ACodEmp: String = ''): TArray<String>;
function fGetBoxDisponivelAleatorio(ACodEmp: String = ''): String;
function fGetCodBox(ANumDoc, AEspDoc, AEmpDoc: String): String;
procedure pAtualizaDocBox(ACodBox, ANumDoc, AEspDoc, AEmpDoc: String; ACodEmp: String = '');
procedure pLimpaDocBox(ACodBox: String; ACodEmp: String = ''); Overload;
procedure pLimpaDocBox(ANumDoc, AEspDoc, AEmpDoc: String); Overload;
function fGetBoxItemPedido(ACodIte: String; AValidaQtdDisp: Boolean = False; ANumeroOnda: String = ''; ACodEmp: String = ''): TArray<String>;
procedure pImprimeEtiquetaBox(ANumDoc, AEspDoc, AEmpDoc, ACodCli: String);

implementation

uses
  untFuncoesSimples, untEditorFastImpressao, untTypesSistema, untCadBoxEti;

function fBoxExiste(ACodBox: String; ACodEmp: String = ''): Boolean;
begin
  If fEmptyStr(ACodEmp) Then
    ACodEmp := VS_strCodEmp;

  Result := Not fEmptyStr(fCampoTabela('BOX_CODIGO', 'CADBOX', ['BOX_CODIGO', 'BOX_CODEMP'], [ACodBox, ACodEmp]));
end;

function fBoxDisponivel(ACodBox: String; ACodEmp: String = ''): Boolean;
begin
  Result := fBoxDisponivel(ACodBox, '', '', '', ACodEmp);
end;

function fBoxDisponivel(ACodBox, ANumDoc, AEspDoc, AEmpDoc: String; ACodEmp: String = ''): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    If fEmptyStr(ACodEmp) Then
      ACodEmp := VS_strCodEmp;

    Result := False;

    qryAux.SQL.Add('SELECT CONCAT(BOX_NUMDOC, BOX_ESPDOC, BOX_EMPDOC) AS NUMDOC');
    qryAux.SQL.Add('FROM CADBOX');
    qryAux.SQL.Add('WHERE BOX_CODIGO = :CODIGO');
    qryAux.SQL.Add('  AND BOX_CODEMP = :CODEMP');

    qryAux.ParamByName('CODIGO').AsString := ACodBox;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit;

    Result := fEmptyStr(qryAux.FieldByName('NUMDOC').AsString);

    If Not Result Then
      If Not fEmptyStr(ANumDoc) Then
        Result := SameStr(qryAux.FieldByName('NUMDOC').AsString, Concat(ANumDoc, AEspDoc, AEmpDoc));
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fGetBoxDisponiveis(ACodEmp: String = ''): TArray<String>;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    If fEmptyStr(ACodEmp) Then
      ACodEmp := VS_strCodEmp;

    qryAux.SQL.Add('SELECT GROUP_CONCAT(BOX_CODIGO ORDER BY BOX_CODIGO) AS CODBOX');
    qryAux.SQL.Add('FROM CADBOX');
    qryAux.SQL.Add('WHERE BOX_CODEMP = :CODEMP');
    qryAux.SQL.Add('  AND BOX_NUMDOC IS NULL');

    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.Open;

    Result := qryAux.FieldByName('CODBOX').AsString.Split([',']);
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fGetBoxDisponivelAleatorio(ACodEmp: String = ''): String;
  Var
    arrBox: TArray<String>;
begin
  Result := EmptyStr;

  arrBox := fGetBoxDisponiveis(ACodEmp);

  If Length(arrBox) = 0 Then
    Exit;

  Result := arrBox[RandomRange(Low(arrBox), High(arrBox) +1)];
end;

function fGetCodBox(ANumDoc, AEspDoc, AEmpDoc: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('SELECT BOX_CODIGO');
    qryAux.SQL.Add('FROM CADBOX');
    qryAux.SQL.Add('WHERE BOX_NUMDOC = :NUMDOC');
    qryAux.SQL.Add('  AND BOX_ESPDOC = :ESPDOC');
    qryAux.SQL.Add('  AND BOX_EMPDOC = :EMPDOC');

    qryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAux.ParamByName('EMPDOC').AsString := AEmpDoc;
    qryAux.Open;

    Result := qryAux.FieldByName('BOX_CODIGO').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pAtualizaDocBox(ACodBox, ANumDoc, AEspDoc, AEmpDoc: String; ACodEmp: String = '');
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    If fEmptyStr(ACodEmp) Then
      ACodEmp := VS_strCodEmp;

    qryAux.SQL.Add('UPDATE CADBOX');
    qryAux.SQL.Add('SET BOX_NUMDOC = :NUMDOC');
    qryAux.SQL.Add('   ,BOX_ESPDOC = :ESPDOC');
    qryAux.SQL.Add('   ,BOX_EMPDOC = :EMPDOC');
    qryAux.SQL.Add('WHERE BOX_CODIGO = :CODIGO');
    qryAux.SQL.Add('  AND BOX_CODEMP = :CODEMP');

    qryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAux.ParamByName('EMPDOC').AsString := AEmpDoc;
    qryAux.ParamByName('CODIGO').AsString := ACodBox;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pLimpaDocBox(ACodBox: String; ACodEmp: String = '');
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    If fEmptyStr(ACodEmp) Then
      ACodEmp := VS_strCodEmp;

    qryAux.SQL.Add('UPDATE CADBOX');
    qryAux.SQL.Add('SET BOX_NUMDOC = NULL');
    qryAux.SQL.Add('   ,BOX_ESPDOC = NULL');
    qryAux.SQL.Add('   ,BOX_EMPDOC = NULL');
    qryAux.SQL.Add('WHERE BOX_CODIGO = :CODIGO');
    qryAux.SQL.Add('  AND BOX_CODEMP = :CODEMP');

    qryAux.ParamByName('CODIGO').AsString := ACodBox;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pLimpaDocBox(ANumDoc, AEspDoc, AEmpDoc: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('UPDATE CADBOX');
    qryAux.SQL.Add('SET BOX_NUMDOC = NULL');
    qryAux.SQL.Add('   ,BOX_ESPDOC = NULL');
    qryAux.SQL.Add('   ,BOX_EMPDOC = NULL');
    qryAux.SQL.Add('WHERE BOX_NUMDOC = :NUMDOC');
    qryAux.SQL.Add('  AND BOX_ESPDOC = :ESPDOC');
    qryAux.SQL.Add('  AND BOX_EMPDOC = :EMPDOC');

    qryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAux.ParamByName('EMPDOC').AsString := AEmpDoc;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fGetBoxItemPedido(ACodIte: String; AValidaQtdDisp: Boolean = False; ANumeroOnda: String = ''; ACodEmp: String = ''): TArray<String>;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    If fEmptyStr(ACodEmp) Then
      ACodEmp := VS_strCodEmp;

    qryAux.SQL.Add('SELECT GROUP_CONCAT(DISTINCT BOX_CODIGO ORDER BY BOX_CODIGO) AS CODBOX');
    qryAux.SQL.Add('FROM CADBOX');
    qryAux.SQL.Add('JOIN FATGOR ON FGO_NUMDOC = BOX_NUMDOC');
    qryAux.SQL.Add('           AND FGO_ESPDOC = BOX_ESPDOC');
    qryAux.SQL.Add('           AND FGO_CODEMP = BOX_EMPDOC');
    qryAux.SQL.Add('JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
    qryAux.SQL.Add('JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM');
    qryAux.SQL.Add('WHERE BOX_CODEMP = :CODEMP');
    qryAux.SQL.Add('  AND FDO_CODITE = :CODITE');

    If AValidaQtdDisp Then
      qryAux.SQL.Add('AND FDO_QTDITE - IFNULL(FDO_QTDBAI,0) > 0');

    If Not fEmptyStr(ANumeroOnda) Then
      qryAux.SQL.Add('AND FGO_SEQSEP = ' + QuotedStr(ANumeroOnda));

    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.ParamByName('CODITE').AsString := ACodIte;
    qryAux.Open;

    Result := qryAux.FieldByName('CODBOX').AsString.Split([',']);
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pImprimeEtiquetaBox(ANumDoc, AEspDoc, AEmpDoc, ACodCli: String);
  Var
    qryCfgRel: TUniQuery;
    frmCadBoxEti: TfrmCadBoxEti;
    strNomImp: String;
begin

  qryCfgRel := fCriaQuery(nil);
  frmCadBoxEti := TfrmCadBoxEti.Create(nil);
  Try
    pCarregaConfImpr(qryCfgRel, 'EtiqBoxSeparacao');
    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    frmCadBoxEti.pImprimirBoxSep(ANumDoc, AEspDoc, AEmpDoc, ACodCli, strNomImp);
  Finally
    FreeAndNil(frmCadBoxEti);
    FreeAndNil(qryCfgRel);
  End;
end;

end.
