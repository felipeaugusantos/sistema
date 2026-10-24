unit untSipag;

interface

uses System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

    cxProgressBar,

    untTSipagImportacaoCartao, untSipagPgto, untSipagPgtoV2, untTSipagFuncoes,
    untISipagIntegracaoLibCartoes;

Type
  TSipag = Class(TSipagImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
  Private
    objPgto   : ICartoes;

    objPgtoV2 : ICartoes;

    FArquivosPgto,
    FArquivosPgtoV2,
    FArquivosVenda: TStringList;

    function ValidaMovimentacaoFinanceira(ALinha:String):Boolean;
    function ValidaMovimentacaoVenda(ALinha:String):Boolean;
    function ArquivoFiserv(ALinha:String): Boolean;
    function ImportarArquivo(ALinha: String):Boolean;
    function ArquivoSipagV2(ALinha: String): Boolean;

    procedure AdicionaLinhasArquivos(itrCartoes: ICartoes);
    procedure pCarregaArquivos(strExt: String; strPath: String);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
    function fVerificaName(strExt : String = ''; strName: String = '') : Boolean;
  End;

implementation

{ TSipag }

procedure TSipag.AdicionaLinhasArquivos(itrCartoes: ICartoes);
  Var
    intCont: Integer;
    intLin : Integer;
    stlAux : TStringList;
begin
  stlAux := Nil;
  If itrCartoes Is TSipagPgto Then
  Begin
    Try
      stlAux := TStringList.Create;

      For intCont := 0 To FArquivosPgto.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(FArquivosPgto[intCont]);
        untSipagPgto.strNomArq := ExtractFileName(FArquivosPgto[intCont]);
        untSipagPgto.FArquivoFiserv := ArquivoFiserv(stlAux.Text);

        For intLin := 0 To stlAux.Count -1 Do
          itrCartoes.pAdicionaLinha(stlAux[intLin]);

        stlAux.Clear;
      End;
    Finally
      If Assigned(stlAux) Then
        FreeAndNil(stlAux);
    End;
    Exit;
  End;

  Try
    stlAux := TStringList.Create;

    For intCont := 0 To FArquivosPgtoV2.Count -1 Do
    Begin
      Application.ProcessMessages;
      stlAux.LoadFromFile(FArquivosPgtoV2[intCont]);

      (itrCartoes As TSipagPgtoV2).NomeArquivo := ExtractFileName(FArquivosPgtoV2[intCont]);

      For intLin := 0 To stlAux.Count -1 Do
        (itrCartoes As TSipagPgtoV2).pAdicionaLinha(stlAux[intLin]);

      stlAux.Clear;
    End;
  Finally
      If Assigned(stlAux) Then
        FreeAndNil(stlAux);
  End;
End;

function TSipag.ArquivoFiserv(ALinha: String): Boolean;
begin
  Result := True;

  ALinha := AnsiUpperCase(ALinha);

  If Not (Pos('MOVIMENTO FINANCEIRO', ALinha) > 0) Then
    Result := False
  Else If (Not ((Pos('7.1.0', ALinha) > 0) or (Pos('7.2.0', ALinha) > 0)))  Then
    Result := False;

end;

function TSipag.ArquivoSipagV2(ALinha: String): Boolean;
begin
  Result := False;

  ALinha := AnsiUpperCase(ALinha);

  If (Pos('MOVIMENTO FINANCEIRO', ALinha) > 0) Then
  Begin
    If (Pos('PROCESSAMENTO,704', ALinha) > 0) or (Pos('REPROCESSAMENTO,704', ALinha) > 0) Then
      Result := True;
  End;
end;

constructor TSipag.Create(Owner: TComponent);
begin
  inherited;
  FArquivosPgto := TStringList.Create;
  FArquivosPgtoV2 := TStringList.Create;
  FArquivosVenda := TStringList.Create;

  objPgto    := TSipagPgto.Create;

  objPgtoV2  := TSipagPgtoV2.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'SIPAG';
  strMenCon := 'Movimento Financeiro - 7.1.0 ou 7.2.0 ou versão 2.0';
end;

destructor TSipag.Destroy;
begin
  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  FreeAndNil(FArquivosPgto);
  FreeAndNil(FArquivosPgtoV2);
  FreeAndNil(FArquivosVenda);

  objPgto := Nil;
  objPgtoV2 := Nil;

  SetLength(FRegistroSipagMovimentoFinanceiroV2, 0);
  SetLength(FRegSipagPgtoV2, 0);
  SetLength(FRegistroSipagMovimentoFinanceiro, 0);
  SetLength(FRegSipagPgto, 0);
  inherited;
end;

function TSipag.fVerificaName(strExt, strName: String): Boolean;
begin
  Result := True;
  If strExt <> '' Then
    Result := False
  Else If strName = '' Then
    Result := False;
end;

function TSipag.ImportarArquivo(ALinha: String): Boolean;
begin
  Result := False;

  If ArquivoFiserv(ALinha) Then
    Result := True;
end;

procedure TSipag.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
  Var
    LMensagemSucesso : String;
begin
  Try
    pCarregaArquivos('csv', strPath);
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);
    pCarregaArquivos('', strPath);
    If (FArquivosPgto.Count + FArquivosPgtoV2.Count) = 0 Then
    Begin
      TSipagFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    LMensagemSucesso := 'Dados importados com sucesso';

    If Not untSipagPgtoV2.FImportouPagamentosV2 Then
    Begin
      If Not untSipagPgto.FImportouPagamentos Then
        LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.'
    End;

    TSipagFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
      TSipagFuncoes.fMensagem('Aviso','Ocorreu um imprevisto ao importar os dados.' + #13 +
                              'Detalhes: ' + E.Message, ['&OK']);  
  End;
end;

function TSipag.ValidaMovimentacaoFinanceira(ALinha: String): Boolean;
begin
  Result := False;

  If Pos(',Movimentação Financeira', ALinha) > 0 Then
    Result := True;
end;

function TSipag.ValidaMovimentacaoVenda(ALinha: String): Boolean;
begin
  Result := False;

  If Pos(',Movimentação de Vendas', ALinha) > 0 Then
    Result := True;
end;

procedure TSipag.pAdicionaLinhas;
Begin
  SetLength(untSipagPgto.FRegSipagPgto, 0);
  SetLength(untSipagPgtoV2.FRegSipagPgtoV2, 0);

  If FArquivosPgtoV2.Count > 0 Then
    AdicionaLinhasArquivos(objPgtoV2);

  If FArquivosPgto.Count > 0 Then
    AdicionaLinhasArquivos(objPgto);
End;

procedure TSipag.pCarregaArquivos(strExt: String; strPath: String);
Var
  arqArquivo: TSearchRec;
  stringList: TStringList;
  strTexto  : String;
Begin
  Try
    If (FindFirst(strPath + TSipagFuncoes.IIF(strExt <> '', '\*.' + strExt, '\*'), faAnyFile, arqArquivo) = 0) Then
    Begin
      Repeat
        Try
          If fVerificaName(strExt, ExtractFileExt(arqArquivo.Name)) Then
            continue;

          If arqArquivo.Attr = faDirectory Then
            Continue;

          Application.ProcessMessages;

          stringList := TStringList.Create;
          Try
            // Carrega todo o conteúdo do arquivo
            stringList.LoadFromFile(strPath + '\' + arqArquivo.Name);
            strTexto := stringList.Text;

            // Validações usando o texto completo
            If ArquivoSipagV2(strTexto) Then
              FArquivosPgtoV2.Add(strPath + '\' + arqArquivo.Name)
            Else If ValidaMovimentacaoFinanceira(strTexto) or ImportarArquivo(strTexto) Then
              FArquivosPgto.Add(strPath + '\' + arqArquivo.Name)
            Else If ValidaMovimentacaoVenda(strTexto) Then
              FArquivosVenda.Add(strPath + '\' + arqArquivo.Name);

          Finally
            FreeAndNil(stringList);
          End;

        Except
          On E: Exception Do
          Begin
            // Trata tanto "I/O ERROR 32" quanto outras exceções de acesso ao arquivo
            If (UpperCase(E.Message) = 'I/O ERROR 32') or
               (Pos('SHARING VIOLATION', UpperCase(E.Message)) > 0) or
               (Pos('EM USO', UpperCase(E.Message)) > 0) or
               (Pos('BEING USED', UpperCase(E.Message)) > 0) or
               (E is EFCreateError) or
               (E is EFOpenError) Then
              Raise Exception.Create('O arquivo '+arqArquivo.Name+' está em uso por outro processo!')
            Else
              Raise;
          End;
        End;

      Until (FindNext(arqArquivo) <> 0);
    End;
  Finally
    FindClose(arqArquivo);
  End;
End;

procedure TSipag.pGravarRegistros(var prgStatus: TcxProgressBar);
Var
  intCont: Integer;
  SNomeArquivoSemExtensao : String;
begin
  VS_FuncoesExternas.fIStartTransaction;

  Try
    objPgto.pGravarRegistros(prgStatus);
    objPgtoV2.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For intCont := 0 to FArquivosPgto.Count - 1 do
    Begin
      SNomeArquivoSemExtensao := AnsiReplaceStr(FArquivosPgto[intCont],
                                                ExtractFileExt(FArquivosPgto[intCont]),
                                                '');

      If FileExists(SNomeArquivoSemExtensao+'.imp') Then
        DeleteFile(SNomeArquivoSemExtensao+'.imp');
      TSipagFuncoes.pRenomeiaAquivo(FArquivosPgto[intCont], SNomeArquivoSemExtensao+'.imp');
    end;

    For intCont := 0 to FArquivosVenda.Count - 1 do
    Begin
      SNomeArquivoSemExtensao := AnsiReplaceStr(FArquivosVenda[intCont],
                                                ExtractFileExt(FArquivosVenda[intCont]),
                                                '');

      If FileExists(SNomeArquivoSemExtensao+'.imp') Then
        DeleteFile(SNomeArquivoSemExtensao+'.imp');
      TSipagFuncoes.pRenomeiaAquivo(FArquivosVenda[intCont], SNomeArquivoSemExtensao+'.imp');
    end;

    For intCont := 0 To FArquivosPgtoV2.Count -1 Do
    Begin
      SNomeArquivoSemExtensao := AnsiReplaceStr(FArquivosPgtoV2[intCont],
                                                ExtractFileExt(FArquivosPgtoV2[intCont]),
                                                '');

      If FileExists(SNomeArquivoSemExtensao+'.imp') Then
        DeleteFile(SNomeArquivoSemExtensao+'.imp');
      TSipagFuncoes.pRenomeiaAquivo(FArquivosPgtoV2[intCont], SNomeArquivoSemExtensao+'.imp');
    End;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      TSipagFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

end.
