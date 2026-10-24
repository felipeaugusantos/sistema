{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Lazzumix *}
{**********************************************************************PH*}
unit untGravandoExecucaoLazzumixCores;

interface

uses
  untAbstractGravandoExecucaoLazzumix, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, untTipoCadastro, untFloatUtils, Classes;

type
  TGravandoExecucaoLazzumixCores = class(TAbstractGravandoExecucaoLazzumix)
  private
    strCodNfm : String;
    strCodAnt : String;
    fltQtdAnt : Double;
    blnIgnorar        : Boolean;
    blnValidarUnidade : Boolean;

    function fGravaLazMixFor(strCodigo,
                             strDilCon : String;
                             fltQtdPro : Double;
                             intNumBas : Integer;
                             strCodBas : String;
                             fltGraAcm : Double;
                             strUniGer : String;
                             blnIgnorar: Boolean;
                             blnValidarUnidade : Boolean): Boolean;

    function fVolumeMaior(fltVolume: Double; strCodigo: String; strDilCon: String): Double;

    function fInsertProdutos: String;
    function fQuantidadeLinhasArqTxt(strArqTxt: String): Integer;
  public
    procedure CriarTmpLazCadMixProdutos(const gravando: IGravando);
    function CriarTmpLazCadMixFormulas(const gravando: IGravando): Boolean;
    procedure pVerificarVolMinConDil(const gravando: IGravando);
    procedure pAtualizarVolMinConDil(pTipoVolume : String; strMixCodigo : String ;
                                     intVolumePro : Integer; fltValorMinAux: Double;
                                     fltVolume : Double; qryValMin: IDataSet);

    procedure GerarLazCadMix(const gravando: IGravando);

    function fRetornaCamposTabela: String;
    function fRetornaCampo: String;
    constructor Create(const strCodNfm: string = '');
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoLazzumixCores }

procedure TGravandoExecucaoLazzumixCores.GerarLazCadMix(const gravando: IGravando);
var
  qryInsert: IDataSet;
begin
  if gravando.Status <> sgGravando then
    Exit;

  qryInsert := TAutcomTintaFactory.Get.fGetDataSet;
  qryInsert.SQL := 'SET @AUTO = 0;';
  qryInsert.ExecSQL;

  qryInsert.SQL :=

  ' INSERT INTO LAZ_CADMIX  ' +
  '  SELECT                 ' +
  '    MIX_CODIGO  ,        ' +
  '    MIX_CODEMP  ,        ' +
  '    MIX_DESCRI  ,        ' +
  '    MIX_REFERE  ,        ' +
  '    MIX_PRECO1  ,        ' +
  '    MIX_PRECO2  ,        ' +
  '    MIX_PRECO3  ,        ' +
  '    MIX_PRECO4  ,        ' +
  '    MIX_MONTAD  ,        ' +
  '    MIX_A_N_O_  ,        ' +
  '    CONCAT(''001'', LPAD(@AUTO := IFNULL(@AUTO, 0) + 1, 14, ''0''), ''001'') AUTOINCREM, ' +
  '    MIX_UNIVER  ,        ' +
  '    MIX_BASE01  ,        ' +
  '    MIX_QTDC01  ,        ' +
  '    MIX_QTDD01  ,        ' +
  '    MIX_BASE02  ,        ' +
  '    MIX_QTDC02  ,        ' +
  '    MIX_QTDD02  ,        ' +
  '    MIX_BASE03  ,        ' +
  '    MIX_QTDC03  ,        ' +
  '    MIX_QTDD03  ,        ' +
  '    MIX_BASE04  ,        ' +
  '    MIX_QTDC04  ,        ' +
  '    MIX_QTDD04  ,        ' +
  '    MIX_BASE05  ,        ' +
  '    MIX_QTDC05  ,        ' +
  '    MIX_QTDD05  ,        ' +
  '    MIX_BASE06  ,        ' +
  '    MIX_QTDC06  ,        ' +
  '    MIX_QTDD06  , ' +
  '    MIX_BASE07  , ' +
  '    MIX_QTDC07  , ' +
  '    MIX_QTDD07  , ' +
  '    MIX_BASE08  , ' +
  '    MIX_QTDC08  , ' +
  '    MIX_QTDD08  , ' +
  '    MIX_BASE09  , ' +
  '    MIX_QTDC09  , ' +
  '    MIX_QTDD09  , ' +
  '    MIX_BASE10  , ' +
  '    MIX_QTDC10  , ' +
  '    MIX_QTDD10  , ' +
  '    MIX_BASE11  , ' +
  '    MIX_QTDC11  , ' +
  '    MIX_QTDD11  , ' +
  '    MIX_BASE12  , ' +
  '    MIX_QTDC12  , ' +
  '    MIX_QTDD12  , ' +
  '    MIX_BASE13  , ' +
  '    MIX_QTDC13  , ' +
  '    MIX_QTDD13  , ' +
  '    MIX_BASE14  , ' +
  '    MIX_QTDC14  , ' +
  '    MIX_QTDD14  , ' +
  '    MIX_BASE15  , ' +
  '    MIX_QTDC15  , ' +
  '    MIX_QTDD15  , ' +
  '    MIX_VOLCON  , ' +
  '    MIX_VOLDIL  , ' +
  '    MIX_BASE16  , ' +
  '    MIX_QTDC16  , ' +
  '    MIX_QTDD16  , ' +
  '    MIX_BASE17  , ' +
  '    MIX_QTDC17  , ' +
  '    MIX_QTDD17  , ' +
  '    MIX_BASE18  , ' +
  '    MIX_QTDC18  , ' +
  '    MIX_QTDD18  , ' +
  '    MIX_BASE19  , ' +
  '    MIX_QTDC19  , ' +
  '    MIX_QTDD19  , ' +
  '    MIX_BASE20  , ' +
  '    MIX_QTDC20  , ' +
  '    MIX_QTDD20  , ' +
  '    MIX_CODNFM  , ' +
  '    MIX_ATIVAD  , ' +
  '    MIX_VOLMIC  , ' +
  '    MIX_VOLMID  , ' +
  '    MIX_ACRMOB  , ' +
  '    MIX_DTACAD    ' +
  '  FROM              ' +
  '    TMP_LAZ_CADMIX  ';
  qryInsert.ExecSQL;
end;

procedure TGravandoExecucaoLazzumixCores.pAtualizarVolMinConDil(pTipoVolume,
  strMixCodigo: String; intVolumePro: Integer; fltValorMinAux,
  fltVolume: Double; qryValMin: IDataSet);
var
  intCont     : Integer;
  fltQtdMin   : Double;
  fltVolResult: Double;
  fltFator    : Double;
  strCampo    : String;
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


  for intCont := 0 to intVolumePro * 2 do
  begin
    fltVolResult := (fltVolResult - fltFator);
    fltQtdMin := TFloatUtils.fFormataFloatLaz(fltValorMinAux  * fltVolResult / fltVolume);


    if (fltQtdMin = 0) or (fltVolResult = 0) then
    begin
      strCampo := '';

      if  (pTipoVolume = 'C') then // Concentrado
        strCampo := 'MIX_VOLMIC'
      else  // Diluído
        strCampo := 'MIX_VOLMID';

      qryValMin.Edit;
      If (fltQtdMin = 0) And (intVolumePro > 0) Then
        qryValMin.FieldByName(strCampo).AsFloat := ((fltVolResult + fltFator)/1000)
      Else
        qryValMin.FieldByName(strCampo).AsFloat := 0;
      qryValMin.Post;

      Break;
    end;
  end;
end;

procedure TGravandoExecucaoLazzumixCores.pVerificarVolMinConDil(const gravando: IGravando);
var
  qryValMin: IDataSet;
  intIdx: Integer;
begin
  qryValMin := TAutcomTintaFactory.Get.fGetDataSet;
  If (Not TStrUtils.fEmptyStr(strCodNfm)) Then
    qryValMin.SQL := 'SELECT * FROM LAZ_CADMIX WHERE MIX_CODIGO = ' + QuotedStr(strCodNfm)
  Else
    qryValMin.SQL := 'SELECT * FROM TMP_LAZ_CADMIX';
  qryValMin.Open;

  While not (qryValMin.Eof) do
  begin
    if gravando.Status <> sgGravando then
      Exit;

    {***** Alimenta as variáveis do volume concentrado ****** }
    fltVolumeC       := qryValMin.FieldByName('MIX_VOLCOF').AsFloat;
    intVolumeProC    := qryValMin.FieldByName('MIX_VOLCOF').AsInteger;
    fltValorMinAuxC  := (qryValMin.FieldByName('MIX_QTDC01').AsFloat);

    {***** Alimenta as variáveis do volume Diluído ****** }
    fltVolumeD       := qryValMin.FieldByName('MIX_VOLDIF').AsFloat;
    intVolumeProD    := qryValMin.FieldByName('MIX_VOLDIF').AsInteger;
    fltValorMinAuxD  := (qryValMin.FieldByName('MIX_QTDD01').AsFloat);

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

      fltValorAtualAuxC := (qryValMin.FieldByName(strCampoTabelaC).AsFloat);
      fltValorAtualAuxD := (qryValMin.FieldByName(strCampoTabelaD).AsFloat);

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
      pAtualizarVolMinConDil('C', qryValMin.FieldByName('MIX_CODIGO').AsString, intVolumeProC, fltValorMinAuxC, fltVolumeC, qryValMin);

    if (intVolumeProD > 0) and (fltValorMinAuxD > 0) then
      pAtualizarVolMinConDil('D', qryValMin.FieldByName('MIX_CODIGO').AsString, intVolumeProD, fltValorMinAuxD, fltVolumeD, qryValMin);

    gravando.RegistrarProgresso(0, qryValMin.RecNo, qryValMin.RecordCount);

    qryValMin.Next;
  end;
end;

constructor TGravandoExecucaoLazzumixCores.Create(const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

function TGravandoExecucaoLazzumixCores.CriarTmpLazCadMixFormulas(const gravando: IGravando): Boolean;
var
  intCont: Integer;

  Arq: TextFile;
  strLinha: String;
  intTotal: Integer;
  intRecNo: Integer;
  strQtdGraAnt : string;
begin
  Result    := False;
  blnGraReg := False;
  intQtdLin := 7;

  qryUpdFor := TAutcomTintaFactory.Get.fGetDataSet;

  Try
    AssignFile(Arq, GetPath(ttGeral, 2));

    Reset(Arq);

    strLinha := '';
    intTotal := fQuantidadeLinhasArqTxt(GetPath(ttGeral, 2));
    intRecNo := 0;

    strCodigo := '';
    While Not (Eof(Arq)) Do
    Begin

      If gravando.Status <> sgGravando Then
      Begin
        Result := False;
        Exit;
      End;

      blnGraReg := False;
      intIndiceCorrecao := 0;
      For intCont := 1 To intQtdLin Do
      Begin
        Readln(Arq, strLinha);

        If (Ord(strLinha[1]) < 32) Then
        Begin
          Break;
        End;

        Case intCont Of
          1:Begin
              strCodigo := strLinha;
              If (Not TStrUtils.fEmptyStr(strCodigo)) Then
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
      End;

      Inc(intRecNo);

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
          strLazQua := Trim(strLazQua);
          intPosSpc := Pos(' ', strLazQua);
          fltQtdPro := TAutcomTintaFactory.Get.fStrToFloat(Trim(LeftStr(strLazQua, intPosSpc-1)));
        End;

        strCodigo := Trim(strCodigo);
        strCodigo := AnsiReplaceStr(strCodigo, '.', '');

        strDilCon := Trim(strDilCon);
        strNumBas := Trim(strNumBas);
        strCodBas := Trim(strCodBas);
        strQtdGra := Trim(strQtdGra);

        If fCfgTin('USAFOR') = 'S' Then
        Begin
          If (Pos('QUARTO', AnsiUpperCase(strLazQua)) > 0) Or
             (Pos('CUARTO', AnsiUpperCase(strLazQua)) > 0) Or
             (Pos('ML', AnsiUpperCase(strLazQua)) > 0)     Then
          Begin
            {*****************************************}
            {* TRANSFORMA OS VALORES ACUMULADOS PARA *}
            {* ABSOLUTOS                             *}
            {**************************************MV*}
            If fCfgTin('ACUABS') = 'A' Then
            Begin
              fltQtdGra := TAutcomTintaFactory.Get.fStrToFloat(strQtdGra);
              fltQtdGra := fltQtdGra - fltValAcu;
              fltValAcu := fltValAcu + fltQtdGra;
              strQtdGra := FloatToStr(fltQtdGra);
            End;

            If (strNumBas = '1') Then
            Begin
              blnValidarUnidade := true;

              If (TAutcomTintaFactory.Get.fStrToFloat(strQtdGra) <= 0) Then
              begin
                strCodAnt     := strCodigo;
                fltQtdAnt     := fltQtdPro;
                strQtdGraAnt  := strQtdGra;

                blnIgnorar := True;
              end
              else
              If ((strCodAnt = strCodigo)And (fltQtdAnt  <> fltQtdPro)) Then
              Begin
                blnIgnorar        := false;
                blnValidarUnidade := (TAutcomTintaFactory.Get.fStrToFloat(strQtdGraAnt) > 0);
                strQtdGraAnt      := strQtdGra;
              End
              else
                blnIgnorar := false;
            End;

            If (Not fGravaLazMixFor(strCodigo,
                                    strDilCon,
                                    fltQtdPro,
                                    StrToInt(strNumBas)+intIndiceCorrecao,
                                    strCodBas,
                                    TAutcomTintaFactory.Get.fStrToFloat(strQtdGra),
                                    strLazQua,
                                    blnIgnorar,
                                    blnValidarUnidade)) Then
            Begin
              Result := False;
              Exit;
            End;

          End;
        End;
      End;

      Result := True;

      gravando.RegistrarProgresso(0, intRecNo, intTotal);
    End;
  Finally
    CloseFile(Arq);
  End;
end;

procedure TGravandoExecucaoLazzumixCores.CriarTmpLazCadMixProdutos(const gravando: IGravando);
var
  qryInsert: IDataSet;

  intCont: Integer;
  intTotal: Integer;
  intRecNo: Integer;

  Arq: TextFile;
  strLinha: String;
begin
  intCont := 0;

  qryInsert := TAutcomTintaFactory.Get.fGetDataSet;
  qryInsert.SQL := fInsertProdutos;

  Try
    AssignFile(Arq, GetPath(ttGeral, 1));

    Reset(Arq);

    strLinha := '';
    intTotal := fQuantidadeLinhasArqTxt(GetPath(ttGeral, 1));
    intRecNo := 0;

    While (Not Eof(Arq)) Do
    Begin
      if gravando.Status <> sgGravando then
      Begin
        Exit;
      End;

      Readln(Arq, strLinha);

      Inc(intCont);

      if Not(Pos('.pdf',strLinha) > 0) Then
      begin

        If intCont = 1 Then
        Begin
          If TStrUtils.fEmptyStr(strLinha) Then
            Exit;
        End;

        If (Pos(IntToStr(intCont), '1_2_3_4_6_7_') > 0) Then
          qryInsert.ParamByName(fRetCampoProduto(intCont)).AsString := fFormataCampoProduto(Trim(strLinha), intCont);

        If (Pos(IntToStr(intCont), '7_') > 0) Then
        Begin
          qryInsert.ParamByName('MIX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryInsert.ParamByName('MIX_ATIVAD').AsString := 'S';
          qryInsert.ExecSQL;
        End;

      End;

      If intCont = intQtdLin Then
      Begin
        intCont := 0;
      End;

      Inc(intRecNo);
      gravando.RegistrarProgresso(0, intRecNo, intTotal);
    End;
  Finally
    CloseFile(Arq);
  End;
end;

procedure TGravandoExecucaoLazzumixCores.Executar(const gravando: IGravando);
begin
  //Quando grava uma nova formula atualiza a quantidade minima a ser vendido
  If (Not TStrUtils.fEmptyStr(strCodNfm)) Then
  Begin
    pVerificarVolMinConDil(gravando);
    Exit;
  End;

  blnIgnorar        := false;
  blnValidarUnidade := true;

  //Geracao Normal
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath(ttGeral, 1)) Then
      Begin
        gravando.Texto  := 'Path para o geração do arquivo de PRODUTOS não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      If (Not fValidaPath(ttGeral, 2)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de FÓRMULAS não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      TAutcomTintaFactory.Get.DropTable('TMP_LAZ_CADMIX');

      TCriadorTabelas.CriarTabelas([ TAbstractCriadorTabela.Create('TMP_LAZ_CADMIX',
                                     fRetornaCamposTabela) ], gravando);

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LAZ_CADMIX');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Limpando LAZ_CADMIX...';
      TAutcomTintaFactory.Get.TruncateTable('LAZ_CADMIX');
      gravando.Texto := 'LAZ_CADMIX limpa com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Preenchendo tabela TMP_LAZ_CADMIX Produtos...';
      CriarTmpLazCadMixProdutos(gravando);

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Tabela TMP_LAZ_CADMIX Produtos preenchida com sucesso!';

      gravando.Texto := 'Preenchendo tabela TMP_LAZ_CADMIX Fórmulas...';
      If Not CriarTmpLazCadMixFormulas(gravando) Then
      Begin
        gravando.Texto := 'Não foi possível preencher a tabela TMP_LAZ_CADMIX Fórmulas...';
        gravando.Cancelar;
        Exit;
      End;
      gravando.Texto := 'Tabela TMP_LAZ_CADMIX Fórmulas preenchida com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Preenchendo tabela TMP_LAZ_CADMIX Volume Mínimo...';
      pVerificarVolMinConDil(gravando);
      gravando.Texto := 'Tabela TMP_LAZ_CADMIX Volume Mínimo preenchido com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Gerando LAZ_CADMIX...';
      GerarLazCadMix(gravando);
      gravando.Texto := 'LAZ_CADMIX gerado com sucesso!';
    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    TAutcomTintaFactory.Get.DropTable('TMP_LAZ_CADMIX');
  End;
end;

function TGravandoExecucaoLazzumixCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoLazzumixCores.fGravaLazMixFor(strCodigo,
  strDilCon: String; fltQtdPro: Double; intNumBas: Integer; strCodBas: String;
  fltGraAcm: Double; strUniGer: String; blnIgnorar: Boolean; blnValidarUnidade : boolean ): Boolean;
var
  fltVolume  : Double;
  fltVolumeFormula: Double;
begin
  Result := True;

  {***************************************}
  {* SE NÃO FOR 1 QUARTO, 660 ML OU      *}
  {* 800 ML, PULA E SE NECESSÁRIO AVISA  *}
  {************************************MV*}
  If blnIgnorar Then
    Exit;


  If blnValidarUnidade Then
  Begin
    If (Not fUnidadeBase(fltQtdPro)) Then
    Begin
      If (Not fUnidadeExcluida(fltQtdPro)) Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Unidade não reconhecida: ' + strUniGer, ['&Ok']);
        Result := False;
      End;

      Exit;
    End;
  End;

  qryUpdFor.SQL := ' UPDATE ' +
                   '   TMP_LAZ_CADMIX ' +
                   ' SET    ' +
                   '   MIX_BASE' + TStrUtils.fStrZero(intNumBas, 2) + ' = :CODBAS, ';

  If LeftStr(strDilCon, 1) = 'C' Then
  Begin
    qryUpdFor.SQL := qryUpdFor.SQL + ' MIX_QTDC' + TStrUtils.fStrZero(intNumBas, 2) + ' = :QTDGRA, ' +
                                     ' MIX_VOLCON = :VOLUME,    ' +
                                     ' MIX_VOLCOF = :VOLUMEFOR  ';

  End
  Else
  Begin
    qryUpdFor.SQL := qryUpdFor.SQL + ' MIX_QTDD' + TStrUtils.fStrZero(intNumBas, 2) + ' = :QTDGRA, ' +
                                     ' MIX_VOLDIL = :VOLUME,    ' +
                                     ' MIX_VOLDIF = :VOLUMEFOR  ';
  End;

  qryUpdFor.SQL := qryUpdFor.SQL +  ' WHERE ' +
                                    '  MIX_CODIGO = :CODIGO ';

  If fltQtdPro = 4 Then
    fltVolume := 900
  Else
    fltVolume := TAutcomTintaFactory.Get.IIF(fltQtdPro = 1, 900, fltQtdPro);

  If (fltVolume = 2) Then
    fltVolume := 1800;

  fltVolumeFormula := fltVolume;
  fltVolumeFormula := fVolumeMaior(fltVolumeFormula, strCodigo, strDilCon);

  qryUpdFor.ParamByName('CODIGO').AsString := strCodigo;
  qryUpdFor.ParamByName('CODBAS').AsString := strCodBas;
  qryUpdFor.ParamByName('QTDGRA').AsFloat  := TAutcomTintaFactory.Get.IIF(fltQtdPro = 4,fltGraAcm/4,fltGraAcm);
  qryUpdFor.ParamByName('VOLUME').AsFloat  := fltVolume;
  qryUpdFor.ParamByName('VOLUMEFOR').AsFloat := fltVolumeFormula;

  qryUpdFor.ExecSQL;
end;

function TGravandoExecucaoLazzumixCores.fInsertProdutos: String;
begin
  Result := ' INSERT INTO TMP_LAZ_CADMIX (MIX_CODIGO, MIX_DESCRI, MIX_REFERE, MIX_A_N_O_, MIX_UNIVER, MIX_MONTAD, MIX_CODEMP, MIX_ATIVAD) ' +
            ' VALUES ' +
            '                            (:MIX_CODIGO, :MIX_DESCRI, :MIX_REFERE, :MIX_A_N_O_, :MIX_UNIVER, :MIX_MONTAD, :MIX_CODEMP, :MIX_ATIVAD) ';
end;

function TGravandoExecucaoLazzumixCores.fQuantidadeLinhasArqTxt(
  strArqTxt: String): Integer;
var
  arqTexto    : TextFile;
  strLinha    : String;
  intContador : Longint;
begin
  Try
    AssignFile(ArqTexto, strArqTxt);
    Reset(ArqTexto);
    intContador := 0;

    While Not (Eof(ArqTexto)) do
    Begin
      ReadLn(ArqTexto, strLinha);
      Inc(intContador);
    End;

    Result := intContador;
  Finally
    CloseFile(ArqTexto);
  End;
end;

function TGravandoExecucaoLazzumixCores.fRetornaCampo: String;
begin
  Result := ' NOME VARCHAR(255) ';
end;

function TGravandoExecucaoLazzumixCores.fRetornaCamposTabela: String;
begin
  Result :=
  '                            MIX_CODIGO VARCHAR(15)   , ' +
  '                            MIX_CODEMP CHAR(3)       , ' +
  '                            MIX_DESCRI VARCHAR(25)   , ' +
  '                            MIX_REFERE VARCHAR(30)   , ' +
  '                            MIX_PRECO1 DECIMAL(14,3) , ' +
  '                            MIX_PRECO2 DECIMAL(14,3) , ' +
  '                            MIX_PRECO3 DECIMAL(14,3) , ' +
  '                            MIX_PRECO4 DECIMAL(14,3) , ' +
  '                            MIX_MONTAD VARCHAR(15)   , ' +
  '                            MIX_A_N_O_ VARCHAR(4)    , ' +
  '                            AUTOINCREM VARCHAR(20)   , ' +
  '                            MIX_UNIVER VARCHAR(15)   , ' +
  '                            MIX_BASE01 VARCHAR(10)   , ' +
  '                            MIX_QTDC01 DECIMAL(12,4) , ' +
  '                            MIX_QTDD01 DECIMAL(12,4) , ' +
  '                            MIX_BASE02 VARCHAR(10)   , ' +
  '                            MIX_QTDC02 DECIMAL(12,4) , ' +
  '                            MIX_QTDD02 DECIMAL(12,4) , ' +
  '                            MIX_BASE03 VARCHAR(10)   , ' +
  '                            MIX_QTDC03 DECIMAL(12,4) , ' +
  '                            MIX_QTDD03 DECIMAL(12,4) , ' +
  '                            MIX_BASE04 VARCHAR(10)   , ' +
  '                            MIX_QTDC04 DECIMAL(12,4) , ' +
  '                            MIX_QTDD04 DECIMAL(12,4) , ' +
  '                            MIX_BASE05 VARCHAR(10)   , ' +
  '                            MIX_QTDC05 DECIMAL(12,4) , ' +
  '                            MIX_QTDD05 DECIMAL(12,4) , ' +
  '                            MIX_BASE06 VARCHAR(10)   , ' +
  '                            MIX_QTDC06 DECIMAL(12,4) , ' +
  '                            MIX_QTDD06 DECIMAL(12,4) , ' +
  '                            MIX_BASE07 VARCHAR(10)   , ' +
  '                            MIX_QTDC07 DECIMAL(12,4) , ' +
  '                            MIX_QTDD07 DECIMAL(12,4) , ' +
  '                            MIX_BASE08 VARCHAR(10)   , ' +
  '                            MIX_QTDC08 DECIMAL(12,4) , ' +
  '                            MIX_QTDD08 DECIMAL(12,4) , ' +
  '                            MIX_BASE09 VARCHAR(10)   , ' +
  '                            MIX_QTDC09 DECIMAL(12,4) , ' +
  '                            MIX_QTDD09 DECIMAL(12,4) , ' +
  '                            MIX_BASE10 VARCHAR(10)   , ' +
  '                            MIX_QTDC10 DECIMAL(12,4) , ' +
  '                            MIX_QTDD10 DECIMAL(12,4) , ' +
  '                            MIX_BASE11 VARCHAR(10)   , ' +
  '                            MIX_QTDC11 DECIMAL(12,4) , ' +
  '                            MIX_QTDD11 DECIMAL(12,4) , ' +
  '                            MIX_BASE12 VARCHAR(10)   , ' +
  '                            MIX_QTDC12 DECIMAL(12,4) , ' +
  '                            MIX_QTDD12 DECIMAL(12,4) , ' +
  '                            MIX_BASE13 VARCHAR(10)   , ' +
  '                            MIX_QTDC13 DECIMAL(12,4) , ' +
  '                            MIX_QTDD13 DECIMAL(12,4) , ' +
  '                            MIX_BASE14 VARCHAR(10)   , ' +
  '                            MIX_QTDC14 DECIMAL(12,4) , ' +
  '                            MIX_QTDD14 DECIMAL(12,4) , ' +
  '                            MIX_BASE15 VARCHAR(10)   , ' +
  '                            MIX_QTDC15 DECIMAL(12,4) , ' +
  '                            MIX_QTDD15 DECIMAL(12,4) , ' +
  '                            MIX_VOLCON DECIMAL(12,4) , ' +
  '                            MIX_VOLDIL DECIMAL(12,4) , ' +
  '                            MIX_BASE16 VARCHAR(10)   , ' +
  '                            MIX_QTDC16 DECIMAL(12,4) , ' +
  '                            MIX_QTDD16 DECIMAL(12,4) , ' +
  '                            MIX_BASE17 VARCHAR(10)   , ' +
  '                            MIX_QTDC17 DECIMAL(12,4) , ' +
  '                            MIX_QTDD17 DECIMAL(12,4) , ' +
  '                            MIX_BASE18 VARCHAR(10)   , ' +
  '                            MIX_QTDC18 DECIMAL(12,4) , ' +
  '                            MIX_QTDD18 DECIMAL(12,4) , ' +
  '                            MIX_BASE19 VARCHAR(10)   , ' +
  '                            MIX_QTDC19 DECIMAL(12,4) , ' +
  '                            MIX_QTDD19 DECIMAL(12,4) , ' +
  '                            MIX_BASE20 VARCHAR(10)   , ' +
  '                            MIX_QTDC20 DECIMAL(12,4) , ' +
  '                            MIX_QTDD20 DECIMAL(12,4) , ' +
  '                            MIX_CODNFM VARCHAR(10)   , ' +
  '                            MIX_ATIVAD CHAR(1)       , ' +
  '                            MIX_VOLMIC DECIMAL(12,4) , ' +
  '                            MIX_VOLMID DECIMAL(12,4) , ' +
  '                            MIX_ACRMOB DECIMAL(12,4) , ' +
  '                            MIX_DTACAD DATE ,          ' +
  '                            MIX_VOLDIF DECIMAL(12,4) , ' +
  '                            MIX_VOLCOF DECIMAL(12,4) , ' +
  '                            KEY IDX_MIX_CODIGO (MIX_CODIGO) ';
end;

function TGravandoExecucaoLazzumixCores.fVolumeMaior(
  fltVolume: Double; strCodigo: String; strDilCon: String): Double;
Var
  qryGen: IDataSet;
begin
  Result := fltVolume;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT * FROM TMP_LAZ_CADMIX  WHERE MIX_CODIGO = :CODIGO    ';
  qryGen.ParamByName('CODIGO').AsString := strCodigo;
  qryGen.Open;

  If LeftStr(strDilCon, 1) = 'C' Then
  Begin
    If qryGen.FieldByName('MIX_VOLCOF').AsFloat > fltVolume Then
      Result := qryGen.FieldByName('MIX_VOLCOF').AsFloat;
  End
  Else
  Begin
    If qryGen.FieldByName('MIX_VOLDIF').AsFloat > fltVolume Then
      Result := qryGen.FieldByName('MIX_VOLDIF').AsFloat;
  End;
end;

end.

