unit untMercadoLivre;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Vcl.Forms,

     untTMercadoLivreImportacaoCartao, untIMercadoLivreIntegracaoLibCartoes,
     untMercadoLivrePgto, untTMercadoLivreFuncoes,

     BitBtnLockedIncrem, cxProgressBar;

Type
  TMercadoLivre = Class(TMercadoLivreImportacaoCartao)
    procedure pGravarRegistros(var pgbProg: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
    procedure ProcessaArquivosSelecionados(AAquivos: TStringList; var prgStatus: TcxProgressBar); override;
  Private
    FObjectPgto: ICartoesMercadoLivre;

    FPossuiBankReport,
    FPossuiExportacaoIncorreta: Integer;

    procedure pAdiciona(itrCartoes: ICartoesMercadoLivre; stlArqs: TStringList);
    procedure pCarregaArquivos(strExt, strPath: String);
    procedure CarregaArquivosSelecionados(AAquivos: TStringList);

    function ValidaArquivo(ALinha, ASeparador: String): Boolean;

    procedure ExibeMensagemBankReport(ANenhumArquivo: Boolean);
    procedure ExibeMensagemExportacaoIncorreta(ANenhumArquivo: Boolean);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

{ TMercadoLivre }

procedure TMercadoLivre.CarregaArquivosSelecionados(AAquivos: TStringList);
  Var
    LContador: Integer;

    LLinhaArquivo,
    LSeparador,
    LNomeArquivo : String;

    LArquivo: TextFile;
Begin
  Try
    FPossuiExportacaoIncorreta := 0;
    For LContador := 0 to AAquivos.Count - 1 Do
    Begin
      LNomeArquivo := System.SysUtils.ExtractFileName(AAquivos[LContador]);
      Application.ProcessMessages;
      AssignFile(LArquivo, AAquivos[LContador]);
      Try
        Reset(LArquivo);
        Readln(LArquivo, LLinhaArquivo);
        LLinhaArquivo := TMercadoLivreFuncoes.fConverteParaAcento(LLinhaArquivo);

        If (Pos('EXTERNAL_REFERENCE,', LLinhaArquivo) > 0) Then
        Begin
          TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'Não foi possível importar o arquivo ' + LNomeArquivo + '.' + #13 + #13 +
                                                    'O arquivo não está no formato esperado. Para importar com sucesso, o arquivo CSV deve atender a todos os requisitos abaixo:' + #13 + #13 +
                                                    '- Ser baixado diretamente do portal do Mercado Pago no formato CSV; ou' + #13 +
                                                    '- Caso exportado de XLSX para CSV, ter o separador de colunas configurado como ponto e vírgula (;)' + #13 +
                                                    '- Não conter alterações nos dados originais após o download e exportação.',
                                                    ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 285);

          Inc(FPossuiExportacaoIncorreta);
          Continue;
        End;

        LSeparador := EmptyStr;
        If (Pos('EXTERNAL_REFERENCE;', LLinhaArquivo) > 0) Then
          LSeparador := ';';

        If ValidaArquivo(LLinhaArquivo, LSeparador) Then
          FArquivos.Add(AAquivos[LContador]);
      Finally
        Flush(LArquivo);
        Close(LArquivo);
      End;
    End;

  Except
    FArquivos.Clear;
    Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + LNomeArquivo  +
                           '. Verifique se esse não está aberto em outro programa.');
  End;
End;

constructor TMercadoLivre.Create(Owner: TComponent);
begin
  inherited;
  FObjectPgto := TMercadoLivrePgto.Create;
  strNomCon := 'MERCADO LIVRE';
  strMenCon := 'A conciliação é feita a partir do Relatório de Liberações do Mercado Pago.';

  FPossuiBankReport := 0;
  FPossuiExportacaoIncorreta := 0;
end;

destructor TMercadoLivre.Destroy;
begin
  TMercadoLivreFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

  If Assigned(VS_DatasPagamento) Then
    FreeAndNil(VS_DatasPagamento);

  FObjectPgto := Nil;

  SetLength(FRegMLPgto, 0);
  inherited;
end;

procedure TMercadoLivre.ExibeMensagemBankReport(ANenhumArquivo: Boolean);
  Var
    LMensagem: String;
begin
  If FPossuiBankReport = 0 Then
    Exit;

  If FPossuiBankReport > 1 Then
  Begin
    LMensagem := 'Alguns arquivos da pasta não foram importados, pois não são do tipo "Relatório de Liberações".';

    If ANenhumArquivo Then
      LMensagem := 'Os arquivos que estão na pasta não foram importados, pois não são do tipo "Relatório de Liberações".';
  End
  Else
  Begin
    LMensagem := 'Algum arquivo da pasta não foi importado, pois não é do tipo "Relatório de Liberações".';

    If ANenhumArquivo Then
      LMensagem := 'O arquivo que está na pasta não foi importado, pois não é do tipo "Relatório de Liberações".';
  End;

  TMercadoLivreFuncoes.fMensagem('ATENÇÃO', LMensagem, ['&Ok']);
end;

procedure TMercadoLivre.ExibeMensagemExportacaoIncorreta(
  ANenhumArquivo: Boolean);
  Var
    LMensagem: String;
begin
  If FPossuiExportacaoIncorreta = 0 Then
    Exit;

  If FPossuiExportacaoIncorreta > 1 Then
  Begin
    LMensagem := 'Alguns arquivos da pasta não foram importados, pois não estão no formato esperado.';

    If ANenhumArquivo Then
      LMensagem := 'Os arquivos que estão na pasta não foram importados, pois não estão no formato esperado.';
  End
  Else
  Begin
    LMensagem := 'Algum arquivo da pasta não foi importado, pois não está no formato esperado.';

    If ANenhumArquivo Then
      LMensagem := 'O arquivo que está na pasta não foi importado, pois não está no formato esperado.';
  End;

  TMercadoLivreFuncoes.fMensagem('ATENÇÃO', LMensagem, ['&Ok']);
end;

function TMercadoLivre.ValidaArquivo(ALinha, ASeparador: String): Boolean;
begin
  Result := ASeparador.Equals(';');

  If Result Then
  Begin
    Result := Pos('EXTERNAL_REFERENCE' + ASeparador, ALinha) > 0;

    If Result Then
      Result := Pos('SOURCE_ID' + ASeparador, ALinha) > 0;

    If Result Then
      Result := Pos('PAYMENT_METHOD', ALinha) > 0;

    If Result Then
      Result := Pos('SHIPPING_ID', ALinha) > 0;

    If Result Then
      Result := Pos('TRANSACTION_DATE', ALinha) <= 0;
  End;
end;

procedure TMercadoLivre.pCarregaArquivos(strExt, strPath: String);
  Var
    arqArquivo: TSearchRec;
    strLinha  : String;
    txtArquivo: TextFile;

    LSeparador: String;
Begin
  FPossuiBankReport := 0;
  FPossuiExportacaoIncorreta := 0;
  Try
    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin
      Repeat
        If Pos('BANK-REPORT', UpperCase(arqArquivo.Name)) > 0 Then
        Begin
          Inc(FPossuiBankReport);

          Continue;
        End;

        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        Try
          strLinha := TMercadoLivreFuncoes.fConverteParaAcento(strLinha);

          If (Pos('EXTERNAL_REFERENCE,', strLinha) > 0) Then
          Begin
            TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'Não foi possível importar o arquivo ' + arqArquivo.Name + '.' + #13 + #13 +
                                                      'O arquivo não está no formato esperado. Para importar com sucesso, o arquivo CSV deve atender a todos os requisitos abaixo:' + #13 + #13 +
                                                      '- Ser baixado diretamente do portal do Mercado Pago no formato CSV; ou' + #13 +
                                                      '- Caso exportado de XLSX para CSV, ter o separador de colunas configurado como ponto e vírgula (;)' + #13 +
                                                      '- Não conter alterações nos dados originais após o download e exportação.',
                                                      ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 285);

            Inc(FPossuiExportacaoIncorreta);
            Continue;
          End;

          LSeparador := EmptyStr;
          If (Pos('EXTERNAL_REFERENCE;', strLinha) > 0) Then
            LSeparador := ';';

          If ValidaArquivo(strLinha, LSeparador) Then
            FArquivos.Add(strPath + '\' + arqArquivo.Name);
        Finally
          Flush(txtArquivo);
          Close(txtArquivo);
        End;

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  Except
    FindClose(arqArquivo);
    Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + arqArquivo.Name +
                           '. Verifique se esse não está aberto em outro programa.');
  End;
End;

procedure TMercadoLivre.pProcessaArquivos(strPath: String;
  var prgStatus: TcxProgressBar);
  Var
    LMensagemSucesso : String;
begin
  Try
    pCarregaArquivos('csv', strPath);
    If (FArquivos.Count = 0) Then
    Begin
      ExibeMensagemBankReport(True);
      ExibeMensagemExportacaoIncorreta(True);
      FPossuiBankReport := 0;
      FPossuiExportacaoIncorreta := 0;
      TMercadoLivreFuncoes.fMensagem('ATENÇÃO','Nenhum arquivo na pasta para importar!',['&OK']);

      Exit;
    End;

    untMercadoLivrePgto.FTemRegistroParaConciliacao := False;
    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    ExibeMensagemBankReport(False);
    ExibeMensagemExportacaoIncorreta(False);

    LMensagemSucesso := 'Dados importados com sucesso';

    If Not untMercadoLivrePgto.FTemRegistroParaConciliacao Then
      LMensagemSucesso := LMensagemSucesso + ', porém não possui registros suficiente para conciliação.'
    Else
      LMensagemSucesso := LMensagemSucesso + '!';

    If untMercadoLivrePgto.FCancelouImportacao Then
      LMensagemSucesso := 'Importação cancelada pelo operador.';

    TMercadoLivreFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
    Begin
      TMercadoLivreFuncoes.fMensagem('ATENÇÃO', E.Message, ['&OK']);

      frmImportacaoCartoes.Close;
    End;
  End;
end;

procedure TMercadoLivre.ProcessaArquivosSelecionados(AAquivos: TStringList;
  var prgStatus: TcxProgressBar);
  Var
    LMensagemSucesso: String;
begin
  Try
    Try
      CarregaArquivosSelecionados(AAquivos);
      If (FArquivos.Count = 0) Then
      Begin
        ExibeMensagemExportacaoIncorreta(True);
        FPossuiExportacaoIncorreta := 0;

        TMercadoLivreFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
        Exit;
      End;

      untMercadoLivrePgto.FTemRegistroParaConciliacao := False;

      pAdicionaLinhas;
      pGravarRegistros(prgStatus);

      ExibeMensagemExportacaoIncorreta(False);
      FPossuiExportacaoIncorreta := 0;

      LMensagemSucesso := 'Dados importados com sucesso';

      If Not untMercadoLivrePgto.FTemRegistroParaConciliacao Then
        LMensagemSucesso := LMensagemSucesso + ', porém não possui registros suficiente para conciliação.'
      Else
        LMensagemSucesso := LMensagemSucesso + '!';

      If untMercadoLivrePgto.FCancelouImportacao Then
        LMensagemSucesso := 'Importação cancelada pelo operador.';

      TMercadoLivreFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

      frmImportacaoCartoes.Close;
    Except
      On E: Exception Do
      Begin
        TMercadoLivreFuncoes.fMensagem('ATENÇÃO', E.Message, ['&OK']);
        frmImportacaoCartoes.Close;
      End;
    End;
  Finally
    SetLength(FRegMLPgto, 0);
    If Assigned(FChaveRegistro) Then
      FreeAndNil(FChaveRegistro);
    If Assigned(VS_ListaEstabelecimentos) Then
      FreeAndNil(VS_ListaEstabelecimentos);
    If Assigned(VS_DatasPagamento) Then
      FreeAndNil(VS_DatasPagamento);
  End;
end;

procedure TMercadoLivre.pAdiciona(itrCartoes: ICartoesMercadoLivre; stlArqs: TStringList);
  Var
    intCont  : Integer;
    intLin   : Integer;
    stlAux   : TStringList;
    dtaDtaArq: TDateTimeInfoRec;
begin
  stlAux := TStringList.Create;

  Try
    For intCont := 0 To stlArqs.Count -1 Do
    Begin
      Application.ProcessMessages;
      stlAux.LoadFromFile(stlArqs[intCont]);
      untMercadoLivrePgto.strNomArq := ExtractFileName(stlArqs[intCont]);
      untMercadoLivrePgto.dtaMaiorData := 0;
      FileGetDateTimeInfo(stlArqs[intCont], dtaDtaArq);
      untMercadoLivrePgto.strDtaArq := FormatDateTime('yyyy/mm/dd', dtaDtaArq.CreationTime);

      If SelecionarArquivos Then
        untMercadoLivrePgto.strCodEmp := Copy(Empresa, 1, 3);

      untMercadoLivrePgto.Separador := ';';

      For intLin := 0 To stlAux.Count -1 Do
      Begin
        If Not TMercadoLivreFuncoes.fEmptyStr(stlAux[intLin]) Then
        Begin
          itrCartoes.pAdicionaLinha(stlAux[intLin]);
        End;
      End;

      stlAux.Clear;
    End;
  Finally
    FreeAndNil(stlAux);
  End;
end;

procedure TMercadoLivre.pAdicionaLinhas;
Begin
  SetLength(FRegMLPgto , 0);

  pAdiciona(FObjectPgto, FArquivos);
End;

procedure TMercadoLivre.pGravarRegistros(var pgbProg: TcxProgressBar);
  Var
    intCont: Integer;
begin
  VS_FuncoesExternas.fIStartTransaction;

  Try
    untMercadoLivrePgto.FCancelouImportacao := False;

    FObjectPgto.pGravarRegistros(pgbProg);

    If untMercadoLivrePgto.FCancelouImportacao Then
    Begin
      VS_FuncoesExternas.fIRollback;
      Exit;
    End;

    VS_FuncoesExternas.fICommit;

    For intCont := 0 to FArquivos.Count - 1 do
    Begin
      If (FileExists(AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'))) Then
        DeleteFile(AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'));
      TMercadoLivreFuncoes.pRenomeiaAquivo(FArquivos[intCont], AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'));
    end;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      TMercadoLivreFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

end.
