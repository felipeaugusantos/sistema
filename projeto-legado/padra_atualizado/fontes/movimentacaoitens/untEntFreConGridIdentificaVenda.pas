unit untEntFreConGridIdentificaVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, UniClientDataSet,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, untFuncoesSimples,
  cxGridBandedTableView, cxGridDBBandedTableView,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, untMsgLiberacao;

type
  TfrmEntFreConGridIdentificaVenda = class(TfrmPaiConfirma)
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    dtsDados: TDataSource;
    cxDadosBandTbl: TcxGridDBBandedTableView;
    cxDadosMov_SeqGer: TcxGridDBBandedColumn;
    cxDadosDuplicado: TcxGridDBBandedColumn;
    cxDadosFIS_CODEMP: TcxGridDBBandedColumn;
    cxDadosFIS_ESPECIE: TcxGridDBBandedColumn;
    cxDadosFIS_NUMDOC: TcxGridDBBandedColumn;
    pnlLegenda: TPanel;
    shpDuplicados: TShape;
    lblDuplicados: TLabel;
    Label2: TLabel;
    Shape2: TShape;
    Label1: TLabel;
    Shape1: TShape;
    cxDadosDUP_RECTNF: TcxGridDBBandedColumn;
    Label3: TLabel;
    Shape3: TShape;
    pnlDup: TPanel;
    memDup: TMemo;
    procedure dtsDadosUpdateData(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    { verifica se dentro dos documentos informados existe algum repetido }
    function fValidaDados: boolean;
    procedure cxDadosBandTblCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    function  fPedeSenhaDocumentoSemVenda: Boolean;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    qryConsulta: TUniQuery;
    cdsDadosBackup: TUniClientDataSet;
    objLiberacao : TLiberacao;
//    FblnDocumentoDuplicado : Boolean;
    function fLocalizaDocumento: String;
    procedure ClientDataSet1AfterScroll(DataSet: TDataSet);
//    procedure setAlteracoesTela(const Value: Boolean);
    { Private declarations }
  public
//    property blnDocumentoDuplicado: Boolean write setAlteracoesTela;
    { Public declarations }
  end;

var
  frmEntFreConGridIdentificaVenda: TfrmEntFreConGridIdentificaVenda;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncFat;


procedure TfrmEntFreConGridIdentificaVenda.ClientDataSet1AfterScroll(DataSet: TDataSet);
begin
  If (dtsDados.DataSet.FieldByName('DUP_RECTNF').AsString = 'S') And
     (dtsDados.DataSet.FieldByName('ENT_DUPLIC').AsString = 'S' )Then
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT FIS_DTAENT,');
    qryConsulta.SQL.Add('       FIS_NUMDOC,');
    qryConsulta.SQL.Add('       FIS_ESPDOC,');
    qryConsulta.SQL.Add('       FIS_DTADOC,');
    qryConsulta.SQL.Add('       FIS_ACESSO');
    qryConsulta.SQL.Add('  FROM RECTNF');
    qryConsulta.SQL.Add('  LEFT JOIN CADFIS ON CADFIS.AUTOINCREM = REC_CTESEQ');
    qryConsulta.SQL.Add(' WHERE RECTNF.REC_MOVSEQ = :MOVSEQ');
    qryConsulta.ParamByName('MOVSEQ').AsString := dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString;
    qryConsulta.Open;
    memDup.Lines.Clear;
    While Not qryConsulta.Eof Do
    Begin
      memDup.Lines.Add('CHAVE CTE: ' + qryConsulta.FieldByName('FIS_ACESSO').AsString +
             ' DATA CADASTRO: ' + qryConsulta.FieldByName('FIS_DTAENT').AsString);
      memDup.Lines.Add('DATA DOCUMENTO: ' + qryConsulta.FieldByName('FIS_DTADOC').AsString +
             ' NUMERO DOC.: ' + qryConsulta.FieldByName('FIS_NUMDOC').AsString +
             ' ESPECIE: ' + qryConsulta.FieldByName('FIS_ESPDOC').AsString);
      qryConsulta.Next;
    End;
    pnlDup.Visible := memDup.Lines.Count > 0;
  End
  Else
    pnlDup.Visible := False;
end;

procedure TfrmEntFreConGridIdentificaVenda.cxDadosBandTblCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var Value: string;
begin
  inherited;
  Value := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxDadosMov_SeqGer.Index]));
  if  Value <> '' Then
    ACanvas.Brush.Color := clMoneyGreen;
  Value := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxDadosDuplicado.Index]));
  if  Value = 'S' Then
  Begin
    ACanvas.Brush.Color := clRed;
    ACanvas.Font.Color := clWhite;
  End;
  If (Value = 'S') and (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxDadosDUP_RECTNF.Index]) = 'S') Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmEntFreConGridIdentificaVenda.dtsDadosUpdateData(Sender: TObject);
begin
  inherited;
  dtsDados.OnUpdateData := nil;
  try
     dtsDados.DataSet.Edit;
     dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString := fLocalizaDocumento;
     if dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString = '' Then
       dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString := ''
     Else
       dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString := fStrZero(dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString, fTamNumDoc);
     dtsDados.DataSet.Post;
     If dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString = '' Then
       pMensagemOk('Documento não encontrado');
     fValidaDados;
  Finally
    dtsDados.OnUpdateData := dtsDadosUpdateData;
  End;
end;

function TfrmEntFreConGridIdentificaVenda.fLocalizaDocumento:String;
begin
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT AUTOINCREM FROM MOVGER');
  qryConsulta.SQL.Add(' WHERE MOVGER.GER_TIP_FC = "C"');
  qryConsulta.SQL.Add('   AND MOVGER.GER_NUMDOC = :NUMDOC');
  qryConsulta.SQL.Add('   AND MOVGER.GER_CODEMP = :CODEMP');
  qryConsulta.SQL.Add('   AND MOVGER.GER_ESPDOC = :ESPDOC');
  qryConsulta.SQL.Add('   AND MOVGER.GER_ORIDOC = "V"');

  Result := '';
  If (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString)) and
     (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_CODEMP').AsString)) and
     (not fEmptyStr(dtsDados.DataSet.FieldByName('FIS_ESPDOC').AsString)) Then
  begin
    qryConsulta.ParamByName('NUMDOC').Value := fStrZero(dtsDados.DataSet.FieldByName('FIS_NUMDOC').AsString, fTamNumDoc);
    qryConsulta.ParamByName('CODEMP').Value := dtsDados.DataSet.FieldByName('FIS_CODEMP').Value;
    qryConsulta.ParamByName('ESPDOC').Value := dtsDados.DataSet.FieldByName('FIS_ESPDOC').Value;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
      Result := qryConsulta.FieldByName('AUTOINCREM').AsString;
  End;
end;

procedure TfrmEntFreConGridIdentificaVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrAbort Then
    Action := caNone;
end;

procedure TfrmEntFreConGridIdentificaVenda.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta:= fCriaQuery();
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmEntFreConGridIdentificaVenda.FormDestroy(Sender: TObject);
begin
  inherited;
  TUniClientDataSet(dtsDados.Dataset).AfterScroll := Nil;
  FreeAndNil(qryConsulta);
  FreeAndNil(objLiberacao);
end;

procedure TfrmEntFreConGridIdentificaVenda.FormShow(Sender: TObject);
begin
  inherited;
  TUniClientDataSet(dtsDados.Dataset).AfterScroll := ClientDataSet1AfterScroll;
end;

function TfrmEntFreConGridIdentificaVenda.fPedeSenhaDocumentoSemVenda: Boolean;
 const
   cTitulo = 'DOCUMENTOS DE FRETE NÃO FORAM VINCULADOS COM AS VENDAS.';
   cTituloDet = 'CHAVES DOS FRETES NÃO VINCULADOS COM VENDA';
Begin
  Result := True;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(70);
  objLiberacao.objMsgLibera.pAddTexto(cTituloDet);
  objLiberacao.objMsgLibera.pAddSeparador(70);

  cdsDadosBackup.First;
  While not cdsDadosBackup.Eof Do
  Begin
    objLiberacao.objMsgLibera.pAddTexto(Copy(cdsDadosBackup.FieldByName('CTE_ACESSO').AsString, 1, 70));
    cdsDadosBackup.Next;
  End;

  objLiberacao.strDirAce := 'IMFRSN';
  objLiberacao.strMsgSen := cTitulo;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnSempreVariavelUsuario := True;


  If Not (objLiberacao.fLibera) Then
    Result := False;
end;

function TfrmEntFreConGridIdentificaVenda.fValidaDados: boolean;
var
  strBookMark: TBookmark;
begin
  Result := True;
  cdsDadosBackup := TUniClientDataSet.Create(nil);
  dtsDados.DataSet.DisableControls;
  Try
     TUniClientDataSet(dtsDados.Dataset).AfterScroll := nil;
     strBookMark := dtsDados.DataSet.Bookmark;
     dtsDados.DataSet.First;
     cdsDadosBackup.Data := TUniClientDataSet(dtsDados.DataSet).Data;
     while not dtsDados.DataSet.EoF do
     Begin
       If dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString <> '' Then
       Begin
         cdsDadosBackup.Filtered := False;
         cdsDadosBackup.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND MOV_GERSEQ = '+ QuotedStr(dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString);
         cdsDadosBackup.Filtered := True;
         dtsDados.DataSet.Edit;
         If cdsDadosBackup.RecordCount > 1 Then
         Begin
           Result := False;
           dtsDados.DataSet.FieldByName('ENT_DUPLIC').AsString := 'S';
         End
         Else
           dtsDados.DataSet.FieldByName('ENT_DUPLIC').AsString := 'N';

         //Verifica se o esse documento ja esta referenciado em outra nota fiscal
         qryConsulta.Sql.Clear;
         qryConsulta.SQL.Add('SELECT *');
         qryConsulta.SQL.Add('  FROM RECTNF');
         qryConsulta.SQL.Add(' WHERE RECTNF.REC_MOVSEQ = :MOVSEQ');
         qryConsulta.ParamByName('MOVSEQ').AsString := dtsDados.DataSet.FieldByName('MOV_GERSEQ').AsString;
         qryConsulta.Open;
         If qryConsulta.RecordCount > 0 Then
         Begin
           dtsDados.DataSet.FieldByName('DUP_RECTNF').AsString := 'S';
           dtsDados.DataSet.FieldByName('ENT_DUPLIC').AsString := 'S';
         End
         Else
           dtsDados.DataSet.FieldByName('DUP_RECTNF').AsString := 'N';

         dtsDados.DataSet.Post;
       End;
       dtsDados.DataSet.Next;
     End;
  Finally
    dtsDados.DataSet.Bookmark := strBookMark;
    dtsDados.DataSet.EnableControls;
    FreeAndNil(cdsDadosBackup);
    TUniClientDataSet(dtsDados.Dataset).AfterScroll := ClientDataSet1AfterScroll;
    ClientDataSet1AfterScroll(dtsDados.DataSet);
  End
end;

{procedure TfrmEntFreConGridIdentificaVenda.setAlteracoesTela(const Value: Boolean);
begin
  If Value Then
  Begin
    FblnDocumentoDuplicado := Value;
    Self.Caption  := 'Notas Fiscais já importadas ou documentos vinculados em mais de uma Nota.';
    cxDadosFIS_CODEMP.Options.Editing := False;
    cxDadosFIS_ESPECIE.Options.Editing := False;
    cxDadosFIS_NUMDOC.Options.Editing := False;
    chkMostrarTodos.Visible := False;
    pnlLegenda.Height := pnlLegenda.Height - pnlVinculoDoc.Height;
    pnlVinculoDoc.Visible := False;
    shpDuplicados.Top := 3;
    lblDuplicados.Top := 3;
  End
end;                          }

procedure TfrmEntFreConGridIdentificaVenda.btnConfirmaClick(Sender: TObject);
 var
   strLinha : String;
 const
   cTitulo = 'DOCUMENTOS(S) DE VENDA(S) VINCULADO COM MAIS DE UMA NOTA.';
   cTituloDet = 'CTE                                          NFE                                          EMPRESA ESPECIE DOC VENDA';
  procedure pImprimeDetalhe(BuscarGravado: boolean= False);
  Begin
    objLiberacao.objMsgLibera.pAddSeparador(120);
    objLiberacao.objMsgLibera.pAddTexto(cTituloDet);
    objLiberacao.objMsgLibera.pAddSeparador(120);
    cdsDadosBackup.First;
    While not cdsDadosBackup.Eof Do
    Begin
      strLinha := stringOfChar(' ', 120);
      Insert(cdsDadosBackup.FieldByName('CTE_ACESSO').AsString, strLinha, 0);
      Insert(cdsDadosBackup.FieldByName('NFE_ACESSO').AsString, strLinha, 46);
      Insert(cdsDadosBackup.FieldByName('FIS_CODEMP').AsString, strLinha, 91);
      Insert(cdsDadosBackup.FieldByName('FIS_ESPDOC').AsString, strLinha, 99);
      Insert(cdsDadosBackup.FieldByName('FIS_NUMDOC').AsString, strLinha, 107);

      objLiberacao.objMsgLibera.pAddTexto(Trim(Copy(strLinha, 1, 120)));

      strLinha := stringOfChar(' ', 120);
      Insert('NUM. DOC.: ' + cdsDadosBackup.FieldByName('NFE_NUMDOC').AsString +
             ' SERIE: ' + cdsDadosBackup.FieldByName('NFE_SERIE_').AsString, strLinha, 46);

      objLiberacao.objMsgLibera.pAddTexto(Trim(Copy(strLinha, 1, 120)));


      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT FIS_DTAENT,');
      qryConsulta.SQL.Add('       FIS_NUMDOC,');
      qryConsulta.SQL.Add('       FIS_ESPDOC,');
      qryConsulta.SQL.Add('       FIS_DTADOC,');
      qryConsulta.SQL.Add('       FIS_ACESSO');
      qryConsulta.SQL.Add('  FROM RECTNF');
      qryConsulta.SQL.Add('  LEFT JOIN CADFIS ON CADFIS.AUTOINCREM = REC_CTESEQ');
      qryConsulta.SQL.Add(' WHERE RECTNF.REC_MOVSEQ = :MOVSEQ');
      qryConsulta.ParamByName('MOVSEQ').AsString := cdsDadosBackup.FieldByName('MOV_GERSEQ').AsString;
      qryConsulta.Open;
      If Not QryConsulta.IsEmpty Then
      Begin
        strLinha := stringOfChar(' ', 120);
        Insert('DOCUMENTO RELACIONADO ANTERIORMENTE', strLinha, 0);
        objLiberacao.objMsgLibera.pAddTexto(Trim(Copy(strLinha, 1, 120)));
      End;

      While Not qryConsulta.Eof Do
      Begin
        strLinha := stringOfChar(' ', 120);
        Insert('CHAVE CTE: ' + qryConsulta.FieldByName('FIS_ACESSO').AsString +
               ' DATA CADASTRO: ' + qryConsulta.FieldByName('FIS_DTAENT').AsString, strLinha, 0);

        objLiberacao.objMsgLibera.pAddTexto(Trim(Copy(strLinha, 1, 120)));

        strLinha := stringOfChar(' ', 120);
        Insert('DATA DOCUMENTO: ' + qryConsulta.FieldByName('FIS_DTADOC').AsString +
               ' NUMERO DOC.: ' + qryConsulta.FieldByName('FIS_NUMDOC').AsString +
               ' ESPECIE: ' + qryConsulta.FieldByName('FIS_ESPDOC').AsString, strLinha, 0);
        objLiberacao.objMsgLibera.pAddTexto(Trim(Copy(strLinha, 1, 120)));
        qryConsulta.Next;
      End;
      cdsDadosBackup.Next;
      objLiberacao.objMsgLibera.pAddSeparador;
    End;
  End;
begin
  ModalResult := mrOk;

  cdsDadosBackup := TUniClientDataSet.Create(Nil);
  Try
    cdsDadosBackup.IndexFieldNames := 'NFE_ACESSO';

    cdsDadosBackup.Data := TUniClientDataSet(dtsDados.DataSet).Data;
    cdsDadosBackup.Filtered := False;
    cdsDadosBackup.Filter := 'CTE_MARCAD = ' + QuotedStr('S') + ' AND MOV_GERSEQ = ''''';
    cdsDadosBackup.Filtered := True;
    If (cdsDadosBackup.RecordCount > 0) And
       (Not fPedeSenhaDocumentoSemVenda) Then
    begin
      pMensagemOk('Existem notas que não foram relacionadas com o documento de venda, fretes não serão importados');
      ModalResult := mrAbort;
      Exit;
    End;

    cdsDadosBackup.Filtered := False;
    cdsDadosBackup.Filter := 'CTE_MARCAD = ' + QuotedStr('S') + ' AND ENT_DUPLIC = ' + QuotedStr('S') + ' OR DUP_RECTNF = ' +  QuotedStr('S');
    cdsDadosBackup.Filtered := True;
    If cdsDadosBackup.RecordCount > 0 Then
    Begin

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto(cTitulo);

      pImprimeDetalhe;

      objLiberacao.strDirAce := 'IMFRDD';
      objLiberacao.strMsgSen := cTitulo;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;


      If Not objLiberacao.fLibera Then
        ModalResult := mrAbort;

    End;
  Finally
    FreeAndNil(cdsDadosBackup)
  End
End;

end.
