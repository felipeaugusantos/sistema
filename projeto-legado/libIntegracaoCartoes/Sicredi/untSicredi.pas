{***************************************}
{* Importação de arquivos da Sicredi *}
{************************************MT*}
unit untSicredi;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untSicrediPgto, ComCtrls, untTImportacaoCartao;

Type
  TSicredi = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
    procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    function fCarregaArquivos(strExt: String; APath: String): Boolean;
  Private
    objPgto                      : TSicrediPgto;
    function ImportarArquivo(ALinha: String):Boolean;
    function ArquivoFiserv(ALinha:String): Boolean;
    function ArquivoRelatorioPagamentoSicredi(ALinha:String): Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

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

  lstEstabel := TStringList.Create;

  strNomCon := 'Sicredi';
  strMenCon := 'Fiserv EDI 7.0.4 - Movimento Financeiro / Relatório de Pagamentos Sicred';
end;

destructor TSicredi.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

function TSicredi.fCarregaArquivos(strExt: String; APath: String): Boolean;
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
Begin
  Result := True;
  If (FindFirst(APath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
  Begin

    Repeat

      Try
        Application.ProcessMessages;
        AssignFile(txtArquivo, APath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        strLinha := fConverteParaAcento(StringReplace(strLinha,',',#13,[rfReplaceAll]));

        If ImportarArquivo(strLinha) Then
          stlPgto.Add(APath + '\' + arqArquivo.Name);

        Flush(txtArquivo);
        Close(txtArquivo);
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
  FindClose(arqArquivo);
End;

function TSicredi.ImportarArquivo(ALinha: String): Boolean;
begin
  Result := False;

  If ArquivoFiserv(ALinha) Then
    Result := True;

  If ArquivoRelatorioPagamentoSicredi(ALinha) Then
    Result := True;

end;

procedure TSicredi.pProcessaArquivos(strPath: String);
begin
  Try
    If Not fCarregaArquivos('csv',strPath) Then
      Exit;

    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('AVISO','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros;

    objFunctions.fIMensagem('AVISO','Dados importados com sucesso!',['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
    Begin
      objFunctions.fIMensagem('ATENÇÃO', E.Message, ['&OK']);

      objPgto := TSicrediPgto.Create;

      lstEstabel := TStringList.Create;

      stlPgto.Clear;
    End;
  End;
end;

procedure TSicredi.pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
  Var
    intCont: Integer;
    intLin : Integer;
    stlAux : TStringList;
    LLinhaInicio: Integer;
begin
  Try
    stlAux := TStringList.Create;

    For intCont := 0 To stlArqs.Count -1 Do
    Begin
      Application.ProcessMessages;

      Try
        stlAux.LoadFromFile(stlArqs[intCont],TEncoding.UTF8);
      Except
        stlAux.LoadFromFile(stlArqs[intCont],TEncoding.ANSI);
      End;

      LLinhaInicio := 0;
      untSicrediPgto.FNomeArquivoImportado := ExtractFileName(stlArqs[intCont]);
      untSicrediPgto.FArquivoFiserv := ArquivoFiserv(stlAux.Text);
      untSicrediPgto.FArquivoRelatorioPagamento := ArquivoRelatorioPagamentoSicredi(stlAux.Text);

      If untSicrediPgto.FArquivoRelatorioPagamento Then
      Begin
        LLinhaInicio := 5;
        If stlAux[0].Contains('Data de pagamento;Código de pagamento;Tipo de pagamento;Data da venda;') Then
          LLinhaInicio := 1;
      End;
      TSicrediPgto(itrCartoes).Campos := stlAux[IIF(LLinhaInicio <= 0, 0, LLinhaInicio-1)];

      pgbProg.Position := 0;
      pgbProg.Max := (stlAux.Count -1);
      For intLin := LLinhaInicio To stlAux.Count -1 Do
      Begin
        Application.ProcessMessages;
        itrCartoes.pAdicionaLinha(stlAux[intLin]);
        pgbProg.Position := (pgbProg.Position + 1);
      End;

      stlAux.Clear;
    End;

    pgbProg.Position := 0;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  FreeAndNil(stlAux);
end;

procedure TSicredi.pAdicionaLinhas;
Begin
  Try
    SetLength(FRegistroSicrediMovimentoFinanceiro , 0);

    pAdiciona(objPgto, stlPgto);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure TSicredi.pGravarRegistros;
Var
  intCont: Integer;
begin

  objPgto.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'))) Then
      DeleteFile(AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'));
    pRenomeiaAquivo(stlPgto[intCont], AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'));
  end;
end;

end.
