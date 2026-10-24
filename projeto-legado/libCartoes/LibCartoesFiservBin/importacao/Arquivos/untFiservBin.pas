{******************************************}
{* Importação de arquivos da FISERV - BIN *}
{***************************************TA*}
unit untFiservBin;

interface

uses System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils, System.IOUtils,
     System.Types,

     cxProgressBar, Json,

     untTFiservBinImportacaoCartao, untFiservBinPgto, untTFiservBinFuncoes,
     untIFiservBinIntegracaoLibCartoes;

Type
  TFiservBin = Class(TFiservBinImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
    procedure pAdiciona(itrCartoes: ICartoes);
    function fCarregaArquivos(strExt: String; APath: String): Boolean;
  Private
    objPgto   : ICartoes;

    FArquivosPgto : TStringList;

    function ValidaMovimentacaoFinanceira(ALinha:String):Boolean;
    function ValidarJsonMovimentacaoFinanceira(const ACaminhoArquivo: string): Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
    function fVerificaName(strExt : String = ''; strName: String = '') : Boolean;
  End;

implementation

{ TFiservBin }

constructor TFiservBin.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TFiservBinPgto.Create;

  FArquivosPgto := TStringList.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'FISERVBIN';
  strMenCon := 'Movimento Financeiro - 7.3/7.4';
end;

destructor TFiservBin.Destroy;
begin
  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  if Assigned(FArquivosPgto) then
    FreeAndNil(FArquivosPgto);

  objPgto := nil;

  SetLength(FRegistroFiservBinMovimentoFinanceiro, 0);
  inherited;
end;

function TFiservBin.fVerificaName(strExt, strName: String): Boolean;
begin
  Result := True;

  If strExt <> '' Then
    Result := False
  Else If strName = '' Then
    Result := False;
end;

function TFiservBin.ValidarJsonMovimentacaoFinanceira(const ACaminhoArquivo: string): Boolean;
var
  LConteudo: TStringList;
  LJsonObj: TJSONObject;
  LFileHeader: TJSONObject;
  LAcquiringName, LFileTypeDesc: string;
begin
  Result := False;
  LConteudo := Nil;
  try
    try
      LConteudo := TStringList.Create;
      LConteudo.LoadFromFile(ACaminhoArquivo);

      if LConteudo.Text.Trim = '' then
        Exit;

      LJsonObj := TJSONObject.ParseJSONValue(LConteudo.Text) as TJSONObject;
      if not Assigned(LJsonObj) then
        Exit;

      try
        if not LJsonObj.TryGetValue('fileHeader', LFileHeader) then
          Exit;

        if Assigned(LFileHeader.Get('acquiringName')) then
          LAcquiringName := LFileHeader.GetValue<string>('acquiringName')
        else
          Exit;

        if LAcquiringName <> 'Bin' then
          Exit;

        if Assigned(LFileHeader.Get('fileTypeDescription')) then
          LFileTypeDesc := LFileHeader.GetValue<string>('fileTypeDescription')
        else
          Exit;

        Result := LFileTypeDesc = 'Movimento Financeiro';

      finally
        FreeAndNil(LJsonObj);
      end;

    except
      on E: Exception do
        Result := False;
    end;
  finally
    If Assigned(LConteudo) Then
      FreeAndNil(LConteudo);
  end;
end;

function TFiservBin.fCarregaArquivos(strExt, APath: String): Boolean;
Var
  arqArquivo: TSearchRec;
  strLinha  : String;
  LLinhas : TStringDynArray;
begin
  Result := True;
  Try
    If (FindFirst(APath + TFiservBinFuncoes.IIF(strExt <> '', '\*.' + strExt, '\*'), faAnyFile, arqArquivo) = 0) Then
    Begin
      Repeat
        If fVerificaName(strExt,ExtractFileExt(arqArquivo.Name)) Then
          continue;

        Application.ProcessMessages;

        SetLength(LLinhas, 0);
        LLinhas := TFile.ReadAllLines(APath + '\' + arqArquivo.Name, TEncoding.UTF8);

        if Length(LLinhas) > 0 then
          strLinha := LLinhas[0]
        else
          strLinha := EmptyStr;

        If ValidaMovimentacaoFinanceira(strLinha) Then
          FArquivosPgto.Add(APath + '\' + arqArquivo.Name)
        Else If ValidarJsonMovimentacaoFinanceira(APath + '\' + arqArquivo.Name) Then
          FArquivosPgto.Add(APath + '\' + arqArquivo.Name);
      Until (FindNext(arqArquivo) <> 0);
    End;
  finally
    FindClose(arqArquivo);
    SetLength(LLinhas, 0);
  end;
end;

procedure TFiservBin.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
Var
  LMensagemSucesso : String;
begin
  Try
    If Not fCarregaArquivos('csv',strPath) Then
      Exit;

    If Not fCarregaArquivos('txt',strPath) Then
      Exit;

    If Not fCarregaArquivos('ret',strPath) Then
      Exit;

    If Not fCarregaArquivos('',strPath) Then
      Exit;

    If Not fCarregaArquivos('json',strPath) Then
      Exit;

	If (FArquivosPgto.Count = 0) Then
    Begin
      TFiservBinFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    LMensagemSucesso := 'Dados importados com sucesso';

    If Not untFiservBinPgto.FImportouPagamentos Then
       LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.'
    Else
       LMensagemSucesso := LMensagemSucesso + '!';

    TFiservBinFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
      TFiservBinFuncoes.fMensagem('ERRO','Ocorreu um erro ao importar os dados.' + #13 +
                                     'Erro gerado: ' + E.Message,['&OK']);
  End;
end;

function TFiservBin.ValidaMovimentacaoFinanceira(ALinha: String): Boolean;
begin
  Result := False;

  If Pos(',Movimento Financeiro', ALinha) > 0 Then
    Result := True;
end;

procedure TFiservBin.pAdiciona(itrCartoes: ICartoes);
Var
  intCont: Integer;
  intLin : Integer;
  stlAux : TStringList;
begin
  stlAux := Nil;
  try
    stlAux := TStringList.Create;
    If itrCartoes Is TFiservBinPgto Then
    Begin

      For intCont := 0 To FArquivosPgto.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(FArquivosPgto[intCont]);
        untFiservBinPgto.strNomArq := ExtractFileName(FArquivosPgto[intCont]);

        If ValidarJsonMovimentacaoFinanceira(FArquivosPgto[intCont]) Then
          itrCartoes.pAdicionaLinha(stlAux.Text)
        Else
        Begin
          For intLin := 0 To stlAux.Count -1 Do
            itrCartoes.pAdicionaLinha(stlAux[intLin]);
        End;

        stlAux.Clear;
      End;
    End;
  finally
    If Assigned(stlAux) Then
      FreeAndNil(stlAux);
  end;
end;

procedure TFiservBin.pAdicionaLinhas;
Begin
  Try
    SetLength(FRegistroFiservBinMovimentoFinanceiro, 0);

    pAdiciona(objPgto);
  Except
    Raise;
  End;
End;

procedure TFiservBin.pGravarRegistros;
Var
  LContador: Integer;
  LNomeArquivoSemExtensao : String;
begin
  VS_FuncoesExternas.fIStartTransaction;

  Try
    objPgto.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For LContador := 0 to FArquivosPgto.Count - 1 do
    Begin
      LNomeArquivoSemExtensao := AnsiReplaceStr(FArquivosPgto[LContador],
                                                ExtractFileExt(FArquivosPgto[LContador]),
                                                '');

      If FileExists(LNomeArquivoSemExtensao+'.imp') Then
         DeleteFile(LNomeArquivoSemExtensao+'.imp');
      TFiservBinFuncoes.pRenomeiaAquivo(FArquivosPgto[LContador], LNomeArquivoSemExtensao+'.imp');
    end;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      TFiservBinFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

end.
