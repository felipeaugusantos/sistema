{**************************************}
{* Importação de arquivos da BANRISUL *}
{***********************************AJ*}
unit untBanrisul;

interface

uses  System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

      cxProgressBar,  dialogs,

      untTBanrisulImportacaoCartao, untBanrisulPgto, untTBanrisulFuncoes,
      untIBanrisulIntegracaoLibCartoes;

Type
  TBanrisul = Class(TBanrisulImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
  Private
    objPgto : ICartoes;

    FArquivosPgto : TStringList;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

Const
  IDENTIFICADORES_ACEITOS: Array[0..8] of String = ('BJRVCA1', 'BJRVCM8', 'BJRVCC1', 'BJRVCMB', 'BJRVCB1',
                                                     'BKNFIN1', 'BJRVCA8', 'BJRVC21', 'BJRVC41');

  IDENTIFICADORES_SOMENTE_TEXTO: Array[0..1] of String = ('BJRVCB1', 'BJRVCA8');

  LARGURA_MENSAGEM = 680;

  LINHAS_MENSAGEM = 4;

function fLayoutExcel(const AIdentificador, ATipoRegistro: String): String;
begin
  Result := '';

  If ATipoRegistro = '00' Then
    Result := 'N2A40A8N8N8N6A10N14'
  Else
  If ATipoRegistro = '10' Then
  Begin
    If AIdentificador = 'BJRVCA1' Then
      Result := 'A2N14N11N15A8N8N8N2N2N6N8N4N6N4N6A4N2N15N15N8N6N6N10N6N15N3N3N8N6A40A14N3N6N15A1A6A4A11'
    Else
    If AIdentificador = 'BJRVCM8' Then
      Result := 'N2N14N11N15A8N8N8N2N2N6N8N4N6N4N6A4N2N15N15N8N6N6N10N6N15N3N3N8N6A40A14N3N6N15A1N3A6A4N1A7'
    Else
    If (AIdentificador = 'BJRVCC1') Or (AIdentificador = 'BJRVCMB') Then
      Result := 'A2N11N15N8N4N2N14N4N10N15A226'
    Else
    If AIdentificador = 'BJRVC21' Then
      Result := 'A2N14N11N15A8N8N6N8N2N2N8N4N6N4N6A4N2N15N15N8N6N6N10N6N15N3N3N8N6N3N15A1N3A1A19A40A14A8N8N8N3N3N2A30'
    Else
    If AIdentificador = 'BJRVC41' Then
      Result := 'A2N11N15N8A1N6N2N14N15A341'
    Else
    If AIdentificador = 'BKNFIN1' Then
      Result := 'N2N14N14N2N3N5N3N4N13N20N15N8A2N8';
  End
  Else
  If ATipoRegistro = '20' Then
  Begin
    If AIdentificador = 'BJRVCC1' Then
      Result := 'A2N11N15N8N4N2N8N8N2N15N6N6N10N10N15A40A149'
    Else
    If AIdentificador = 'BJRVCMB' Then
      Result := 'A2N11N15N8N4N2N8N8N2N15N6N6N10N10N15A40N14A135'
    Else
    If AIdentificador = 'BJRVC41' Then
      Result := 'A2N11N15N8N4N2N8N8N2N15N6N6N10N10N15N14'
    Else
    If AIdentificador = 'BKNFIN1' Then
      Result := 'N2N14N14N3N5A1N15N8';
  End
  Else
  If (ATipoRegistro = '30') And (AIdentificador = 'BKNFIN1') Then
    Result := 'N2N14N14N2N3N5A1N15N8';
end;

function fCampoNumericoExcel(const AValor: String; ATamanho: Integer): String;
Var
  LValor,
  LInteiro,
  LDecimal  : String;
  LHifen,
  LCont     : Integer;
  LTemLetra,
  LDecimais : Boolean;
begin
  LValor := Trim(AValor);

  If (LValor <> '') And (LValor[1] = '-') Then
    Raise Exception.Create('Valor negativo não suportado na versão Excel (' + LValor +
                           '). Use a versão texto do arquivo.');

  LHifen := Pos('-', LValor);
  If LHifen > 1 Then
  Begin
    LTemLetra := False;
    For LCont := LHifen + 1 To Length(LValor) Do
      If CharInSet(UpCase(LValor[LCont]), ['A'..'Z']) Then
      Begin
        LTemLetra := True;
        Break;
      End;

    If LTemLetra Then
      LValor := Trim(Copy(LValor, 1, LHifen - 1));
  End;

  LInteiro  := '';
  LDecimal  := '';
  LDecimais := False;
  For LCont := 1 To Length(LValor) Do
  Begin
    If LValor[LCont] = ',' Then
      LDecimais := True
    Else
    If CharInSet(LValor[LCont], ['0'..'9']) Then
    Begin
      If LDecimais Then
        LDecimal := LDecimal + LValor[LCont]
      Else
        LInteiro := LInteiro + LValor[LCont];
    End;
  End;

  Result := LInteiro;
  If LDecimais Then
    Result := Result + Copy(LDecimal + '00', 1, 2);

  If Length(Result) > ATamanho Then
    Raise Exception.Create('Valor "' + AValor + '" excede ' + IntToStr(ATamanho) + ' posições.');

  Result := StringOfChar('0', ATamanho - Length(Result)) + Result;
end;

function fConverteLinhaExcel(const AIdentificador, ALinha: String): String;
Var
  LCampos  : TArray<String>;
  LLayout,
  LValor   : String;
  LTipo    : Char;
  LTamanho,
  LPosicao,
  LIndice  : Integer;
begin
  Result := '';

  LCampos := ALinha.Split([';']);
  If Length(LCampos) < 2 Then
    Exit;

  If Trim(LCampos[0]) = '99' Then
    Exit('99');

  If (Trim(LCampos[0]) = '00') And (Length(LCampos) > 2) Then
    LCampos[2] := AIdentificador;

  LLayout := fLayoutExcel(AIdentificador, Trim(LCampos[0]));
  If LLayout = '' Then
    Exit;

  LPosicao := 1;
  LIndice  := 0;
  While LPosicao <= Length(LLayout) Do
  Begin
    LTipo := LLayout[LPosicao];
    Inc(LPosicao);

    LTamanho := 0;
    While (LPosicao <= Length(LLayout)) And CharInSet(LLayout[LPosicao], ['0'..'9']) Do
    Begin
      LTamanho := (LTamanho * 10) + (Ord(LLayout[LPosicao]) - Ord('0'));
      Inc(LPosicao);
    End;

    If LIndice < Length(LCampos) Then
      LValor := Trim(LCampos[LIndice])
    Else
      LValor := '';

    If LTipo = 'A' Then
      Result := Result + Copy(LValor + StringOfChar(' ', LTamanho), 1, LTamanho)
    Else
      Result := Result + fCampoNumericoExcel(LValor, LTamanho);

    Inc(LIndice);
  End;
end;

function fIdentificaCabecalho(const ALinha: String; out AIdentificador, AChaveDia: String;
  out AExcel: Boolean): Boolean;
Var
  LCampos: TArray<String>;
begin
  Result         := False;
  AIdentificador := '';
  AChaveDia      := '';
  AExcel         := False;

  If Copy(ALinha, 1, 2) <> '00' Then
    Exit;

  If Copy(ALinha, 3, 1) = ';' Then
  Begin
    LCampos := ALinha.Split([';']);
    If Length(LCampos) < 8 Then
      Exit;

    AExcel         := True;
    AIdentificador := Trim(LCampos[2]);
    AChaveDia      := Trim(LCampos[3]) + Trim(LCampos[7]);
  End
  Else
  Begin
    AIdentificador := Trim(Copy(ALinha, 43, 8));
    AChaveDia      := Trim(Copy(ALinha, 51, 8)) + Trim(Copy(ALinha, 83, 14));
  End;

  If (Length(AIdentificador) = 8) And (AnsiRightStr(AIdentificador, 1) = 'S') Then
    AIdentificador := Copy(AIdentificador, 1, 7);

  Result := AIdentificador <> '';
end;

function fLeCabecalhoArquivo(const AArquivo: String; out AIdentificador, AChaveDia: String;
  out AExcel: Boolean): Boolean;
Var
  LArquivo: TextFile;
  LLinha  : String;
  LLidas  : Integer;
begin
  Result         := False;
  AIdentificador := '';
  AChaveDia      := '';
  AExcel         := False;

  AssignFile(LArquivo, AArquivo);
  Reset(LArquivo);
  Try
    LLidas := 0;
    While (Not Result) And (Not Eof(LArquivo)) And (LLidas < 10) Do
    Begin
      Readln(LArquivo, LLinha);
      Inc(LLidas);
      Result := fIdentificaCabecalho(LLinha, AIdentificador, AChaveDia, AExcel);
    End;
  Finally
    CloseFile(LArquivo);
  End;
end;

procedure pRetiraArquivosRepetidos(AArquivos, ATipos, ARepetidos: TStringList);
Var
  LCont,
  LUnificado : Integer;
  LTipo,
  LChave,
  LTipoUnico : String;
begin
  For LCont := AArquivos.Count - 1 DownTo 0 Do
  Begin
    LTipo  := Copy(ATipos[LCont], 1, 7);
    LChave := Copy(ATipos[LCont], 9, MaxInt);

    If (LTipo = 'BJRVCA1') Or (LTipo = 'BJRVCM8') Then
      LTipoUnico := 'BJRVC21'
    Else
    If (LTipo = 'BJRVCC1') Or (LTipo = 'BJRVCMB') Then
      LTipoUnico := 'BJRVC41'
    Else
      Continue;

    LUnificado := ATipos.IndexOf(LTipoUnico + '|' + LChave);
    If LUnificado < 0 Then
      Continue;

    ARepetidos.Add(AArquivos[LCont]);
    AArquivos.Delete(LCont);
    ATipos.Delete(LCont);
  End;
end;

function fNomeImportado(const AArquivo: String): String;
begin
  If Length(ExtractFileExt(AArquivo)) = 4 Then
    Result := ChangeFileExt(AArquivo, '.imp')
  Else
    Result := AArquivo + '.imp';
end;

procedure pMarcaComoImportados(AArquivos: TStringList);
Var
  LCont     : Integer;
  LImportado: String;
begin
  For LCont := 0 To AArquivos.Count - 1 Do
  Begin
    LImportado := fNomeImportado(AArquivos[LCont]);
    If FileExists(LImportado) Then
      DeleteFile(LImportado);
    TBanrisulFuncoes.pRenomeiaAquivo(AArquivos[LCont], LImportado);
  End;
end;

procedure pMostraResumo(const ACabecalho: String; AImportados, ARepetidos: Integer; AIgnorados: TStringList);
Var
  LMotivos: TStringList;
  LTexto  : String;
  LLinhas,
  LCont   : Integer;
begin
  LTexto  := ACabecalho;
  LLinhas := 1;

  If AImportados > 0 Then
  Begin
    LTexto := LTexto + #13 + 'Arquivos importados: ' + IntToStr(AImportados) + '.';
    Inc(LLinhas);
  End;

  If ARepetidos > 0 Then
  Begin
    LTexto := LTexto + #13 + 'Já contidos no arquivo de todas as bandeiras e marcados como importados: ' +
              IntToStr(ARepetidos) + '.';
    Inc(LLinhas);
  End;

  If AIgnorados.Count > 0 Then
  Begin
    LMotivos := TStringList.Create;
    Try
      For LCont := 0 To AIgnorados.Count - 1 Do
        LMotivos.Values[AIgnorados[LCont]] := IntToStr(StrToIntDef(LMotivos.Values[AIgnorados[LCont]], 0) + 1);

      For LCont := 0 To LMotivos.Count - 1 Do
        LTexto := LTexto + #13 + LMotivos.Names[LCont] + ': ' + LMotivos.ValueFromIndex[LCont] + '.';

      LTexto  := LTexto + #13 + 'Os arquivos não importados continuam na pasta com o nome original.';
      LLinhas := LLinhas + LMotivos.Count + 1;
    Finally
      FreeAndNil(LMotivos);
    End;
  End;

  If LLinhas > LINHAS_MENSAGEM Then
    TBanrisulFuncoes.fMensagem('', LTexto, ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 0,
                               LARGURA_MENSAGEM, LLinhas - LINHAS_MENSAGEM)
  Else
    TBanrisulFuncoes.fMensagem('', LTexto, ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 0,
                               LARGURA_MENSAGEM);
end;

{ TBanrisul }

constructor TBanrisul.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TBanrisulPgto.Create;

  FArquivosPgto := TStringList.Create;

  strNomCon := 'BANRISUL';
  strMenCon := '';
end;

destructor TBanrisul.Destroy;
begin
  TBanrisulFuncoes.FreeAndNilStringLists(VS_ListaEstabelecimentos);
  TBanrisulFuncoes.FreeAndNilStringLists(FArquivosPgto);

  objPgto := Nil;

  inherited;
end;

procedure TBanrisul.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
Var
  LarqArquivo    : TSearchRec;
  LArquivo,
  LIdentificador,
  LChaveDia      : String;
  LExcel         : Boolean;
  LTipos,
  LIgnorados,
  LRepetidos     : TStringList;
begin
  LTipos     := Nil;
  LIgnorados := Nil;
  LRepetidos := Nil;
  Try
    LTipos     := TStringList.Create;
    LIgnorados := TStringList.Create;
    LRepetidos := TStringList.Create;

    Try
      If (FindFirst(strPath + '\*.*', faAnyFile, LarqArquivo) = 0) Then
      Begin

        Repeat
          Application.ProcessMessages;

          if (LarqArquivo.Name <> '.') And
             (LarqArquivo.Name <> '..') and
             (LarqArquivo.Attr <> faDirectory) And
             (Not AnsiEndsText('imp', LarqArquivo.Name)) then
          begin
            LArquivo := strPath + '\' + LarqArquivo.Name;
            Try
              If Not fLeCabecalhoArquivo(LArquivo, LIdentificador, LChaveDia, LExcel) Then
                LIgnorados.Add('Não é arquivo de conciliação da Banrisul')
              Else
              If AnsiIndexText(LIdentificador, IDENTIFICADORES_ACEITOS) < 0 Then
                LIgnorados.Add('Tipo ' + LIdentificador + ', não usado na conciliação')
              Else
              If LExcel And (AnsiIndexText(LIdentificador, IDENTIFICADORES_SOMENTE_TEXTO) >= 0) Then
                LIgnorados.Add('Tipo ' + LIdentificador + ', lido só na versão texto')
              Else
              Begin
                FArquivosPgto.Add(LArquivo);
                LTipos.Add(LIdentificador + '|' + LChaveDia);
              End;
            Except
              On E: Exception Do
                LIgnorados.Add('Não foi possível ler o arquivo');
            End;
          end;

        Until (FindNext(LarqArquivo) <> 0);

      End;
    Finally
      FindClose(LarqArquivo);
    End;

    pRetiraArquivosRepetidos(FArquivosPgto, LTipos, LRepetidos);

    Try
      If (FArquivosPgto.Count = 0) Then
      Begin
        pMostraResumo('Nenhum arquivo na pasta para importar!', 0, 0, LIgnorados);
        Exit;
      End;

      pAdicionaLinhas;

      pGravarRegistros(prgStatus);

      pMarcaComoImportados(LRepetidos);

      pMostraResumo('Dados importados com sucesso!', FArquivosPgto.Count, LRepetidos.Count, LIgnorados);

      frmImportacaoCartoes.Close;
    Finally
      FArquivosPgto.Clear;
    End;
  Finally
    TBanrisulFuncoes.FreeAndNilStringLists(LTipos);
    TBanrisulFuncoes.FreeAndNilStringLists(LIgnorados);
    TBanrisulFuncoes.FreeAndNilStringLists(LRepetidos);
  End;
end;

procedure TBanrisul.pAdicionaLinhas;
Var
  LintCont : Integer;
  LintLin  : Integer;
  LstlAux  : TStringList;
  LLinha,
  LIdentificador,
  LChaveDia: String;
  LExcel   : Boolean;
Begin
  objPgto := Nil;
  objPgto := TBanrisulPgto.Create;
  If Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos.Clear;

  LstlAux := Nil;
  try
    LstlAux := TStringList.Create;
    For LintCont := 0 To FArquivosPgto.Count -1 Do
    Begin
      Application.ProcessMessages;
      LstlAux.LoadFromFile(FArquivosPgto[LintCont]);
      untBanrisulPgto.strNomArq := ExtractFileName(FArquivosPgto[LintCont]);

      LExcel := False;
      For LintLin := 0 To LstlAux.Count -1 Do
        If fIdentificaCabecalho(LstlAux[LintLin], LIdentificador, LChaveDia, LExcel) Then
          Break;

      For LintLin := 0 To LstlAux.Count -1 Do
      Begin
        LLinha := LstlAux[LintLin];

        If LExcel Then
        Begin
          LLinha := fConverteLinhaExcel(LIdentificador, LLinha);
          If LLinha = '' Then
            Continue;
        End;

        objPgto.pAdicionaLinha(LLinha);
      End;

      LstlAux.Clear;
    End;
  finally
    TBanrisulFuncoes.FreeAndNilStringLists(LstlAux);
  end;
End;

procedure TBanrisul.pGravarRegistros(var prgStatus: TcxProgressBar);
Var
  LintCont  : Integer;
  LImportado: String;
begin
  VS_FuncoesExternas.fIStartTransaction;
  Try
    objPgto.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For LintCont := 0 to FArquivosPgto.Count - 1 do
    Begin
      LImportado := fNomeImportado(FArquivosPgto[LintCont]);
      If (FileExists(LImportado)) Then
        DeleteFile(LImportado);
      TBanrisulFuncoes.pRenomeiaAquivo(FArquivosPgto[LintCont], LImportado);
    end;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollBack;

      TBanrisulFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

end.
