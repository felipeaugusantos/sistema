{******************************************}
{* Importação de arquivos do MERCADOLIVRE *}
{***************************************AJ*}
unit untMercadoLivre;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untMercadoLivrePgto, ComCtrls, untTImportacaoCartao;

Type
  TMercadoLivre = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
    procedure ProcessaArquivosSelecionados(AAquivos: TStringList); override;
  Private
    objPgto   : TMercadoLivrePgto;

    FPossuiBankReport: Integer;

    procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    procedure pCarregaArquivos(strExt, strPath: String);
    procedure CarregaArquivosSelecionados(AAquivos: TStringList);

    function ValidaArquivo(ALinha, ASeparador: String): Boolean;

    procedure ExibeMensagemBankReport(ANenhumArquivo: Boolean);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TMercadoLivre }

procedure TMercadoLivre.CarregaArquivosSelecionados(AAquivos: TStringList);
  Var
    I: Integer;
    strLinha  : String;
    txtArquivo: TextFile;
    LSeparador: String;
    LNomeArquivo : String;
Begin
  Try

    For I := 0 to AAquivos.Count - 1 Do
    Begin
      LNomeArquivo := System.SysUtils.ExtractFileName( AAquivos[I]);

      Application.ProcessMessages;
      AssignFile(txtArquivo, AAquivos[I]);
      Reset(txtArquivo);
      Readln(txtArquivo, strLinha);
      strLinha := fConverteParaAcento(strLinha);

      LSeparador := ',';
      If (Pos('EXTERNAL_REFERENCE;', strLinha) > 0) Then
        LSeparador := ';';

      If ValidaArquivo(strLinha, LSeparador) Then
        stlPgto.Add(AAquivos[I]);

      Flush(txtArquivo);
      Close(txtArquivo);
    End;

  Except
    Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + LNomeArquivo  +
                           '. Verifique se esse não está aberto em outro programa.');
  End;
End;

constructor TMercadoLivre.Create(Owner: TComponent);
begin
  inherited;
  objPgto   := TMercadoLivrePgto.Create;
  strNomCon := 'MERCADO LIVRE';
  strMenCon := 'A conciliação é feita a partir do Relatório de Liberações do Mercado Pago.';

  FPossuiBankReport := 0;
end;

destructor TMercadoLivre.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);

  If Assigned(FRegistrosJaImportados) Then;
    FRegistrosJaImportados := Nil;

  If Assigned(FDatasPagamento) Then
    FreeAndNil(FDatasPagamento);

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

  objFunctions.fIMensagem('ATENÇÃO', LMensagem, ['&Ok']);
end;

function TMercadoLivre.ValidaArquivo(ALinha, ASeparador: String): Boolean;
begin
  Result := Pos('EXTERNAL_REFERENCE' + ASeparador, ALinha) > 0;

  If Result Then
  Begin
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
        strLinha := fConverteParaAcento(strLinha);

        LSeparador := ',';
        If (Pos('EXTERNAL_REFERENCE;', strLinha) > 0) Then
          LSeparador := ';';

        If ValidaArquivo(strLinha, LSeparador) Then
          stlPgto.Add(strPath + '\' + arqArquivo.Name);

        Flush(txtArquivo);
        Close(txtArquivo);

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  Except
    Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + arqArquivo.Name +
                           '. Verifique se esse não está aberto em outro programa.');
  End;
End;

procedure TMercadoLivre.pProcessaArquivos(strPath: String);
  Var
    LMensagemSucesso : String;
begin
  Try
    pCarregaArquivos('csv', strPath);
    If (stlPgto.Count = 0) Then
    Begin
      ExibeMensagemBankReport(True);
      FPossuiBankReport := 0;
      objFunctions.fIMensagem('ATENÇÃO','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    untMercadoLivrePgto.FTemRegistroParaConciliacao := False;
    pAdicionaLinhas;
    pGravarRegistros;

    ExibeMensagemBankReport(False);
    LMensagemSucesso := 'Dados importados com sucesso';

    If Not untMercadoLivrePgto.FTemRegistroParaConciliacao Then
      LMensagemSucesso := LMensagemSucesso + ', porém não possui registros suficiente para conciliação.'
    Else
      LMensagemSucesso := LMensagemSucesso + '!';

    objFunctions.fIMensagem('',LMensagemSucesso,['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
    Begin
      objFunctions.fIMensagem('ATENÇÃO', E.Message, ['&OK']);

      frmForm.Close;
    End;
  End;
end;

procedure TMercadoLivre.ProcessaArquivosSelecionados(AAquivos: TStringList);
  Var
    LMensagemSucesso: String;
begin
  Try
    CarregaArquivosSelecionados(AAquivos);
    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    untMercadoLivrePgto.FTemRegistroParaConciliacao := False;

    pAdicionaLinhas;
    pGravarRegistros;

    LMensagemSucesso := 'Dados importados com sucesso';

    If Not untMercadoLivrePgto.FTemRegistroParaConciliacao Then
      LMensagemSucesso := LMensagemSucesso + ', porém não possui registros suficiente para conciliação.'
    Else
      LMensagemSucesso := LMensagemSucesso + '!';

    objFunctions.fIMensagem('',LMensagemSucesso,['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
    Begin
      objFunctions.fIMensagem('ATENÇÃO', E.Message, ['&OK']);
      frmForm.Close;
    End;
  End;
end;

procedure TMercadoLivre.pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
  Var
    intCont  : Integer;
    intLin   : Integer;
    stlAux   : TStringList;
    dtaDtaArq: TDateTimeInfoRec;
begin
  Try
    stlAux := TStringList.Create;

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

      untMercadoLivrePgto.Separador := ',';
      If (Pos('EXTERNAL_REFERENCE;', stlAux[0]) > 0) Then
        untMercadoLivrePgto.Separador := ';';

      For intLin := 0 To stlAux.Count -1 Do
      Begin
        If Not fEmptyStr(stlAux[intLin]) Then
        Begin
          itrCartoes.pAdicionaLinha(stlAux[intLin]);
        End;
      End;

      stlAux.Clear;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(stlAux);

end;

procedure TMercadoLivre.pAdicionaLinhas;
Begin
  SetLength(FRegMLPgto , 0);

  pAdiciona(objPgto, stlPgto);
End;

procedure TMercadoLivre.pGravarRegistros;
  Var
    intCont: Integer;
begin

  objPgto.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
    pRenomeiaAquivo(stlPgto[intCont], AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
  end;
end;

end.
