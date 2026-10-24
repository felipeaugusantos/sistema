unit untFatDefineLoteEntregaFuturaFaltaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni;

type
  TfrmFatDefineLoteEntregaFuturaFaltaProduto = class(TfrmPaiConfirma)
    pnlFiltros: TPanel;
    pnlLegenda: TPanel;
    grdDocumentosDBTableView: TcxGridDBTableView;
    grdDocumentosLevel: TcxGridLevel;
    grdDocumentos: TcxGrid;
    lblLegendaEnter: TLabel;
    lblProduto: TLabel;
    lblCliente: TLabel;
    edtCodPro: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomPro: TEditFocus;
    cdsDocumentos: TUniClientDataSet;
    dtsDocumentos: TDataSource;
    cdsDocumentosCODITE: TStringField;
    cdsDocumentosDESITE: TStringField;
    cdsDocumentosREFERE: TStringField;
    cdsDocumentosQTDPEN: TFloatField;
    cdsDocumentosDTAVEN: TDateField;
    cdsDocumentosCODCLI: TStringField;
    cdsDocumentosNOMCLI: TStringField;
    cdsDocumentosCLIENT: TStringField;
    cdsDocumentosNUMDOC: TStringField;
    cdsDocumentosESPDOC: TStringField;
    cdsDocumentosCODEMP: TStringField;
    cdsDocumentosDOCVEN: TStringField;
    cdsDocumentosREQUIS: TStringField;
    cdsDocumentosNUMPED: TStringField;
    cdsDocumentosESPPED: TStringField;
    cdsDocumentosEMPPED: TStringField;
    cdsDocumentosPEDCOM: TStringField;
    cdsDocumentosNUMENT: TStringField;
    cdsDocumentosESPENT: TStringField;
    cdsDocumentosEMPENT: TStringField;
    cdsDocumentosDOCENT: TStringField;
    grdDocumentosCODITE: TcxGridDBColumn;
    grdDocumentosDESITE: TcxGridDBColumn;
    grdDocumentosREFERE: TcxGridDBColumn;
    grdDocumentosQTDPEN: TcxGridDBColumn;
    grdDocumentosDTAVEN: TcxGridDBColumn;
    grdDocumentosCODCLI: TcxGridDBColumn;
    grdDocumentosNOMCLI: TcxGridDBColumn;
    grdDocumentosCLIENT: TcxGridDBColumn;
    grdDocumentosNUMDOC: TcxGridDBColumn;
    grdDocumentosESPDOC: TcxGridDBColumn;
    grdDocumentosCODEMP: TcxGridDBColumn;
    grdDocumentosDOCVEN: TcxGridDBColumn;
    grdDocumentosREQUIS: TcxGridDBColumn;
    grdDocumentosNUMPED: TcxGridDBColumn;
    grdDocumentosESPPED: TcxGridDBColumn;
    grdDocumentosEMPPED: TcxGridDBColumn;
    grdDocumentosPEDCOM: TcxGridDBColumn;
    grdDocumentosNUMENT: TcxGridDBColumn;
    grdDocumentosESPENT: TcxGridDBColumn;
    grdDocumentosEMPENT: TcxGridDBColumn;
    grdDocumentosDOCENT: TcxGridDBColumn;
    cdsDocumentosAUTINC: TStringField;
    cdsDocumentosMOTFUT: TStringField;
    cdsDocumentosDTAFUT: TDateField;
    cdsDocumentosCODUNI: TStringField;
    cdsDocumentosNUMLOT: TStringField;
    lblLegendaSalDis: TLabel;
    cdsDocumentosCODVEN: TStringField;
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDocumentosDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FItens: String;
    FClientes: String;
    procedure pCarregaDocumentos;
    procedure pRetornaDocumentoEntrada(var ANumEnt, AEspEnt, AEmpEnt: String; ANumPed, ACodIte: String);
    procedure pAlteraDocumento;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema,
  untFatAlteraLoteEntregaFuturaFaltaProduto;

{$R *.dfm}

procedure TfrmFatDefineLoteEntregaFuturaFaltaProduto.edtCodCliKeyPress(
  Sender: TObject; var Key: Char);
var
  LarrSel: TConsultasArray;
  LContador: integer;
begin
  inherited;
  if fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, LarrSel, False) then
  begin
    if fValidaCampos(edtCodCli) then
    begin
      if Length(LarrSel) > 0 then
      begin
        FClientes := EmptyStr;
        for LContador := Low(LarrSel) to High(LarrSel) do
          pIncrementaListaStr(LarrSel[LContador].strCodigo, FClientes, True);
      end;
      SelectNext(ActiveControl, True, True);
    end
  end;
end;

procedure TfrmFatDefineLoteEntregaFuturaFaltaProduto.edtCodProKeyPress(
  Sender: TObject; var Key: Char);
var
  LarrSel: TConsultasArray;
  LContador: integer;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodPro, edtNomPro, nil, Key, LarrSel, False) then
  begin
    if fValidaCampos(edtCodPro) then
    begin
      if Length(LarrSel) > 0 then
      begin
        FItens := EmptyStr;
        for LContador := Low(LarrSel) to High(LarrSel) do
          pIncrementaListaStr(LarrSel[LContador].strCodigo, FItens, True);
      end;
      SelectNext(ActiveControl, True, True);
    end;
  end;
end;


procedure TfrmFatDefineLoteEntregaFuturaFaltaProduto.FormCreate(
  Sender: TObject);
begin
  inherited;
  cdsDocumentos.CreateDataSet;
  FItens := EmptyStr;
  FClientes := EmptyStr;
end;

procedure TfrmFatDefineLoteEntregaFuturaFaltaProduto.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPro);
end;

function TfrmFatDefineLoteEntregaFuturaFaltaProduto.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodPro) Then
  Begin
    if fEmptyStr(edtCodPro.Text) then
    begin
      edtNomPro.Clear;
      Exit;
    end;

    if (not fEmptyStr(edtCodPro.Text)) and (edtNomPro.Text = '+1') then
    begin
      Exit;
    end;

    edtCodPro.Text := fStrZero(edtCodPro.Text, edtCodPro.TamCampo);

    edtNomPro.Text := fRetNomProduto(edtCodPro.Text);

    If (Not fEmptyStr(edtCodPro.Text)) And (fEmptyStr(edtNomPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Produto não encontrado!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = edtCodCli) Then
  Begin

    if fEmptyStr(edtCodCli.Text) then
    begin
      edtNomCli.Clear;
      pCarregaDocumentos;
      Exit;
    end;

    if (not fEmptyStr(edtCodCli.Text)) and (edtNomCli.Text = '+1') then
    begin
      pCarregaDocumentos;
      Exit;
    end;

    edtCodCli.Text := fStrZero(edtCodCli.Text, edtCodCli.TamCampo);

    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

    If (Not fEmptyStr(edtCodCli.Text)) And (fEmptyStr(edtNomCli.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Cliente não encontrado!', ['&Ok']);
      Result := False;
    End
    Else
      pCarregaDocumentos;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatDefineLoteEntregaFuturaFaltaProduto.grdDocumentosDBTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_RETURN: pAlteraDocumento;
  end;
end;

procedure TfrmFatDefineLoteEntregaFuturaFaltaProduto.pAlteraDocumento;
var
  frmFatAlteraLoteEntregaFuturaFaltaProduto: TfrmFatAlteraLoteEntregaFuturaFaltaProduto;
begin
  if not Assigned(cdsDocumentos) then
    Exit;

  if not cdsDocumentos.Active then
    Exit;

  if cdsDocumentos.RecordCount <= 0 then
    Exit;

  if cdsDocumentos.RecNo <= 0 then
    Exit;

  pCriarFormularios(TfrmFatAlteraLoteEntregaFuturaFaltaProduto, frmFatAlteraLoteEntregaFuturaFaltaProduto);

  try
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.strAutInc := cdsDocumentosAUTINC.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.strCodPro := cdsDocumentosCODITE.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.strNomPro := cdsDocumentosDESITE.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.strRefere := cdsDocumentosREFERE.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.strCodUni := cdsDocumentosCODUNI.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.fltQtdPen := cdsDocumentosQTDPEN.AsFloat;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.strNumLot := cdsDocumentosNUMLOT.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.strMotivo := cdsDocumentosMOTFUT.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.dtaPrevis := cdsDocumentosDTAFUT.AsDateTime;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.FProduto.strCodEmp := cdsDocumentosCODEMP.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.strCodCli          := cdsDocumentosCODCLI.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.strCodVen          := cdsDocumentosCODVEN.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.strNumDoc          := cdsDocumentosNUMDOC.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.strEspDoc          := cdsDocumentosESPDOC.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.strEmpDoc          := cdsDocumentosCODEMP.AsString;
    frmFatAlteraLoteEntregaFuturaFaltaProduto.ShowModal;

    if frmFatAlteraLoteEntregaFuturaFaltaProduto.ModalResult = mrOk then
      pCarregaDocumentos;

  finally
    pFreeAndNil(frmFatAlteraLoteEntregaFuturaFaltaProduto);
  end;
end;

procedure TfrmFatDefineLoteEntregaFuturaFaltaProduto.pCarregaDocumentos;
var
  LDocumentos: TUniQuery;
  LNumEnt: String;
  LEspEnt: String;
  LEmpEnt: String;
begin
  LDocumentos := fCriaQuery;

  try
    if (fEmptyStr(edtCodPro.Text)) and (fEmptyStr(edtNomPro.Text)) then
      FItens := EmptyStr;

    if (fEmptyStr(edtCodCli.Text)) and (fEmptyStr(edtNomCli.Text)) then
      FClientes := EmptyStr;

    cdsDocumentos.DisableControls;
    cdsDocumentos.EmptyDataSet;

    LDocumentos.Close;
    LDocumentos.SQL.Clear;
    LDocumentos.SQL.Add('SELECT * FROM (');
    LDocumentos.SQL.Add('SELECT DET_CODITE, DET_DESCRI, DET_REFERE, DET_DTAENT, DET_CODCLI, DET_CODVEN, DET_NUMDOC, DET_ESPDOC, DET_CODEMP,');
    LDocumentos.SQL.Add(fSQLSaldoDisponivel('ITEGER', True, False, True) + ' AS DET_SALDOS, ');
    LDocumentos.SQL.Add('       MOVDET.AUTOINCREM, DET_MOTFUT, DET_DTAFUT, UNI_SIGUNI AS DET_CODUNI, DET_NUMLOT,');
    LDocumentos.SQL.Add('       RCD_CODIGO AS DET_REQUIS, PCD_NUMPED AS DET_NUMPED, PCD_ESPDOC AS DET_ESPPED, PCD_CODEMP AS DET_EMPPED,');
    LDocumentos.SQL.Add('       (DET_QTDITE - IFNULL(SEP_QTDIMP, 0) - IFNULL(DET_QTDENT, 0)) AS DET_QTDPEN');
    LDocumentos.SQL.Add('FROM MOVDET');
    LDocumentos.SQL.Add('INNER JOIN MOVGER');
    LDocumentos.SQL.Add('ON(MOVGER.AUTOINCREM = MOVDET.DET_SEQGER)');
    LDocumentos.SQL.Add('INNER JOIN CADLOT');
    LDocumentos.SQL.Add('ON(CADLOT.LOT_CODITE = MOVDET.DET_CODITE AND CADLOT.LOT_CODEMP = MOVDET.DET_CODEMP)');
    LDocumentos.SQL.Add('INNER JOIN ITEGER');
    LDocumentos.SQL.Add('ON(MOVDET.DET_CODITE = ITEGER.ITE_CODITE AND MOVDET.DET_CODEMP = ITEGER.ITE_CODEMP)');
    LDocumentos.SQL.Add('INNER JOIN CADITE');
    LDocumentos.SQL.Add('ON(MOVDET.DET_CODITE = CADITE.ITE_CODITE)');
    LDocumentos.SQL.Add('LEFT JOIN MOVRCD');
    LDocumentos.SQL.Add('ON(MOVRCD.RCD_DOCPDV = MOVDET.DET_NUMDOC AND MOVRCD.RCD_ESPPDV = MOVDET.DET_ESPDOC AND MOVRCD.RCD_EMPPDV = MOVDET.DET_CODEMP AND MOVRCD.RCD_CODITE = MOVDET.DET_CODITE)');
    LDocumentos.SQL.Add('LEFT JOIN PCMDET');
    LDocumentos.SQL.Add('ON(PCMDET.AUTOINCREM = MOVRCD.RCD_SEQPCD)');
    LDocumentos.SQL.Add('LEFT JOIN SEPFUT');
    LDocumentos.SQL.Add('ON(MOVDET.AUTOINCREM = SEPFUT.SEP_SEQGER)');
    LDocumentos.SQL.Add('LEFT JOIN CADUNI');
    LDocumentos.SQL.Add('ON(MOVDET.DET_UNIDAD = CADUNI.UNI_CODUNI)');
    LDocumentos.SQL.Add('WHERE DET_CODEMP = '+QuotedStr(VS_strCodEmp)+'');
    LDocumentos.SQL.Add('AND DET_ENTFUT = "S"');
    LDocumentos.SQL.Add('AND DET_MOTFUT = "F"');
    LDocumentos.SQL.Add('AND DET_NUMLOT = "A DEFINIR" ');
    LDocumentos.SQL.Add('AND LOT_NUMLOT <> "A DEFINIR"');

    if not fEmptyStr(FItens) then
    begin
      LDocumentos.SQL.Add('AND DET_CODITE IN('+FItens+')');
    end
    else if not fEmptyStr(edtCodPro.Text) then
    begin
      LDocumentos.SQL.Add('AND DET_CODITE = '+QuotedStr(edtCodPro.Text)+'');
    end;

    if not fEmptyStr(FClientes) then
    begin
      LDocumentos.SQL.Add('AND DET_CODCLI IN('+FClientes+')');
    end
    else if not fEmptyStr(edtCodCli.Text) then
    begin
      LDocumentos.SQL.Add('AND DET_CODCLI = '+QuotedStr(edtCodCli.Text)+'');
    end;

    LDocumentos.SQL.Add('UNION');

    LDocumentos.SQL.Add('SELECT DET_CODITE, DET_DESCRI, DET_REFERE, DET_DTAENT, DET_CODCLI, DET_CODVEN, DET_NUMDOC, DET_ESPDOC, DET_CODEMP,');
    LDocumentos.SQL.Add(fSQLSaldoDisponivel('ITEGER', True, False, True) + ' AS DET_SALDOS, ');
    LDocumentos.SQL.Add('       MOVDET.AUTOINCREM, DET_MOTFUT, DET_DTAFUT, UNI_SIGUNI AS DET_CODUNI, DET_NUMLOT,');
    LDocumentos.SQL.Add('       RCD_CODIGO AS DET_REQUIS, PCD_NUMPED AS DET_NUMPED, PCD_ESPDOC AS DET_ESPPED, PCD_CODEMP AS DET_EMPPED,');
    LDocumentos.SQL.Add('       (DET_QTDITE - IFNULL(SEP_QTDIMP, 0) - IFNULL(DET_QTDENT, 0)) AS DET_QTDPEN');
    LDocumentos.SQL.Add('FROM MOVDET');
    LDocumentos.SQL.Add('INNER JOIN MOVGER');
    LDocumentos.SQL.Add('ON(MOVGER.AUTOINCREM = MOVDET.DET_SEQGER)');
    LDocumentos.SQL.Add('INNER JOIN ITEGER');
    LDocumentos.SQL.Add('ON(MOVDET.DET_CODITE = ITEGER.ITE_CODITE AND MOVDET.DET_CODEMP = ITEGER.ITE_CODEMP)');
    LDocumentos.SQL.Add('INNER JOIN CADITE');
    LDocumentos.SQL.Add('ON(MOVDET.DET_CODITE = CADITE.ITE_CODITE)');
    LDocumentos.SQL.Add('LEFT JOIN MOVRCD');
    LDocumentos.SQL.Add('ON(MOVRCD.RCD_DOCPDV = MOVDET.DET_NUMDOC AND MOVRCD.RCD_ESPPDV = MOVDET.DET_ESPDOC AND MOVRCD.RCD_EMPPDV = MOVDET.DET_CODEMP AND MOVRCD.RCD_CODITE = MOVDET.DET_CODITE)');
    LDocumentos.SQL.Add('LEFT JOIN PCMDET');
    LDocumentos.SQL.Add('ON(PCMDET.AUTOINCREM = MOVRCD.RCD_SEQPCD)');
    LDocumentos.SQL.Add('LEFT JOIN SEPFUT');
    LDocumentos.SQL.Add('ON(MOVDET.AUTOINCREM = SEPFUT.SEP_SEQGER)');
    LDocumentos.SQL.Add('LEFT JOIN CADUNI');
    LDocumentos.SQL.Add('ON(MOVDET.DET_UNIDAD = CADUNI.UNI_CODUNI)');
    LDocumentos.SQL.Add('WHERE DET_CODEMP = '+QuotedStr(VS_strCodEmp)+'');
    LDocumentos.SQL.Add('AND DET_ENTFUT = "S"');
    LDocumentos.SQL.Add('AND DET_MOTFUT = "F"');
    LDocumentos.SQL.Add('AND IFNULL(DET_NUMLOT,"") = "" ');

    if not fEmptyStr(FItens) then
    begin
      LDocumentos.SQL.Add('AND DET_CODITE IN('+FItens+')');
    end
    else if not fEmptyStr(edtCodPro.Text) then
    begin
      LDocumentos.SQL.Add('AND DET_CODITE = '+QuotedStr(edtCodPro.Text)+'');
    end;

    if not fEmptyStr(FClientes) then
    begin
      LDocumentos.SQL.Add('AND DET_CODCLI IN('+FClientes+')');
    end
    else if not fEmptyStr(edtCodCli.Text) then
    begin
      LDocumentos.SQL.Add('AND DET_CODCLI = '+QuotedStr(edtCodCli.Text)+'');
    end;

    LDocumentos.SQL.Add(') AS TAB');
    LDocumentos.SQL.Add('WHERE DET_SALDOS > 0');

    LDocumentos.SQL.Add('ORDER BY DET_NUMDOC, DET_CODITE');

    LDocumentos.Open;

    if LDocumentos.IsEmpty then
    begin
      fMensagem('ATENÇÃO!', 'Nenhum registro encontrado!', ['&Ok']);
      Exit;
    end;

    while not LDocumentos.Eof do
    begin
      pRetornaDocumentoEntrada(LNumEnt, LEspEnt, LEmpEnt, LDocumentos.FieldByName('DET_NUMPED').AsString, LDocumentos.FieldByName('DET_CODITE').AsString);

      cdsDocumentos.Append;
      cdsDocumentosCODITE.AsString := LDocumentos.FieldByName('DET_CODITE').AsString;
      cdsDocumentosDESITE.AsString := LDocumentos.FieldByName('DET_DESCRI').AsString;
      cdsDocumentosREFERE.AsString := LDocumentos.FieldByName('DET_REFERE').AsString;
      cdsDocumentosQTDPEN.AsFloat :=  LDocumentos.FieldByName('DET_QTDPEN').AsFloat;
      cdsDocumentosDTAVEN.AsDateTime := LDocumentos.FieldByName('DET_DTAENT').AsDateTime;
      cdsDocumentosCODCLI.AsString := LDocumentos.FieldByName('DET_CODCLI').AsString;
      cdsDocumentosNOMCLI.AsString := fRetNomCliente(cdsDocumentosCODCLI.AsString);
      cdsDocumentosCLIENT.AsString := cdsDocumentosCODCLI.AsString + '-' + cdsDocumentosNOMCLI.AsString;
      cdsDocumentosNUMDOC.AsString := LDocumentos.FieldByName('DET_NUMDOC').AsString;
      cdsDocumentosESPDOC.AsString := LDocumentos.FieldByName('DET_ESPDOC').AsString;
      cdsDocumentosCODEMP.AsString := LDocumentos.FieldByName('DET_CODEMP').AsString;
      cdsDocumentosDOCVEN.AsString := cdsDocumentosNUMDOC.AsString + '-' + cdsDocumentosESPDOC.AsString + '-' + cdsDocumentosCODEMP.AsString;
      cdsDocumentosREQUIS.AsString := LDocumentos.FieldByName('DET_REQUIS').AsString;
      cdsDocumentosNUMPED.AsString := LDocumentos.FieldByName('DET_NUMPED').AsString;
      cdsDocumentosESPPED.AsString := LDocumentos.FieldByName('DET_ESPPED').AsString;
      cdsDocumentosEMPPED.AsString := LDocumentos.FieldByName('DET_EMPPED').AsString;
      cdsDocumentosAUTINC.AsString := LDocumentos.FieldByName('AUTOINCREM').AsString;
      cdsDocumentosMOTFUT.AsString := LDocumentos.FieldByName('DET_MOTFUT').AsString;
      cdsDocumentosDTAFUT.AsDateTime := LDocumentos.FieldByName('DET_DTAFUT').AsDateTime;
      cdsDocumentosCODUNI.AsString := LDocumentos.FieldByName('DET_CODUNI').AsString;
      cdsDocumentosNUMLOT.AsString := LDocumentos.FieldByName('DET_NUMLOT').AsString;
      cdsDocumentosCODVEN.AsString := LDocumentos.FieldByName('DET_CODVEN').AsString;

      if not fEmptyStr(LDocumentos.FieldByName('DET_NUMPED').AsString) then
        cdsDocumentosPEDCOM.AsString := cdsDocumentosNUMPED.AsString + '-' + cdsDocumentosESPPED.AsString + '-' + cdsDocumentosEMPPED.AsString;

      cdsDocumentosNUMENT.AsString := LNumEnt;
      cdsDocumentosESPENT.AsString := LEspEnt;
      cdsDocumentosEMPENT.AsString := LEmpEnt;

      if not fEmptyStr(LNumEnt) then
        cdsDocumentosDOCENT.AsString := cdsDocumentosNUMENT.AsString + '-' + cdsDocumentosESPENT.AsString + '-' + cdsDocumentosEMPENT.AsString;

      cdsDocumentos.Post;
      LDocumentos.Next;
    end;
    cdsDocumentos.First;
  finally
    cdsDocumentos.EnableControls;
    FreeAndNil(LDocumentos);
  end;
end;

procedure TfrmFatDefineLoteEntregaFuturaFaltaProduto.pRetornaDocumentoEntrada(
  var ANumEnt, AEspEnt, AEmpEnt: String; ANumPed, ACodIte: String);
var
  LDocEntrada: TUniQuery;
begin
  LDocEntrada := fCriaQuery;

  try
    ANumEnt := EmptyStr;
    AEspEnt := EmptyStr;
    AEmpEnt := EmptyStr;

    if fEmptyStr(ANumPed) then
      Exit;

    LDocEntrada.Close;
    LDocEntrada.SQL.Clear;
    LDocEntrada.SQL.Add('SELECT DET_NUMDOC, DET_ESPDOC, DET_CODEMP ');
    LDocEntrada.SQL.Add('FROM MOVDET');
    LDocEntrada.SQL.Add('INNER JOIN PCMDET ON(DET_PEDCOM = PCD_NUMPED AND DET_CODEMP = PCD_CODEMP AND DET_CODITE = PCD_CODITE)');
    LDocEntrada.SQL.Add('WHERE DET_PEDCOM = :NUMPED');
    LDocEntrada.SQL.Add('AND DET_CODITE = :CODITE');
    LDocEntrada.SQL.Add('AND DET_CODEMP = :CODEMP');
    LDocEntrada.ParamByName('NUMPED').AsString := ANumPed;
    LDocEntrada.ParamByName('CODITE').AsString := ACodIte;
    LDocEntrada.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LDocEntrada.Open;

    if LDocEntrada.IsEmpty then
      Exit;

    ANumEnt := LDocEntrada.FieldByName('DET_NUMDOC').AsString;
    AEspEnt := LDocEntrada.FieldByName('DET_ESPDOC').AsString;
    AEmpEnt := LDocEntrada.FieldByName('DET_CODEMP').AsString;;
  finally
    FreeAndNil(LDocEntrada);
  end;
end;

end.
