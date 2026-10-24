unit untTermoAceiteCompraVenda;

interface

uses System.Classes, Vcl.Forms, Winapi.Windows, System.SysUtils, System.StrUtils, Uni, Printers;

type
  TTermoAceiteCompraVenda = class
  private
    { private declarations }
    class var strExtensao: String;
    class function fRetArqOrigem: String;
    class function fRetArqDestino(const ANomArq: String): String;
  protected
    { protected declarations }
  public
    { public declarations }
    class function pImprimeTermoDoc(const ADataEmi: TDate;
     const ANumDoc, AEspDoc, ACodEmp, ANomeFan, AEmailEmp, ATelEmp, ANomVen, ANomCli : String): Boolean;

    class function fRetArqTermoDoc(const ADataEmi: TDate; const ANumDoc, AEspDoc, ACodEmp,
                                    ANomeFan, AEmailEmp, ATelEmp, ANomVen, ANomCli : String;
                                    blnExibiMsg: Boolean = True): String;
  end;

const
  strNomArq = 'TERMO_ACEITE_COMPRA_VENDA';
  strNomDir = 'TERMO DE ACEITE';

implementation

{ TTermoAceiteCompraVenda }

uses
  untFuncoesSimples, untWord, untCfgRel, untFuncoesGenerica;

class function TTermoAceiteCompraVenda.fRetArqOrigem: String;
begin
  Result := ExtractFilePath(Application.ExeName) + strNomArq;
  strExtensao := '.docx';

  If Not FileExists(Result + strExtensao) Then
    strExtensao := '.doc';

  Result := Result + strExtensao;
end;

class function TTermoAceiteCompraVenda.fRetArqDestino(const ANomArq: String): String;
begin
  Result := ExtractFilePath(Application.ExeName) + strNomDir;

  If Not DirectoryExists(Result) Then
    CreateDir(Result);

  Result := Concat(Result, PathDelim, strNomArq, '_', ANomArq, strExtensao);

  If FileExists(Result) Then
    DeleteFile(Result);
end;

class function TTermoAceiteCompraVenda.fRetArqTermoDoc(const ADataEmi: TDate; const ANumDoc, AEspDoc, ACodEmp,
                                    ANomeFan, AEmailEmp, ATelEmp, ANomVen, ANomCli : String;
                                    blnExibiMsg: Boolean = True): String;
Var
    strArqOri, strArqDes: String;
    Word: TWord;
begin

  Try
    strArqOri := fRetArqOrigem;

    If Not FileExists(strArqOri) Then
    Begin
      If blnExibiMsg Then
        pMensagemOk('Arquivo "' + strNomArq + strExtensao + '" não encontrado!');

      Exit;
    End;

    strArqDes := fRetArqDestino(Concat(ANumDoc, '-', AEspDoc, '-', ACodEmp));

    If Not CopyFile(PChar(strArqOri), PChar(strArqDes), False) Then
    Begin
      If blnExibiMsg Then
        pMensagemOk('Não foi possível criar o arquivo "' + strArqDes + '"!');
      Exit;
    End;

    Word := TWord.fCriarWord(Nil);

    If Word = Nil Then
      Exit;

    Try
      If Not Word.AbrirArquivo(strArqDes) Then
      Begin
        If blnExibiMsg Then
          pMensagemOk('Não foi possível abrir o arquivo "' + strArqDes + '"!');

        Exit;
      End;

      Word.pGoToPageHeader;
      Word.pGoToMainDocument;

      Word.pReplace('{{DTEMIS}}',   FormatDateTime('dd/mm/yyyy', ADataEmi));
      Word.pReplace('{{NUMPED}}',   ANumDoc);
      Word.pReplace('{{NOMEFAN}}',  ANomeFan);
      Word.pReplace('{{EMAILEMP}}', AEmailEmp);
      Word.pReplace('{{TELEMP}}',   fFormataFone(ATelEmp));
      If (AEspDoc = 'PD') then
        Word.pReplace('{{TIPO}}',   'PEDIDO')
      Else If (AEspDoc = 'OR') then
        Word.pReplace('{{TIPO}}',   'ORÇAMENTO');

      Word.pReplace('{{NOMVEN}}', ANomVen);
      Word.pReplace('{{NOMCLI}}', ANomCli);

      Sleep(2000);//deve aguardar para concluir o replace no documento

      strArqDes := ReplaceStr(strArqDes, ExtractFileExt(strArqDes), '.pdf');
      Word.SaveAsPDF(strArqDes);

      Word.pFechar;

      Result := strArqDes;
    Finally
      FreeAndNil(Word);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TTermoAceiteCompraVenda.fRetArqTermoDoc]');
  End;
end;

class function TTermoAceiteCompraVenda.pImprimeTermoDoc(const ADataEmi: TDate;
  const ANumDoc, AEspDoc, ACodEmp, ANomeFan, AEmailEmp, ATelEmp, ANomVen, ANomCli : String): Boolean;
  Const
    FCopias = 1;
  Var
    strArqDes, strNomImp: String;
    Word: TWord;
    qryCfgRel: TUniQuery;
    I: Integer;
begin
  Result := False;

  Try
    Word := TWord.fCriarWord(Nil);
    qryCfgRel := fCriaQuery;

    If Word = Nil Then
      Exit;

    strArqDes := fRetArqTermoDoc(ADataEmi, ANumDoc, AEspDoc, ACodEmp, ANomeFan, AEmailEmp, ATelEmp, ANomVen, ANomCli);

    Try
      If Not Word.AbrirArquivo(strArqDes) Then
      Begin
        pMensagemOk('Não foi possível abrir o arquivo "' + strArqDes + '"!');
        Exit;
      End;

      pCarregaConfImpr(qryCfgRel, 'TERMO_ACEITE_COMPRA_VENDA');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      If ((fEmptyStr(strNomImp)) Or (Not fImpressoraExiste(strNomImp))) Then
      Begin
        TCfgRel.fExecutePrintDialog(strNomImp);
        If fEmptyStr(strNomImp) Then
          strNomImp := TCfgRel.fGetImpressoraSelecionada;
      End;

      If fEmptyStr(strNomImp) Then
      Begin
        Raise Exception.Create('É necessário selecionar uma impressora.');
        Exit;
      End;

      Application.ProcessMessages;

      For I := 1 To FCopias Do
      Begin
        Sleep(1000);
        TCfgRel.pPrintReport('TERMO_ACEITE_COMPRA_VENDA', ExtractFileName(strArqDes), strNomImp, Word);
      End;

      Word.pFechar;

      Result := True;
    Finally
      FreeAndNil(Word);
      FreeAndNil(qryCfgRel);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TTermoAceiteCompraVenda.pImprimeTermoDoc]');
  End;
end;

end.
