unit untImpressaoPedidoTrocaRecebimento;

interface

uses System.Classes, Vcl.Forms, Winapi.Windows, System.SysUtils, System.StrUtils, Uni, Printers;

type
  TImpPedidoTrocaRecebimento = class
    private
      class var FExtensao: String;
      class function fRetArqOrigem: String;
      class function fRetArqDestino(const ANomArq: String): String;
      class function fRetArqFormularioDoc(const ANumDoc, AEspDoc, ACodEmp, ACodCli: String): String;

    public
       class function pImprimeFormularioDoc(const ANumDoc, AEspDoc, ACodEmp, ACodCli: String): Boolean;
  end;

const
  FNomArq = 'FORMULÁRIO DE DEVOLUÇÃO VENDA A BASE DE TROCA';
  FNomDir = 'DEVOLUÇÃO_VENDA_A_BASE_DE_TROCA';

implementation

uses
  untFuncoesSimples, untWord, untCfgRel, untFuncoesGenerica;

{ TImpPedidoTrocaRecebimento }

class function TImpPedidoTrocaRecebimento.fRetArqDestino(
  const ANomArq: String): String;
begin
  Result := ExtractFilePath(Application.ExeName) + FNomDir;

  If Not DirectoryExists(Result) Then
    CreateDir(Result);

  Result := Concat(Result, PathDelim, FNomArq, '_', ANomArq, FExtensao);

  If FileExists(Result) Then
    DeleteFile(Result);
end;

class function TImpPedidoTrocaRecebimento.fRetArqOrigem: String;
begin
  Result := ExtractFilePath(Application.ExeName) + FNomArq;
  FExtensao := '.docx';

  If Not FileExists(Result + FExtensao) Then
    FExtensao := '.doc';

  Result := Result + FExtensao;
end;

class function TImpPedidoTrocaRecebimento.fRetArqFormularioDoc(const ANumDoc,
  AEspDoc, ACodEmp, ACodCli: String): String;
var
  LArqOri, LArqDes: String;
  LWord: TWord;
  LData: TDate;
  LCidade: String;
  LQryTabela: TUniQuery;
  LLinha: Integer;
begin
  Try
    LArqOri := fRetArqOrigem;

    If Not FileExists(LArqOri) Then
    Begin
      pMensagemOk('Arquivo "' + FNomArq + FExtensao + '" não encontrado!');
      Exit;
    End;

    LArqDes := fRetArqDestino(Concat(ANumDoc, '-', AEspDoc, '-', ACodEmp));

    If Not CopyFile(PChar(LArqOri), PChar(LArqDes), False) Then
    Begin
      pMensagemOk('Não foi possível criar o arquivo "' + LArqDes + '"!');
      Exit;
    End;

    LWord := TWord.fCriarWord(Nil);

    If LWord = Nil Then
      Exit;

    Try
      If Not LWord.AbrirArquivo(LArqDes) Then
      Begin
        pMensagemOk('Não foi possível abrir o arquivo "' + LArqDes + '"!');
        Exit;
      End;

      LWord.pGoToPageHeader;
      LWord.pGoToMainDocument;

      LData := fCampoTabela('FGO_DTAENT', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP', 'FGO_CODCLI'], [ANumDoc,AEspDoc,ACodEmp,ACodCli], False);
      LCidade := fCampoTabela('EMP_CODCID','CADEMP',['EMP_CODEMP'],[ACodEmp],False);

      LWord.pReplace('{{DOCUMENTO}}',  Concat(ANumDoc, ' ', AEspDoc));
      LWord.pReplace(' {{NOME}}',  fRetNomCliente(ACodCli));
      LWord.pReplace('{{DATA}}',  FormatDateTime('dd/mm/yyyy', LData));
      LWord.pReplace('{{INFORMACAO}}',  Concat(fRetNomCidade(LCidade),', ',FormatDateTime('dd "de" mmmm "de" yyyy', fRetDataServidor)));

      LQryTabela := fCriaQuery;

      try
        LQryTabela.Close;
        LQryTabela.SQL.Clear;
        LQryTabela.SQL.Add('SELECT IRC_ITEPEN, IRC_QTDPEN, IRC_UNIPEN, IRC_TOTPEN, ITE_DESITE, MAR_DESMAR, CAST("" AS CHAR(10)) AS DEVOLVIDO');
        LQryTabela.SQL.Add('FROM ITEREC');
        LQryTabela.SQL.Add('INNER JOIN PENREC');
        LQryTabela.SQL.Add('ON(PENREC.AUTOINCREM = ITEREC.IRC_SEQGER)');
        LQryTabela.SQL.Add('INNER JOIN CADITE');
        LQryTabela.SQL.Add('ON(ITEREC.IRC_ITEPEN = CADITE.ITE_CODITE)');
        LQryTabela.SQL.Add('LEFT JOIN CADMAR');
        LQryTabela.SQL.Add('ON(CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR)');
        LQryTabela.SQL.Add('WHERE PEN_NUMDOC = :NUMDOC');
        LQryTabela.SQL.Add('AND PEN_ESPDOC = :ESPDOC');
        LQryTabela.SQL.Add('AND PEN_CODEMP = :CODEMP');
        LQryTabela.SQL.Add('AND PEN_CODCLI = :CODCLI');
        LQryTabela.SQL.Add('AND IRC_ITEPEN IS NOT NULL');

        LQryTabela.ParamByName('NUMDOC').AsString := ANumDoc;
        LQryTabela.ParamByName('ESPDOC').AsString := AEspDoc;
        LQryTabela.ParamByName('CODEMP').AsString := ACodEmp;
        LQryTabela.ParamByName('CODCLI').AsString := ACodCli;

        LQryTabela.Open;

        if not LQryTabela.IsEmpty then
        begin
          LWord.pCriaTabela('{{TABELA1}}', LQryTabela.RecordCount + 1, 7);

          if LWord.blnTabelaCriada then
          begin
            LLinha := 1;

            LWord.pCelulaNegrito(LLinha, 1);
            LWord.pCelulaEscreve(LLinha, 1, 'CÓDIGO');

            LWord.pCelulaNegrito(LLinha, 2);
            LWord.pCelulaEscreve(LLinha, 2, 'DESCRIÇÃO');

            LWord.pCelulaNegrito(LLinha, 3);
            LWord.pCelulaEscreve(LLinha, 3, 'MARCA');

            LWord.pCelulaNegrito(LLinha, 4);
            LWord.pCelulaAlignRight(LLinha, 4);
            LWord.pCelulaEscreve(LLinha, 4, 'QTD.');

            LWord.pCelulaNegrito(LLinha, 5);
            LWord.pCelulaAlignRight(LLinha, 5);
            LWord.pCelulaEscreve(LLinha, 5, 'VALOR');

            LWord.pCelulaNegrito(LLinha, 6);
            LWord.pCelulaAlignRight(LLinha, 6);
            LWord.pCelulaEscreve(LLinha, 6, 'TOTAL');

            LWord.pCelulaNegrito(LLinha, 7);
            LWord.pCelulaEscreve(LLinha, 7, 'DEVOLVIDO');

            while not LQryTabela.Eof do
            begin
              Inc(LLinha);

              LWord.pCelulaEscreve(LLinha, 1, LQryTabela.FieldByName('IRC_ITEPEN').AsString);
              LWord.pCelulaEscreve(LLinha, 2, LQryTabela.FieldByName('ITE_DESITE').AsString);
              LWord.pCelulaEscreve(LLinha, 3, LQryTabela.FieldByName('MAR_DESMAR').AsString);
              LWord.pCelulaAlignRight(LLinha, 4);
              LWord.pCelulaEscreve(LLinha, 4, FormatFloat('#,##0.00',LQryTabela.FieldByName('IRC_QTDPEN').AsFloat));
              LWord.pCelulaAlignRight(LLinha, 5);
              LWord.pCelulaEscreve(LLinha, 5, FormatFloat('#,##0.00',LQryTabela.FieldByName('IRC_UNIPEN').AsFloat));
              LWord.pCelulaAlignRight(LLinha, 6);
              LWord.pCelulaEscreve(LLinha, 6, FormatFloat('#,##0.00',LQryTabela.FieldByName('IRC_TOTPEN').AsFloat));
              LWord.pCelulaEscreve(LLinha, 7, LQryTabela.FieldByName('DEVOLVIDO').AsString);

              LQryTabela.Next;
            end;
          end;

          LQryTabela.First;

          LWord.pCriaTabela('{{TABELA2}}', LQryTabela.RecordCount + 1, 7);

          if LWord.blnTabelaCriada then
          begin
            LLinha := 1;

            LWord.pCelulaNegrito(LLinha, 1);
            LWord.pCelulaEscreve(LLinha, 1, 'CÓDIGO');

            LWord.pCelulaNegrito(LLinha, 2);
            LWord.pCelulaEscreve(LLinha, 2, 'DESCRIÇÃO');

            LWord.pCelulaNegrito(LLinha, 3);
            LWord.pCelulaEscreve(LLinha, 3, 'MARCA');

            LWord.pCelulaNegrito(LLinha, 4);
            LWord.pCelulaAlignRight(LLinha, 4);
            LWord.pCelulaEscreve(LLinha, 4, 'QTD.');

            LWord.pCelulaNegrito(LLinha, 5);
            LWord.pCelulaAlignRight(LLinha, 5);
            LWord.pCelulaEscreve(LLinha, 5, 'VALOR');

            LWord.pCelulaNegrito(LLinha, 6);
            LWord.pCelulaAlignRight(LLinha, 6);
            LWord.pCelulaEscreve(LLinha, 6, 'TOTAL');

            LWord.pCelulaNegrito(LLinha, 7);
            LWord.pCelulaEscreve(LLinha, 7, 'DEVOLVIDO');

            while not LQryTabela.Eof do
            begin
              Inc(LLinha);

              LWord.pCelulaEscreve(LLinha, 1, LQryTabela.FieldByName('IRC_ITEPEN').AsString);
              LWord.pCelulaEscreve(LLinha, 2, LQryTabela.FieldByName('ITE_DESITE').AsString);
              LWord.pCelulaEscreve(LLinha, 3, LQryTabela.FieldByName('MAR_DESMAR').AsString);
              LWord.pCelulaAlignRight(LLinha, 4);
              LWord.pCelulaEscreve(LLinha, 4, FormatFloat('#,##0.00',LQryTabela.FieldByName('IRC_QTDPEN').AsFloat));
              LWord.pCelulaAlignRight(LLinha, 5);
              LWord.pCelulaEscreve(LLinha, 5, FormatFloat('#,##0.00',LQryTabela.FieldByName('IRC_UNIPEN').AsFloat));
              LWord.pCelulaAlignRight(LLinha, 6);
              LWord.pCelulaEscreve(LLinha, 6, FormatFloat('#,##0.00',LQryTabela.FieldByName('IRC_TOTPEN').AsFloat));
              LWord.pCelulaEscreve(LLinha, 7, LQryTabela.FieldByName('DEVOLVIDO').AsString);

              LQryTabela.Next;
            end;
          end;
        end;
      finally
        FreeAndNil(LQryTabela);
      end;

      Sleep(2000);//deve aguardar para concluir o replace no documento

      LWord.pSalvar;

      LWord.pFechar;

      Result := LArqDes;
    Finally
      FreeAndNil(LWord);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TImpPedidoTrocaRecebimento.fRetArqFormularioDoc]');
  End;
end;

class function TImpPedidoTrocaRecebimento.pImprimeFormularioDoc(const ANumDoc,
  AEspDoc, ACodEmp, ACodCli: String): Boolean;
const
  LCopias = 1;
var
  LArqDes: String;
  LWord: TWord;
begin
  Result := False;

  Try
    LWord := TWord.fCriarWord(Nil);

    If LWord = Nil Then
      Exit;

    LArqDes := fRetArqFormularioDoc(ANumDoc, AEspDoc, ACodEmp, ACodCli);

    Try
      Application.ProcessMessages;

      pExecArquivo(LArqDes, 0);

      Result := True;
    Finally
      FreeAndNil(LWord);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TImpPedidoTrocaRecebimento.pImprimeFormularioDoc]');
  End;
end;
end.
