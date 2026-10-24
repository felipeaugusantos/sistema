unit untLazzumixAutomotivaDinamica;

interface

uses  Classes,  Forms, SysUtils, StrUtils,
  Uni, DateUtils, untTintadeMaquina, UniClientDataSet, DB, Variants;

Type
  TLazzumixAutomotivaDinamica = class(TTintadeMaquina)
  public
    constructor Create(AOwner: TComponent); override;
    function fGravarNovasFormulas(): Boolean; override;
  End;

  function fFormataFloatLaz(fltValor: Double): Double;
  function fLazzumixGeraArquivoDinamica(intOpcao: Integer): Boolean;
  function fGravaLazCadMix(strCodigo,
                           strDescri,
                           strRefere,
                           strAno,
                           strMontad,
                           strUniver: String;
                           Var intAutInc: Integer): Boolean;

  function fGravaLazMixFor(strCodigo,
                           strDilCon: String;
                           fltQtdPro: Double;
                           intNumBas: Integer;
                           strCodBas: String;
                           fltGraAcm: Double;
                           strUniGer: String): Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormula(strCodPro: String);
  function fContaLinhas(strNomArq: String): Integer;
  function fGravarFormulasPersonalizadas(): Boolean;
  function fGetReferencia(strCodBas: String): string;

  procedure pGerarBases;

  procedure pVerificarVolMinConDil;
  procedure pAtualizarVolMinConDil(pTipoVolume : String; strMixCodigo : String ;
                                   intVolumePro : Integer; fltValorMinAux: Double; fltVolume : Double );

  function fTxtCorreto(strLazSO, strPatLfo: String): Boolean;
  function fTxtCorretoBases(strPatLba, strLazSO: String): Boolean;

implementation

uses untModuloTinta, untFuncoesSimples, untFuncoes, untIConfTinta, untFuncTinta;

function fLazzumixGeraArquivoDinamica(intOpcao: Integer): Boolean;
  Var
    strPatLpr: String;
    strPatLfo: String;
    arqLazTxt: TextFile;

    strCodigo: String;
    strDescri: String;
    strRefere: String;
    strAnoTin: String;
    strLin005: String;
    strUniver: String;
    strMontad: String;
    strLin08: String;
    strLin09: String;
    strLin10: String;
    strLin11: String;
    strLin12: String;

    intQtdLin: Integer;
    blnGraReg: Boolean;
    intContador: Integer;

    intContProc: Integer;
    intContador2: Integer;

    strDilCon: String;
    strAnterior: String;
    strLazQua: String;
    strNumBas: String;
    strCodBas: String;
    strQtdGra: String;
    fltQtdPro: Double;
    intPosSpc: Integer;

    intAutInc: Integer;
    qryCadNfm: TUniQuery;

    fltValAcu: Double;
    fltQtdGra: Double;

    ArqMixFor: TextFile;
    strLinha: String;
    conf: IConfTinta;
    intIndiceCorrecao: Integer;
begin
  Result := True;

  {******************************}
  {* GERAR BASES.               *}
  {***************************MV*}
  If (intOpcao = 3) Then
  Begin
    pGerarBases;
  End;

  if (intOpcao = 0) Or (intOpcao = 2) then
  begin
    fltValAcu := 0;
    conf := fGetConfTinta('LAZ');
    strPatLpr := conf.fGet('LAZPPR');
    strPatLfo := conf.fGet('LAZPFO');

    If (Not FileExists(strPatLpr)) Then
    Begin
      Result := False;
      fMensagem('', 'Não foi possivel encontrar o arquivo de atualização PRODUTO.TXT no ' +
                    'diretorio ' + strPatLpr, ['&Ok']);
      Exit;
    End;

    If (fArqIniTinta(0, 'USA_FORMUL', 'LAZ', 'S') = 'S') Then
    Begin
      If (Not FileExists(strPatLfo)) Then
      Begin
        Result := False;
        fMensagem('', 'Não foi possivel encontrar o arquivo de atualização FORMULA.TXT no ' +
                      'diretorio ' + strPatLfo, ['&Ok']);
        Exit;
      End;
    End;

    If Not fTxtCorreto(conf.fGet('LAZ_SO'), strPatLfo) then
    Begin
      Result := False;
      fMensagem('', 'Favor alterar as configurações para : '+IIF(conf.fGet('LAZ_SO') = 'W','Dos','Windows'), ['&Ok']);
      Exit;
    End;

    {*****************************************}
    {* ZAPEIA ARQUIVO DE PRODUTOS            *}
    {**************************************MV*}
    pZapTable('LAZ_CADMIX');

    intQtdLin := 12;
    intAutInc := 0;

    AssignFile(arqLazTxt, strPatLpr);
    Reset(arqLazTxt);

    While (Not Eof(arqLazTxt)) Do
    Begin

      Application.ProcessMessages;

      blnGraReg := False;

      For intContador := 1 To intQtdLin Do
      Begin

        Case intContador Of

          01: Begin
                ReadLn(arqLazTxt, strCodigo);
                If (Not fEmptyStr(strCodigo)) Then
                  blnGraReg := True;
              End;
          02: ReadLn(arqLazTxt, strDescri);
          03: ReadLn(arqLazTxt, strRefere);
          04: ReadLn(arqLazTxt, strAnoTin);
          05: ReadLn(arqLazTxt, strLin005);
          06: ReadLn(arqLazTxt, strUniver);
          07: ReadLn(arqLazTxt, strMontad);
          08: ReadLn(arqLazTxt, strLin08);
          09: ReadLn(arqLazTxt, strLin09);
          10: ReadLn(arqLazTxt, strLin10);
          11: ReadLn(arqLazTxt, strLin11);
          12: ReadLn(arqLazTxt, strLin12);

        End;

      End;

      If (Not blnGraReg) Then
        Break;

      Application.ProcessMessages;

      If (Not fGravaLazCadMix(Trim(strCodigo),
                              Trim(strDescri),
                              Trim(strRefere),
                              Trim(strAnoTin),
                              Trim(strMontad),
                              Trim(strUniver),
                              intAutInc)) Then
      Begin
        Result := False;
        Break;
      End;

    End;

    fGravaAutoIncrem('LAZ_CADMIX', intAutInc);

    If (Not Result) Then
    Begin
      Exit;
    End;

    {*****************************************}
    {* ZAPEIA ARQUIVO DE PRODUTOS            *}
    {**************************************MV*}
    pZapTable('LAZ_MIXFOR');

    {*****************************************}
    {* IMPORTA ARQUIVO DE FORMULAS           *}
    {**************************************MV*}
    If conf.fGet('LAZ_SO') = 'W' Then
      intQtdLin := 7
    Else
      intQtdLin := 6;

    intContProc := 0;
    AssignFile(ArqMixFor, strPatLfo);
    Reset(ArqMixFor);

    strCodigo := '';
    While (Not Eof(ArqMixFor)) Do
    Begin

      If intContProc > 2000 Then
      Begin
        Application.ProcessMessages;
        intContProc := 0;
      End;

      Inc(intContProc);

      blnGraReg := False;
      intIndiceCorrecao := 0;
      For intContador2 := 1 To intQtdLin Do
      Begin

        Readln(ArqMixFor, strLinha);

        If (Ord(strLinha[1]) < 32) Then
        Begin
          Break;
        End;

        If conf.fGet('LAZ_SO') = 'W' Then
        Begin
          {****************************************************}
          {* A ANTIGA LINHA 3 NO ARQUIVO DA LAZZUMIX, É AGORA *}
          {* UM INDICADOR SE É TINTA ANTIGA OU NAO            *}
          {*************************************************MV*}
          Case intContador2 Of

            1:Begin
                strCodigo := strLinha;
                If (Not fEmptyStr(strCodigo)) Then
                Begin
                  blnGraReg := True;
                End;
              End;
            2: strDilCon   := Trim(strLinha);
            3: strAnterior := strLinha; // Linha 3: Anterior
            4: strLazQua   := Trim(strLinha);
            5:Begin

                strNumBas   := strLinha;
                If strNumBas = '0' Then
                Begin
                  intIndiceCorrecao := 1;
                End;
              End;
            6: strCodBas   := strLinha;
            7: strQtdGra   := strLinha;

          End;
        End
        Else
        Begin
          Case intContador2 Of

            1:Begin
                If Trim(strCodigo) <> Trim(strLinha) Then
                Begin
                  fltValAcu := 0;
                End;

                strCodigo := strLinha;
                If (Not fEmptyStr(strCodigo)) Then
                Begin
                  blnGraReg := True;
                End;
              End;
            2: strDilCon   := Trim(strLinha);
            3: strLazQua   := Trim(strLinha);
            4: strNumBas   := strLinha;
            5: strCodBas   := strLinha;
            6: strQtdGra   := strLinha;
          End;
        End;
      End;

      If (Pos('ANTERIOR', AnsiUpperCase(strAnterior)) > 0) Then
        Continue;

      If blnGraReg Then
      Begin

        If (LeftStr(strLazQua, 1) = Chr(171)) Or (LeftStr(strLazQua, 3) = '1/2') Then
        Begin
          fltQtdPro := 0.5;
        End
        Else
        Begin
          strLazQua  := Trim(strLazQua);
          intPosSpc := Pos(' ', strLazQua);
          fltQtdPro := fStrToFloat(Trim(LeftStr(strLazQua, intPosSpc-1)));
        End;

        strCodigo := Trim(strCodigo);
        strCodigo := AnsiReplaceStr(strCodigo, '.', '');

        strDilCon := Trim(strDilCon);
        strNumBas := Trim(strNumBas);
        strCodBas := Trim(strCodBas);
        strQtdGra := Trim(strQtdGra);

        If conf.fGet('LAZ_SO') = 'D' Then
          strQtdGra := AnsiReplaceStr(strQtdGra, '.', ',');

        Application.ProcessMessages;

        If (fArqIniTinta(0, 'USA_FORMUL', 'LAZ', 'S') = 'S') Then
        Begin

          If (Pos('QUARTO', AnsiUpperCase(strLazQua)) > 0) Or
             (Pos('CUARTO', AnsiUpperCase(strLazQua)) > 0) Or
             (Pos('ML', AnsiUpperCase(strLazQua)) > 0)     Then
          Begin

            {*****************************************}
            {* TRANSFORMA OS VALORES ACUMULADOS PARA *}
            {* ABSOLUTOS                             *}
            {**************************************MV*}
            If conf.fGet('ACUABS') = 'A' Then
            Begin

              fltQtdGra := fStrToFloat(strQtdGra);

              fltQtdGra := fltQtdGra - fltValAcu;

              fltValAcu := fltValAcu + fltQtdGra;

              strQtdGra := FloatToStr(fltQtdGra);

            End;

            If (Not fGravaLazMixFor(strCodigo,
                                    strDilCon,
                                    fltQtdPro,
                                    StrToInt(strNumBas)+intIndiceCorrecao,
                                    strCodBas,
                                    fStrToFloat(strQtdGra),
                                    strLazQua)) Then
            Begin
              Result := False;
              Exit;
            End;

          End;

        End;

      End;

    End;

    pVerificarVolMinConDil;

    CloseFile(ArqMixFor);

    qryCadNfm := fCriaQuery(Nil);
    qryCadNfm.SQL.Add('SELECT * FROM LAZ_CADNFM');
    qryCadNfm.Open;

    While (Not qryCadNfm.Eof) Do
    Begin
      fGeraNovasFormulas(qryCadNfm);
      qryCadNfm.Next;
    End;

    FreeAndNil(qryCadNfm);
  end;

  if (intOpcao = 1) Or (intOpcao = 2) Then
  begin
    Result := Result And fGravarFormulasPersonalizadas;
  end;
end;

function fGravaLazCadMix(strCodigo,
                         strDescri,
                         strRefere,
                         strAno,
                         strMontad,
                         strUniver: String;
                         Var intAutInc: Integer): Boolean;
begin

  Try

    With frmModuloTinta.qryLaz_CadMix Do
    Begin

      If (Not Active) Then
      Begin
        Open;
      End;

      Insert;
      FieldByName('MIX_CODIGO').AsString  := AnsiReplaceStr(strCodigo, '.', '');
      FieldByName('MIX_DESCRI').AsString  := strDescri;
      FieldByName('MIX_REFERE').AsString  := strRefere;
      FieldByName('MIX_A_N_O_').AsString  := RightStr(strAno, 4);
      FieldByName('MIX_MONTAD').AsString  := strMontad;
      FieldByName('MIX_UNIVER').AsString  := strUniver;
      FieldByName('MIX_CODEMP').AsString  := VS_strCodEmp;
      //FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('LAZ_CADMIX', VS_strCodEmp);
      FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp);
      FieldByName('MIX_ATIVAD').AsString := 'S';
      Post;
      Result := True;

      Inc(intAutInc);

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaLazCadMix]');
    End;
  End;

end;

function fGravaLazMixFor(strCodigo,
                         strDilCon: String;
                         fltQtdPro: Double;
                         intNumBas: Integer;
                         strCodBas: String;
                         fltGraAcm: Double;
                         strUniGer: String): Boolean;
  Const
    arrUnidadesBase: Array[1..5] Of Double = (1, 660, 675, 800, 4);
    arrUnidadesExcluidas: Array[1..15] Of Double = (0.5, 2, 3, 4, 300,
                                                    1320, 1980, 2640,
                                                    1600, 2400, 3200,
                                                    2700, 337, 1350, 2025);
  Var
    strSQL: String;
    qryAux: TUniQuery;
    function fUnidadeBase(fltValor: Double): Boolean;
      Var
        intContador: Integer;
    begin
      Result := False;
      For intContador := Low(arrUnidadesBase) To High(arrUnidadesBase) Do
      Begin
        If fFormataFloat(fltValor, 1) = fFormataFloat(arrUnidadesBase[intContador], 1) Then
        Begin
          Result := True;
          Break;
        End;
      End;
    end;

    function fUnidadeExcluida(fltValor: Double): Boolean;
      Var
        intContador: Integer;
    begin
      Result := False;
      For intContador := Low(arrUnidadesExcluidas) To High(arrUnidadesExcluidas) Do
      Begin
        If fFormataFloat(fltValor, 1) = fFormataFloat(arrUnidadesExcluidas[intContador], 1) Then
        Begin
          Result := True;
          Break;
        End;
      End;

    end;
begin

  Result := True;

  {***************************************}
  {* SE NÃO FOR 1 QUARTO, 660 ML OU      *}
  {* 800 ML, PULA E SE NECESSÁRIO AVISA  *}
  {************************************MV*}
  If (Not fUnidadeBase(fltQtdPro)) Then
  Begin
    If (Not fUnidadeExcluida(fltQtdPro)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Unidade não reconhecida: ' + strUniGer, ['&Ok']);
    End;

    Exit;
  End;

  qryAux := fCriaQuery(Nil);

  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  LAZ_CADMIX ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  MIX_BASE' + fStrZero(intNumBas, 2) + ' = :CODBAS, ';

    If LeftStr(strDilCon, 1) = 'C' Then
    Begin
      strSQL := strSQL + 'MIX_QTDC' + fStrZero(intNumBas, 2) + ' = :QTDGRA, ';
      strSQL := strSQL + 'MIX_VOLCON = :VOLUME ';

    End
    Else
    Begin
      strSQL := strSQL + 'MIX_QTDD' + fStrZero(intNumBas, 2) + ' = :QTDGRA, ';
      strSQL := strSQL + 'MIX_VOLDIL = :VOLUME ';
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MIX_CODIGO = :CODIGO ';

    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('CODBAS').AsString := strCodBas;
    qryAux.ParamByName('QTDGRA').AsFloat  := IIF(fltQtdPro = 4,fltGraAcm/4,fltGraAcm); //fltGraAcm; // adicionado quarto = 4 , porque estava dando diferenca na formulacao.
    qryAux.ParamByName('CODIGO').AsString := strCodigo;
    if fltQtdPro = 4 then // adicionado quarto = 4 , porque estava dando diferenca na formulacao.
      qryAux.ParamByName('VOLUME').AsFloat  := 900
    else
      qryAux.ParamByName('VOLUME').AsFloat  := IIF(fltQtdPro = 1, 900, fltQtdPro);
    qryAux.ExecSQL;
    qryAux.Close;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaLazMixFor]');
      Result := False;
    End;
  End;

  FreeAndNil(qryAux);

end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadMix: TUniQuery;
    intContador: Integer;
begin

  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

  qryCadMix := fCriaQuery(Nil);
  qryCadMix.SQL.Add('SELECT * FROM LAZ_CADMIX LIMIT 0');
  qryCadMix.Open;
  qryCadMix.Append;
  qryCadMix.FieldByName('MIX_CODIGO').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadMix.FieldByName('MIX_DESCRI').AsString  := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadMix.FieldByName('MIX_REFERE').AsString  := qryCadNfm.FieldByName('NFM_REFERE').AsString;
  qryCadMix.FieldByName('MIX_A_N_O_').AsString  := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
  qryCadMix.FieldByName('MIX_MONTAD').AsString  := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
  qryCadMix.FieldByName('MIX_UNIVER').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadMix.FieldByName('MIX_CODEMP').AsString  := VS_strCodEmp;
  qryCadMix.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('LAZ_CADMIX', VS_strCodEmp);
  qryCadMix.FieldByName('MIX_VOLCON').AsFloat   := qryCadNfm.FieldByName('NFM_VOLCON').AsFloat;
  qryCadMix.FieldByName('MIX_VOLDIL').AsFloat   := qryCadNfm.FieldByName('NFM_VOLDIL').AsFloat;

  For intContador := 1 To 20 Do
  Begin
    qryCadMix.FieldByName('MIX_BASE' + fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intContador, 2)).AsString;
    qryCadMix.FieldByName('MIX_QTDC' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intContador, 2)).AsFloat;
    qryCadMix.FieldByName('MIX_QTDD' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intContador, 2)).AsFloat;
  End;

  qryCadMix.Post;
  FreeAndNil(qryCadMix);

  Result := True;
end;

procedure pDeletaNovaFormula(strCodPro: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MIX_UNIVER = :CODPRO ';

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

{ TLazzumixAutomotivaDinamica }

constructor TLazzumixAutomotivaDinamica.Create(AOwner: TComponent);
begin
  NomeTinta := 'Lazzumix Automotiva';
  inherited;
end;

function TLazzumixAutomotivaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM LAZ_CADNFM';
  qryGen.Open;

  pRegistraAcao('Cadastrando novas formulas...');
  Result := True;
  
  While Not qryGen.Eof Do
  Begin
    Result := Result And fGeraNovasFormulas(qryGen);
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);

end;

function fContaLinhas(strNomArq: String): Integer;
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
      Application.ProcessMessages;
    End;

    CloseFile(arqGen);
  Except
    Result := 0;
  End;
end;

function fGravarFormulasPersonalizadas(): Boolean;
  Var
    strPat210,
    strPat211: String;

    cds210,
    cds211: TUniClientDataSet;

    dts210: TDataSource;

    strLinha: String;
    arqTxt: TextFile;
    intLinha: Integer;

    qryCadBas: TUniQuery;
    intProCod: Integer;
    qryCadNfm: TUniQuery;
    intCont: Integer;

    tinta: TLazzumixAutomotivaDinamica;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('LAZ');

  strPat210 := conf.fGet('PERSO210');
  strPat211 := conf.fGet('PERSO211');

  cds210 := TUniClientDataSet.Create(Nil);
  cds211 := TUniClientDataSet.Create(Nil);

  qryCadBas := fCriaQuery(Nil);
  qryCadNfm := fCriaQuery(Nil);
  Try
    cds210.FieldDefs.Add('CODIGO', ftString, 50, False);
    cds210.FieldDefs.Add('DESCRICAO', ftString, 50, False);
    cds210.FieldDefs.Add('ANO', ftString, 4, False);
    cds210.FieldDefs.Add('MONTADORA', ftString, 50, False);
    cds210.FieldDefs.Add('CODIGO UNIVERSAL', ftString, 50, False);
    cds210.FieldDefs.Add('MODELO', ftString, 50, False);
    cds210.FieldDefs.Add('TOTAL_GRAMAS', ftFloat, 0, False);
    cds210.FieldDefs.Add('TOTAL_ML', ftFloat, 0, False);
    cds210.CreateDataSet;
    dts210 := fCriaDataSource(cds210);

    cds211.FieldDefs.Add('CODIGO', ftString, 50, False);
    cds211.FieldDefs.Add('CODIGO_BASE', ftString, 50, False);
    if conf.fGetInteger('LINPER') = 4 then
      cds211.FieldDefs.Add('CODIGO_NOVO', ftString, 50, False);
    cds211.FieldDefs.Add('QUANTIDADE', ftFloat, 0, False);

    cds211.FieldDefs.Add('PESO_ESPECIFICO', ftFloat, 0, False);
    cds211.FieldDefs.Add('PORCENTAGEM', ftFloat, 0, False);
    cds211.FieldDefs.Add('QUANTIDADE_ML', ftFloat, 0, False);
    cds211.FieldDefs.Add('QUANTIDADE_ML_900', ftFloat, 0, False);
    cds211.FieldDefs.Add('QUANTIDADE_900', ftFloat, 0, False);
    cds211.CreateDataSet;

    AssignFile(arqTxt, strPat210);
    Reset(arqTxt);
    intLinha := 0;

    While Not Eof(arqTxt) Do
    Begin
      intLinha := intLinha + 1;
      Readln(arqTxt, strLinha);
      If (intLinha = 1) Then
      Begin
        cds210.Append;
      End;

      cds210.Fields[intLinha - 1].AsString := Trim(strLinha);

      If (intLinha = 6) Then
      Begin
        cds210.Post;
        intLinha := 0;
      End;
    End;

    CloseFile(arqTxt);

    AssignFile(arqTxt, strPat211);
    Reset(arqTxt);
    intLinha := 0;

    While Not Eof(arqTxt) Do
    Begin
      intLinha := intLinha + 1;
      Readln(arqTxt, strLinha);
      If (intLinha = 1) Then
      Begin
        cds211.Append;
      End;

      cds211.Fields[intLinha - 1].AsString := Trim(strLinha);

      If (intLinha = conf.fGetInteger('LINPER')) Then
      Begin
        cds211.Post;
        intLinha := 0;
      End;
    End;

    CloseFile(arqTxt);

    qryCadBas.SQL.Text := 'SELECT DISTINCT BAS_CODBAS, BAS_PESESP FROM LAZ_CADBAS';
    qryCadBas.Open;

    cds211.IndexFieldNames := 'CODIGO';
    cds211.MasterFields := 'CODIGO';
    cds211.MasterSource := dts210;

    cds210.First;
    cds211.First;

    While Not cds210.Eof Do
    Begin
      cds210.Edit;
      cds210.FieldByName('TOTAL_GRAMAS').AsFloat :=  0;
      cds210.FieldByName('TOTAL_ML').AsFloat :=  0;
      While Not cds211.Eof Do
      Begin
        If qryCadBas.Locate('BAS_CODBAS', varArrayOf([cds211.FieldByName('CODIGO_BASE').AsString]), []) Then
        Begin
          cds211.Edit;
          cds211.FieldByName('PESO_ESPECIFICO').AsFloat :=  qryCadBas.FieldByName('BAS_PESESP').AsFloat;

          cds211.FieldByName('QUANTIDADE_ML').AsFloat :=
            (cds211.FieldByName('QUANTIDADE').AsFloat / cds211.FieldByName('PESO_ESPECIFICO').AsFloat);

          cds211.Post;



          cds210.FieldByName('TOTAL_GRAMAS').AsFloat :=
            cds210.FieldByName('TOTAL_GRAMAS').AsFloat + cds211.FieldByName('QUANTIDADE').AsFloat;

          cds210.FieldByName('TOTAL_ML').AsFloat :=
            cds210.FieldByName('TOTAL_ML').AsFloat + cds211.FieldByName('QUANTIDADE_ML').AsFloat;
        End;
        cds211.Next;
      End;
      cds210.Post;
      cds210.Next;
    End;

    cds210.First;
    cds211.First;

    While Not cds210.Eof Do
    Begin
      While Not cds211.Eof Do
      Begin
        If qryCadBas.Locate('BAS_CODBAS', varArrayOf([cds211.FieldByName('CODIGO_BASE').AsString]), []) Then
        Begin
          cds211.Edit;
          cds211.FieldByName('QUANTIDADE_ML_900').AsFloat :=
            cds211.FieldByName('QUANTIDADE_ML').AsFloat * 900 / cds210.FieldByName('TOTAL_ML').AsFloat;

          cds211.FieldByName('QUANTIDADE_900').AsFloat :=
            cds211.FieldByName('QUANTIDADE_ML_900').AsFloat * cds211.FieldByName('PESO_ESPECIFICO').AsFloat;

          cds211.Post;

        End;
        cds211.Next;
      End;
      cds210.Next;
    End;

    intProCod := conf.fGetInteger('PRONFM') + 1; //StrToIntDef(fArqIniTinta(0, 'LAZZUMIX', 'PRONFM', '00001'), 0) + 1;

    qryCadNfm.SQL.Add(' INSERT INTO LAZ_CADNFM ');
    qryCadNfm.SQL.Add('             (NFM_CODNFM, ');
    qryCadNfm.SQL.Add('              NFM_DESCRI, ');
    qryCadNfm.SQL.Add('              NFM_DTACAD, ');

    For intCont := 1 To 20 Do
    Begin
      qryCadNfm.SQL.Add('              NFM_CODB' + fStrZero(intCont, 2) + ', ');
      qryCadNfm.SQL.Add('              NFM_QTDB' + fStrZero(intCont, 2) + ', ');
      qryCadNfm.SQL.Add('              NFM_QTDD' + fStrZero(intCont, 2) + ', ');
    End;

    qryCadNfm.SQL.Add('              NFM_VOLCON, ');
    qryCadNfm.SQL.Add('              NFM_VOLDIL, ');
    qryCadNfm.SQL.Add('              AUTOINCREM, ');
    qryCadNfm.SQL.Add('              NFM_REFERE, ');
    qryCadNfm.SQL.Add('              NFM_MONTAD, ');
    qryCadNfm.SQL.Add('              NFM_A_N_O_) ');
    qryCadNfm.SQL.Add(' VALUES (:NFM_CODNFM, ');
    qryCadNfm.SQL.Add('         :NFM_DESCRI, ');
    qryCadNfm.SQL.Add('         :NFM_DTACAD, ');

    For intCont := 1 To 20 Do
    Begin
      qryCadNfm.SQL.Add('         :NFM_CODB' + fStrZero(intCont, 2) + ', ');
      qryCadNfm.SQL.Add('         :NFM_QTDB' + fStrZero(intCont, 2) + ', ');
      qryCadNfm.SQL.Add('         :NFM_QTDD' + fStrZero(intCont, 2) + ', ');
    End;

    qryCadNfm.SQL.Add('         :NFM_VOLCON, ');
    qryCadNfm.SQL.Add('         :NFM_VOLDIL, ');
    qryCadNfm.SQL.Add('         :AUTOINCREM, ');
    qryCadNfm.SQL.Add('         :NFM_REFERE, ');
    qryCadNfm.SQL.Add('         :NFM_MONTAD, ');
    qryCadNfm.SQL.Add('         :NFM_A_N_O_); ');

    cds210.First;
    while Not cds210.Eof do
    Begin
      qryCadNfm.ParamByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(intProCod, 6);
      qryCadNfm.ParamByName('NFM_DESCRI').AsString := cds210.FieldByName('DESCRICAO').AsString; //Trim(cds210.FieldByName('CODIGO').AsString + ' ' +
//        cds210.FieldByName('CODIGO UNIVERSAL').AsString + ' (' + cds210.FieldByName('MODELO').AsString + ')');
      qryCadNfm.ParamByName('NFM_DTACAD').AsDate := Now();
      qryCadNfm.ParamByName('NFM_VOLCON').AsFloat:= 900;
      qryCadNfm.ParamByName('NFM_VOLDIL').AsFloat := 900;
      qryCadNfm.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LAZ_CADNFM', VS_strCodEmp);
      qryCadNfm.ParamByName('NFM_REFERE').AsString := '';
      qryCadNfm.ParamByName('NFM_MONTAD').AsString := cds210.FieldByName('MONTADORA').AsString;
      qryCadNfm.ParamByName('NFM_A_N_O_').AsString := cds210.FieldByName('ANO').AsString;

      For intCont := 1 To 20 Do
      Begin
        qryCadNfm.ParamByName('NFM_CODB' + fStrZero(intCont, 2)).Value := Null;
        qryCadNfm.ParamByName('NFM_QTDB' + fStrZero(intCont, 2)).Value := Null;
        qryCadNfm.ParamByName('NFM_QTDD' + fStrZero(intCont, 2)).Value := Null;
      End;

      For intCont := 1 To cds211.RecordCount Do
      Begin
        cds211.RecNo := intCont;

        If (fEmptyStr(qryCadNfm.ParamByName('NFM_REFERE').AsString)) Then
          qryCadNfm.ParamByName('NFM_REFERE').AsString := fGetReferencia(cds211.FieldByName('CODIGO_BASE').AsString);

        qryCadNfm.ParamByName('NFM_CODB' + fStrZero(intCont, 2)).AsString := cds211.FieldByName('CODIGO_BASE').AsString;
        qryCadNfm.ParamByName('NFM_QTDB' + fStrZero(intCont, 2)).AsFloat := cds211.FieldByName('QUANTIDADE_900').AsFloat;
        qryCadNfm.ParamByName('NFM_QTDD' + fStrZero(intCont, 2)).AsFloat := 0;
      End;

      Try
        qryCadNfm.ExecSQL;
        intProCod := intProCod + 1;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, 'untLazzumixAutomotivaDinamica.fGravarFormulasPersonalizadas');
        End;
      End;

      cds210.Next;
    End;

    conf.pSet('PRONFM', IntToStr(intProCod + 1)); //fArqIniTinta(1, 'LAZZUMIX', 'PRONFM', IntToStr(intProCod + 1));

  Except
    On E: Exception Do
  End;

  if Assigned(cds210) then
    cds210.Free;

  if Assigned(cds211) then
    cds211.Free;

  if Assigned(qryCadBas) then
    qryCadBas.Free;

  if Assigned(qryCadNfm) then
    qryCadNfm.Free;

  tinta := TLazzumixAutomotivaDinamica.Create(Nil);
  Result := tinta.fGravarNovasFormulas();
  FreeAndNil(tinta);
end;

function fGetReferencia(strCodBas: String): string;
Begin
  Result := '';
  If (LeftStr(strCodBas, 2) = 'FC') Then
    Result := 'FLEET COLOR'
  Else
  If (LeftStr(strCodBas, 2) = 'LM') Then
    Result := 'LAZZUCRIL'
  Else
  If (LeftStr(strCodBas, 2) = 'LM') Then
    Result := 'LAZZUDUR'
  Else
  If (LeftStr(strCodBas, 2) = 'PU') Then
  Result := 'LAZZUDUR PU MS'
  Else
  If (LeftStr(strCodBas, 2) = 'LL') Then
  Result := 'LAZZULAC'
  Else
  If (LeftStr(strCodBas, 2) = 'LS') Then
  Result := 'LAZZURIL'
  Else
  If (LeftStr(strCodBas, 2) = 'HS') Then
  Result := 'POLIESTER HS'
  Else
  If (LeftStr(strCodBas, 2) = 'LP') Then
    Result := 'POLIURETANO';
End;

procedure pGerarBases;
  Var
    strPatLba: String;
    conf: IConfTinta;
    stlBases: TStringList;
    intContador: Integer;

    strCodBas: String;
    strDesBas: String;
    strEmbala: String;
    fltEmbala: Double;

    procedure pTentaInterpretarBase;
      Var
        strPrimeiroCaracter: String;
        intPos: Integer;
    begin
      fltEmbala := 0.0;
      strPrimeiroCaracter := LeftStr(strEmbala, 1);

      If fIsNumber(strPrimeiroCaracter) Then
      Begin
        intPos := Pos(' ', strEmbala)-1;
        If intPos <= 0 Then
          intPos := Length(strEmbala);

        strEmbala := Trim(LeftStr(strEmbala, intPos));
        fltEmbala := fStrToFloat(strEmbala) * 1000;
      End
      Else if (strEmbala = 'LITRO') Then
        fltEmbala := 1000
      Else if (strEmbala = 'QUARTO') Then
        fltEmbala := 900
      Else If (strEmbala = 'FRASCO') Then
      Begin
        fltEmbala := 240;
      End
      Else If (strEmbala = 'GALAO') Then
        fltEmbala := 3600
      Else If (strEmbala = 'TAMBOR') Then
        fltEmbala := 198000;

    end;

    procedure pCadastrarBase;
      Var
        qryAux: TUniQuery;
    begin
      pTentaInterpretarBase;
      
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Add('SELECT * FROM LAZ_CADBAS WHERE BAS_CODBAS = :CODBAS');
      qryAux.ParamByName('CODBAS').AsString := strCodBas;
      qryAux.Open;

      If qryAux.IsEmpty Then
      Begin
        qryAux.Append;
        qryAux.FieldByName('BAS_CODBAS').AsString := strCodBas;
        qryAux.FieldByName('BAS_DESBAS').AsString := strDesBas;
        qryAux.FieldByName('BAS_EMBALA').AsFloat  := fltEmbala;
        qryAux.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LAZ_CADBAS', VS_strCodEmp);
        qryAux.Post;
      End;

      FreeAndNil(qryAux);
    end;
begin
  conf := fGetConfTinta('LAZ');

  strPatLba := conf.fGet('LAZPBA');

  If (Not FileExists(strPatLba)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Arquivo (' + strPatLba + ') não foi encontrado. Favor verificar.', ['&Ok']);
    Exit;
  End;

  If (Not fTxtCorretoBases(strPatLba, conf.fGet('LAZ_SO'))) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Layout do arquivo de bases está fora do padrão de geração!', ['&Ok']);
    Exit;
  End;


  stlBases := TStringList.Create;
  stlBases.LoadFromFile(strPatLba);

  intContador := 0;
  While (intContador < stlBases.Count-1) Do
  Begin

    strCodBas := Trim(stlBases[intContador]);
    Inc(intContador);

    strEmbala := Trim(stlBases[intContador]);
    Inc(intContador);

    strDesBas := Trim(stlBases[intContador]);
    Inc(intContador, 2);

    pCadastrarBase;

    Application.ProcessMessages;

  End;

  FreeAndNil(stlBases);

end;

function fTxtCorreto(strLazSO, strPatLfo: String): Boolean;
Var
  ArqMixFor: TextFile;
  intCont: Integer;
  strLinha: String;
begin
  Result := True;

  AssignFile(ArqMixFor, strPatLfo);
  Reset(ArqMixFor);

  For intCont := 1 to 7 Do // Numero de linhas da formulacao
  Begin
    Readln(ArqMixFor, strLinha);

    if (intCont = 6) and (Length(strLinha) = 11) then
    begin
      if strLazSO = 'W' then
      begin
        Result := False;
        Break;
      end;
    end
    else
      if (intCont = 7) then
      begin
        if strLazSO = 'D' then
        begin
          Result := False;
          Break;
        end;
      end;
  End;

end;

function fTxtCorretoBases(strPatLba, strLazSO: String): Boolean;
Var
  stlArqBases: TStringList;
begin

  Try
    stlArqBases := TStringList.Create;
    stlArqBases.LoadFromFile(strPatLba);
    Try
      Result := true;
    Except
      Result := false;
    End;
  Finally
    FreeAndNil(stlArqBases);
  End;
end;

procedure pVerificarVolMinConDil;
var
  qryValMin         : TUniQuery;
  intIdx            : Integer;

  intVolumeProC     : Integer;
  intVolumeProD     : Integer;

  fltValorMinAuxC   : Double;
  fltValorMinAuxD   : Double;

  fltValorAtualAuxC : Double;
  fltValorAtualAuxD : Double;

  fltVolumeC        : Double;
  fltVolumeD        : Double;

  strCampoTabelaC   : String;
  strCampoTabelaD   : String;
begin

  try
    qryValMin := fCriaQuery(Nil);

    qryValMin.Close;
    qryValMin.SQl.Text := ' SELECT * '+
                          '   FROM LAZ_CADMIX ';
    qryValMin.Open;

    While not (qryValMin.Eof) do
    begin
      {***** Alimenta as variáveis do volume concentrado ****** }
      fltVolumeC       := qryValMin.FieldByName('MIX_VOLCON').AsFloat;
      intVolumeProC    := qryValMin.FieldByName('MIX_VOLCON').AsInteger;
      fltValorMinAuxC  := fFormataFloatLaz(qryValMin.FieldByName('MIX_QTDC01').AsFloat);

      {***** Alimenta as variáveis do volume Diluído ****** }
      fltVolumeD       := qryValMin.FieldByName('MIX_VOLDIL').AsFloat;
      intVolumeProD    := qryValMin.FieldByName('MIX_VOLDIL').AsInteger;
      fltValorMinAuxD  := fFormataFloatLaz(qryValMin.FieldByName('MIX_QTDD01').AsFloat);

      {***** Inicio : Faz a comparação entre as todas quantidades Diluidas e Concentradas do registro para armanezar a "menor" ******* }

      for intIdx := 2 to 20 do
      begin
        if (intIdx < 10 ) then
        begin
          strCampoTabelaC  := 'MIX_QTDC0' + IntToStr(intIdx);
          strCampoTabelaD  := 'MIX_QTDD0' + IntToStr(intIdx);
        end
        else
        begin

          strCampoTabelaC  := 'MIX_QTDC' + IntToStr(intIdx);
          strCampoTabelaD  := 'MIX_QTDD' + IntToStr(intIdx);
        end;

        fltValorAtualAuxC := fFormataFloatLaz(qryValMin.FieldByName(strCampoTabelaC).AsFloat);
        fltValorAtualAuxD := fFormataFloatLaz(qryValMin.FieldByName(strCampoTabelaD).AsFloat);

        {  Concentrado }
        if (fltValorMinAuxC = 0 )then
          fltValorMinAuxC := fltValorAtualAuxC;

        if (fltValorAtualAuxC < fltValorMinAuxC) and (fltValorAtualAuxC > 0)then
          fltValorMinAuxC := fltValorAtualAuxC;

        {  Diluído }
        if (fltValorMinAuxD = 0) then
          fltValorMinAuxD := fltValorAtualAuxD;

        if (fltValorAtualAuxD < fltValorMinAuxD) and (fltValorAtualAuxD > 0)then
          fltValorMinAuxD := fltValorAtualAuxD;
      end;

      {***** Fim : Faz a comparação entre as todas quantidades Diluidas e Concentradas do registro para armanezar a "menor" ******* }

      if (intVolumeProC > 0) and (fltValorMinAuxC > 0) then
        pAtualizarVolMinConDil('C', qryValMin.FieldByName('MIX_CODIGO').AsString, intVolumeProC, fltValorMinAuxC, fltVolumeC);

      if (intVolumeProD > 0) and (fltValorMinAuxD > 0) then
        pAtualizarVolMinConDil('D', qryValMin.FieldByName('MIX_CODIGO').AsString, intVolumeProD, fltValorMinAuxD, fltVolumeD);

      qryValMin.Next;
    end;
  finally
    pFreeAndNil(qryValMin);
  end;
end;

procedure pAtualizarVolMinConDil(pTipoVolume : String; strMixCodigo : String ;  intVolumePro : Integer; fltValorMinAux: Double; fltVolume : Double );
var
  intIdx      : Integer;
  fltQtdMin   : Double;
  strSQl      : string;
  qryAux      : TUniQuery;
  fltVolResult: Double;
  fltFator    : Double;
begin

  fltFator := 0.50;

  if (fltValorMinAux >= 0.1600) and  (fltValorMinAux < 0.2600) then
    fltFator := 0.70
  else
  if (fltValorMinAux >= 0.2600) and  (fltValorMinAux < 0.3600) then
    fltFator := 0.80
  else
  if (fltValorMinAux >= 0.3600) and  (fltValorMinAux < 0.4600) then
    fltFator := 0.85
  else
  if (fltValorMinAux >= 0.4600) and  (fltValorMinAux < 0.6600) then
    fltFator := 0.90
  else
  if (fltValorMinAux >= 0.6600) and  (fltValorMinAux < 1.2600) then
    fltFator := 0.95
  else
  if (fltValorMinAux >= 1.2600) then
    fltFator := 1.00;

  fltVolResult := intVolumePro;

  for intIdx := 0 to intVolumePro do
  begin

    fltVolResult := (fltVolResult - fltFator);

    fltQtdMin := fFormataFloatLaz(fFormataFloatLaz(fltValorMinAux)  * fFormataFloatLaz(fltVolResult) / fltVolume);

    if (fltQtdMin = 0) or (fltVolResult = 0) then
    begin
      strSQl := '';
      strSQl := 'UPDATE LAZ_CADMIX ';

      if  (pTipoVolume = 'C') then // Concentrado
        strSQl := strSQl + ' SET MIX_VOLMIC = :MIX_VOLMIN '
      else  // Diluído
        strSQl := strSQl + ' SET MIX_VOLMID = :MIX_VOLMIN ';

      strSQl := strSQl + ' WHERE MIX_CODIGO = :MIX_CODIGO ';

      try
        qryAux          := fCriaQuery(Nil);
        qryAux.SQl.Text := strSQl;

        if (fltQtdMin = 0) and (intVolumePro > 0) then
          qryAux.ParamByName('MIX_VOLMIN').AsFloat := ((fltVolResult + fltFator)/1000)
        else
          qryAux.ParamByName('MIX_VOLMIN').AsFloat := 0;

        qryAux.ParamByName('MIX_CODIGO').AsString := strMixCodigo;

        qryAux.ExecSQL;
      finally
       pFreeAndNil(qryAux);
      end;

      Break;
    end;
  end;
end;

function fFormataFloatLaz(fltValor: Double): Double;
var
  strValor: String;
  strValor2: String;
begin
  Result   := fltValor;
  strValor := FloatToStr(fltValor);
  if Pos(',',strValor) > 0 then
    strValor2 := Copy(strValor,Pos(',',strValor) + 2,1)
  else
    strValor2 := '0';

  if strValor2 > '5' then
  begin
    strValor2 := Copy(strValor,1,Pos(',',strValor) + 2);
    strValor2 := FormatFloat('###,#0.0',fStrToFloat(strValor2));
    Result := fStrToFloat(strValor2);
  end
  else if strValor2 > '0' then
  begin
     strValor2 := Copy(strValor,1,Pos(',',strValor) + 1);
     Result := fStrToFloat(strValor2);
  end;
end;

end.
