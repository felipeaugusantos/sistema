unit untListaDocsGarantia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, DB, Grids, DBGridCitel, DBGrids,
  UniClientDataSet, AppEvnts, BitBtnLockedIncrem, frxClass, Uni,
  frxExportCSVTestabilidade, Datasnap.DBClient, untLiberacao, untMsgLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxTextEdit, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus;

type
  TCallBackDocumentoSelecionado =
    procedure(pstrTabela, pstrCodIte, strSeqDoc, strNumDoc, strEmpDoc, strCodVenOri, strDocFat, strIncOri,strDataVenda,
              strEspDocDet, strNumDocDet: String;
              const fltDispon, fltQtdIte, fltValIte, fltDesAceD, fltQtdSel, pfltUniCrd, pfltDET_UNITAR,
                pfltDET_DESESP, pfltDET_DESCFF: Double) of object;

type
  TfrmListaDocsGarantia = class(TfrmPai)
    dtsDocumentos: TDataSource;
    cdsDocumentos: TUniClientDataSet;
    cdsDocumentosNUMDOC: TStringField;
    cdsDocumentosDTAENT: TDateTimeField;
    cdsDocumentosDTAFIN: TDateTimeField;
    cdsDocumentosVENDA_: TFloatField;
    cdsDocumentosDISPON: TFloatField;
    cdsDocumentosFORNEC: TFloatField;
    cdsDocumentosREPOR_: TFloatField;
    cdsDocumentosREFUGO: TFloatField;
    cdsDocumentosPREJUI: TFloatField;
    cdsDocumentosMARDES: TStringField;
    cdsDocumentosVALITE: TFloatField;
    cdsDocumentosTMPGAR: TIntegerField;
    cdsDocumentosEMPDOC: TStringField;
    btnConfirmar: TBitBtnLocked;
    cdsDocumentosDET_NUMDOC: TStringField;
    cdsDocumentosDET_ESPDOC: TStringField;
    cdsDocumentosDEVOLU: TFloatField;
    cdsDocumentosCODVEN: TStringField;
    cdsDocumentosSERIE_: TStringField;
    cdsDocumentosDET_SERIE_: TStringField;
    cdsDocumentosDET_DESACE: TFloatField;
    cdsDocumentosDOCFAT: TStringField;
    cdsDocumentosINCORI: TStringField;
    cdsDocumentosDOCVEN: TStringField;
    cdsDocumentosSEQDOC: TStringField;
    Label1: TLabel;
    cdsDocumentosVALUNT: TFloatField;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGridCitel;
    cxGridDBTableViewCitel1NUMDOC: TcxGridDBColumn;
    cxGridDBTableViewCitel1SERIE_: TcxGridDBColumn;
    cxGridDBTableViewCitel1EMPDOC: TcxGridDBColumn;
    cxGridDBTableViewCitel1DTAENT: TcxGridDBColumn;
    cxGridDBTableViewCitel1TMPGAR: TcxGridDBColumn;
    cxGridDBTableViewCitel1DTAFIN: TcxGridDBColumn;
    cxGridDBTableViewCitel1VALUNT: TcxGridDBColumn;
    cxGridDBTableViewCitel1VENDA_: TcxGridDBColumn;
    cxGridDBTableViewCitel1FORNEC: TcxGridDBColumn;
    cxGridDBTableViewCitel1DEVOLU: TcxGridDBColumn;
    cxGridDBTableViewCitel1DISPON: TcxGridDBColumn;
    cxGridDBTableViewCitel1REPOR_: TcxGridDBColumn;
    cxGridDBTableViewCitel1REFUGO: TcxGridDBColumn;
    cxGridDBTableViewCitel1PREJUI: TcxGridDBColumn;
    cxGridDBTableViewCitel1DOCFAT: TcxGridDBColumn;
    cxGridDBTableViewCitel1DOCVEN: TcxGridDBColumn;
    cxGridDBTableViewCitel1MARDES: TcxGridDBColumn;
    cdsDocumentosTABELA: TStringField;
    cxGridDBTableViewCitel1TABELA: TcxGridDBColumn;
    cdsDocumentosQTDSEL: TFloatField;
    cdsDocumentosTOTSEL: TAggregateField;
    cxGridDBTableViewCitelQTDSEL: TcxGridDBColumn;
    pnlProduto: TPanel;
    lblProduto: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtQtdRec: TEditFocus;
    edtTotSel: TEditFocus;
    lblQtdIte: TLabel;
    lblQtdSel: TLabel;
    cdsDocumentosQTDSELANT: TFloatField;
    cdsDocumentosUNICRD: TFloatField;
    cdsDocumentosDET_UNITAR: TFloatField;
    cdsDocumentosDET_DESESP: TFloatField;
    cdsDocumentosDET_DESCFF: TFloatField;

    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridDBTableViewCitel1DblClick(Sender: TObject);
    procedure cxGridDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cdsDocumentosQTDSELValidate(Sender: TField);
    procedure cdsDocumentosNewRecord(DataSet: TDataSet);
    procedure pMensagemQtdSelInvalida;
    procedure pMensagemSelecionadoMaiorDisponivel;
    function fValidaSelecao: Boolean;

    procedure cdsDocumentosAfterPost(DataSet: TDataSet);
    procedure cdsDocumentosBeforePost(DataSet: TDataSet);

  private
    { Private declarations }
    objLiberacao : TLiberacao;
    FPermiteSelecaoMultipla: Boolean;
    FQtdRec: Double;
    FCallBackDocumentoSelecionado: TCallBackDocumentoSelecionado;
    procedure pSelecionaDocumento;
    function  fVerificaCadRecAberto(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;
    procedure pAdicionarItensDocVendaNaLiberacao(const strCodCli, strNumDoc, strEspDoc, strCodEmp: String);
    function fGetSQLDocVenda: String;
    function fEhDocumentoReposicaoClienteOrigemFaturamentoFuturo(const strIncDoc, strIncOri: String): Boolean;
    procedure pLimparProduto;
    function fSaldoSelecionar: Double;
    function fValidarQuantidadeSel(const fltQtdSel, fltQtdMax: Double; fltQtdMin: Double = 0): Boolean;
    procedure pSetQtdRec(Const Value: Double);
    procedure AtualizarTotalSel;
    function fTotalSelecionadoAsFloat: Double;
  public
    procedure pSetCallBackDocumentoSelecionado(CallBackDocumentoSelecionado: TCallBackDocumentoSelecionado);
    procedure pEnviarDocumentosSelecionados;
  public
    strCodCli: String;
    strNomCli: String;
    strCodIte: String;
    strDesIte: String;
    blnImportandoXML: Boolean;
    procedure pExibirDadosProduto;
    property fltQtdRec: Double Read FQtdRec Write pSetQtdRec;


    { Public declarations }

  end;

var
  frmListaDocsGarantia: TfrmListaDocsGarantia;

implementation

uses untfuncoesSimples, untTypesSistema, untFuncFat;

{$R *.dfm}



procedure TfrmListaDocsGarantia.pAdicionarItensDocVendaNaLiberacao(
  const strCodCli, strNumDoc, strEspDoc, strCodEmp: String);

  CONST
    LARGURA_CODIGO: Integer = 9;
    LARGURA_DESCRICAO: Integer = 47;
    LARGURA_QUANTIDADE: Integer = 14;
    NUMCOLUNASIMP: Integer = 74;
  Var
    Qry: TUniquery;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    strCliente: String;
    strSQL: String;
begin
  Qry := Nil;
  Try
    strSQL := fGetSQLDocVenda;
    Qry := fCriaQuery();
    Qry.Sql.Clear;
    Qry.Sql.add(strSQL);
    Qry.ParamByName('CODCLI').AsString := strCodCli;
    Qry.ParamByName('NUMDOC').AsString := strNumDoc;
    Qry.ParamByName('ESPDOC').AsString := strEspDoc;
    Qry.ParamByName('CODEMP').AsString := strCodEmp;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    objLiberacao.objMsgLibera.pAddQuebra;
    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha := TLinhaMsgLibera.create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('','INFORMAÇÕES DO DOCUMENTO DE VENDA', NUMCOLUNASIMP, alEsquerda, teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    strCliente := Format('Cliente: %s-%s',[strCodCli,Qry.FieldByname('GER_NOMCON').AsString]);
    objLinha := TLinhaMsgLibera.create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('',strCliente, NUMCOLUNASIMP, alEsquerda, teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('','ITENS',     NUMCOLUNASIMP, alCentro, teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('','CÓDIGO',     LARGURA_CODIGO, alCentro, teAutcom);
    objLinha.pAddColuna('','DESCRIÇÃO', LARGURA_DESCRICAO, alEsquerda, teAutcom);
    objlinha.pAddColuna('','QUANTIDADE',LARGURA_QUANTIDADE, alDireita, teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    Qry.First;
    While Not Qry.Eof do
    begin
      objLinha := TLinhaMsgLibera.create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna('CÓDIGO', Qry.FieldByName('DET_CODITE').AsString, LARGURA_CODIGO, alCentro, teAutcom);
      objLinha.pAddColuna('DESCRIÇÃO', qry.FieldByName('DET_DESCRI').AsString, LARGURA_DESCRICAO, alEsquerda, teAutcom);
      objlinha.pAddColuna('QUANTIDADE', FormatFloat('#,###,##0.000', Qry.FieldByName('QTD').AsFloat), LARGURA_QUANTIDADE, alDireita, teAutcom);
      objTabela.lstLinhas.Add(objLinha);
      Qry.Next;
    end;
    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    Qry.Close;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;

end;

procedure TfrmListaDocsGarantia.pExibirDadosProduto;
begin
  edtCodIte.Text := strCodIte;
  edtDesIte.Text := strDesIte;
  if blnImportandoXML then
  begin
    edtQtdRec.Visible := True;
    lblQtdIte.Visible := edtQtdRec.Visible;
    edtTotSel.Visible := True;
    lblQtdSel.Visible := edtTotSel.Visible;
    edtQtdRec.Text := FormatFloat('#,##0.00', fltQtdRec);

  end;
end;

procedure TfrmListaDocsGarantia.pLimparProduto;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
end;

procedure TfrmListaDocsGarantia.pEnviarDocumentosSelecionados;
begin
  Try
    cdsDocumentos.DisableControls;
    cdsDocumentos.Filtered := False;
    cdsDocumentos.Filter := 'MARDES = '+ QuotedStr('S');
    cdsDocumentos.Filtered := True;
    cdsDocumentos.First;



    While Not cdsDocumentos.Eof do
    begin
       FCallBackDocumentoSelecionado(cdsDocumentosTABELA.asstring,
                                     strCodIte,
                                     cdsDocumentosSEQDOC.AsString,
                                     cdsDocumentosNUMDOC.AsString,
                                     cdsDocumentosEMPDOC.AsString,
                                     cdsDocumentosCODVEN.AsString,
                                     cdsDocumentosDOCFAT.AsString,
                                     cdsDocumentosINCORI.AsString,
                                     cdsDocumentosDTAENT.AsString,
                                     cdsDocumentosDET_ESPDOC.AsString,
                                     cdsDocumentosDET_NUMDOC.AsString,
                                     cdsDocumentosDISPON.AsFloat,
                                     cdsDocumentosVENDA_.AsFloat,
                                     cdsDocumentosVALITE.AsFloat,
                                     cdsDocumentosDET_DESACE.AsFloat,
                                     cdsDocumentosQTDSEL.AsFloat,
                                     cdsDocumentosUNICRD.AsFloat,
                                     cdsDocumentosDET_UNITAR.AsFloat,
                                     cdsDocumentosDET_DESESP.AsFloat,
                                     cdsDocumentosDET_DESCFF.AsFloat);

      cdsDocumentos.Next;
    end;
  Finally
    cdsDocumentos.Filtered := False;
    cdsDocumentos.Filter := EmptyStr;
    cdsDocumentos.EnableControls;
  End;
end;

procedure TfrmListaDocsGarantia.pMensagemQtdSelInvalida;
begin
 pMensagemOk('A quantidade selecionada deve ser menor ou igual a quantidade recebida do item!');
end;

procedure TfrmListaDocsGarantia.pMensagemSelecionadoMaiorDisponivel;
begin
  fMensagem('Atenção!','A quantidade selecionada não pode ser maior que saldo disponível do item no documento.',['&Ok']);
end;


function TfrmListaDocsGarantia.fValidaSelecao: Boolean;
begin
  Result := False;
  If cdsDocumentos.IsEmpty Then
    Exit;

  if cdsDocumentosTABELA.AsString = 'MOVGER' Then
  begin
    if fEhDocumentoReposicaoClienteOrigemFaturamentoFuturo(cdsDocumentosSEQDOC.AsString,
         cdsDocumentosINCORI.AsString) then
    begin
      pMensagemOk('Este é um documento de reposição de garantia para cliente'
                  +sLineBreak+'com origem em processo de faturamento futuro (FF) já confirmado e não pode ser utilizado para garantia.'
                  +sLineBreak+'A garantia deste item pertence ao documento confirmado e seu respectivo destinarário/cliente!');
      Exit;
    end;
  end;

  if fCfgSis('LBCRGA', varBoolean) then
  begin
    if not fVerificaCadRecAberto(Copy(cdsDocumentos.FieldByName('NUMDOC').AsString, 0, Pos('-', cdsDocumentos.FieldByName('NUMDOC').AsString) - 1),
                                  cdsDocumentos.FieldByName('DET_ESPDOC').AsString,
                                  strCodCli,
                                  cdsDocumentos.FieldByName('EMPDOC').AsString) then
      Exit;
  end;
  Result := True;

End;

{*******************************************}
{* SELECIONA DOCUMENTOS DA GRID            *}
{****************************************RL*}
procedure TfrmListaDocsGarantia.pSelecionaDocumento;
  Var
    BookMark : TBookmark;
    strValOld: String;
    lfltQtdSel: Double;
begin

  If Not fValidaSelecao Then
    Exit;

  strValOld := cdsDocumentos.FieldByName('MARDES').AsString;

  BookMark := Nil;

  Try
    cdsDocumentos.DisableControls;

    if Not FPermiteSelecaoMultipla then
    begin
      BookMark := cdsDocumentos.GetBookmark;

      cdsDocumentos.First;

      While Not cdsDocumentos.Eof DO
      Begin
        cdsDocumentos.Edit;
        cdsDocumentos.FieldByName('MARDES').AsString := 'N';
        cdsDocumentos.FieldByName('QTDSEL').AsFloat := 0;
        cdsDocumentos.Post;

        cdsDocumentos.Next
      End;


      if cdsDocumentos.BookmarkValid(BookMark) then
        cdsDocumentos.GotoBookmark(BookMark);
    end;


    cdsDocumentos.Edit;
    If strValOld = 'N' Then
    begin
      lfltQtdSel := cdsDocumentos.FieldByName('QTDSEL').AsFloat;
      if lfltQtdSel = 0 then
      begin
        lfltQtdSel := fSaldoSelecionar;
        if lfltQtdSel > cdsDocumentosDISPON.AsFloat then
          lfltQtdSel := cdsDocumentosDISPON.AsFloat;

        cdsDocumentos.FieldByName('QTDSEL').AsFloat := lfltQtdSel;
      end;

      if lfltQtdSel > 0 then
        cdsDocumentos.FieldByName('MARDES').AsString := 'S';

    end
    Else
    begin
      cdsDocumentos.FieldByName('MARDES').AsString := 'N';
      cdsDocumentos.FieldByName('QTDSEL').AsFloat := 0;
    end;

    cdsDocumentos.Post;

  Finally
    if Assigned(BookMark) then
      cdsDocumentos.FreeBookmark(BookMark);

    cdsDocumentos.EnableControls;
  End;

end;

procedure TfrmListaDocsGarantia.pSetCallBackDocumentoSelecionado(
  CallBackDocumentoSelecionado: TCallBackDocumentoSelecionado);
begin
  FCallBackDocumentoSelecionado :=  CallBackDocumentoSelecionado;
end;

procedure TfrmListaDocsGarantia.pSetQtdRec(const Value: Double);
begin
  FQtdRec := Value;
end;

procedure TfrmListaDocsGarantia.cdsDocumentosAfterPost(DataSet: TDataSet);
begin
  inherited;
  AtualizarTotalSel;
end;

procedure TfrmListaDocsGarantia.cdsDocumentosBeforePost(DataSet: TDataSet);
begin
  inherited;
  cdsDocumentosQTDSELANT.AsFloat := cdsDocumentosQTDSEL.AsFloat;
end;

procedure TfrmListaDocsGarantia.cdsDocumentosNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsDocumentosQTDSEL.AsFloat := 0;
  cdsDocumentosQTDSELANT.AsFloat := 0;
end;

procedure TfrmListaDocsGarantia.cdsDocumentosQTDSELValidate(Sender: TField);
begin
  inherited;

  if Sender.AsFloat = 0 then
  begin
    cdsDocumentosMARDES.AsString := 'N';
    Exit;
  end;

  if Not fValidarQuantidadeSel(Sender.AsFloat, cdsDocumentosDISPON.AsFloat) then
  begin
    pMensagemSelecionadoMaiorDisponivel;
    Abort;
  end;

  if Not fValidarQuantidadeSel((Sender.AsFloat - cdsDocumentosQTDSELANT.AsFloat) + fTotalSelecionadoAsFloat , fltQtdRec) then
  begin
    pMensagemQtdSelInvalida;
    abort;
  end;

  cdsDocumentosMARDES.AsString := 'S';
end;

procedure TfrmListaDocsGarantia.cxGridDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  Var
    strValue: String;
begin
  inherited;

  strValue := VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxGridDBTableViewCitel1MARDES.Index],'N');
  if strValue = 'S' then
    ACanvas.Font.Color := clBlue
  else
    ACanvas.Font.Color := clBlack;


  if AViewInfo.GridRecord.Selected then
    ACanvas.Brush.Color := clWhite;

end;

procedure TfrmListaDocsGarantia.cxGridDBTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaDocumento;
end;

procedure TfrmListaDocsGarantia.cxGridDBTableViewCitel1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = Vk_Return) Then
    pSelecionaDocumento
  Else If Key = VK_Escape Then
    Close;
end;

function TfrmListaDocsGarantia.fEhDocumentoReposicaoClienteOrigemFaturamentoFuturo(
  const strIncDoc, strIncOri: String): Boolean;
  Var
    Qry: TUniQuery;
    strSQL: String;
begin
  Qry := Nil;
  Try
    strSQL := EmptyStr;
    strSQL := strSQL + ' SELECT 1 ';
    strSQL := strSQL + ' FROM MOVDET D ';
    strSQL := strSQL + ' JOIN MOVGRC C ON GRC_SEQDET = D.AUTOINCREM AND GRC_OPCDOC IN ("GC","OU") ';
    strSQL := strSQL + ' JOIN MOVDET D2 ON D2.AUTOINCREM = C.GRC_INCORI AND D2.DET_ESPDOC = "FF" AND D2.DET_JAFATU = "1" ';
    strSQL := strSQL + '                   AND IFNULL(D2.DET_NUMFAT,"") <> "" AND D2.AUTOINCREM = :INCORI  ';
    strSQL := strSQL + '                   AND D2.DET_CODCLI = D.DET_CODCLI  ';
    strSQL := strSQL + ' WHERE D.AUTOINCREM = :INCDOC ';
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSQL);
    Qry.ParambyName('INCDOC').AsString := strIncDoc;
    Qry.ParamByName('INCORI').AsString := strIncOri;
    Qry.Open;
    Result := Not Qry.IsEmpty;
  Finally
    if Assigned(Qry) Then
      FreeAndNil(Qry);
  End;
end;

function TfrmListaDocsGarantia.fGetSQLDocVenda: String;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT D.DET_CODITE, D.DET_DESCRI, SUM(D.DET_QTDITE) AS QTD, G.GER_NOMCON ';
  Result := Result + ' FROM MOVDET D ';
  Result := Result + ' JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + ' WHERE D.DET_NUMDOC = :NUMDOC AND D.DET_ESPDOC = :ESPDOC AND D.DET_CODEMP = :CODEMP AND D.DET_CODCLI = :CODCLI ';
  Result := Result + ' GROUP BY D.DET_CODITE ';
end;

procedure TfrmListaDocsGarantia.AtualizarTotalSel;
begin
  edtTotSel.Text := FormatFloat('##0.00', fTotalSelecionadoAsFloat);
end;

procedure TfrmListaDocsGarantia.btnConfirmarClick(Sender: TObject);

begin
  inherited;

  cdsDocumentos.CheckBrowseMode;

  if Not fValidarQuantidadeSel(fTotalSelecionadoAsFloat, fltQtdRec, fltQtdRec) then
  begin
    fMensagem('', 'O total selecionado deve ser igual a quantidade a receber!', ['&Ok']);
    Exit;
  end;

  cdsDocumentos.Filtered := False;
  cdsDocumentos.Filter   := 'MARDES = ''S''';
  cdsDocumentos.Filtered := True;


  If cdsDocumentos.IsEmpty or (fSaldoSelecionar > 0) Then
    Begin
    cdsDocumentos.Filtered := False;
       
      fMensagem('', 'Selecione um documento!', ['&Ok']);
      Exit;
    End;  

  ModalResult := mrOk;
  
end;

procedure TfrmListaDocsGarantia.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  strCodCli := '';
  fltQtdRec := 0;
  FPermiteSelecaoMultipla := False;
  blnImportandoXML := False;
end;

procedure TfrmListaDocsGarantia.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmListaDocsGarantia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = Vk_F10 Then
  Begin

    Key := 0;
    btnConfirmar.Click;

  End;

end;

procedure TfrmListaDocsGarantia.FormShow(Sender: TObject);
begin
  inherited;
  cxGridDBTableViewCitelQTDSEL.Visible := blnImportandoXML;
  pLimparProduto;
  pExibirDadosProduto;  pSetFocus(cxGrid);
  FPermiteSelecaoMultipla := blnImportandoXML;
  AtualizarTotalSel;
end;

function TfrmListaDocsGarantia.fSaldoSelecionar: Double;
  Var
    fltQtdSel: Double;
begin
  if fltQtdRec = 0 then
    Exit(0);

  fltQtdSel := StrToFloatdef(cdsDocumentosTOTSEL.AsString,0);
  Result := fltQtdRec - fltQtdSel;

  if Result < 0 then
    Result := 0;
end;

function TfrmListaDocsGarantia.fTotalSelecionadoAsFloat: Double;
begin
  Result := StrToFloatDef(cdsDocumentosTOTSEL.AsString, 0.0);
end;

function TfrmListaDocsGarantia.fValidarQuantidadeSel(const fltQtdSel, fltQtdMax: Double; fltQtdMin: Double = 0): Boolean;
begin
  Result :=  fltQtdSel <= fltQtdMax;
  if fltQtdMin > 0 then
    Result := Result And (fltQtdSel >= fltQtdMin);
end;

function TfrmListaDocsGarantia.fVerificaCadRecAberto(strNumDoc, strEspDoc,
  strCodCli, strCodEmp: String): Boolean;
Var
  qryTmp: TUniQuery;
  objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;
  strDocumento: String;
  fltValor: Double;
begin
  qryTmp := fCriaQuery;
  try
    with qryTmp do
    begin
      Close;
      SQL.Clear;

      SQL.Add(' SELECT CTR_NUMDUP ');
      SQL.Add(' , CTR_PARCEL ');
      SQL.Add(' , CTR_ESPDOC ');
      SQL.Add(' , CTR_CODEMP ');
      SQL.Add(' , CTR_DTACAD ');
      SQL.Add(' , CTR_DTAVEN ');
      SQL.Add(' , CTR_VALDUP ');
      SQL.Add(' FROM CADREC ');
      SQL.Add(' WHERE CTR_DTAREC IS NULL ');
      SQL.Add(' AND CTR_NUMDUP = :NUMDUP ');
      SQL.Add(' AND CTR_ESPDOC = :ESPDOC ');
      SQL.Add(' AND CTR_CODCLI = :CODCLI ');
      SQL.Add(' AND CTR_CODEMP = :CODEMP ');

      ParamByName('NUMDUP').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;
      First;

      if RecordCount > 0 then
      begin
        objLiberacao.Clear;

        fltValor := 0;
        strDocumento := FieldByName('CTR_NUMDUP').AsString +'-'+ FieldByName('CTR_ESPDOC').AsString +'-'+ FieldByName('CTR_CODEMP').AsString;
        While Not Eof Do
        Begin
          fltValor := fltValor + FieldByName('CTR_VALDUP').AsFloat;
          Next;
        End;

        objLiberacao.objMsgLibera.pAddTexto('CONTAS A RECEBER EM ABERTO', alCentro, teAmbos, '', 70);
        objLiberacao.objMsgLibera.pAddSeparador(70);
        objLiberacao.objMsgLibera.pAddTexto('Solicitação de Liberação para Recebimento do Cliente na Garantia');
        objLiberacao.objMsgLibera.pAddSeparador(70);
        objLiberacao.objMsgLibera.pAddTexto('O documento de venda '+ strDocumento +' possui R$ '+ FormatFloat('#,##0.00', fltValor));
        objLiberacao.objMsgLibera.pAddTexto('em aberto no contas a receber, conforme abaixo:');

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'DUPLICATA'    , 22 , alCentro  , teAutcom);
        objLinha.pAddColuna(''  , 'DT.CADASTRO'  , 13 , alCentro  , teAutcom);
        objLinha.pAddColuna(''  , 'DT.VENCIMENTO', 13 , alCentro  , teAutcom);
        objLinha.pAddColuna(''  , 'VR.EM ABERTO' , 13 , alDireita , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        First;
        While Not Eof Do
        Begin

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna('DUPLICATA'    ,   FieldByName('CTR_NUMDUP').AsString +'-'
                                               + FieldByName('CTR_PARCEL').AsString +'-'
                                               + FieldByName('CTR_ESPDOC').AsString +'-'
                                               + FieldByName('CTR_CODEMP').AsString                                 , 22 , alCentro  , teAutcom);
          objLinha.pAddColuna('DT.CADASTRO'  ,   FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTACAD').AsDateTime) , 13 , alCentro  , teAutcom);
          objLinha.pAddColuna('DT.VENCIMENTO',   FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime) , 13 , alCentro  , teAutcom);
          objLinha.pAddColuna('VR.EM ABERTO' ,   FormatFloat('#,##0.00', FieldByName('CTR_VALDUP').AsFloat)         , 13 , alDireita , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          Next;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        objLiberacao.objMsgLibera.pAddQuebra;

        objLiberacao.objMsgLibera.pAddTexto(Format('Produto: %s',[Self.strCodIte]), alEsquerda,teAmbos,'',25);
        objLiberacao.objMsgLibera.pAddTexto(Format('Descrição do Produto: %s',[Self.strDesIte]), alEsquerda,teAmbos,'',90);

        objLiberacao.objMsgLibera.pAddQuebra;

        pAdicionarItensDocVendaNaLiberacao(strCodCli, strNumDoc, strEspDoc, strCodEmp);

        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        Result := objLiberacao.fLibera;
      end
      else
        Result := True;
    end;

  finally
    FreeAndNil(qryTmp);
  end;
end;

end.

