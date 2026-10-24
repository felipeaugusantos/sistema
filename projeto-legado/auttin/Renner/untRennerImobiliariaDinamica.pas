unit untRennerImobiliariaDinamica;

interface

uses
  Classes, Uni, Variants, UniClientDataSet, DB, SysUtils,
  untTintadeMaquina, untIConfTinta;

Type
  TRennerImobiliariaDinamica = class(TTintadeMaquina)
  private
    strPat : String;
    conf: IConfTinta;
    function fCsvCamposToClientDataSet(strNomArq, strDelimit: String; arrCampos: Array of String): TUniClientDataSet;
    function fContaLinhasArquivoTexto(strNomArq: String): Integer;
  protected
    function fProcessaCadBas: Boolean;
    function fProcessaCadCol: Boolean;
    function fProcessaCadRei: Boolean;

    function fRetDescricaoBase(strCodBas: String): String;

    function fConverteOncaRenner(strQtd1, strQtd2, strQtd3: String): Double;
    function fConverteDataRenner(strDataRenner: String): TDateTime;
  public
    function fRetProxCodSeq(): Integer;
    function fGravarNovaFormula(qryCadRei, qryCadNfm: TUniQuery; intProCod: Integer = 1): Boolean; overload;
    function fGravarNovaFormula(qryCadNfm: TUniQuery): Boolean; overload;
    function fGravarNovasFormulas(): Boolean; override;

    constructor Create(AOwner: TComponent); override;
    function fProcessaArquivos(intOpcao: Integer): Boolean;
  End;

implementation

uses TypInfo, untFuncoesSimples, untFuncTinta, Math, StrUtils, untDDLFactory;

{ TRennerImobiliariaDinamica }

constructor TRennerImobiliariaDinamica.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  conf      := fGetConfTinta('REI');
  strPat := conf.fGet('TXTREI'); //fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TXTREI', '');
  If AnsiEndsText('TXT', strPat) Then
    strPat := ExtractFilePath(strPat);

  NomeTinta := 'Renner Imobiliária';
end;

function TRennerImobiliariaDinamica.fContaLinhasArquivoTexto(
  strNomArq: String): Integer;
  Var
    arqGen: TextFile;
begin
  Result := 0;
  Try
    AssignFile(arqGen, strNomArq);
    Reset(arqGen);

    While Not Eof(arqGen) Do
    Begin
      Readln(arqGen);
      Result := Result + 1;
    End;

    CloseFile(arqGen);
  Except
    CloseFile(arqGen);
    Result := 0;
  End;
end;

function TRennerImobiliariaDinamica.fConverteDataRenner(
  strDataRenner: String): TDateTime;
begin
  // 14/10/1999
  Insert('/', strDataRenner, 3);
  Insert('/', strDataRenner, 6);
  Result := StrToDateDef(strDataRenner, fNow());
end;

function TRennerImobiliariaDinamica.fConverteOncaRenner(strQtd1, strQtd2,
  strQtd3: String): Double;
begin
  Result := 0;

  if fEmptyStr(strQtd1) then
    strQtd1 := '0';

  if fEmptyStr(strQtd2) then
    strQtd2 := '0';

  if fEmptyStr(strQtd3) then
    strQtd3 := '0';

  Result := Result + fStrToFloat(strQtd1) * 29.57353;

//  If (fStrToFloat(strQtd1) = 0) Then
//    Result := Result + (fStrToFloat(strQtd2) + IfThen(fStrToFloat(strQtd3) = 1, 0.5)) / 48
//  Else
    Result := Result + (fStrToFloat(strQtd2) + IfThen(fStrToFloat(strQtd3) = 1, 0.5)) * 29.57353 / 48;
end;

function TRennerImobiliariaDinamica.fCsvCamposToClientDataSet(strNomArq,
  strDelimit: String; arrCampos: array of String): TUniClientDataSet;
  Var
    intCont: Integer;
    txtArq: TextFile;
    strLinha: String;

    intLinha: Integer;
    intLinhas: Integer;
begin
  If (Not FileExists(strNomArq)) Then
    Raise Exception.Create('Arquivo (' + strNomArq + ') não encontrado');

  Try
    AssignFile(txtArq, strNomArq);
    Reset(txtArq);
  Except
    CloseFile(txtArq);
    Result := nil;
    Exit;
  End;

  pRegistraAcao('Carregando arquivo ' + strNomArq);
  intLinhas := fContaLinhasArquivoTexto(strNomArq);
  intLinha := 1;

  Result := TUniClientDataSet.Create(nil);

  For intCont := 0 To Length(arrCampos) - 1 Do
  Begin
    Result.FieldDefs.Add(arrCampos[intCont], ftString, 50, False);
  End;

  Result.CreateDataSet;

  While Not Eof(txtArq) Do
  Begin
    Readln(txtArq, strLinha);
    strLinha := strLinha + ';';
    Result.Insert;
    For intCont := 0 To Length(arrCampos) - 1 Do
    Begin
      Result.Fields.Fields[intCont].AsString := Copy(strLinha, 1, Pos(strDelimit, strLinha) - 1);
      strLinha := Copy(strLinha, Pos(strDelimit, strLinha) + 1, Length(strLinha));
    End;
    Result.Post;
    pRegistraProgresso(0, intLinha, intLinhas);
    intLinha := intLinha + 1;
  End;

  CloseFile(txtArq);
  pRegistraAcao('Arquivo Carregado com sucesso!');
end;

function TRennerImobiliariaDinamica.fGravarNovaFormula(qryCadRei,
  qryCadNfm: TUniQuery; intProCod: Integer = 1): Boolean;
  Var
    intCont: Integer;

    intUnidades: Integer;
  Const
    arrUnidades: Array[1..3] of String = ('QT', 'GL', 'LA');
    arrPesos: Array[1..3] of Integer = (1, 4, 20);    
begin

  For intUnidades := 1 To 3 Do
  Begin
    qryCadRei.Insert;
    qryCadRei.FieldByName('REI_CODSEQ').AsString := fStrZero(intProCod, 6);
    qryCadRei.FieldByName('REI_DESCRI').AsString := fRetDescricaoBase(qryCadNfm.FieldByName('NFM_CODBAS').AsString);
    qryCadRei.FieldByName('REI_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
    qryCadRei.FieldByName('REI_UNIDAD').AsString := arrUnidades[intUnidades];
    qryCadRei.FieldByName('REI_DESCOR').AsString := qryCadNfm.FieldByName('NFM_DESCOR').AsString;
    qryCadRei.FieldByName('REI_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadRei.FieldByName('REI_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
    qryCadRei.FieldByName('REI_CODEMP').AsString := qryCadNfm.FieldByName('NFM_CODEMP').AsString;
    qryCadRei.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REI_CADREI', VS_strCodEmp);
    qryCadRei.FieldByName('REI_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;
    qryCadRei.FieldByName('REI_STAT__').AsString := qryCadNfm.FieldByName('NFM_STAT__').AsString;
    qryCadRei.FieldByName('REI_STAT2_').AsString := qryCadNfm.FieldByName('NFM_STAT2_').AsString;

    For intCont := 1 To 6 Do
    Begin
      If fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
        Break;

      qryCadRei.FieldByName('REI_FORM' + fStrZero(intCont, 2)).AsString :=
        qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
      qryCadRei.FieldByName('REI_QTDC' + fStrZero(intCont, 2)).AsFloat :=
        qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * arrPesos[intUnidades];
    End;

    qryCadRei.FieldByName('REI_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadRei.Post;
  End;
  
  Result := True;
end;

function TRennerImobiliariaDinamica.fGravarNovaFormula(
  qryCadNfm: TUniQuery): Boolean;
var
  qryCadRei: TUniQuery;
  intProCod: Integer;
  intCont: Integer;
  intUnidades: Integer;
  arrPesos: Array[1..3] of Double;
const
  arrUnidades: Array[1..3] of String = ('QT', 'GL', 'LA');
begin
  Result := False;
  qryCadRei := nil;
  Try
    Try
      qryCadRei := fCriaQuery(Self);
      qryCadRei.SQL.Text := 'DELETE FROM REI_CADREI WHERE REI_CODNFM = ' + QuotedStr(qryCadNfm.FieldByName('NFM_CODPRO').AsString);
      qryCadRei.ExecSQL;

      qryCadRei.SQL.Text := 'SELECT * FROM REI_CADREI WHERE FALSE';
      qryCadRei.Open;

      if qryCadNfm.FieldByName('NFM_UNIDAD').AsString = 'QT' then
      begin
        arrPesos[1] := 1;
        arrPesos[2] := 4;
        arrPesos[3] := 20;
      end
      else if qryCadNfm.FieldByName('NFM_UNIDAD').AsString = 'GL' then
      begin
        arrPesos[1] := 1 / 4;
        arrPesos[2] := 4 / 4;
        arrPesos[3] := 20 / 4;
      end
      else if qryCadNfm.FieldByName('NFM_UNIDAD').AsString = 'LA' then
      begin
        arrPesos[1] := 1 / 20;
        arrPesos[2] := 4 / 20;
        arrPesos[3] := 20 / 20;
      end;


      For intUnidades := 1 To 3 Do
      Begin
        intProCod := fRetProxCodSeq();

        qryCadRei.Insert;
        qryCadRei.FieldByName('REI_CODSEQ').AsString := fStrZero(intProCod, 6);
        qryCadRei.FieldByName('REI_DESCRI').AsString := fRetDescricaoBase(qryCadNfm.FieldByName('NFM_CODBAS').AsString);
        qryCadRei.FieldByName('REI_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
        qryCadRei.FieldByName('REI_UNIDAD').AsString := arrUnidades[intUnidades];
        qryCadRei.FieldByName('REI_DESCOR').AsString := qryCadNfm.FieldByName('NFM_DESCOR').AsString;
        qryCadRei.FieldByName('REI_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
        qryCadRei.FieldByName('REI_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryCadRei.FieldByName('REI_CODEMP').AsString := VS_strCodEmp;
        qryCadRei.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REI_CADREI', VS_strCodEmp);
        qryCadRei.FieldByName('REI_DTACAD').AsDateTime := fNow();

        For intCont := 1 To 6 Do
        Begin
          If fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
            Break;

          qryCadRei.FieldByName('REI_FORM' + fStrZero(intCont, 2)).AsString :=
            qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
          qryCadRei.FieldByName('REI_QTDC' + fStrZero(intCont, 2)).AsFloat :=
            qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * arrPesos[intUnidades];
        End;

        qryCadRei.FieldByName('REI_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
        qryCadRei.Post;
      End;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadRei) then FreeAndNil(qryCadRei);
  End;
end;

function TRennerImobiliariaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryCadRei: TUniQuery;
    qryCadNfm: TUniQuery;
    intProCod: Integer;
begin
  qryCadrei := fCriaQuery(Self);

  { LIMPA TODAS AS NOVAS FORMULAS JA CADASTRADAS }
  qryCadRei.SQL.Text := 'DELETE FROM REI_CADREI WHERE REI_CODNFM IN (SELECT NFM_CODPRO FROM REI_CADNFM)';
  qryCadRei.ExecSQL;

  qryCadRei.SQL.Text := 'SELECT * FROM REI_CADREI WHERE FALSE';
  qryCadRei.Open;

  qryCadNfm := fCriaQuery(Self);
  qryCadNfm.SQL.Text := 'SELECT * FROM REI_CADNFM';
  qryCadNfm.Open;

  pRegistraAcao('Cadastrando Novas Fórmulas...');
  intProCod := fRetProxCodSeq();

  TTintadeMaquina.fAjustaInicialAutoIncremento('REI_CADREI', VS_strCodEmp);
  
  While Not qryCadNfm.Eof Do
  Begin
    fGravarNovaFormula(qryCadRei, qryCadNfm, intProCod);
    intProCod := intProCod + 1;
    pRegistraProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
    qryCadNfm.Next;
  End;

  FreeAndNil(qryCadNfm);
  FreeAndNil(qryCadRei);
  Result := True;
  pRegistraAcao('Cadastro de Novas Fórmulas Realizada com Sucesso!');
end;

function TRennerImobiliariaDinamica.fProcessaArquivos(intOpcao: Integer): Boolean;
begin
	Result := False;
  If intOpcao = 0 Then
    Result := fProcessaCadBas
  Else If intOpcao = 1 Then
    Result := fProcessaCadRei
  Else If intOpcao = 2 Then
    Result := fProcessaCadCol;
end;

function TRennerImobiliariaDinamica.fProcessaCadBas: Boolean;
  Var
    txtArqBas: TextFile;
    qryCadBas: TUniQuery;

    strLinha: String;
    intLinhas: Integer;
    intLinha: Integer;

    strTipoReg: String;
    strCodBas: String;
    strDesBas: String;

    intCont: Integer;

    strNomArq: String;
  Const
    arrUnidades: Array[1..3] of String = ('QT', 'GL', 'LA');
begin

  Try
    strNomArq := strPat + '\DM02.TXT';
    AssignFile(txtArqBas, strNomArq);
    Reset(txtArqBas);
  Except
    CloseFile(txtArqBas);
    Result := False;
    Exit;
  End;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Text := 'SELECT * FROM REI_CADBAS';
  qryCadBas.Open;

  intLinhas := fContaLinhasArquivoTexto(strPat + '\DM02.TXT');
  Reset(txtArqBas);
  intLinha := 1;

  pRegistraAcao('Cadastrando Bases...');

  TTintadeMaquina.fAjustaInicialAutoIncremento('REI_CADBAS', VS_strCodEmp);

  While Not Eof(txtArqBas) Do
  Begin
    Readln(txtArqBas, strLinha);

    strTipoReg := Copy(strLinha, 1, Pos(';', strLinha) - 1);
    strLinha := Copy(strLinha, Pos(';', strlinha) + 1, Length(strLinha));

    { BASE }
    If (strTipoReg = 'B') Then
    Begin
      strCodBas := Trim(Copy(strLinha, 1, Pos(';', strLinha) - 1));

      strLinha := Trim(Copy(strLinha, Pos(';', strLinha) + 1, Length(strLinha)));

      if Copy(strLinha,1,1) = ';' then
        strLinha := Trim(Copy(strLinha, Pos(';', strLinha) + 1, Length(strLinha)));      

      strDesBas := Trim(Copy(strLinha, 1, Pos(';', strLinha) - 1));
      
      For intCont := 1 To 3 Do
      Begin
        If Not qryCadBas.Locate('BAS_CODBAS;BAS_UNIDAD',
          VarArrayOf([strCodBas, arrUnidades[intCont]]), []) Then
        Begin
          qryCadBas.Insert;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := strCodBas;
          qryCadBas.FieldByName('BAS_UNIDAD').AsString := arrUnidades[intCont]; // EMBALAGENS DE 946ML (QT)
          qryCadBas.FieldByName('BAS_DESCRI').AsString := strDesBas;
          qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
          qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REI_CADBAS', VS_strCodEmp);
          qryCadBas.Post;
        End;
      End;


    End;
    pRegistraProgresso(0, intLinha, intLinhas);
    intLinha := intLinha + 1;
  End;

  pRegistraAcao('Cadastro de Bases Realizado com Sucesso!');

  FreeAndNil(qryCadBas);
  CloseFile(txtArqBas);
  Result := True;
end;

function TRennerImobiliariaDinamica.fProcessaCadCol: Boolean;
  Var
    txtArqCol: TextFile;
    qryCadCol: TUniQuery;

    strLinha: String;
    intLinhas: Integer;
    intLinha: Integer;

    strTipoReg: String;
    strCodCol: String;
    strDesCol: String;
begin

  Try
    AssignFile(txtArqCol, strPat + '\DM02.TXT');
    Reset(txtArqCol);
  Except
    CloseFile(txtArqCol);
    Result := False;
    Exit;
  End;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Text := 'SELECT * FROM REI_CADCOL';
  qryCadCol.Open;

  intLinhas := fContaLinhasArquivoTexto(strPat + '\DM02.TXT');
  Reset(txtArqCol);
  intLinha := 1;

  pRegistraAcao('Cadastrando Colorantes...');
  TTintadeMaquina.fAjustaInicialAutoIncremento('REI_CADCOL', VS_strCodEmp);
  While Not Eof(txtArqCol) Do
  Begin
    Readln(txtArqCol, strLinha);

    strTipoReg := Copy(strLinha, 1, Pos(';', strLinha) - 1);
    strLinha := Copy(strLinha, Pos(';', strlinha) + 1, Length(strLinha));

    { COLORANTE }
    If (strTipoReg = 'P') Then
    Begin
      strCodCol := Copy(strLinha, 1, Pos(';', strLinha) - 1);

      strLinha := Copy(strLinha, Pos(';', strLinha) + 1, Length(strLinha));
      strLinha := Copy(strLinha, Pos(';', strLinha) + 1, Length(strLinha));

      strDesCol := Copy(strLinha, 1, Pos(';', strLinha) - 1);

      If Not qryCadCol.Locate('COL_CODCOL;COL_DESCRI', VarArrayOf([strCodCol, strDesCol]), []) Then
      Begin
        qryCadCol.Insert;
        qryCadCol.FieldByName('COL_CODCOL').AsString := strCodCol;
        qryCadCol.FieldByName('COL_DESCRI').AsString := strDesCol;
        qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REI_CADCOL', VS_strCodEmp);
        qryCadCol.Post;
      End;
    End;
    pRegistraProgresso(0, intLinha, intLinhas);
    intLinha := intLinha + 1;
  End;

  pRegistraAcao('Cadastro de Colorantes Realizado com Sucesso!');

  FreeAndNil(qryCadCol);
  CloseFile(txtArqCol);
  Result := True;
end;

function TRennerImobiliariaDinamica.fProcessaCadRei: Boolean;
  Var
    cdsTintas: TUniClientDataSet;
    cdsFormulas: TUniClientDataSet;
    dtsTintas: TDataSource;

    qryCadRei: TUniQuery;
    qryCadBas: TUniQuery;

    intCont: Integer;
    intCodSeq: Integer;

    blnVazio: Boolean;
  Const
    arrUnidades: Array[1..3] of String = ('QT', 'GL', 'LA');
begin
  cdsTintas := fCsvCamposToClientDataSet(strPat + '\' + 'DM01.TXT', ';', ['CODPROD', 'CODIND', 'COR', 'BASE', 'IDENT', 'DT_CAD', 'STAT', 'STAT2']);
  cdsFormulas := fCsvCamposToClientDataSet(strPat + '\' + 'DD01.TXT', ';', ['CODPROD', 'PIG', 'BASE',	'QTD14_1', 'QTD14_2',  'QTD14_3', 'QTD01_1',	'QTD01_2',	'QTD01_3',  'QTD18_1', 'QTD18_2', 'QTD18_3']);

  dtsTintas := fCriaDataSource(cdsTintas);
  cdsFormulas.MasterFields := 'CODPROD;BASE';
  cdsFormulas.IndexFieldNames := 'CODPROD;BASE';
  cdsFormulas.MasterSource := dtsTintas;

  qryCadRei := fCriaQuery(Self);
  qryCadRei.SQL.Text := 'TRUNCATE TABLE REI_CADREI';
  qryCadRei.ExecSQL;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Text := 'SELECT * FROM REI_CADBAS';
  qryCadBas.Open;

  cdsTintas.First;
  pRegistraAcao('Cadastrando Tintas');

  TTintadeMaquina.fAjustaInicialAutoIncremento('REI_CADREI', VS_strCodEmp);

  intCodSeq := 1;
  While Not cdsTintas.Eof Do
  Begin

    For intCont := 1 To 3 Do
    Begin

      If qryCadBas.Locate('BAS_CODBAS;BAS_UNIDAD', VarArrayOf([cdsTintas.FieldByName('BASE').AsString,
        arrUnidades[intCont]]), []) Then
      Begin
        qryCadRei.SQL.Clear;
        qryCadRei.Params.Clear;
        qryCadRei.SQL.Text := TDDLFactory.GetInsertDelayed('REI_CADREI');
        qryCadRei.ParamByName('REI_CODPRO').AsString := cdsTintas.FieldByName('CODPROD').AsString;
        qryCadRei.ParamByName('REI_DESCOR').AsString := cdsTintas.FieldByName('COR').AsString;
        qryCadRei.ParamByName('REI_REFERE').AsString := cdsTintas.FieldByName('IDENT').AsString;
        qryCadRei.ParamByName('REI_DESCRI').AsString := qryCadBas.FieldByName('BAS_DESCRI').AsString;
        qryCadRei.ParamByName('REI_DTACAD').AsDateTime := fConverteDataRenner(cdsTintas.FieldByName('DT_CAD').AsString);
        qryCadRei.ParamByName('REI_CODBAS').AsString := cdsTintas.FieldByName('BASE').AsString;
        qryCadRei.ParamByName('REI_STAT__').AsString := cdsTintas.FieldByName('STAT').AsString;
        qryCadRei.ParamByName('REI_STAT2_').AsString := cdsTintas.FieldByName('STAT2').AsString;
        qryCadRei.ParamByName('REI_UNIDAD').AsString := arrUnidades[intCont];
        qryCadRei.ParamByName('REI_CODSEQ').AsString := fStrZero(intCodSeq, 6);
        qryCadRei.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REI_CADREI', VS_strCodEmp);

        cdsFormulas.First;
        blnVazio := False;
        While Not cdsFormulas.Eof Do
        Begin
          qryCadRei.ParamByName('REI_FORM' + fStrZero(cdsFormulas.RecNo, 2)).AsString := cdsFormulas.FieldByName('PIG').AsString;

          Case intCont of

            1: qryCadRei.ParamByName('REI_QTDC' + fStrZero(cdsFormulas.RecNo, 2)).AsFloat :=
                  fConverteOncaRenner(cdsFormulas.FieldByName('QTD14_1').AsString,
                                      cdsFormulas.FieldByName('QTD14_2').AsString,
                                      cdsFormulas.FieldByName('QTD14_3').AsString);

            2: qryCadRei.ParamByName('REI_QTDC' + fStrZero(cdsFormulas.RecNo, 2)).AsFloat :=
                  fConverteOncaRenner(cdsFormulas.FieldByName('QTD01_1').AsString,
                                      cdsFormulas.FieldByName('QTD01_2').AsString,
                                      cdsFormulas.FieldByName('QTD01_3').AsString);

            3: qryCadRei.ParamByName('REI_QTDC' + fStrZero(cdsFormulas.RecNo, 2)).AsFloat :=
                  fConverteOncaRenner(cdsFormulas.FieldByName('QTD18_1').AsString,
                                      cdsFormulas.FieldByName('QTD18_2').AsString,
                                      cdsFormulas.FieldByName('QTD18_3').AsString);
          End;

          blnVazio := qryCadRei.ParamByName('REI_QTDC' + fStrZero(cdsFormulas.RecNo, 2)).AsFloat = 0.0;

          If blnVazio Then
          Begin
            Break;
          End;

          cdsFormulas.Next;
        End;

        If Not blnVazio Then
          qryCadRei.ExecSQL;

        intCodSeq :=  intCodSeq + 1;
      End;

    End;

    cdsTintas.Next;
    pRegistraProgresso(0, cdsTintas.RecNo, cdsTintas.RecordCount);
  End;

  pRegistraAcao('Cadastro de Tintas Realizado com Sucesso!!!');

  FreeAndNil(cdsFormulas);
  FreeAndNil(dtsTintas);
  FreeAndNil(cdsTintas);
  FreeAndNil(qryCadRei);

  Result := True;
end;

function TRennerImobiliariaDinamica.fRetDescricaoBase(
  strCodBas: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT DISTINCT BAS_DESCRI FROM REI_CADBAS WHERE BAS_CODBAS = :CODBAS';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;
  Result := qryGen.FieldByName('BAS_DESCRI').AsString;
  FreeAndNil(qryGen);
end;

function TRennerImobiliariaDinamica.fRetProxCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT IFNULL(MAX(REI_CODSEQ), 0) PRO FROM REI_CADREI';
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('PRO').AsInteger + 1;

  FreeAndNil(qryGen);
end;

end.
