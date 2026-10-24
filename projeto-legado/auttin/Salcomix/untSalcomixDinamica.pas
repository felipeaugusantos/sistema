unit untSalcomixDinamica;

interface

uses Windows, SysUtils, Uni,  Classes, StrUtils,
  DateUtils, Forms, untTintadeMaquina, ADODB;

Type
  TBasSal = Record
    strCodBas: String;
    fltQtdBas: Double;
  End;

  TSalcomixDinamica = class(TTintadeMaquina)
  public
    constructor Create(AOwner: TComponent); override;
    function fGravarNovasFormulas(): Boolean; override;
  End;

  function fSalcomixGeraBases: Boolean;
  function fSalcomixGeraArquivoDinamica: Boolean;
  function fGeraNovasFormulasDinamica(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormulaDinamica(strCodPro: String);

  procedure pGeraAmerica(qryCadSal: TUniQuery; strPatSal: String;
    Var intAutInc: Integer);
  procedure pGeraImporta(qryCadSal: TUniQuery; strPatSal: String;
    Var intAutInc: Integer);
  procedure pGeraEspecial(qryCadSal: TUniQuery; strPatSal: String;
    fltFveVen: Double; Var intAutInc: Integer);

  procedure pGeraSQLServerSalcomix(qryCadSal: TUniQuery; Var intAutInc: Integer);

  function fGravaCadSal(qryCadSal: TUniQuery;
                        strCodPro,
                        strLinha,
                        strMaisCo,
                        strDescri,
                        strVariac,
                        strMontad,
                        strAnoCor: String;
                        fltPreCus,
                        fltPreVen: Double;
                        arrBasSal: Array Of TBasSal;
                        Var intAutInc: Integer;
                        strPasso: String): Boolean;


implementation

uses untFuncoes, untModuloTinta, untSalcomixSQLServer,untFuncoesSimples, untIConfTinta, untFuncTinta;

function fSalcomixGeraBases: Boolean;
  Var
    qryCadBas: TUniQuery;
    strArqBas: String;
    stlArquivo: TStringList;
    intContador: Integer;
    strLinha: String;

    strCodBas: String;
    strDesBas: String;
    fltPesEsp: Double;

    gerarBases: TBasesSalcomixSQLServer;
    conf: IConfTinta;

    function fTentaRetornarEmbalagem(strDescri: String): Double;
      Var
        strChar: String;
        intPosicao: Integer;
        strEmbalagem: String;
    begin
      strEmbalagem := '';
      intPosicao := Length(strDescri)-1;

      If (AnsiEndsText('L', strDescri)) Then
      Begin
        Repeat
          strChar := Copy(strDescri, intPosicao, 1);
          strEmbalagem := strChar + strEmbalagem;
          Dec(intPosicao);
        Until (strChar = ' ') Or (intPosicao = 0);

        If (intPosicao = 0) Then
          Result := 900
        Else
          Result := fStrToFloat(Trim(strEmbalagem)) * 1000;
      End
      Else
        Result := 900;
    end;

begin
  stlArquivo := TStringList.Create;
  conf       := fGetConfTinta('SAL');
  If conf.fGet('CALFOR') = '0' Then
  Begin
    strArqBas := conf.fGet('PATSAL') + '\BASES.TXT';
    If (Not FileExists(strArqBas)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não encontrei o arquivo ' + strArqBas, ['&Ok']);
      Result := False;
      Exit;
    End;

    stlArquivo.LoadFromFile(strArqBas);
  End;

  qryCadBas := fCriaQuery(Nil);
  qryCadBas.SQL.Add('SELECT * FROM SAL_CADBAS');
  qryCadBas.Open;


  If conf.fGet('CALFOR') = '1' Then
  Begin
    gerarBases := TBasesSalcomixSQLServer.Create(qryCadBas);
    gerarBases.pGerarBases;
    FreeAndNil(gerarBases);
  End
  Else
  Begin
    For intContador := 0 To stlArquivo.Count -1 Do
    Begin
      strLinha := stlArquivo[intContador];

      strCodBas := Trim(Copy(strLinha, 18, 08));
      strDesBas := Trim(Copy(strLinha, 26, 44));
      fltPesEsp := fStrToFloat(AnsiReplaceStr(Copy(strLinha, 97, 05), '.', ','));

      If (fltPesEsp > 0)                                     And
         (Pos('EMBALAGEM', strDesBas) <= 0)                  And
         (Not qryCadBas.Locate('BAS_CODBAS', strCodBas, [])) Then
      Begin
        qryCadBas.Append;
        qryCadBas.FieldByName('BAS_CODBAS').AsString := strCodBas;
        qryCadBas.FieldByName('BAS_DESBAS').AsString := strDesBas;
        qryCadBas.FieldByName('BAS_PESBAS').AsFloat  := fltPesEsp;
        qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := fTentaRetornarEmbalagem(strDesBas);
        qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadBas.FieldByName('BAS_VALBAS').AsFloat  := 0.0;
        qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SAL_CADBAS', VS_strCodEmp);
        qryCadBas.Post;
      End;

      Application.ProcessMessages;
    End;
  End;

  FreeAndNil(qryCadBas);
  Result := True;
end;

function fSalcomixGeraArquivoDinamica: Boolean;
  Var
    fltFveSal: Double;
    strFveSal: String;
    strPatSal: String;
    intAutInc: Integer;
    qryCadSal: TUniQuery;
    qryCadNfm: TUniQuery;
    conf: IConfTinta;
begin
  pZapTable('SAL_CADSAL');
  conf      := fGetConfTinta('SAL');
  qryCadSal := fCriaQuery(Nil);
  qryCadSal.SQL.Add('SELECT * FROM SAL_CADSAL');
  qryCadSal.Open;

  qryCadNfm := fCriaQuery(Nil);
  qryCadNfm.SQL.Add('SELECT * FROM SAL_CADNFM');
  qryCadNfm.Open;

  fltFVeSal := conf.fGetDouble('FVESAL');
  strFveSal := AnsiReplaceStr(FloatToStr(fltFveSal), ',', '.');
  strPatSal := conf.fGet('PATSAL');
  intAutInc := 1;

  If conf.fGet('CALFOR') = '0' Then
  Begin
    pGeraAmerica(qryCadSal, strPatSal, intAutInc);
    pGeraImporta(qryCadSal, strPatSal, intAutInc);
    pGeraEspecial(qryCadSal, strPatSal, fltFveSal, intAutInc);
  End
  Else
  Begin
    pGeraSQLServerSalcomix(qryCadSal, intAutInc);
  End;

  FreeAndNil(qryCadSal);

  fGravaAutoIncrem('SAL_CADSAL', intAutInc);

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
    qryCadSal: TUniQuery;
    strAutInc: String;
    intContador: Integer;
    strCodBas: String;
    conf: IConfTinta;
    strMd5: String;
begin
  conf      := fGetConfTinta('SAL');
  pDeletaNovaFormulaDinamica(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

  qryCadSal := fCriaQuery(Nil);
  qryCadSal.SQL.Clear;
  qryCadSal.SQL.Add('SELECT * FROM SAL_CADSAL WHERE AUTOINCREM = -1');
  qryCadSal.Open;

  strAutInc := fRetAutoIncrem('SAL_CADSAL', VS_strCodEmp);

  qryCadSal.Append;
  qryCadSal.FieldByName('SAL_CODSEQ').AsString := RightStr(LeftStr(strAutInc, 17), 6);

{  If conf.fGet('CALFOR') = '0' Then
    qryCadSal.FieldByName('SAL_LINHA_').AsString := '****'
  Else
    qryCadSal.FieldByName('SAL_LINHA_').AsString := 'S327';}

  qryCadSal.FieldByName('SAL_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
  qryCadSal.FieldByName('SAL_MONTAD').AsString := 'GERAL';
  qryCadSal.FieldByName('SAL_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadSal.FieldByName('SAL_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadSal.FieldByName('SAL_ATIVO_').AsString := IIF(fEmptyStr(qryCadNfm.FieldByName('NFM_ATIVO_').AsString),'S',qryCadNfm.FieldByName('NFM_ATIVO_').AsString);
  qryCadSal.FieldByName('SAL_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime));
  qryCadSal.FieldByName('SAL_VARIAC').AsString := '';
  qryCadSal.FieldByName('SAL_ACRMOB').AsString := qryCadNfm.FieldByName('NFM_ACRMOB').AsString;
  qryCadSal.FieldByName('SAL_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

  For intContador := 1 To 20 Do
  Begin
    strCodBas := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intContador, 2)).AsString;
    If (fEmptyStr(strCodBas)) Then
      Break;

    If (strCodBas = 'E 057000') Then
      Continue;

    qryCadSal.FieldByName('SAL_FORM' + fStrZero(intContador, 2)).AsString := TrimRight(strCodBas);
    qryCadSal.FieldByName('SAL_QTDB' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intContador, 2)).AsFloat;
    qryCadSal.FieldByName('SAL_QTDD' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intContador, 2)).AsFloat;    
  End;

  qryCadSal.FieldByName('SAL_PRECUS').AsFloat  := 0.0;
  qryCadSal.FieldByName('SAL_PREVEN').AsFloat  := 0.0;
  qryCadSal.FieldByName('SAL_CODEMP').AsString := VS_strCodEmp;
  qryCadSal.FieldByName('AUTOINCREM').AsString := strAutInc;

  strMd5 := '';
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODSEQ').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODPRO').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_LINHA_').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_DESCRI').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_MONTAD').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_ANOCOR').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_VARIAC').AsString;

  qryCadSal.FieldByName('SAL_MD5KEY').AsString := GetMD5(strMd5);

  qryCadSal.Post;

  Result := True;
end;

procedure pDeletaNovaFormulaDinamica(strCodPro: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  SAL_CADSAL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SAL_CODPRO = :CODPRO ';

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

procedure pGeraAmerica(qryCadSal: TUniQuery; strPatSal: String;
  Var intAutInc: Integer);
  Var
    stlAmerica: TStringList;
    intContador: Integer;
    intIdxBase: Integer;
    intIndTxt: Integer;
    strLinTxt: String;
    arrBasSal: Array [1..15] Of TBasSal;
    blnResult: Boolean;

    strCodPro: String;
    strLinha : String;
    strMaisCo: String;
    strDescri: String;
    strVariac: String;
    strMontad: String;
    strAnoCor: String;
    strPasso: String;
begin

  If (Not FileExists(strPatSal + '\AMERICA.TXT')) Then
  Begin
    Exit;
  End;

  stlAmerica := TStringList.Create;

  Try
    stlAmerica.LoadFromFile(strPatSal + '\AMERICA.TXT');
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
      strPasso  := Trim(Copy(strLinTxt, 072, 34));

      For intIdxBase := 1 To 15 Do
      Begin
        arrBasSal[intIdxBase].strCodBas := '';
        arrBasSal[intIdxBase].fltQtdBas := 0.0;
      End;

      intIndTxt := 116;
      For intIdxBase := 1 To 15 Do
      Begin
        arrBasSal[intIdxBase].strCodBas := Trim(Copy(strLinTxt, intIndTxt, 08));

        If (fEmptyStr(arrBasSal[intIdxBase].strCodBas)) Then
          Continue;

        If (arrBasSal[intIdxBase].strCodBas = 'E 057000') Then
          arrBasSal[intIdxBase].strCodBas := ''
        Else
          arrBasSal[intIdxBase].fltQtdBas := fStrToFloat(AnsiReplaceStr(Copy(strLinTxt, intIndTxt+08, 06), '.', ','));

        Inc(intIndTxt, 22);

      End;

      blnResult := fGravaCadSal(qryCadSal,
                                strCodPro,
                                strLinha,
                                strMaisCo,
                                strDescri,
                                strVariac,
                                strMontad,
                                strAnoCor,
                                0.0,
                                0.0,
                                arrBasSal,
                                intAutInc,
                                strPasso);

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

procedure pGeraImporta(qryCadSal: TUniQuery; strPatSal: String;
  Var intAutInc: Integer);
  Var
    stlImporta: TStringList;
    intContador: Integer;
    intIdxBase: Integer;
    intIndTxt: Integer;
    strLinTxt: String;
    arrBasSal: Array [1..15] Of TBasSal;
    blnResult: Boolean;

    strCodPro: String;
    strLinha : String;
    strMaisCo: String;
    strDescri: String;
    strVariac: String;
    strMontad: String;
    strAnoCor: String;
    strPasso : String;
begin

  If (Not FileExists(strPatSal + '\IMPORTA.TXT')) Then
  Begin
    Exit;
  End;

  stlImporta := TStringList.Create;
  Try
    stlImporta.LoadFromFile(strPatSal + '\IMPORTA.TXT');
    For intContador := 0 To stlImporta.Count -1 Do
    Begin

      strLinTxt := stlImporta[intContador];

      strLinha  := Trim(Copy(strLinTxt, 001, 04));
      strMontad := Trim(Copy(strLinTxt, 005, 03));
      strDescri := Trim(Copy(strLinTxt, 008, 45));
      strCodPro := Trim(Copy(strLinTxt, 050, 15));
      strAnoCor := Trim(Copy(strLinTxt, 056, 04));
      strVariac := Trim(Copy(strLinTxt, 452, 05));
      strPasso  := Trim(Copy(strLinTxt, 075, 34));

      For intIdxBase := 1 To 15 Do
      Begin
        arrBasSal[intIdxBase].strCodBas := '';
        arrBasSal[intIdxBase].fltQtdBas := 0.0;
      End;

      intIndTxt := 119;

      For intIdxBase := 1 To 15 Do
      Begin
        arrBasSal[intIdxBase].strCodBas := Trim(Copy(strLinTxt, intIndTxt, 08));

        If (fEmptyStr(arrBasSal[intIdxBase].strCodBas)) Then
          Continue;

        If arrBasSal[intIdxBase].strCodBas = 'E 057000' Then
          arrBasSal[intIdxBase].strCodBas := ''
        Else
          arrBasSal[intIdxBase].fltQtdBas := fStrToFloat(AnsiReplaceStr(Copy(strLinTxt, intIndTxt+08, 06), '.', ','));

        Inc(intIndTxt, 22);

      End;

      blnResult := fGravaCadSal(qryCadSal,
                                strCodPro,
                                strLinha,
                                strMaisCo,
                                strDescri,
                                strVariac,
                                strMontad,
                                strAnoCor,
                                0.0,
                                0.0,
                                arrBasSal,
                                intAutInc,
                                strPasso);

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

procedure pGeraEspecial(qryCadSal: TUniQuery; strPatSal: String;
  fltFveVen: Double; Var intAutInc: Integer);
  Var
    stlEspecial: TStringList;
    intContador: Integer;
    intIdxBase: Integer;
    strLinTxt: String;
    arrBasSal: Array [1..15] Of TBasSal;
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

  If (Not FileExists(strPatSal + '\ESPECIAL.TXT')) Then
  Begin
    Exit;
  End;

  For intIdxBase := 1 To 15 Do
  Begin
    arrBasSal[intIdxBase].strCodBas := '';
    arrBasSal[intIdxBase].fltQtdBas := 0.0;
  End;

  stlEspecial := TStringList.Create;

  Try
    stlEspecial.LoadFromFile(strPatSal + '\ESPECIAL.TXT');
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

      blnResult := fGravaCadSal(qryCadSal,
                                strCodPro,
                                strLinha,
                                strMaisCo,
                                strDescri,
                                strVariac,
                                strMontad,
                                strAnoCor,
                                fltPreCus,
                                fltPreVen,
                                arrBasSal,
                                intAutInc,
                                '');

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

function fGravaCadSal(qryCadSal: TUniQuery;
                      strCodPro,
                      strLinha,
                      strMaisCo,
                      strDescri,
                      strVariac,
                      strMontad,
                      strAnoCor: String;
                      fltPreCus,
                      fltPreVen: Double;
                      arrBasSal: Array Of TBasSal;
                      Var intAutInc: Integer;
                      strPasso: String): Boolean;
  Var
    intContador: Integer;
    strMd5: String;
begin
  qryCadSal.Append;
  qryCadSal.FieldByName('SAL_CODSEQ').AsString := fStrZero(intAutInc, 6);
  qryCadSal.FieldByName('SAL_LINHA_').AsString := strLinha;
  qryCadSal.FieldByName('SAL_MONTAD').AsString := strMontad;
  qryCadSal.FieldByName('SAL_DESCRI').AsString := strDesCri + IIF(Not fEmptyStr(strMaisCo), ' ' + strMaisCo, '');
  qryCadSal.FieldByName('SAL_CODPRO').AsString := strCodPro;
  qryCadSal.FieldByName('SAL_PRECUS').AsFloat  := fltPreCus;
  qryCadSal.FieldByName('SAL_PREVEN').AsFloat  := fltPreCus;
  qryCadSal.FieldByName('SAL_ANOCOR').AsString := strAnoCor;
  qryCadSal.FieldByName('SAL_VARIAC').AsString := strVariac;
  qryCadSal.FieldByName('SAL_PASSO_').AsString := strPasso;

  For intContador := Low(arrBasSal) To High(arrBasSal) Do
  Begin
    qryCadSal.FieldByName('SAL_FORM' + fStrZero(intContador+1, 2)).AsString := arrBasSal[intContador].strCodBas;
    qryCadSal.FieldByName('SAL_QTDB' + fStrZero(intContador+1, 2)).AsFloat  := arrBasSal[intContador].fltQtdBas;
  End;

  qryCadSal.FieldByName('SAL_CODEMP').AsString := VS_strCodEmp;
  qryCadSal.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp);

  strMd5 := '';
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODSEQ').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODPRO').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_LINHA_').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_DESCRI').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_MONTAD').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_ANOCOR').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_VARIAC').AsString;

  qryCadSal.FieldByName('SAL_MD5KEY').AsString := GetMD5(strMd5);
  qryCadSal.Post;

  Inc(intAutInc);

  Result := True;
end;

{ SalcomixDinamica }

constructor TSalcomixDinamica.Create(AOwner: TComponent);
begin
  NomeTinta := 'Salcomix Automotiva';
  inherited;
end;

function TSalcomixDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM SAL_CADNFM';
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
  Result := True;
end;

procedure pGeraSQLServerSalcomix(qryCadSal: TUniQuery; Var intAutInc: Integer);
  Var
    salcomix: TSalcomixSQLServer;
begin
  salcomix := TSalcomixSQLServer.Create(qryCadSal, intAutInc);
  salcomix.pGerarCores;
  intAutInc := salcomix.fGetAutInc;
  FreeAndNil(salcomix);
end;

end.
