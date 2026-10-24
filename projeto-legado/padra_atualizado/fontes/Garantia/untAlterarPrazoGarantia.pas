unit untAlterarPrazoGarantia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untTAlterarPrazoGarantia,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, Vcl.Mask, MaskEditFocus, untZClient,
  cxTextEdit;

type
  TfrmAlterarPrazoGarantia = class(TfrmPai)
    pnlPrincipal: TPanel;
    pnlCabecalho: TPanel;
    Panel2: TPanel;
    cxgDadosDBTableView1: TcxGridDBTableView;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGrid;
    dtsDados: TDataSource;
    pnlPesq: TPanel;
    pnlDadosDoc: TPanel;
    edtCodCli: TEditFocus;
    edtEspDoc: TEditFocus;
    edtNumDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    lblCodEmp: TLabel;
    lblNumDoc: TLabel;
    lblEspDoc: TLabel;
    lblCliente: TLabel;
    edtNomCli: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    lblCodVen: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    medtDtaEmi: TMaskEditFocus;
    lblDtaEmi: TLabel;
    lblVlrCon: TLabel;
    edtVlrCon: TEditFocus;
    cxgDadosDBTableView1SELECIONADO: TcxGridDBColumn;
    cxgDadosDBTableView1CODITE: TcxGridDBColumn;
    cxgDadosDBTableView1DESCRI: TcxGridDBColumn;
    cxgDadosDBTableView1UNIDAD: TcxGridDBColumn;
    cxgDadosDBTableView1UNITAR: TcxGridDBColumn;
    cxgDadosDBTableView1TOTITE: TcxGridDBColumn;
    cxgDadosDBTableView1TMPGAR: TcxGridDBColumn;
    cxgDadosDBTableView1TMPGARORI: TcxGridDBColumn;
    cxgDadosDBTableView1DET_QTDITE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgDadosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDadosDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDadosDBTableView1TMPGARCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure cxgDadosDBTableView1TMPGARPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Strict Private Type
    TMetodoProc = procedure of Object;
  private
    FTAlterarPrazoGarantia: TAlterarPrazoGarantia;
    FCodCli: String;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FSelecionarItem: TMetodoProc;
    procedure SetCodCli(Value: String);
    procedure SetNumDoc(Value: String);
    procedure SetEspDoc(Value: String);
    procedure SetCodEmp(Value: String);
    procedure pAplicarValor(Sender: TObject);
    procedure pConfirmar;
    procedure pSelecionar;
    procedure pLimparDados;
    { Private declarations }
  public
    cdsDados: TZClient;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmAlterarPrazoGarantia: TfrmAlterarPrazoGarantia;

implementation

uses
  System.SysUtils, untFuncoesSimples, untGravando, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmAlterarPrazoGarantia.pAplicarValor(Sender: TObject);
  Var
    edtSelec: TEdit;
begin
  if Not (Sender is TEdit) then
    Exit;
  edtSelec := TEdit(Sender);

  if edtSelec = edtNumDoc then
    SetNumDoc(edtSelec.Text)
  else if edtSelec = edtCodCli then
    SetCodCli(edtSelec.Text)
  else if edtSelec = edtEspDoc then
    SetEspDoc(edtSelec.Text)
  else if edtSelec = edtCodEmp then
    SetCodEmp(edtSelec.Text);
end;

procedure TfrmAlterarPrazoGarantia.pConfirmar;
  var
    frmGravando : TFrmGravando;
    blnResult: boolean;
begin
  cdsDados.DisableControls;
  frmGravando := Nil;
  blnResult := False;
  Try
    cdsDados.Filter := ' SELECIONADO = '+ QuotedStr(DOC_SELECIONADO);
    cdsDados.Filtered := True;
    if cdsDados.IsEmpty then
    begin
      pMensagemOk('Não há item selecionado para alterar!');
      Exit;
    end;
    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Gravando Informações!';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := FTAlterarPrazoGarantia.fConfirmar;
    frmGravando.ShowModal;
    blnResult := frmGravando.blnConfirma;

    if blnResult then
      pMensagemOk('Processo concluído com sucesso!');

  Finally
    if Assigned(frmGravando) then
      FreeAndNil(frmGravando);

    if cdsDados.Filtered then
    begin
      cdsDados.Filtered := False;
      cdsDados.Filter := EmptyStr;
    end;

    if blnResult then
      pLimparDados
    else
      pMensagemOk('Processo não foi concluído!');
    cdsDados.EnableControls;
  End;
end;

procedure TfrmAlterarPrazoGarantia.pLimparDados;
begin
  FTAlterarPrazoGarantia.pLimpar;
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtVlrCon.Clear;
  medtDtaEmi.Clear;
end;

procedure TfrmAlterarPrazoGarantia.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pConfirmar;
end;

procedure TfrmAlterarPrazoGarantia.cxgDadosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strValue: String;
begin
  inherited;
  strValue := VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxgDadosDBTableView1SELECIONADO.Index],'0');
  if strValue = DOC_SELECIONADO then
  begin
    ACanvas.Font.Color := clBlue;
  end;
end;

procedure TfrmAlterarPrazoGarantia.cxgDadosDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: pSelecionar;
  end;
end;

procedure TfrmAlterarPrazoGarantia.cxgDadosDBTableView1TMPGARCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clInfoBk;

  IF AViewInfo.GridRecord.Selected then
        ACanvas.Font.Color := clBlack;
end;

procedure TfrmAlterarPrazoGarantia.cxgDadosDBTableView1TMPGARPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    strValor: String;
    intValor: Integer;
begin
  inherited;
  strValor :=   VarToStrDef(DisplayValue,'');
  if TryStrToInt(strValor, intValor) then
  begin
    if intValor > 999 Then
    begin
      FTAlterarPrazoGarantia.pMensagemTempoMaximo;
      Error := true;
    end
    else if intValor < 1 then
    begin
      Error := True;
      FTAlterarPrazoGarantia.pMensagemTempoMinimo;
    end;
  end;

end;

procedure TfrmAlterarPrazoGarantia.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
    begin
      SelectNext((ActiveControl), True, True);
    end;
  End;
end;

procedure TfrmAlterarPrazoGarantia.FormCreate(Sender: TObject);
begin
  inherited;
  FTAlterarPrazoGarantia := TAlterarPrazoGarantia.Create;
  FTAlterarPrazoGarantia.strCodOpe := strLoginUsuarioLogado;
  FTAlterarPrazoGarantia.strCodEmp := VS_strCodEmp;
  FSelecionarItem := FTAlterarPrazoGarantia.pSelecionarItem;
  cdsDados := FTAlterarPrazoGarantia.cdsDados;
  dtsDados.DataSet := cdsDados;
  edtCodEmp.Text := FTAlterarPrazoGarantia.strCodEmp;

end;

procedure TfrmAlterarPrazoGarantia.FormDestroy(Sender: TObject);
begin
  if Assigned(FTAlterarPrazoGarantia) then
    FreeAndNil(FTAlterarPrazoGarantia);
  inherited;
end;

procedure TfrmAlterarPrazoGarantia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_F10: begin
              Key := 0;
              btnConfirmar.Click;
            end;
  end;
end;

procedure TfrmAlterarPrazoGarantia.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

function TfrmAlterarPrazoGarantia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
  begin
    pAplicarValor(Sender);
    if (Sender = edtCodCli) then
    begin
      FTAlterarPrazoGarantia.strCodEmp := edtCodEmp.Text;
      FTAlterarPrazoGarantia.strNumDoc := edtNumDoc.Text;
      FTAlterarPrazoGarantia.strEspDoc := edtEspDoc.Text;
      FTAlterarPrazoGarantia.strCodCli := edtCodCli.Text;

      if FTAlterarPrazoGarantia.fCarregarDocumentoVenda then
      begin
        edtCodVen.Text := cdsDados.FieldByName('GER_CODVEN').AsString;
        edtNomCli.Text := cdsDados.FieldByName('CLI_NOMCLI').AsString;
        edtNomVen.Text := cdsDados.FieldByName('OPE_NOMOPE').AsString;
        medtDtaEmi.Text := DateToStr(cdsDados.FieldByName('GER_DTAENT').AsDateTime);
        edtVlrCon.Text := FormatFloat('#0.00', cdsDados.FieldByName('GER_VLRCON').AsFloat);
      end
      else
        Result := False;
    end
    else if (Sender = edtEspDoc) then
    begin
      if fEmptyStr(edtEspDoc.Text) then
      begin
        pmensagemOk('É obrigatório informar a espécie do documento!');
        Result := False;
      end
      else if (pos(edtEspDoc.Text,'_NF_IF_NV_IV_FF') = 0) then
      begin
        pmensagemOk('Espécie de documento inválida!');
        Result := False;
      end;
    end
    else if (Sender = edtNumDoc) then
    begin
      if fEmptyStr(edtNumDoc.Text) then
      begin
        pmensagemOk('É obrigatório informar o documento!');
        Result := False;
      end
    end;
  end;
  If Not (Result) Then
    pSetFocus(Sender);
end;


procedure TfrmAlterarPrazoGarantia.pSelecionar;
begin
  if Assigned(FSelecionarItem) then
    FSelecionarItem;
end;

procedure TfrmAlterarPrazoGarantia.SetCodCli(Value: String);
begin
  if Value = FCodCli then
    Exit;
  FCodCli := Value;

  if cdsDados.Active then
    cdsDados.Close
end;

procedure TfrmAlterarPrazoGarantia.SetCodEmp(Value: String);
begin
  if Value = FCodEmp then
    Exit;
  FCodEmp := Value;

  if cdsDados.Active then
    cdsDados.Close

end;

procedure TfrmAlterarPrazoGarantia.SetEspDoc(Value: String);
begin
  if Value = FEspDoc then
    Exit;
  FEspDoc := Value;

  if cdsDados.Active then
    cdsDados.Close

end;

procedure TfrmAlterarPrazoGarantia.SetNumDoc(Value: String);
begin
  if Value = FNumDoc then
    Exit;
  FNumDoc := Value;

  if cdsDados.Active then
    cdsDados.Close
end;

end.
