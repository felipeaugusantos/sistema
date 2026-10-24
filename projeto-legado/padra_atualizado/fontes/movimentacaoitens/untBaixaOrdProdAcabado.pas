unit untBaixaOrdProdAcabado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCalc, cxTextEdit, Vcl.StdCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Datasnap.DBClient,
  UniClientDataSet, untZClient, uni, cxCurrencyEdit;

type
  TfrmBaixaOrdProdAcabado = class(TfrmPai)
    pnlOrdPro: TPanel;
    Label3: TLabel;
    edtOrdPro: TEditFocus;
    pnlIteEst: TPanel;
    dbgIteFatDor: TcxGridCitel;
    dbgIteFatDorTV: TcxGridDBTableViewCitel;
    dbgIteFatDorTVCODITE: TcxGridDBColumn;
    dbgIteFatDorTVDESITE: TcxGridDBColumn;
    dbgIteFatDorTVSIGUNI: TcxGridDBColumn;
    dbgIteFatDorTVQTDITE: TcxGridDBColumn;
    dbgIteFatDorLvl: TcxGridLevel;
    btnGravar: TBitBtnLocked;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    dtsGrid: TDataSource;
    dbgIteFatDorTVQTDBAI: TcxGridDBColumn;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensAUTINC: TStringField;
    cdsItensSEQGER: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensDESITE: TStringField;
    cdsItensSIGUNI: TStringField;
    cdsItensQTDBAI: TFloatField;
    cdsItensPRECUS: TFloatField;
    cdsItensPREMED: TFloatField;
    cdsItensTOTBAI: TAggregateField;
    cdsItensTOTCUS: TAggregateField;
    cdsItensTOTMED: TAggregateField;
    cdsProdutoAcabado: TUniClientDataSet;

    cdsProdutoAcabadoAUTINC: TStringField;
    cdsProdutoAcabadoSEQGER: TStringField;
    cdsProdutoAcabadoCODITE: TStringField;
    cdsProdutoAcabadoDESITE: TStringField;
    cdsProdutoAcabadoSIGUNI: TStringField;
    cdsProdutoAcabadoQTDITE: TFloatField;
    cdsProdutoAcabadoQTDBAI: TFloatField;
    cdsProdutoAcabadoPRECUS: TFloatField;
    cdsProdutoAcabadoPREMED: TFloatField;
    cdsProdutoAcabadoTOTCUS: TAggregateField;
    cdsProdutoAcabadoTOTMED: TAggregateField;
    cdsProdutoAcabadoTOTBAI: TAggregateField;
    Panel1: TPanel;
    btnIncluirItem: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsItensQTDBAIValidate(Sender: TField);
    procedure dbgIteFatDorTVKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirItemClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FNumDoc: String;
    FCodPro: String;
    FCodEmp: String;
    qryProdutoAcabado: Tuniquery;

    procedure pPreencheProdutoAcabado(blnIgnoraPrdAcabado: Boolean = false);
    procedure pValidarOperador;
    function ValidarItensAcabado: Boolean;
    procedure pPreencheProdutoAcabadoFatdor;

    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    function fSeparador: String;
    procedure pInicia(blnIgnoraPrdAcabado: Boolean = false);
    function fCodigoEmpresa(strCodigoEmpresa: String): TfrmBaixaOrdProdAcabado;
    function fNumeroDocumento(strNumeroDocumento: String): TfrmBaixaOrdProdAcabado;
    function fCodigoProducao(strCodPro: String): TfrmBaixaOrdProdAcabado;
    { Public declarations }
  end;

var
  frmBaixaOrdProdAcabado: TfrmBaixaOrdProdAcabado;

implementation

uses
  untBaixaOrdProdAcabadoIncluiItens;

{$R *.dfm}

procedure TfrmBaixaOrdProdAcabado.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If cdsItens.FieldByName('AUTINC').AsString  <> '' Then
  Begin
    pMensagemOk('Itens adicionados pela importação de arquivo não podem ser deletados!');
    Exit;
  End
  Else
  If fPergunta('Excluir o item ' + cdsItens.FieldByName('CODITE').AsString) Then
    cdsItens.Delete;

end;

procedure TfrmBaixaOrdProdAcabado.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtSenDig) And
     ValidarItensAcabado Then
      ModalResult := mrOk;
end;

procedure TfrmBaixaOrdProdAcabado.btnIncluirItemClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmBaixaOrdProdAcabadoIncluiItens, frmBaixaOrdProdAcabadoIncluiItens);
  Try
    frmBaixaOrdProdAcabadoIncluiItens.cdsItens := cdsItens;
    frmBaixaOrdProdAcabadoIncluiItens.strSeqGer := cdsItens.FieldByName('SEQGER').AsString;
    frmBaixaOrdProdAcabadoIncluiItens.ShowModal;
  Finally
    FreeAndNil(frmBaixaOrdProdAcabadoIncluiItens);
  End;

end;

procedure TfrmBaixaOrdProdAcabado.pPreencheProdutoAcabadoFatdor;
begin
  qryProdutoAcabado.SQL.Clear;
  qryProdutoAcabado.SQL.Add('SELECT');
  qryProdutoAcabado.SQL.Add('  FATDOR.AUTOINCREM AS AUTINC,');
  qryProdutoAcabado.SQL.Add('  FDO_SEQGER _SEQGER,');
  qryProdutoAcabado.SQL.Add('  FDO_CODITE CODITE,');
  qryProdutoAcabado.SQL.Add('  FDO_DESCRI DESITE,');
  qryProdutoAcabado.SQL.Add('  UNI_SIGUNI SIGUNI,');
  qryProdutoAcabado.SQL.Add('  FDO_QTDITE QTDITE,');
  qryProdutoAcabado.SQL.Add('  FDO_QTDITE QTDBAI');
  qryProdutoAcabado.SQL.Add('FROM  FATDOR');
  qryProdutoAcabado.SQL.Add('JOIN CADUNI ON CADUNI.UNI_CODUNI = FATDOR.FDO_UNIDAD');
  qryProdutoAcabado.SQL.Add(' WHERE FDO_NUMDOC = "'+ FNumDoc +'"');
  qryProdutoAcabado.SQL.Add('   AND FDO_ESPDOC = "PD"');
  qryProdutoAcabado.SQL.Add('   AND FDO_CODEMP = "'+ FCodEmp +'"');
  qryProdutoAcabado.SQL.Add('   ORDER BY FATDOR.AUTOINCREM ');
  qryProdutoAcabado.Open;
  while Not qryProdutoAcabado.Eof  do
  Begin
    cdsProdutoAcabado.Insert;
    cdsProdutoAcabado.FieldByName('CODITE').Value :=  qryProdutoAcabado.FieldByName('CODITE').Value;
    cdsProdutoAcabado.FieldByName('DESITE').Value :=  qryProdutoAcabado.FieldByName('DESITE').Value;
    cdsProdutoAcabado.FieldByName('SIGUNI').Value :=  qryProdutoAcabado.FieldByName('SIGUNI').Value;
    cdsProdutoAcabado.FieldByName('QTDITE').Value :=  qryProdutoAcabado.FieldByName('QTDITE').Value;
    cdsProdutoAcabado.FieldByName('QTDBAI').Value :=  qryProdutoAcabado.FieldByName('QTDITE').Value;
    If qryProdutoAcabado.RecNo = 1 Then
    begin
      cdsProdutoAcabado.FieldByName('AUTINC').Value :=  qryProdutoAcabado.FieldByName('AUTINC').Value;
      cdsProdutoAcabado.FieldByName('PRECUS').Value := cdsItens.FieldByName('TOTCUS').Value;
      cdsProdutoAcabado.FieldByName('PREMED').Value := cdsItens.FieldByName('TOTMED').Value;
    End
    Else
    Begin
      cdsProdutoAcabado.FieldByName('AUTINC').Value := '';
      cdsProdutoAcabado.FieldByName('PRECUS').Value := 0;
      cdsProdutoAcabado.FieldByName('PREMED').Value := 0;
    End;

    cdsProdutoAcabado.Post;
    qryProdutoAcabado.Next;
  End;
end;


procedure TfrmBaixaOrdProdAcabado.cdsItensQTDBAIValidate(Sender: TField);
begin
  inherited;
  if Sender.AsCurrency < 0 then
    pMensagemOk('ATENÇÃO! A quantdade não pode ser menor que zero!');
end;

procedure TfrmBaixaOrdProdAcabado.dbgIteFatDorTVKeyPress(Sender: TObject;
  var Key: Char);
var
  AView: TcxGridDBTableView;
  ASite: TcxGridSite;
begin
  ASite := Sender as TcxGridSite;
  AView := ASite.GridView as TcxGridDBTableView;
  if Key = #13 then
    AView.DataController.FocusedRowIndex := AView.DataController.FocusedRowIndex + 1;
end;

function TfrmBaixaOrdProdAcabado.fCodigoEmpresa(
  strCodigoEmpresa: String): TfrmBaixaOrdProdAcabado;
begin
  Result := Self;
  FCodEmp := strCodigoEmpresa;
end;

function TfrmBaixaOrdProdAcabado.fNumeroDocumento(
  strNumeroDocumento: String): TfrmBaixaOrdProdAcabado;
begin
  Result := Self;
  FNumDoc := strNumeroDocumento;
end;

function TfrmBaixaOrdProdAcabado.fCodigoProducao(
  strCodPro: String): TfrmBaixaOrdProdAcabado;
begin
  Result := Self;
  FCodPro := strCodPro;
end;

procedure TfrmBaixaOrdProdAcabado.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
  cdsProdutoAcabado.CreateDataSet;
  WindowState := wsMaximized;
  qryProdutoAcabado := fCriaQuery;
end;

procedure TfrmBaixaOrdProdAcabado.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryProdutoAcabado);
  inherited;
end;

procedure TfrmBaixaOrdProdAcabado.FormShow(Sender: TObject);
begin
  inherited;
  pInicia(True);
end;

procedure TfrmBaixaOrdProdAcabado.pInicia(blnIgnoraPrdAcabado: Boolean = False);
begin
  edtOrdPro.Text := FCodPro;
  pPreencheProdutoAcabado(blnIgnoraPrdAcabado);
  Caption := 'Ordem de Produção Pedido de Venda - ' + fNumDoc + '-PD-' + fCodEmp;
End;

function TfrmBaixaOrdProdAcabado.FSeparador: String;
begin
  Result := edtSenDig.Text;
end;

function TfrmBaixaOrdProdAcabado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = edtSenDig) Then
        pValidarOperador
    End;
  Except
    On E: Exception Do
    Begin
      Result := false;
      pSetFocus(Sender);
      pMensagemOk(e.Message);
    End;
  End;
end;

procedure TfrmBaixaOrdProdAcabado.pValidarOperador;
begin
  edtNomDig.Text := fRetNomVendRep(edtSenDig.Text);

  if (fEmptyStr(edtSenDig.Text))  then
    raise Exception.Create('ATENÇÃO! O separador deve ser preenchido!');

  if (fEmptyStr(edtNomDig.Text)) then
    raise Exception.Create('ATENÇÃO! Separador inválido!');

  dbgIteFatDor.Enabled := Not fEmptyStr(edtNomDig.Text);
end;

procedure TfrmBaixaOrdProdAcabado.pPreencheProdutoAcabado(blnIgnoraPrdAcabado: Boolean = false);
Var
  qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT DOP_ITESUB AS CODITE,');
    qryConsulta.SQL.Add('       DOP_SEQGER AS SEQGER,');
    qryConsulta.SQL.Add('       D.AUTOINCREM AS AUTINC,');
    qryConsulta.SQL.Add('       ITE_DESITE AS DESITE,');
    qryConsulta.SQL.Add('       UNI_SIGUNI AS SIGUNI,');
    qryConsulta.SQL.Add('       DOP_QTDITE AS QTDITE,');
    qryConsulta.SQL.Add('       ITE_PRECUS AS PRECUS,');
    qryConsulta.SQL.Add('       ITE_PREMED AS PREMED ');
    qryConsulta.SQL.Add('  FROM DETPRO D');
    qryConsulta.SQL.Add(' INNER JOIN MOVPRO ON MOVPRO.AUTOINCREM = DOP_SEQGER');
    qryConsulta.SQL.Add(' INNER JOIN CADITE C ON C.ITE_CODITE = DOP_ITESUB');
    qryConsulta.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = DOP_ITESUB AND G.ITE_CODEMP = PRO_EMPPED');
    qryConsulta.SQL.Add('  LEFT JOIN CADUNI ON CADUNI.UNI_CODUNI = ITE_CODUNI');
    qryConsulta.SQL.Add(' WHERE PRO_NUMPED = "'+ FNumDoc +'"');
    qryConsulta.SQL.Add('   AND PRO_ESPPED = "PD"');
    qryConsulta.SQL.Add('   AND PRO_EMPPED = "'+ FCodEmp +'"');
    qryConsulta.SQL.Add('   AND PRO_CODPRO = "'+ FCodPro +'"');

    qryConsulta.Open;
    while Not qryConsulta.Eof  do
    Begin
      cdsItens.Insert;
      cdsItens.FieldByName('AUTINC').Value :=  qryConsulta.FieldByName('AUTINC').Value;
      cdsItens.FieldByName('SEQGER').Value :=  qryConsulta.FieldByName('SEQGER').Value;
      cdsItens.FieldByName('CODITE').Value :=  qryConsulta.FieldByName('CODITE').Value;
      cdsItens.FieldByName('DESITE').Value :=  qryConsulta.FieldByName('DESITE').Value;
      cdsItens.FieldByName('SIGUNI').Value :=  qryConsulta.FieldByName('SIGUNI').Value;
      cdsItens.FieldByName('QTDITE').Value :=  qryConsulta.FieldByName('QTDITE').Value;
      cdsItens.FieldByName('QTDBAI').Value :=  qryConsulta.FieldByName('QTDITE').Value;
      cdsItens.FieldByName('PRECUS').Value :=  qryConsulta.FieldByName('PRECUS').Value;
      cdsItens.FieldByName('PREMED').Value :=  qryConsulta.FieldByName('PREMED').Value;
      cdsItens.Post;
      qryConsulta.Next;
    End;
    If Not blnIgnoraPrdAcabado Then
      pPreencheProdutoAcabadoFatdor;
  finally
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmBaixaOrdProdAcabado.ValidarItensAcabado: Boolean;
begin
  cdsItens.DisableControls;
  cdsItens.Filter := 'QTDBAI > 0';
  cdsItens.Filtered := True;
  Result := Not cdsItens.IsEmpty;
  cdsItens.Filtered := Result;
  cdsItens.EnableControls;
  if Not Result then
    pMensagemOk('ATENÇÃO! Não é possível baixar itens com quantidade de baixa igual a 0');
end;



end.
