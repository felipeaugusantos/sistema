unit untGlasuritDinamica;

interface

uses Windows, SysUtils, Uni, Classes, StrUtils,
  DateUtils, Forms, untTintadeMaquina, ADODB;

Type
  TBasGla = Record
    strCodBas: String;
    fltQtdBas: Double;
  End;

  TGlasuritDinamica = class(TTintadeMaquina)
  public
    constructor Create(AOwner: TComponent); override;
    function fGravarNovasFormulas(): Boolean; override;
  End;

  function fGlasuritGeraArquivoDinamica: Boolean;
  function fGeraNovasFormulasDinamica(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormulaDinamica(strCodPro: String);

  procedure pGeraAmerica(qryCadGla: TUniQuery; strPatGla: String;
    Var intAutInc: Integer);
  procedure pGeraImporta(qryCadGla: TUniQuery; strPatGla: String;
    Var intAutInc: Integer);
  procedure pGeraEspecial(qryCadGla: TUniQuery; strPatGla: String;
    fltFveVen: Double; Var intAutInc: Integer);

  procedure pGeraSQLServerGlasurit(qryCadGla: TUniQuery; Var intAutInc: Integer);

  function fGlasuritGeraBases: Boolean;

  function fGravaCadGla(qryCadGla: TUniQuery;
                        strCodPro,
                        strLinha,
                        strMaisCo,
                        strDescri,
                        strVariac,
                        strMontad,
                        strAnoCor: String;
                        fltPreCus,
                        fltPreVen: Double;
                        arrBasGla: Array Of TBasGla;
                        Var intAutInc: Integer): Boolean;


implementation

uses untFuncoesSimples, untFuncoes, untModuloTinta,
     untIConfTinta, untFuncTinta, untGlasuritSQLServer;

function fGlasuritGeraBases: Boolean;
  Var
    qryCadBas: TUniQuery;
    gerarBases: TBasesGlasuritSQLServer;
begin
  qryCadBas := fCriaQuery(Nil);
  qryCadBas.SQL.Add('SELECT * FROM GLA_CADBAS');
  qryCadBas.Open;

  gerarBases := TBasesGlasuritSQLServer.Create(qryCadBas);
  gerarBases.pGerarBases;
  FreeAndNil(gerarBases);

  FreeAndNil(qryCadBas);
  Result := True;
end;

function fGlasuritGeraArquivoDinamica: Boolean;
  Var
    fltFveGla: Double;
    strFveGla: String;
    strPatGla: String;
    intAutInc: Integer;
    qryCadGla: TUniQuery;
    qryCadNfm: TUniQuery;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('GLA');

  pZapTable('GLA_CADGLA');

  qryCadGla := fCriaQuery(Nil);
  qryCadGla.SQL.Add('SELECT * FROM GLA_CADGLA');
  qryCadGla.Open;

  qryCadNfm := fCriaQuery(Nil);
  qryCadNfm.SQL.Add('SELECT * FROM GLA_CADNFM');
  qryCadNfm.Open;

  fltFVeGla := conf.fGetDouble('FVEGLA');
  strFveGla := AnsiReplaceStr(FloatToStr(fltFveGla), ',', '.');
  strPatGla := conf.fGet('PATGLA');
  intAutInc := 1;

  If conf.fGet('CALFOR') = '0' Then
  Begin
    pGeraAmerica(qryCadGla, strPatGla, intAutInc);
    pGeraImporta(qryCadGla, strPatGla, intAutInc);
    pGeraEspecial(qryCadGla, strPatGla, fltFveGla, intAutInc);
  End
  Else
  Begin
    pGeraSQLServerGlasurit(qryCadGla, intAutInc);
  End;

  FreeAndNil(qryCadGla);

  fGravaAutoIncrem('GLA_CADGLA', intAutInc);

  Result := True;
  While (Not qryCadNfm.Eof) Do
  Begin
    Result := fGeraNovasFormulasDinamica(qryCadNfm);
    qryCadNfm.Next;
  End;

  qryCadNfm.Close;
  FreeAndNil(qryCadNfm);

end;

function fGeraNovasFormulasDinamica(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadGla: TUniQuery;
    strAutInc: String;
    intContador: Integer;
    strCodBas: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('GLA');
  
  pDeletaNovaFormulaDinamica(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

  qryCadGla := fCriaQuery(Nil);
  qryCadGla.SQL.Clear;
  qryCadGla.SQL.Add('SELECT * FROM GLA_CADGLA WHERE AUTOINCREM = -1');
  qryCadGla.Open;

  strAutInc := fRetAutoIncrem('GLA_CADGLA', VS_strCodEmp);

  qryCadGla.Append;
  qryCadGla.FieldByName('GLA_CODSEQ').AsString := RightStr(LeftStr(strAutInc, 17), 6);


{  If conf.fGet('CALFOR') = '0' Then
    qryCadGla.FieldByName('GLA_LINHA_').AsString := '****'
  Else
    qryCadGla.FieldByName('GLA_LINHA_').AsString := '22';}

  qryCadGla.FieldByName('GLA_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;

  qryCadGla.FieldByName('GLA_MONTAD').AsString := 'GERAL';
  qryCadGla.FieldByName('GLA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadGla.FieldByName('GLA_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadGla.FieldByName('GLA_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime));
  qryCadGla.FieldByName('GLA_VARIAC').AsString := '';
  qryCadGla.FieldByName('GLA_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

  For intContador := 1 To 18 Do
  Begin
    strCodBas := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intContador, 2)).AsString;
    If (fEmptyStr(strCodBas)) Then
      Break;

    If (strCodBas = 'E 057055') Then
      Continue;

    qryCadGla.FieldByName('GLA_FORM' + fStrZero(intContador, 2)).AsString := TrimRight(strCodBas);
    qryCadGla.FieldByName('GLA_QTDB' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intContador, 2)).AsFloat;
    qryCadGla.FieldByName('GLA_QTDD' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intContador, 2)).AsFloat;    
  End;

  qryCadGla.FieldByName('GLA_PRECUS').AsFloat  := 0.0;
  qryCadGla.FieldByName('GLA_PREVEN').AsFloat  := 0.0;
  qryCadGla.FieldByName('GLA_CODEMP').AsString := VS_strCodEmp;
  qryCadGla.FieldByName('AUTOINCREM').AsString := fFormataAutInc(StrToInt(RightStr(LeftStr(strAutInc, 17), 14)), VS_strCodEmp);
  qryCadGla.FieldByName('GLA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

  qryCadGla.Post;

  Result := True;
end;

procedure pDeletaNovaFormulaDinamica(strCodPro: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  GLA_CADGLA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GLA_CODPRO = :CODPRO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;
    ExecSQL;
    Close;
  End;
end;

procedure pGeraAmerica(qryCadGla: TUniQuery; strPatGla: String;
  Var intAutInc: Integer);
  Var
    stlAmerica: TStringList;
    intContador: Integer;
    intIdxBase: Integer;
    intIndTxt: Integer;
    strLinTxt: String;
    arrBasGla: Array [1..15] Of TBasGla;
    blnResult: Boolean;

    strCodPro: String;
    strLinha : String;
    strMaisCo: String;
    strDescri: String;
    strVariac: String;
    strMontad: String;
    strAnoCor: String;
begin

  If (Not FileExists(strPatGla + '\AMERICA.TXT')) Then
  Begin
    Exit;
  End;

  stlAmerica := TStringList.Create;

  Try
    stlAmerica.LoadFromFile(strPatGla + '\AMERICA.TXT');
    For intContador := 0 To stlAmerica.Count -1 Do
    Begin

      strLinTxt := stlAmerica[intContador];

      strCodPro := Trim(Copy(strLinTxt, 053, 08));
      strLinha  := Trim(Copy(strLinTxt, 001, 04));
      strMaisCo := Trim(Copy(strLinTxt, 072, 02));
      strDescri := Trim(Copy(strLinTxt, 008, 45));
      strVariac := Trim(Copy(strLinTxt, 064, 04));
      strMontad := Trim(Copy(strLinTxt, 005, 03));
      strAnoCor := Trim(Copy(strLinTxt, 068, 04));

      For intIdxBase := 1 To 15 Do
      Begin
        arrBasGla[intIdxBase].strCodBas := '';
        arrBasGla[intIdxBase].fltQtdBas := 0.0;
      End;

      intIndTxt := 116;
      For intIdxBase := 1 To 15 Do
      Begin
        arrBasGla[intIdxBase].strCodBas := Trim(Copy(strLinTxt, intIndTxt, 08));

        If (fEmptyStr(arrBasGla[intIdxBase].strCodBas)) Then
          Continue;

        If (arrBasGla[intIdxBase].strCodBas = 'E 057055') Then
          arrBasGla[intIdxBase].strCodBas := ''
        Else
          arrBasGla[intIdxBase].fltQtdBas := fStrToFloat(AnsiReplaceStr(Copy(strLinTxt, intIndTxt+08, 06), '.', ','));

        Inc(intIndTxt, 22);

      End;

      blnResult := fGravaCadGla(qryCadGla,
                                strCodPro,
                                strLinha,
                                strMaisCo,
                                strDescri,
                                strVariac,
                                strMontad,
                                strAnoCor,
                                0.0,
                                0.0,
                                arrBasGla,
                                intAutInc);

      If (Not blnResult) Then
      Begin
        Break;
      End;

      Application.ProcessMessages;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro na geração do arquivo AMERICA.TXT:' + #13#10 +
                     E.Message, '[pGeraAmerica]');
    End;
  End;

  FreeAndNil(stlAmerica);
end;

procedure pGeraImporta(qryCadGla: TUniQuery; strPatGla: String;
  Var intAutInc: Integer);
  Var
    stlImporta: TStringList;
    intContador: Integer;
    intIdxBase: Integer;
    intIndTxt: Integer;
    strLinTxt: String;
    arrBasGla: Array [1..15] Of TBasGla;
    blnResult: Boolean;

    strCodPro: String;
    strLinha : String;
    strMaisCo: String;
    strDescri: String;
    strVariac: String;
    strMontad: String;
    strAnoCor: String;
begin

  If (Not FileExists(strPatGla + '\IMPORTA.TXT')) Then
  Begin
    Exit;
  End;

  stlImporta := TStringList.Create;
  Try
    stlImporta.LoadFromFile(strPatGla + '\IMPORTA.TXT');
    For intContador := 0 To stlImporta.Count -1 Do
    Begin

      strLinTxt := stlImporta[intContador];

      strLinha  := Trim(Copy(strLinTxt, 001, 04));
      strMontad := Trim(Copy(strLinTxt, 005, 03));
      strDescri := Trim(Copy(strLinTxt, 008, 45));
      strCodPro := Trim(Copy(strLinTxt, 050, 15));
      strAnoCor := Trim(Copy(strLinTxt, 056, 04));
      strVariac := Trim(Copy(strLinTxt, 452, 05));

      For intIdxBase := 1 To 15 Do
      Begin
        arrBasGla[intIdxBase].strCodBas := '';
        arrBasGla[intIdxBase].fltQtdBas := 0.0;
      End;

      intIndTxt := 119;

      For intIdxBase := 1 To 15 Do
      Begin
        arrBasGla[intIdxBase].strCodBas := Trim(Copy(strLinTxt, intIndTxt, 08));

        If (fEmptyStr(arrBasGla[intIdxBase].strCodBas)) Then
          Continue;

        If arrBasGla[intIdxBase].strCodBas = 'E 057055' Then
          arrBasGla[intIdxBase].strCodBas := ''
        Else
          arrBasGla[intIdxBase].fltQtdBas := fStrToFloat(AnsiReplaceStr(Copy(strLinTxt, intIndTxt+08, 06), '.', ','));

        Inc(intIndTxt, 22);

      End;

      blnResult := fGravaCadGla(qryCadGla,
                                strCodPro,
                                strLinha,
                                strMaisCo,
                                strDescri,
                                strVariac,
                                strMontad,
                                strAnoCor,
                                0.0,
                                0.0,
                                arrBasGla,
                                intAutInc);

      If (Not blnResult) Then
      Begin
        Break;
      End;

      Application.ProcessMessages;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro na geração do arquivo IMPORTA.TXT:' + #13#10 +
                     E.Message, '[pGeraImporta]');
    End;
  End;

  FreeAndNil(stlImporta);
end;

procedure pGeraEspecial(qryCadGla: TUniQuery; strPatGla: String;
  fltFveVen: Double; Var intAutInc: Integer);
  Var
    stlEspecial: TStringList;
    intContador: Integer;
    intIdxBase: Integer;
    strLinTxt: String;
    arrBasGla: Array [1..15] Of TBasGla;
    blnResult: Boolean;

    strCodPro: String;
    strLinha : String;
    strMaisCo: String;
    strDescri: String;
    strVariac: String;
    strMontad: String;
    strAnoCor: String;
    fltPreCus: Double;
    fltPreVen: Double;
begin

  If (Not FileExists(strPatGla + '\ESPECIAL.TXT')) Then
  Begin
    Exit;
  End;

  For intIdxBase := 1 To 15 Do
  Begin
    arrBasGla[intIdxBase].strCodBas := '';
    arrBasGla[intIdxBase].fltQtdBas := 0.0;
  End;

  stlEspecial := TStringList.Create;

  Try
    stlEspecial.LoadFromFile(strPatGla + '\ESPECIAL.TXT');
    For intContador := 0 To stlEspecial.Count -1 Do
    Begin
      strLinTxt := stlEspecial[intContador];

      strLinha  := Trim(Copy(strLinTxt, 001, 04));
      strMontad := '';
      strDescri := Trim(Copy(strLinTxt, 005, 48));
      strCodPro := Trim(Copy(strLinTxt, 053, 04));
      strVariac := '';
      strAnoCor := '';

      fltPreCus := fStrToFloat(AnsiReplaceStr(Copy(strLinTxt, 064, 12), '.', ','));
      fltPreVen := fltPreCus * fltFVeVen;

      blnResult := fGravaCadGla(qryCadGla,
                                strCodPro,
                                strLinha,
                                strMaisCo,
                                strDescri,
                                strVariac,
                                strMontad,
                                strAnoCor,
                                fltPreCus,
                                fltPreVen,
                                arrBasGla,
                                intAutInc);

      If (Not blnResult) Then
      Begin
        Break;
      End;

      Application.ProcessMessages;

    End;

  Except
    On E: Exception Do
    Begin
      
    End;
  End;

  FreeAndNil(stlEspecial);

end;

function fGravaCadGla(qryCadGla: TUniQuery;
                      strCodPro,
                      strLinha,
                      strMaisCo,
                      strDescri,
                      strVariac,
                      strMontad,
                      strAnoCor: String;
                      fltPreCus,
                      fltPreVen: Double;
                      arrBasGla: Array Of TBasGla;
                      Var intAutInc: Integer): Boolean;
  Var
    intContador: Integer;
begin
  qryCadGla.Append;
  qryCadGla.FieldByName('GLA_CODSEQ').AsString := fStrZero(intAutInc, 6);
  qryCadGla.FieldByName('GLA_LINHA_').AsString := strLinha;
  qryCadGla.FieldByName('GLA_MONTAD').AsString := strMontad;
  qryCadGla.FieldByName('GLA_DESCRI').AsString := strDesCri + IIF(Not fEmptyStr(strMaisCo), ' ' + strMaisCo, '');
  qryCadGla.FieldByName('GLA_CODPRO').AsString := strCodPro;
  qryCadGla.FieldByName('GLA_PRECUS').AsFloat  := fltPreCus;
  qryCadGla.FieldByName('GLA_PREVEN').AsFloat  := fltPreCus;
  qryCadGla.FieldByName('GLA_ANOCOR').AsString := strAnoCor;
  qryCadGla.FieldByName('GLA_VARIAC').AsString := strVariac;

  For intContador := Low(arrBasGla) To High(arrBasGla) Do
  Begin
    qryCadGla.FieldByName('GLA_FORM' + fStrZero(intContador+1, 2)).AsString := arrBasGla[intContador].strCodBas;
    qryCadGla.FieldByName('GLA_QTDB' + fStrZero(intContador+1, 2)).AsFloat  := arrBasGla[intContador].fltQtdBas;
  End;

  qryCadGla.FieldByName('GLA_CODEMP').AsString := VS_strCodEmp;
  qryCadGla.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp);
  qryCadGla.Post;

  Inc(intAutInc);

  Result := True;
end;

{ GlasuritDinamica }

constructor TGlasuritDinamica.Create(AOwner: TComponent);
begin
  NomeTinta := 'Glasurit Automotiva';
  inherited;
end;

function TGlasuritDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := True;
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM GLA_CADNFM';
  qryGen.Open;

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    Result := fGeraNovasFormulasDinamica(qryGen);

    If Not Result Then Break;

    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');
  FreeAndNil(qryGen);
end;

procedure pGeraSQLServerGlasurit(qryCadGla: TUniQuery; Var intAutInc: Integer);
  Var
    glasurit: TGlasuritSQLServer;
begin
  glasurit := TGlasuritSQLServer.Create(qryCadGla, intAutInc);
  glasurit.pGerarCores;
  intAutInc := glasurit.fGetAutInc;
  FreeAndNil(glasurit);
end;

end.
