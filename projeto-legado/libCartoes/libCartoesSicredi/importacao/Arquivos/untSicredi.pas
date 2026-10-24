{***************************************}
{* Importação de arquivos da Sicredi *}
{************************************MT*}
unit untSicredi;

interface

uses System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

     cxProgressBar,

     untTSicrediImportacaoCartao, untSicrediPgto, untTSicrediFuncoes,
     untISicrediIntegracaoLibCartoes;

Type
  TSicredi = Class(TSicrediImportacaoCartao)

    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
    procedure pAdiciona(itrCartoes: ICartoes);
    function fCarregaArquivos(strExt: String; APath: String): Boolean;
  Private
    objPgto       : ICartoes;

    FArquivosPgto : TStringList;

    function ImportarArquivo(ALinha: String):Boolean;
    function ArquivoFiserv(ALinha:String): Boolean;
    function ArquivoRelatorioPagamentoSicredi(ALinha:String): Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

{ TSicredi }

function TSicredi.ArquivoFiserv(ALinha: String): Boolean;
begin
  Result := True;

  ALinha := AnsiUpperCase(ALinha);

  If Not (Pos('MOVIMENTO FINANCEIRO', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('7.0.4', ALinha) > 0) Then
    Result := False;
end;

function TSicredi.ArquivoRelatorioPagamentoSicredi(ALinha: String): Boolean;
  Var
    LLinhaOriginal: String;
begin
  Result := True;

  LLinhaOriginal := ALinha;

  ALinha := AnsiUpperCase(ALinha);

  If Not (Pos('RELATÓRIO DE PAGAMENTOS', ALinha) > 0) Then
    Result := False;

  If Not Result Then
    Result :=  LLinhaOriginal.Contains('Data de pagamento;Código de pagamento;Tipo de pagamento;Data da venda;');
end;

constructor TSicredi.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TSicrediPgto.Create;

  FArquivosPgto := TStringList.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'Sicredi';
  strMenCon := 'Fiserv EDI 7.0.4 - Movimento Financeiro / Relatório de Pagamentos Sicredi';
end;

destructor TSicredi.Destroy;
begin
  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  If Assigned(FArquivosPgto) Then
    FreeAndNil(FArquivosPgto);

  objPgto := Nil;

  SetLength(FRegistroSicrediMovimentoFinanceiro, 0);
  inherited;
end;

function TSicredi.fCarregaArquivos(strExt: String; APath: String): Boolean;
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
Begin
  Result := True;
  Try
    If (FindFirst(APath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Try
          Application.ProcessMessages;
          AssignFile(txtArquivo, APath + '\' + arqArquivo.Name);
          Try
            Reset(txtArquivo);
            Readln(txtArquivo, strLinha);

            strLinha :=  TSicrediFuncoes.fConverteParaAcento(StringReplace(strLinha,',',#13,[rfReplaceAll]));

            If ImportarArquivo(strLinha) Then
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
End;

function TSicredi.ImportarArquivo(ALinha: String): Boolean;
begin
  Result := False;

  If ArquivoFiserv(ALinha) Then
    Result := True;

  If ArquivoRelatorioPagamentoSicredi(ALinha) Then
    Result := True;
end;

procedure TSicredi.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
var
  LMensagemSucesso : String;
begin
  Try
    If Not fCarregaArquivos('csv',strPath) Then
      Exit;

    If (FArquivosPgto.Count = 0) Then
    Begin
      TSicrediFuncoes.fMensagem('AVISO','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    LMensagemSucesso := 'Dados importados com sucesso';

    if not untSicrediPgto.FImportouPagamentos then
      LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.';

    TSicrediFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
      TSicrediFuncoes.fMensagem('ERRO','Ocorreu um erro ao importar os dados.' + #13 +
                                           'Erro gerado: ' + E.Message,['&OK']);
  End;
end;

procedure TSicredi.pAdiciona(itrCartoes: ICartoes);
  Var
    intCont: Integer;
    intLin : Integer;
    stlAux : TStringList;
    LLinhaInicio: Integer;
    LDataArquivo: TDateTimeInfoRec;
begin
  stlAux := Nil;
  Try
    stlAux := TStringList.Create;

    For intCont := 0 To FArquivosPgto.Count -1 Do
    Begin
      Application.ProcessMessages;

      Try
        stlAux.LoadFromFile(FArquivosPgto[intCont],TEncoding.UTF8);
      Except
        stlAux.LoadFromFile(FArquivosPgto[intCont],TEncoding.ANSI);
      End;

      LLinhaInicio := 0;
      untSicrediPgto.NomeArquivo := ExtractFileName(FArquivosPgto[intCont]);
      untSicrediPgto.FArquivoFiserv := ArquivoFiserv(stlAux.Text);
      untSicrediPgto.FArquivoRelatorioPagamento := ArquivoRelatorioPagamentoSicredi(stlAux.Text);

      FileGetDateTimeInfo(FArquivosPgto[intCont], LDataArquivo);
        untsicrediPgto.DataArquivo := FormatDateTime('yyyy/mm/dd', LDataArquivo.CreationTime);

      If untSicrediPgto.FArquivoRelatorioPagamento Then
      Begin
        LLinhaInicio := 5;
        If stlAux[0].Contains('Data de pagamento;Código de pagamento;Tipo de pagamento;Data da venda;') Then
          LLinhaInicio := 1;
      End;
      TSicrediPgto(itrCartoes).Campos := stlAux[TSicrediFuncoes.IIF(LLinhaInicio <= 0, 0, LLinhaInicio-1)];

      For intLin := LLinhaInicio To stlAux.Count -1 Do
      Begin
        Application.ProcessMessages;
        itrCartoes.pAdicionaLinha(stlAux[intLin]);
      End;

      stlAux.Clear;
    End;
  Finally
    If Assigned(stlAux) Then
      FreeAndNil(stlAux);
  End;
end;

procedure TSicredi.pAdicionaLinhas;
Begin
  Try
    SetLength(FRegistroSicrediMovimentoFinanceiro , 0);

    pAdiciona(objPgto);
  Except
    Raise;
  End;
End;

procedure TSicredi.pGravarRegistros(var prgStatus: TcxProgressBar);
Var
  LContador: Integer;
  LNomeArquivoSemExtensao: string;
begin
  VS_FuncoesExternas.fIStartTransaction;
  try
    objPgto.pGravarRegistros(prgStatus);

    VS_FuncoesExternas.fICommit;
    for LContador := 0 to FArquivosPgto.Count - 1 do
    begin
      LNomeArquivoSemExtensao := ChangeFileExt(FArquivosPgto[LContador], '');
      if FileExists(LNomeArquivoSemExtensao + '.imp') then
        DeleteFile(LNomeArquivoSemExtensao + '.imp');
      TSicrediFuncoes.pRenomeiaAquivo(FArquivosPgto[LContador], LNomeArquivoSemExtensao + '.imp');
    end;
  except
    on E: Exception do
    begin
      VS_FuncoesExternas.fIRollback;
      TSicrediFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    end;
  end;
end;

end.
