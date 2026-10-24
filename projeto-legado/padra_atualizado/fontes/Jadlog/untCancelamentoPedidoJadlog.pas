unit untCancelamentoPedidoJadlog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni;

type
  TfrmCancelamentoPedidoJadlog = class(TfrmPai)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNumDoc: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodCli: TEditFocus;
    Panel2: TPanel;
    Label6: TLabel;
    btnEnvCan: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnDesmar: TBitBtnLocked;
    edtCodRas: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    mskDtaIni: TcxDateEdit;
    Label7: TLabel;
    mskDtaFin: TcxDateEdit;
    grdjadlogDBTableView: TcxGridDBTableView;
    grdjadlogLevel1: TcxGridLevel;
    grdjadlog: TcxGrid;
    cdsJadlog: TUniClientDataSet;
    dtsJadlog: TDataSource;
    cdsJadlogAUTINC: TStringField;
    cdsJadlogCODJAD: TStringField;
    cdsJadlogCODSHI: TStringField;
    cdsJadlogCODCLI: TStringField;
    cdsJadlogNUMDOC: TStringField;
    cdsJadlogESPDOC: TStringField;
    cdsJadlogCODEMP: TStringField;
    cdsJadlogDTAEMI: TDateField;
    cdsJadlogCANCEL: TBooleanField;
    cdsJadlogDOCUME: TStringField;
    cdsJadlogCLIENT: TStringField;
    cdsJadlogMARDES: TStringField;
    grdjadlogDTAEMI: TcxGridDBColumn;
    grdjadlogDOCUME: TcxGridDBColumn;
    grdjadlogCLIENT: TcxGridDBColumn;
    grdjadlogCODSHI: TcxGridDBColumn;
    btnAdicionar: TBitBtnLocked;
    grdjadlogMARDES: TcxGridDBColumn;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnDesmarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure grdjadlogDBTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdjadlogDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnEnvCanClick(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaPedidoJadlog;
    procedure pSQLWhere(var AQry: TUniQuery);
    procedure pMarcarDesmarcar(const AMarDes: String = 'M');
    procedure pMarcarDesmarcarTodos(const AMarDes: String = 'M');
    procedure pInverte;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, untJadlog;

{$R *.dfm}

procedure TfrmCancelamentoPedidoJadlog.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  pCarregaPedidoJadlog;
end;

procedure TfrmCancelamentoPedidoJadlog.btnDesmarClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarTodos('D');
end;

procedure TfrmCancelamentoPedidoJadlog.btnEnvCanClick(Sender: TObject);
begin
  inherited;
    
  if not cdsJadlog.Active then
    Exit;

  if cdsJadlog.RecordCount <= 0 then
    Exit;

  if cdsJadlog.RecNo <= 0 then
    Exit;


  try
    cdsJadlog.DisableControls;
    cdsJadlog.Filtered := False;
    cdsJadlog.Filter := ' MARDES = ' + QuotedStr('M');
    cdsJadlog.Filtered := True;

    if cdsJadlog.RecordCount = 0 then
    begin
      fMensagem('','Nenhum registro selecionado!',['&OK']);
      Exit;
    end;

    cdsJadlog.First;
    
    while not cdsJadlog.Eof do
    begin
      fCancelarPedidoJadlog(cdsJadlogCODSHI.AsString);
      cdsJadlog.Next;
    end;

    pCarregaPedidoJadlog;
  finally
    cdsJadlog.Filtered := False;
    cdsJadlog.Filter := EmptyStr;  
    cdsJadlog.First;
    cdsJadlog.EnableControls;
  end;

  
end;

procedure TfrmCancelamentoPedidoJadlog.btnMarcarClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarTodos;
end;

procedure TfrmCancelamentoPedidoJadlog.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
var
  LarrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, LarrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCancelamentoPedidoJadlog.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  LarrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, LarrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCancelamentoPedidoJadlog.FormCreate(Sender: TObject);
begin
  inherited;
  cdsJadlog.CreateDataSet;
end;

procedure TfrmCancelamentoPedidoJadlog.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F5:  btnMarcar.Click;
    VK_F6:  btnDesmar.Click;
    VK_F10: btnEnvCan.Click;
  end;
end;

procedure TfrmCancelamentoPedidoJadlog.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmCancelamentoPedidoJadlog.pSQLWhere(var AQry: TUniQuery);
begin
  if not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
  begin
    if not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) then
    begin
      AQry.SQL.Add('AND JAD_DTAEMI BETWEEN :DTAINI AND :DTAFIN');
      AQry.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      AQry.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    end;
  end;

  if not fEmptyStr(edtNumDoc.Text) then
  begin
    AQry.SQL.Add('AND JAD_NUMDOC = :NUMDOC');
    AQry.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
  end;

  if not fEmptyStr(edtCodEmp.Text) then
  begin
    AQry.SQL.Add('AND JAD_CODEMP = :CODEMP');
    AQry.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  end;

  if not fEmptyStr(edtCodCli.Text) then
  begin
    AQry.SQL.Add('AND JAD_CODCLI = :CODCLI');
    AQry.ParamByName('CODCLI').AsString := edtCodCli.Text;
  end;

  if not fEmptyStr(edtCodRas.Text) then
  begin
    AQry.SQL.Add('AND JAD_SHIPME = :SHIPME');
    AQry.ParamByName('SHIPME').AsString := edtCodRas.Text;
  end;
end;

function TfrmCancelamentoPedidoJadlog.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('','Cliente não encontrado!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa não encontrada!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (StrToDateDef(mskDtaFin.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))  And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('','O campo Data Inicial deve ser preechindo!',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
    End

    Else If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCancelamentoPedidoJadlog.grdjadlogDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdjadlogMARDES.Index]) = 'M' Then
  Begin
    ACanvas.Brush.Color := clBlue;
    ACanvas.Font.Color := clWhite;
  End
  Else
  Begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmCancelamentoPedidoJadlog.grdjadlogDBTableViewKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  Case Key Of
    Chr(VK_RETURN): pInverte;
  End;
end;

procedure TfrmCancelamentoPedidoJadlog.pCarregaPedidoJadlog;
var
  qryJadlog: TUniQuery;
begin
  qryJadlog := fCriaQuery;
  cdsJadlog.EmptyDataSet;

  try
    cdsJadlog.DisableControls;
  
    qryJadlog.Close;
    qryJadlog.SQL.Clear;
    qryJadlog.SQL.Add('SELECT * FROM PEDJAD WHERE JAD_CANCEL = 0');

    pSQLWhere(qryJadlog);

    qryJadlog.Open;

    if qryJadlog.IsEmpty then
      Exit;


    while not qryJadlog.Eof do
    begin
      cdsJadlog.Append;
      cdsJadlogAUTINC.AsString := qryJadlog.FieldByName('AUTOINCREM').AsString;
      cdsJadlogCODJAD.AsString := qryJadlog.FieldByName('JAD_CODJAD').AsString;
      cdsJadlogCODSHI.AsString := qryJadlog.FieldByName('JAD_SHIPME').AsString;
      cdsJadlogCODCLI.AsString := qryJadlog.FieldByName('JAD_CODCLI').AsString;
      cdsJadlogNUMDOC.AsString := qryJadlog.FieldByName('JAD_NUMDOC').AsString;
      cdsJadlogESPDOC.AsString := qryJadlog.FieldByName('JAD_ESPDOC').AsString;
      cdsJadlogCODEMP.AsString := qryJadlog.FieldByName('JAD_CODEMP').AsString;
      cdsJadlogDTAEMI.AsDateTime := qryJadlog.FieldByName('JAD_DTAEMI').AsDateTime;
      cdsJadlogCANCEL.AsBoolean := qryJadlog.FieldByName('JAD_CANCEL').AsBoolean;
      cdsJadlogDOCUME.AsString := qryJadlog.FieldByName('JAD_NUMDOC').AsString + '-' + qryJadlog.FieldByName('JAD_ESPDOC').AsString + '-' + qryJadlog.FieldByName('JAD_CODEMP').AsString;
      cdsJadlogCLIENT.AsString := Copy(qryJadlog.FieldByName('JAD_CODCLI').AsString + '-' + fRetNomCliente(qryJadlog.FieldByName('JAD_CODCLI').AsString),1,60);
      cdsJadlogMARDES.AsString := 'D';
      cdsJadlog.Post;
      qryJadlog.Next;
    end;

    cdsJadlog.First;
  finally
    FreeAndNil(qryJadlog);
    cdsJadlog.EnableControls;
  end;
end;

procedure TfrmCancelamentoPedidoJadlog.pInverte;
begin
  if not cdsJadlog.Active then
    Exit;

  if cdsJadlog.RecordCount <= 0 then
    Exit;

  if cdsJadlog.RecNo <= 0 then
    Exit;

  if cdsJadlogMARDES.AsString = 'M' then
    pMarcarDesmarcar('D')
  else
    pMarcarDesmarcar;
end;

procedure TfrmCancelamentoPedidoJadlog.pMarcarDesmarcar(const AMarDes: String);
begin
  if not cdsJadlog.Active then
    Exit;

  if cdsJadlog.RecordCount <= 0 then
    Exit;

  if cdsJadlog.RecNo <= 0 then
    Exit;

  cdsJadlog.Edit;
  cdsJadlogMARDES.AsString := AMarDes;
  cdsJadlog.Post;
end;

procedure TfrmCancelamentoPedidoJadlog.pMarcarDesmarcarTodos(
  const AMarDes: String);
begin
  if not cdsJadlog.Active then
    Exit;

  if cdsJadlog.RecordCount <=0  then
    Exit;

  try
    cdsJadlog.DisableControls;
    cdsJadlog.First;

    while not cdsJadlog.Eof do
    begin
      pMarcarDesmarcar(AMarDes);
      cdsJadlog.Next;
    end;
  finally
    cdsJadlog.First;
    cdsJadlog.EnableControls;
  end;
end;

end.
