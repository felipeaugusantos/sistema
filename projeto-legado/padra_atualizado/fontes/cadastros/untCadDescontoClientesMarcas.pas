unit untCadDescontoClientesMarcas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdenaEdit, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.DBCtrls, DBEditFocus;

type
  TfrmCadDescontoClientesMarcas = class(TfrmPaiOrdenaEdit)
    pnlCliente: TPanel;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblMarca: TLabel;
    Label2: TLabel;
    cxgDescon: TcxGridCitel;
    cxgDesconTBV: TcxGridDBTableViewCitel;
    cxgDesconTBVCodMar: TcxGridDBColumn;
    cxgDesconTBVDesMar: TcxGridDBColumn;
    cxgDesconTBVDecon: TcxGridDBColumn;
    cxgDesconLevel1: TcxGridLevel;
    cdsConsultaAUTOINCREM: TStringField;
    cdsConsultaMDS_CODMAR: TStringField;
    cdsConsultaMAR_DESMAR: TStringField;
    cdsConsultaMDS_CODEMP: TStringField;
    cdsConsultaMDS_CODCLI: TStringField;
    cdsConsultaMDS_PERDES: TFloatField;
    btnPesquisaDesc: TBitBtnLocked;
    dbeDesMar: TDBEditFocus;
    dbeCodMar: TDBEditFocus;
    dbePerdes: TDBEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure cdsConsultaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure cxgDesconTBVCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dbeCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaDescClick(Sender: TObject);
    procedure cxgDesconTBVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    cdsAuxCad: TUniClientDataSet;

    procedure pHabilitarTela(blnDigitarCliente: Boolean);
    function fSalvarDesconto: Boolean;
    procedure pHabilitaGrid;
  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fGetOrderBy: String; override;
    function fAbreConsulta(blnLike: Boolean = True): Boolean; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pHabilitaControles(Habilitar: Boolean); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untPanelCxClientes,
  untPnlDadosCliente, untConstantes, untFuncoes;

{ TfrmCadDescontoClientesMarcas }

procedure TfrmCadDescontoClientesMarcas.btnAlterarClick(Sender: TObject);
begin
  pCloneDataSet(cdsAuxCad, cdsConsulta);
  cdsAuxCad.IndexFieldNames := 'MDS_CODMAR';
  inherited;
  pHabilitaGrid;
end;

procedure TfrmCadDescontoClientesMarcas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitaGrid;
end;

procedure TfrmCadDescontoClientesMarcas.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If blnExcluiu Then
    fSalvarDesconto;
end;

procedure TfrmCadDescontoClientesMarcas.btnGravarClick(Sender: TObject);
begin
  inherited;
  pHabilitaGrid;
  If blnGravou Then
    fSalvarDesconto;
end;

procedure TfrmCadDescontoClientesMarcas.btnIncluirClick(Sender: TObject);
begin
  pCloneDataSet(cdsAuxCad, cdsConsulta);
  cdsAuxCad.IndexFieldNames := 'MDS_CODMAR';
  inherited;
  cdsConsultaMDS_CODCLI.AsString := edtCodCli.Text;
  cdsConsultaMDS_CODEMP.AsString := VS_strCodEmp;
  cdsConsultaAUTOINCREM.AsString := fRetAutoIncrem('MARDES', VS_strCodEmp);
  pHabilitaGrid;
end;

procedure TfrmCadDescontoClientesMarcas.btnPesquisaDescClick(Sender: TObject);
var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  chrKey := '/';
  if fPesqDescClientesMarcas(Self, edtCodCli, nil, chrKey, arrSel) then
    fValidaCampos(edtCodCli, True);
end;

procedure TfrmCadDescontoClientesMarcas.cdsConsultaReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := raAbort;
  Raise ExceptionAutCom.Create(E.Message);
end;

procedure TfrmCadDescontoClientesMarcas.cxgDesconTBVCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnAlterar.Click;
end;

procedure TfrmCadDescontoClientesMarcas.cxgDesconTBVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (cdsConsulta.State = dsBrowse) and (cdsConsulta.RecordCount > 0) then
    btnExcluir.Click;
end;

procedure TfrmCadDescontoClientesMarcas.edtCodCliKeyPress(Sender: TObject; var Key: Char);
var
  arrClientes: TConsultasArray;
  objfrmPnl : TPanelCxClientes;
begin
  inherited;
  try
    try
      objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
      objfrmPnl.strNomForm := self.name;

      if fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, nil, Key, arrClientes,true,objfrmPnl) then
      begin
        if fValidaCampos(edtCodCli, True) then
          SelectNext(ActiveControl, True, True);
      end;
    except
      on E: Exception Do
        pMensagensErro(E.Message, '[pCodCliKeyPress]');
    end;
  finally
    FreeAndNil(objfrmPnl);
  end;
end;

procedure TfrmCadDescontoClientesMarcas.dbeCodMarKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  if fPesqMarcas(Self, dbeCodMar, nil, nil, Key, arrSel) then
  begin
    If fValidaCampos(dbeCodMar, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmCadDescontoClientesMarcas.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  Result := inherited fAbreConsulta(blnLike);
  dbgConsultaTitleClick(fFindColumnByName(dbgConsulta, 'MAR_DESMAR'));
end;

function TfrmCadDescontoClientesMarcas.fGetOrderBy: String;
begin
  Result := ' ORDER BY MAR_DESMAR ';
end;

function TfrmCadDescontoClientesMarcas.fGetSql(blnLike: Boolean): String;
begin
  Result := ' SELECT ' +
            '   MARDES.*, ' +
            '   (SELECT MAR_DESMAR FROM CADMAR WHERE MAR_CODMAR = MDS_CODMAR) AS MAR_DESMAR ' +
            ' FROM ' +
            '   MARDES ' +
            ' WHERE ' +
            '   MDS_CODCLI = ' + QuotedStr(edtCodCli.Text);
end;

procedure TfrmCadDescontoClientesMarcas.FormCreate(Sender: TObject);
begin
  inherited;
  strCamChave  := 'AUTOINCREM';
  blnTemSelecao := False;
  blnSelecionaComEspaco := False;
  blnUsaProxCodVirtual := False;
  cdsAuxCad := TUniClientDataSet.Create(Self);
end;

procedure TfrmCadDescontoClientesMarcas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) And
     ((ActiveControl) <> edtCodCli) And
     (Not (cdsConsulta.State In [dsInsert, dsEdit])) Then
  Begin
    pHabilitarTela(True);
    Key := 0;
  End
  Else If (Key <> VK_DELETE) Then
    inherited;
end;

procedure TfrmCadDescontoClientesMarcas.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitarTela(True);
end;

function TfrmCadDescontoClientesMarcas.fSalvarDesconto: Boolean;
begin
  try
    if (cdsConsulta.ChangeCount > 0) then
      Result := cdsConsulta.ApplyUpdates(0) = 0
    else
      Result := True;
  except
    On E: ExceptionAutCom Do
    Begin
      pMensagensErro(E.Message, '[TZClient.fSalva]');
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TZClient.fSalva]');
      Result := False;
    End;
  end;
end;

function TfrmCadDescontoClientesMarcas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(Sender)) then
  begin
    if (Sender = edtCodCli) And blnBuscaPorChave then
    begin
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código do cliente!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Código do cliente não existe!', ['&Ok']);
        Result := False;
      End
      Else
        pHabilitarTela(False);
    end
    else if (Sender = dbeCodMar) then
    begin
     if fEmptyStr(dbeCodMar.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Informe o código da marca!', ['&Ok']);
        Result := False;
      end
      else If fEmptyStr(fRetNomMarca(dbeCodMar.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'Código da marca não encontrado!', ['&Ok']);
        Result := False;
      end
      else
      begin
        cdsAuxCad.Open;
        if (cdsAuxCad.Locate('MDS_CODMAR', dbeCodMar.Text, [])) and
           ((IfNull(cdsConsultaMDS_CODMAR.OldValue, '') <> dbeCodMar.Text) Or (cdsConsulta.State = dsInsert)) then
        begin
          fMensagem('ATENÇÃO!', 'Código da marca já utilizado!', ['&Ok']);
          Result := False;
        end
        else
          dbeDesMar.Field.AsString := fRetNomMarca(dbeCodMar.Text);
      End;
    end
    else
    if (Sender = dbePerdes) then
    begin
      if (fEmptyStr(dbePerdes.Text)) then
      begin
        fMensagem('', 'O Desconto deve ser preenchido!' , ['&Ok']);
        Result := False;
      end
      else
      begin
        if fStrToFloat(dbePerdes.Text) <= 0 then
        Begin
          fMensagem('ATENÇÃO!', 'O valor do desconto deve ser maior que zero!', ['&Ok']);
          Result := False;
        end
        else if fStrToFloat(dbePerdes.Text) > 100 then
        Begin
          fMensagem('ATENÇÃO!', 'O valor do desconto deve ser menor ou igual a 100!', ['&Ok']);
          Result := False;
        end;
      end;
    end;
  end;

  if (not Result) and (Sender.CanFocus) then
    pSetFocus(Sender);
end;

procedure TfrmCadDescontoClientesMarcas.pHabilitaControles(Habilitar: Boolean);
begin
  inherited pHabilitaControles(Habilitar);
  edtCodCli.Enabled := True;
  edtNomCli.Enabled := True;
end;

procedure TfrmCadDescontoClientesMarcas.pHabilitaGrid;
begin
  cxgDescon.Enabled  := (Not (cdsConsulta.State In [dsInsert, dsEdit])) And (Not cdsConsulta.IsEmpty);
end;

procedure TfrmCadDescontoClientesMarcas.pHabilitarTela(blnDigitarCliente: Boolean);
begin
  pLimpaPesquisa;
  blnMudarFoco        := False;
  pnlCliente.Enabled  := blnDigitarCliente;
  pnlHeader.Enabled   := not blnDigitarCliente;
  pnlPesquisa.Enabled := not blnDigitarCliente;
  pnlBotoes.Enabled   := not blnDigitarCliente;
  dbgConsulta.Enabled := not blnDigitarCliente;

  If blnDigitarCliente Then
  Begin
    qryConsulta.Close;
    cdsConsulta.Close;
    edtCodCli.Clear;
    edtNomCli.Clear;
    SelectFirst;
  End
  Else
    pIniciaPesquisa;

  pHabilitaGrid;
end;

end.
