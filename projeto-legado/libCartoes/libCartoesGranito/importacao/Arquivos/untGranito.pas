unit untGranito;

interface

uses System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

     cxProgressBar, Json,

     untTGranitoImportacaoCartao, untGranitoPgto, untTGranitoFuncoes,
     untIGranitoIntegracaoLibCartoes;

Type
  TGranito = Class(TGranitoImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
    procedure pAdiciona(itrCartoes: ICartoes);
    function fCarregaArquivos(strExt: String; APath: String): Boolean;
  Private
    objPgto: ICartoes;

    FArquivosPgto: TStringList;

    function ValidaArquivoGranito(ALinha:String):Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
    function fVerificaName(strExt : String = ''; strName: String = '') : Boolean;
  End;

implementation

{ TGranito }

constructor TGranito.Create(Owner: TComponent);
begin
  inherited;
  objPgto := TGranitoPgto.Create;

  FArquivosPgto := TStringList.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'Granito';
  strMenCon := '';
end;

destructor TGranito.Destroy;
begin
  TGranitoFuncoes.FreeAndNilStringLists(VS_ListaEstabelecimentos);
  TGranitoFuncoes.FreeAndNilStringLists(FArquivosPgto);

  objPgto := Nil;

  SetLength(FRegistroGranitoMovimentoFinanceiro, 0);
  inherited;
end;

function TGranito.fVerificaName(strExt, strName: String): Boolean;
begin
  Result := True;
  If strExt <> '' Then
    Result := False
  Else If strName = '' Then
    Result := False;
end;

function TGranito.fCarregaArquivos(strExt, APath: String): Boolean;
Var
  arqArquivo: TSearchRec;
  txtArquivo: TextFile;
  strLinha  : String;
begin
   Result := True;
  Try
    If (FindFirst(APath + TGranitoFuncoes.IIF(strExt <> '', '\*.' + strExt, '\*'), faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Try
          If fVerificaName(strExt,ExtractFileExt(arqArquivo.Name)) Then
            continue;

          Application.ProcessMessages;
          AssignFile(txtArquivo, APath + '\' + arqArquivo.Name);
          Try
            Reset(txtArquivo);
            Readln(txtArquivo, strLinha);

          If ValidaArquivoGranito(strLinha) Then
            FArquivosPgto.Add(APath + '\' + arqArquivo.Name);
          Finally
            Flush(txtArquivo);
            Close(txtArquivo);
          End;
        Except
          On E: Exception Do
          Begin
            If (UpperCase(E.Message) = 'I/O ERROR 32') Then
              Raise Exception.Create('O arquivo '+arqArquivo.Name+' está em uso por outro processo!')
            Else
              Raise Exception.Create(E.Message);
          End;
        End;

      Until (FindNext(arqArquivo) <> 0);

    End;
  Finally
    FindClose(arqArquivo);
  End;
end;

procedure TGranito.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
Var
  LMensagemSucesso : String;
begin
  Try
    If Not fCarregaArquivos('txt',strPath) Then
      Exit;

	If (FArquivosPgto.Count = 0) Then
    Begin
      TGranitoFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    LMensagemSucesso := 'Dados importados com sucesso';

    If Not untGranitoPgto.FImportouPagamentos Then
       LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.'
    Else
       LMensagemSucesso := LMensagemSucesso + '!';

    TGranitoFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
      TGranitoFuncoes.fMensagem('ERRO','Ocorreu um erro ao importar os dados.' + #13 +
                                     'Erro gerado: ' + E.Message,['&OK']);
  End;
end;

function TGranito.ValidaArquivoGranito(ALinha: String): Boolean;
begin
  Result := Trim(Copy(ALinha, 2, 30)) = 'GRANITO SOLUCOES EM PAGAMENTOS';
end;

procedure TGranito.pAdiciona(itrCartoes: ICartoes);
Var
  intCont: Integer;
  intLin : Integer;
  stlAux : TStringList;
begin
  stlAux := Nil;
  Try
    stlAux := TStringList.Create;

    If itrCartoes Is TGranitoPgto Then
    Begin

      For intCont := 0 To FArquivosPgto.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(FArquivosPgto[intCont]);
        untGranitoPgto.strNomArq := ExtractFileName(FArquivosPgto[intCont]);

         For intLin := 0 To stlAux.Count - 1 Do
        Begin
          itrCartoes.pAdicionaLinha(stlAux[intLin]);
        End;

        stlAux.Clear;
      End;
    End;
  Finally
    TGranitoFuncoes.FreeAndNilStringLists(stlAux);
  End;
end;

procedure TGranito.pAdicionaLinhas;
Begin
  Try
    SetLength(FRegistroGranitoMovimentoFinanceiro, 0);

    pAdiciona(objPgto);
  Except
    Raise;
  End;
End;

procedure TGranito.pGravarRegistros;
Var
  LCont: Integer;
  LNomeArquivoSemExtensao : String;
begin
  VS_FuncoesExternas.fIStartTransaction;

  Try
    objPgto.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For LCont := 0 to FArquivosPgto.Count - 1 do
    Begin
      LNomeArquivoSemExtensao := AnsiReplaceStr(FArquivosPgto[LCont],
                                                ExtractFileExt(FArquivosPgto[LCont]),
                                                '');

      If FileExists(LNomeArquivoSemExtensao+'.imp') Then
         DeleteFile(LNomeArquivoSemExtensao+'.imp');
      TGranitoFuncoes.pRenomeiaAquivo(FArquivosPgto[LCont], LNomeArquivoSemExtensao+'.imp');
    end;
  Except
     On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      TGranitoFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;

end;

end.
