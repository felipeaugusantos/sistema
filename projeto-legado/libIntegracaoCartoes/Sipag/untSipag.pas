{***********************************}
{* Importação de arquivos da SIPAG *}
{********************************AJ*}
unit untSipag;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untSipagPgto, ComCtrls, untTImportacaoCartao, untSipagPgtoV2;

Type
  TSipag = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TSipagPgto;

    objPgtoV2 : TSipagPgtoV2;

    stlPgtoV2 : TStringList;
    blnArquivoV2 : Boolean;
    function ValidaMovimentacaoFinanceira(ALinha:String):Boolean;
    function ValidaMovimentacaoVenda(ALinha:String):Boolean;
    function ArquivoFiserv(ALinha:String): Boolean;
    function ImportarArquivo(ALinha: String):Boolean;
    function ArquivoSipagV2(ALinha: String): Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
    function fVerificaName(strExt : String = ''; strName: String = '') : Boolean;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TSipag }

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
     Begin
        Result := True;
     End;
  End;

end;

constructor TSipag.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TSipagPgto.Create;

  objPgtoV2  := TSipagPgtoV2.Create;
  stlPgtoV2  := TStringList.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'SIPAG';
  strMenCon := 'Movimento Financeiro - 7.1.0 ou 7.2.0 ou versão 2.0';
end;

destructor TSipag.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
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

procedure TSipag.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
    LMensagemSucesso : String;

  procedure pCarregaArquivos(strExt: String);
  Begin

    If (FindFirst(strPath + IIF(strExt <> '', '\*.' + strExt, '\*'), faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        If fVerificaName(strExt,ExtractFileExt(arqArquivo.Name)) Then
          continue;

        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        If ArquivoSipagV2(strLinha) Then
        Begin
          stlPgtoV2.Add(strPath + '\' + arqArquivo.Name);
          blnArquivoV2 := True;
        End
        Else
        If ValidaMovimentacaoFinanceira(strLinha) or ImportarArquivo(strLinha) Then
          stlPgto.Add(strPath + '\' + arqArquivo.Name)
        Else If ValidaMovimentacaoVenda(strLinha) Then
          stlCredito.Add(strPath + '\' + arqArquivo.Name);

        Flush(txtArquivo);
        Close(txtArquivo);

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  End;
begin
  Try
    pCarregaArquivos('csv');
    pCarregaArquivos('txt');
    pCarregaArquivos('ret');
    pCarregaArquivos('');
    If (stlPgto.Count = 0)  And (Not blnArquivoV2) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    If (stlPgtoV2.Count = 0) And (blnArquivoV2) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros;

    LMensagemSucesso := 'Dados importados com sucesso';

    If (blnArquivoV2) Then
    Begin
       If Not untSipagPgtoV2.FImportouPagamentosV2 Then
          LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.'
    End
    Else
    Begin

      If Not untSipagPgto.FImportouPagamentos Then
        LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.'
      Else
        LMensagemSucesso := LMensagemSucesso + '!';

    End;

    objFunctions.fIMensagem('',LMensagemSucesso,['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
      objFunctions.fIMensagem('ERRO','Ocorreu um erro ao importar os dados.' + #13 +
                                     'Erro gerado: ' + E.Message,['&OK']);
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

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont: Integer;
      intLin : Integer;
      stlAux : TStringList;
  begin
    Try
      stlAux := TStringList.Create;

      If itrCartoes Is TSipagPgto Then
      Begin

        For intCont := 0 To stlArqs.Count -1 Do
        Begin
          Application.ProcessMessages;
          stlAux.LoadFromFile(stlArqs[intCont]);
          untSipagPgto.strNomArq := ExtractFileName(stlArqs[intCont]);
          untSipagPgto.FArquivoFiserv := ArquivoFiserv(stlAux.Text);

          For intLin := 0 To stlAux.Count -1 Do
            itrCartoes.pAdicionaLinha(stlAux[intLin]);

          stlAux.Clear;
        End;

      End;

      If itrCartoes Is TSipagPgtoV2 Then
      Begin
        For intCont := 0 To stlPgtoV2.Count -1 Do
        Begin
          Application.ProcessMessages;
          stlAux.LoadFromFile(stlPgtoV2[intCont]);

          (itrCartoes As TSipagPgtoV2).NomeArquivo := ExtractFileName(stlPgtoV2[intCont]);

          For intLin := 0 To stlAux.Count -1 Do
            (itrCartoes As TSipagPgtoV2).pAdicionaLinha(stlAux[intLin]);

          stlAux.Clear;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

    FreeAndNil(stlAux);

  end;

Begin
  SetLength(FRegSipagPgto , 0);
  SetLength(FRegSipagPgtoV2 , 0);

  If blnArquivoV2 Then
     pAdiciona(objPgtoV2, stlPgtoV2)
  Else
     pAdiciona(objPgto, stlPgto);
End;

procedure TSipag.pGravarRegistros;
Var
  intCont: Integer;
  SNomeArquivoSemExtensao : String;
begin

  objPgto.pGravarRegistros(pgbProg);

  objPgtoV2.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    SNomeArquivoSemExtensao := AnsiReplaceStr(stlPgto[intCont],
                                              ExtractFileExt(stlPgto[intCont]),
                                              '');

    If FileExists(SNomeArquivoSemExtensao+'.imp') Then
       DeleteFile(SNomeArquivoSemExtensao+'.imp');
    pRenomeiaAquivo(stlPgto[intCont], SNomeArquivoSemExtensao+'.imp');
  end;

  For intCont := 0 to stlCredito.Count - 1 do
  Begin
    SNomeArquivoSemExtensao := AnsiReplaceStr(stlCredito[intCont],
                                              ExtractFileExt(stlCredito[intCont]),
                                              '');

    If FileExists(SNomeArquivoSemExtensao+'.imp') Then
       DeleteFile(SNomeArquivoSemExtensao+'.imp');
   pRenomeiaAquivo(stlCredito[intCont], SNomeArquivoSemExtensao+'.imp');
  end;

  For intCont := 0 To stlPgtoV2.Count -1 Do
  Begin
    SNomeArquivoSemExtensao := AnsiReplaceStr(stlPgtoV2[intCont],
                                              ExtractFileExt(stlPgtoV2[intCont]),
                                              '');

    If FileExists(SNomeArquivoSemExtensao+'.imp') Then
      DeleteFile(SNomeArquivoSemExtensao+'.imp');
    pRenomeiaAquivo(stlPgtoV2[intCont], SNomeArquivoSemExtensao+'.imp');
  End;

end;

end.
