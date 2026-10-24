unit untConsultaPedidosPend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, Mask, MaskEditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData,cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxGridBandedTableView, cxGridDBBandedTableView, BitBtnLockedIncrem,
  ComCtrls, untZClient, cxLookAndFeels, cxLookAndFeelPainters,strUtils,cxNavigator,frxClass,
  frxExportCSVTestabilidade,
  cxGridCitel, untReimpressao,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxGridExportLink;

type
  TfrmConsultaPedidosPend = class(TfrmPaiConfirma)
    pnlCabecalho         : TPanel;
    Label1               : TLabel;
    Label2               : TLabel;
    Label3               : TLabel;
    Label4               : TLabel;
    Label5               : TLabel;
    mskDtaIni            : TMaskEditFocus;
    mskDtaFin            : TMaskEditFocus;
    edtCodCli            : TEditFocus;
    edtNomCli            : TEditFocus;
    edtCodEmp            : TEditFocus;
    edtNomEmp            : TEditFocus;
    edtCodVen            : TEditFocus;
    edtNomVen            : TEditFocus;
    cxgConsultaLevel1    : TcxGridLevel;
    cxgConsulta          : TcxGrid;
    dtsConsul            : TDataSource;
    cxStyleRepository    : TcxStyleRepository;
    cxsTitulo1           : TcxStyle;
    cxsTitulo2           : TcxStyle;
    cxsFatura            : TcxStyle;
    cxsTitulo3           : TcxStyle;
    cxsEntFut            : TcxStyle;
    btnAdicionar         : TBitBtnLocked;
    btnCancelaItem       : TBitBtnLocked;
    prbProgresso         : TProgressBar;
    edtNumPed            : TEditFocus;
    Label6               : TLabel;
    cxsPedido            : TcxStyle;
    cxsPedidoBaixado     : TcxStyle;
    Label7               : TLabel;
    edtCodRede           : TEditFocus;
    edtNomRede           : TEditFocus;
    Label8               : TLabel;
    edtCodReg            : TEditFocus;
    edtDesReg            : TEditFocus;
    Label9               : TLabel;
    edtCodDepVen         : TEditFocus;
    edtDesDepVen         : TEditFocus;
    Label10              : TLabel;
    edtCodDepIte         : TEditFocus;
    edtDesDepIte         : TEditFocus;
    Label11              : TLabel;
    edtDesIte            : TEditFocus;
    edtPorPedAte         : TEditFocus;
    Label12              : TLabel;
    ckbEstAtuDisp        : TCheckBox;
    ckbSalDisp           : TCheckBox;
    edtCodIte            : TEditFocus;
    cxgConsultaView      : TcxGridDBTableViewCitel;
    cxgConsultaViewNumDoc: TcxGridDBColumn;
    cxgConsultaViewCodCli: TcxGridDBColumn;
    cxgConsultaViewCodVen: TcxGridDBColumn;
    cxgConsultaViewDtaEnt: TcxGridDBColumn;
    cxgConsultaViewCodIte: TcxGridDBColumn;
    cxgConsultaViewEntRet: TcxGridDBColumn;
    cxgConsultaViewDtEntr: TcxGridDBColumn;
    cxgConsultaViewEstAtu: TcxGridDBColumn;
    cxgConsultaViewQtdIte: TcxGridDBColumn;
    cxgConsultaViewSaldos: TcxGridDBColumn;
    cxgConsultaViewPerTot: TcxGridDBColumn;
    cxgConsultaViewPedCom: TcxGridDBColumn;
    cxgConsultaViewPedCli: TcxGridDBColumn;
    cxgConsultaViewPedSit: TcxGridDBColumn;
    btnPedVen: TBitBtnLocked;
    Panel1: TPanel;
    lblNumPedCli: TLabel;
    edtPedCli: TEditFocus;
    cxgConsultaViewNitCmp: TcxGridDBColumn;
    cxgConsultaViewVlrUni: TcxGridDBColumn;
    cxgConsultaViewDtPDCm: TcxGridDBColumn;
    cxgConsultaViewEnPDCm: TcxGridDBColumn;
    cxgConsultaViewDiaEnt: TcxGridDBColumn;
    btnImprimir: TBitBtnLocked;
    cxgConsultaViewDtaCmp: TcxGridDBColumn;
    cxgConsultaViewStatus: TcxGridDBColumn;
    cxgConsultaViewDiaEntNUMULTPDCMP: TcxGridDBColumn;
    cxgConsultaViewDiaEntFORULTPDCMP: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure ckbEstAtuDispClick(Sender: TObject);
    procedure ckbSalDispClick(Sender: TObject);
    procedure edtPorPedAteChange(Sender: TObject);
    procedure cxgConsultaViewEstAtuCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgConsultaViewSaldosCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnPedVenClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadCli: TUniQuery;
    qryCadEmp: TUniQuery;
    qryCadIte: TUniQuery;

    cdsConsul: TZClient;
    cdsConAux: TZClient;

    reimpressao: TReimpressao;

    Function fVerificaDepartamentoVendedor: Boolean;
    Function fVerificaDepartamentoProduto: Boolean;
    Function fSqlConsulta: String;
    Function fCarregaRede: Boolean;

    Procedure pCarregaCliente;
    Procedure pCarregaEmpresa;
    Procedure pCarregaVendedor;
    Procedure pCarregaRegiao;
    Procedure pCarregaDepartamento(intTipo: Integer);
    Procedure pCarregaProduto;
    Procedure pAbreConsulta;
    Procedure pFechaConsulta;
    Procedure pProcessaPedidos;
    Procedure pFiltraPedidos;
    Procedure pImprimePedido;
  public
    { Public declarations }
  protected
    Procedure pEscapePressed; override;
    Function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untConstantes, untFuncoesSimples, untConsultas,untPesqAux, untTypesSistema,
  untInfPedido, untTelAcompEntregaEmail, untEnderecoEntrega,
  untGravando, untReimpressaoDocsList, untSaldoPedidoCompra;

{$R *.dfm}


procedure TfrmConsultaPedidosPend.pCarregaCliente;
begin
  pPesquisaCadCli(Nil, qryCadCli, edtCodCli.Text);
  edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
end;

procedure TfrmConsultaPedidosPend.pCarregaDepartamento(intTipo: Integer);
begin
  Case intTipo Of
    1: edtDesDepVen.Text := fRetNomDep(edtCodDepVen.Text);
    2: edtDesDepIte.Text := fRetNomDep(edtCodDepIte.Text);
  End;
end;

procedure TfrmConsultaPedidosPend.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryCadEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmConsultaPedidosPend.pCarregaProduto;
begin
  pPesquisaCadIte(Nil, qryCadIte, edtCodIte.Text);
  edtDesIte.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
end;

procedure TfrmConsultaPedidosPend.pCarregaRegiao;
begin
  edtDesReg.Text := fRetDesReg(edtCodReg.Text);
end;

procedure TfrmConsultaPedidosPend.pCarregaVendedor;
begin
  edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);
end;

function TfrmConsultaPedidosPend.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodCli) Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
    Begin
      edtNomCli.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaCliente;
      If (qryCadCli.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodRede) Then
  Begin
    If fEmptyStr(edtCodRede.Text) Then
    Begin
      edtNomRede.Text := 'TODAS';
    End
    Else
    Begin
      If (Not fCarregaRede) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa rede de lojas não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodEmp) Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      edtNomEmp.Text := 'TODAS';
    End
    Else
    Begin
      pCarregaEmpresa;
      If qryCadEmp.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodReg) Then
  Begin
    If fEmptyStr(edtCodReg.Text) Then
    Begin
      edtDesReg.Text := 'TODAS';
    End
    Else
    Begin
      pCarregaRegiao;
      If fEmptyStr(edtDesReg.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa região não está cadastrada!', ['&Ok']);
        Result := False;
      End
    End;
  End

  Else If (Sender = edtCodDepVen) Then
  Begin
    If fEmptyStr(edtCodDepVen.Text) Then
    Begin
      edtDesDepVen.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaDepartamento(1);
      If fEmptyStr(edtDesDepVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse departamento não está cadastrado!', ['&Ok']);
        Result := False;
      End
    End;
  End

  Else If (Sender = edtCodDepIte) Then
  Begin
    If fEmptyStr(edtCodDepIte.Text) Then
    Begin
      edtDesDepIte.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaDepartamento(2);
      If fEmptyStr(edtDesDepIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse departamento não está cadastrado!', ['&Ok']);
        Result := False;
      End
    End;
  End

  Else If (Sender = edtCodVen) Then
  Begin
    If fEmptyStr(edtCodVen.Text) Then
    Begin
      edtNomVen.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaVendedor;
      If fEmptyStr(edtNomVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else
        Result := fVerificaDepartamentoVendedor;

    End;
  End

  Else If (Sender = edtCodIte) Then
  Begin
    If fEmptyStr(edtCodIte.Text) Then
    Begin
      edtDesIte.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaProduto;
      If qryCadIte.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else
        Result := fVerificaDepartamentoProduto;

    End;
  End

  Else If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
       fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
      Result := False;
    End

    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
            (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data final deve ser maior que a data inicial!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmConsultaPedidosPend.fVerificaDepartamentoProduto: Boolean;
var
  strDep : String;
begin
  Result := True;

  If Not fEmptyStr(edtCodDepIte.Text) Then
  Begin
    strDep := fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]);

    If edtCodDepIte.Text <> strDep Then
    Begin
      pMensagemOk('O Departamento não é o mesmo do Produto selecionado.');
      edtCodIte.Clear;
      edtDesIte.Clear;
      Result := False;
    End;
  End;

end;

function TfrmConsultaPedidosPend.fVerificaDepartamentoVendedor: Boolean;
var
  strDep : String;
begin
  Result := True;

  If Not fEmptyStr(edtCodDepVen.Text) Then
  Begin
    strDep := fCampoTabela('OPE_CODDEP', 'CADOPE', ['OPE_CODOPE'], [edtCodVen.Text]);

    If edtCodDepVen.Text <> strDep Then
    Begin
      pMensagemOk('O Departamento não é o mesmo do Vendedor selecionado.');
      edtCodVen.Clear;
      edtNomVen.Clear;
      Result := False;
    End;
  End;
end;

procedure TfrmConsultaPedidosPend.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    Exit;
  End;

  TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde, Carregando Pedidos...', '');
end;

procedure TfrmConsultaPedidosPend.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  pFechaConsulta;
end;

procedure TfrmConsultaPedidosPend.btnImprimirClick(Sender: TObject);
var
  LSave: TSaveDialog;
begin
  inherited;

  LSave := TSaveDialog.Create(Self);

  Try
    LSave.Filter := 'Arquivos CSV|*.csv';

    if LSave.Execute then
    begin
      ExportGridToCSV(LSave.FileName, cxgConsulta, True, True, ';');
      pMensagemOk('Arquivo gerado com sucesso!');
    end;
  Finally
    FreeAndNil(LSave);
  end;
end;

procedure TfrmConsultaPedidosPend.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultaPedidosPend.btnPedVenClick(Sender: TObject);
begin
  inherited;

  btnPedVen.Enabled := False;
  pImprimePedido;
  btnPedVen.Enabled := True;
  pSetFocus(cxgConsulta);
end;

procedure TfrmConsultaPedidosPend.ckbEstAtuDispClick(Sender: TObject);
begin
  inherited;

  pFiltraPedidos;
end;

procedure TfrmConsultaPedidosPend.ckbSalDispClick(Sender: TObject);
begin
  inherited;

  pFiltraPedidos;
end;

procedure TfrmConsultaPedidosPend.cxgConsultaViewEstAtuCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  With cxgConsulta Do
  Begin

    If Not Active Then
      Exit;

    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaViewEstAtu.Index] < 0) Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clBlue;

  End;
end;

procedure TfrmConsultaPedidosPend.cxgConsultaViewSaldosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  With cxgConsulta Do
  Begin

    If Not Active Then
      Exit;

    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaViewSaldos.Index] < 0) Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clBlue;

  End;
end;

procedure TfrmConsultaPedidosPend.edtCodCliKeyPress(Sender: TObject; var Key: Char);
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
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidosPend.edtCodDepIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;

  If fPesqDepartamento(Self, edtCodDepIte, edtDesDepIte, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(edtCodDepIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaPedidosPend.edtCodDepVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;

  If fPesqDepartamento(Self, edtCodDepVen, edtDesDepVen, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(edtCodDepVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaPedidosPend.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidosPend.edtCodIteKeyPress(Sender: TObject; var Key: Char);
var
  arrProd: TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrProd) Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidosPend.edtCodRedeKeyPress(Sender: TObject; var Key: Char);
var
  arrRedes: TConsultasArray;
begin
  inherited;

  If fPesqRedeLojas(Self, edtCodRede, edtNomRede, Nil, Key, arrRedes) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidosPend.edtCodRegKeyPress(Sender: TObject; var Key: Char);
  Var
    arrReg: TConsultasArray;
begin
  inherited;

  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrReg) Then
  Begin
    If fValidaCampos(edtCodReg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidosPend.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtCodVen, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaPedidosPend.edtPorPedAteChange(Sender: TObject);
begin
  inherited;

  pFiltraPedidos;
end;

procedure TfrmConsultaPedidosPend.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  edtNumPed.MaxLength := fTamDocCadRec;
  edtNumPed.TamCampo  := fTamDocCadRec;

  qryCadCli := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  qryCadIte := fCriaQuery(Self);

  cdsConsul := TZClient.Create(Self);
  dtsConsul.DataSet := cdsConsul;

  cdsConAux := TZClient.Create(Self, fSqlConsulta);
  cdsConAux.fAbreClient(True, 'TfrmConsultaPedidos.FormCreate');

  cxgConsultaViewDtaCmp.Visible := (fCfgSis('SDTRPC') = 'S');

  cxgConsultaViewStatus.Visible := fCfgSis('EXISTA', varBoolean);
end;

procedure TfrmConsultaPedidosPend.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(qryCadCli);
  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadIte);
  FreeAndNil(cdsConsul);
  FreeAndNil(cdsConAux);
end;

procedure TfrmConsultaPedidosPend.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pEscapePressed;
    VK_SPACE : btnPedVen.Click;
  End;
end;

procedure TfrmConsultaPedidosPend.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumPed);
end;

Procedure TfrmConsultaPedidosPend.pAbreConsulta;
Begin
  Try
    cxgConsulta.Enabled := False;

    With cdsConsul, qryQuery Do
    Begin
      Close;

      SQL.Text := fSqlConsulta;

      If (Not fEmptyStr(edtCodRede.Text)) Then
      Begin
        ParamByName('CODRED').AsString := edtCodRede.Text;
      End;

      If (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        ParamByName('CODCLI').AsString := edtCodCli.Text;
      End;

      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
      End;

      If (Not fEmptyStr(edtCodVen.Text)) Then
      Begin
        ParamByName('CODVEN').AsString := edtCodVen.Text;
      End;

      If (Not fEmptyStr(edtCodDepVen.Text)) And (fEmptyStr(edtCodVen.Text)) Then
      Begin
        ParamByName('DEPVEN').AsString := edtCodDepVen.Text;
      End;

      If (Not fEmptyStr(edtCodIte.Text)) Then
      Begin
        ParamByName('CODITE').AsString := edtCodIte.Text;
      End;

      If (Not fEmptyStr(edtCodDepIte.Text)) And (fEmptyStr(edtCodIte.Text)) Then
      Begin
        ParamByName('DEPITE').AsString := edtCodDepIte.Text;
      End;

      If (Not fEmptyStr(edtCodReg.Text)) Then
      Begin
        ParamByName('CODREG').AsString := edtCodReg.Text;
      End;

      if (not fEmptyStr(edtPedCli.Text)) then
        ParamByName('PEDCLI').AsString := edtPedCli.Text;

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      End;

      If (Not fEmptyStr(edtNumPed.Text)) Then
      Begin
        ParamByName('NUMDOC').AsString := edtNumPed.Text;
      End;

      ParamByName('EMP_CD').AsString := fCfgSis('EMP_CD');

      fAbreClient(True, 'TfrmConsultaPedidos.pAbreConsulta');

      TFloatField(cdsConsul.FieldByName('ESTATU')).DisplayFormat := '#,##0.000';
      TFloatField(cdsConsul.FieldByName('QTDITE')).DisplayFormat := '#,##0.00';
      TFloatField(cdsConsul.FieldByName('SALDOS')).DisplayFormat := '#,##0.000';
      TFloatField(cdsConsul.FieldByName('PERTOT')).DisplayFormat := '#,##0.00';
      TFloatField(cdsConsul.FieldByName('PEDCOM')).DisplayFormat := '#,##0.00';
      TFloatField(cdsConsul.FieldByName('VLRUNI')).DisplayFormat := '#,##0.00';

      cdsConAux.EmptyDataSet;

      cxgConsultaView.ApplyBestFit();

      pProcessaPedidos;

      cxgConsulta.Enabled := True;

      cxgConsultaView.NavigatorButtons.First.Click;

      cxgConsultaView.ApplyBestFit();
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmConsultaPedidos.pAbreConsulta');
    End;
  End;

  pSetFocus(cxgConsulta);
end;

procedure TfrmConsultaPedidosPend.pEscapePressed;
begin
  If (Not cdsConsul.IsEmpty) Then
    btnCancelaItem.Click
  Else
    btnSair.Click;
end;

procedure TfrmConsultaPedidosPend.pProcessaPedidos;
Begin
  With cdsConsul Do
  Begin
    DisableControls;

    prbProgresso.Position := 0;
    prbProgresso.Max      := RecordCount;
    prbProgresso.Visible  := True;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin
      Next;
      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    prbProgresso.Visible := False;
    EnableControls;
  End;
End;

Procedure TfrmConsultaPedidosPend.pFechaConsulta;
Begin
  cdsConsul.Close;
  qryCadCli.Close;

  edtNumPed.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodRede.Clear;
  edtNomRede.Clear;
  edtCodDepVen.Clear;
  edtDesDepVen.Clear;
  edtCodDepIte.Clear;
  edtDesDepIte.Clear;

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  pSetFocus(edtNumPed);
End;

procedure TfrmConsultaPedidosPend.pFiltraPedidos;

  function E: String;
  begin
    If (fEmptyStr(cdsConsul.Filter)) Then
      Result := ''
    Else
      Result := ' AND ';
  end;

begin
  If (Not cdsConsul.IsEmpty) Then
  Begin
    cdsConsul.Filter := '';

    If (ckbEstAtuDisp.Checked) Then
      cdsConsul.Filter := cdsConsul.Filter + E + ' ESTATU > 0 ';

    If (ckbSalDisp.Checked) Then
      cdsConsul.Filter := cdsConsul.Filter + E + ' SALDOS > 0 ';

    If (Not fEmptyStr(edtPorPedAte.Text)) Then
    Begin
      If edtPorPedAte.Text[Length(edtPorPedAte.Text)] = ',' Then
        Exit;

      If (fStrToFloat(edtPorPedAte.Text) >= 0  ) And
         (fStrToFloat(edtPorPedAte.Text) <= 100) Then
        cdsConsul.Filter := cdsConsul.Filter + E + ' PERTOT >= ' + QuotedStr(edtPorPedAte.Text)
      Else
        FormatFloat(edtPorPedAte.EditFormat, 0);
    End;

    cdsConsul.Filtered := False;
    cdsConsul.Filtered := True;
  End
end;

procedure TfrmConsultaPedidosPend.pImprimePedido;
var
  blnReabrir: Boolean;
  intRecNo  : Integer;
  strNumPed,
  strEspDoc : String;
begin
  intRecNo := -1;

  Repeat
    Try
      With cdsConsul Do
      Begin
        If IsEmpty Then
          Exit;

        strNumPed := FieldByName('NUMPED').AsString;
        strEspDoc := FieldByName('ESPDOC').AsString;
      End;

      blnReabrir  := False;
      reimpressao := TReimpressao.Create(strNumPed,
                                         strEspdoc,
                                         VS_Date,
                                         VS_Date,
                                         '',
                                         '',
                                         '',
                                         True,
                                         '',
                                         True,
                                         False,
                                         False,
                                         '',
                                         '',
                                         True,
                                         0,
                                         False,
                                         '',
                                         True,
                                         False,
                                         '');

      If Not reimpressao.objDocumentos.cdsDocumentos.IsEmpty Then
      Begin
        Try
          pCriarFormularios(TfrmReimpressaoDocsList, frmReimpressaoDocsList);

          frmReimpressaoDocsList.reiReimpressao := reimpressao;
          frmReimpressaoDocsList.intRecNo       := intRecNo;
          frmReimpressaoDocsList.ShowModal;

          blnReabrir := frmReimpressaoDocsList.blnReabrir;
          intRecNo   := frmReimpressaoDocsList.intRecNo;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[frmConsultaPedidosPend.btnPedVen]');
          End;
        End;

        pFreeAndNil(frmReimpressaoDocsList);
      End;
    Finally
      If (Assigned(reimpressao)) Then
        FreeAndNil(reimpressao);
    End;
  Until Not blnReabrir;
end;

function TfrmConsultaPedidosPend.fCarregaRede: Boolean;
var
  qryCadRede: TUniQuery;
  strSQL: String;
begin
  strSQL := 'SELECT RED_DESRED FROM CADRED WHERE RED_CODRED = :CODRED';
  qryCadRede := fCriaQuery();
  Try
    With qryCadRede, SQL Do
    Begin
      Close;
      Clear;
      Text := strSQL;
      ParamByName('CODRED').AsString := edtCodRede.Text;
      Open;

      edtNomRede.Text := FieldByName('RED_DESRED').AsString;
      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryCadRede);
  End;
end;

function TfrmConsultaPedidosPend.fSqlConsulta: String;
const
  SQL_SALDO_ATUAL = ' IF(IFNULL(G.FGO_ENT_CD, "N") = "S", ' +
                    '    IF(ITE_EMP_CD.ITE_SALDOS < 0, 0, ITE_EMP_CD.ITE_SALDOS), ' +
                    '    IF(I.ITE_SALDOS < 0, 0, I.ITE_SALDOS)) ';
var
  strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   D.FDO_NUMDOC AS NUMPED, ';
  strSQL := strSQL + '   D.FDO_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '   CONCAT(D.FDO_NUMDOC, "-", D.FDO_ESPDOC, "-", D.FDO_CODEMP) AS NUMDOC, ';
  strSQL := strSQL + '   CONCAT(D.FDO_CODCLI, "-", L.CLI_NOMCLI) AS CODCLI, ';
  strSQL := strSQL + '   G.FGO_CODVEN AS CODVEN, ';
  strSQL := strSQL + '   G.FGO_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   CONCAT(D.FDO_CODITE, "-", D.FDO_DESCRI) AS CODITE, ';
  strSQL := strSQL + '   E.FDO_ENTRET AS ENTRET, ';
  strSQL := strSQL + '   E.FDO_DTENTR AS DTENTR, ';

  strSQL := strSQL + fSQLCamposQuantidadePendenteCompra(False {blnSoma}, False, False, 'SP') +  ' AS PEDCOM, ';

  strSQL := strSQL + '   E.FDO_NUMCMP AS PEDCLI, ';
  strSQL := strSQL + '   IFNULL(G.FGO_NUMPOK, G.FGO_PEDSIT) AS PEDSIT, ';
  strSQL := strSQL + SQL_SALDO_ATUAL + ' AS ESTATU, ';
  strSQL := strSQL + '   (D.FDO_QTDITE - D.FDO_QTDBAI) AS QTDITE, ';
  strSQL := strSQL + SQL_SALDO_ATUAL + ' - D.FDO_QTDITE AS SALDOS, ';
  strSQL := strSQL + '   (IFNULL(( ';
  strSQL := strSQL + '      SELECT                                                  ';
  strSQL := strSQL + '        SUM(DI.FDO_QTDITE - DI.FDO_QTDBAI) AS TOTATE          ';
  strSQL := strSQL + '      FROM FATDOR DI                                          ';
  strSQL := strSQL + '        INNER JOIN FATGOR GI ON GI.AUTOINCREM = DI.FDO_SEQGER ';
  strSQL := strSQL + '        INNER JOIN ITEGER II ON II.ITE_CODITE = DI.FDO_CODITE ';
  strSQL := strSQL + '                            AND II.ITE_CODEMP = DI.FDO_CODEMP ';
  strSQL := strSQL + '      WHERE DI.FDO_JAFATU = 0                                 ';
  strSQL := strSQL + '        AND IFNULL(GI.FGO_LIBERA, 0) > 0                      ';
  strSQL := strSQL + '        AND DI.FDO_ESPDOC = "PD"                              ';
  strSQL := strSQL + '        AND (II.ITE_SALDOS - DI.FDO_QTDITE) >= 0              ';
  strSQL := strSQL + '        AND D.FDO_NUMDOC = DI.FDO_NUMDOC                      ';
  strSQL := strSQL + '        AND D.FDO_ESPDOC = DI.FDO_ESPDOC                      ';
  strSQL := strSQL + '        AND D.FDO_CODEMP = DI.FDO_CODEMP                      ';
  strSQL := strSQL + '   ),0) / ( ';
  strSQL := strSQL + '      SELECT                                                  ';
  strSQL := strSQL + '        SUM(DI.FDO_QTDITE - DI.FDO_QTDBAI) AS TOTPED          ';
  strSQL := strSQL + '      FROM FATDOR DI                                          ';
  strSQL := strSQL + '        INNER JOIN EXTDOR EI ON DI.AUTOINCREM = EI.FDO_SEQFDO ';
  strSQL := strSQL + '      WHERE DI.FDO_NUMDOC = G.FGO_NUMDOC                      ';
  strSQL := strSQL + '        AND DI.FDO_ESPDOC = G.FGO_ESPDOC                      ';
  strSQL := strSQL + '        AND DI.FDO_CODEMP = G.FGO_CODEMP                      ';
  strSQL := strSQL +     ')) * 100 AS PERTOT, ';
  strSQL := strSQL + '   E.FDO_NITCMP AS NITCMP, ';
  strSQL := strSQL + '   D.FDO_UNITAR AS VLRUNI, ';
  strSQL := strSQL + '   P.PCD_DTAPED AS DTPDCM, ';
  strSQL := strSQL + '   P.PCD_DTAENT AS ENPDCM, ';
  strSQL := strSQL + '   DATEDIFF(E.FDO_DTENTR, CURRENT_DATE) AS DIAENT, ';
  strSQL := strSQL + '   E.FDO_DTACMP AS DTACMP, ';
  strSQL := strSQL + '   S.STA_DESCRI AS STATUS, ';
  strSQL := strSQL + '   (SELECT DISTINCT PC.PCD_NUMPED      ';
  strSQL := strSQL + '    FROM PCMDET PC                     ';
  strSQL := strSQL + '    WHERE PC.PCD_CODITE = D.FDO_CODITE ';
  strSQL := strSQL + '      AND PC.PCD_CODEMP = D.FDO_CODEMP ';
  strSQL := strSQL + '    ORDER BY PC.PCD_NUMPED DESC        ';
  strSQL := strSQL + '    LIMIT 0, 1) AS NUMULTPDCMP,        ';
  strSQL := strSQL + '   (SELECT CONCAT(PC.PCD_CODFOR, ''-'', FC.FOR_NOMFOR) ';
  strSQL := strSQL + '    FROM PCMDET PC                     ';
  strSQL := strSQL + '    LEFT JOIN CADFOR FC                ';
  strSQL := strSQL + '      ON FC.FOR_CODFOR = PC.PCD_CODFOR ';
  strSQL := strSQL + '    WHERE PC.PCD_CODITE = D.FDO_CODITE ';
  strSQL := strSQL + '      AND PC.PCD_CODEMP = D.FDO_CODEMP ';
  strSQL := strSQL + '    ORDER BY PC.PCD_NUMPED DESC        ';
  strSQL := strSQL + '    LIMIT 0, 1) AS FORULTPDCMP         ';
  strSQL := strSQL + ' FROM FATDOR D ';
  strSQL := strSQL + '   INNER JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER ';
  strSQL := strSQL + '   INNER JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM ';
  strSQL := strSQL + '   INNER JOIN ITEGER I ON I.ITE_CODITE = D.FDO_CODITE ';
	strSQL := strSQL + '                	    AND I.ITE_CODEMP = D.FDO_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN ITEGER ITE_EMP_CD ';
  strSQL := strSQL + '     ON ITE_EMP_CD.ITE_CODITE = D.FDO_CODITE ';
  strSQL := strSQL + '     AND ITE_EMP_CD.ITE_CODEMP = :EMP_CD ';

  strSQL := strSQL + '   LEFT JOIN SALPDC SP ON SP.SAL_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                      AND SP.SAL_CODEMP = I.ITE_CODEMP ';

  strSQL := strSQL + '   INNER JOIN CADITE C ON C.ITE_CODITE = D.FDO_CODITE ';
  strSQL := strSQL + '   INNER JOIN CADOPE O ON O.OPE_CODOPE = D.FDO_CODVEN ';
  strSQL := strSQL + '   INNER JOIN CADCLI L ON L.CLI_CODCLI = D.FDO_CODCLI ';
  strSQL := strSQL + '   LEFT  JOIN AUXGOR A ON A.AUX_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '   LEFT  JOIN ENTCLI N ON N.AUTOINCREM = A.AUX_ENTGER ';
  strSQL := strSQL + '   INNER JOIN EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM ';
  strSQL := strSQL + '   LEFT  JOIN MOVRCD R ON D.FDO_NUMDOC = R.RCD_DOCPDV ';
  strSQL := strSQL + '                      AND D.FDO_ESPDOC = R.RCD_ESPPDV ';
  strSQL := strSQL + '                      AND D.FDO_CODEMP = R.RCD_EMPPDV ';
  strSQL := strSQL + '                      AND D.FDO_CODITE = R.RCD_CODITE ';
  strSQL := strSQL + '   LEFT  JOIN PCMDET P ON R.RCD_SEQPCD = P.AUTOINCREM ';
  strSQL := strSQL + '   LEFT  JOIN FGOSTA S ON X.FGO_STATUS = S.STA_CODIGO ';
  strSQL := strSQL + '   WHERE D.FDO_JAFATU = 0 ';
  strSQL := strSQL + '     AND IFNULL(G.FGO_LIBERA, 0) > 0 ';
  strSQL := strSQL + '     AND G.FGO_ESPDOC = "PD" ';
  strSQL := strSQL + '     AND G.FGO_JAFATU = 0 ';
  strSQL := strSQL + '     AND IFNULL(X.FGO_LOC_PD, "N")  <> "S" ';

  If (Not fEmptyStr(edtCodRede.Text)) Then
  Begin
    strSQL := strSQL + 'AND L.CLI_CODRED = :CODRED';
  End;

  If (Not fEmptyStr(edtCodCli.Text)) Then
  Begin
    strSQL := strSQL + '  AND G.FGO_CODCLI = :CODCLI ';
  End;

  If (Not fEmptyStr(edtCodEmp.Text)) Then
  Begin
    strSQL := strSQL + '  AND G.FGO_CODEMP = :CODEMP ';
  End;

  If (Not fEmptyStr(edtCodVen.Text)) Then
  Begin
    strSQL := strSQL + '  AND G.FGO_CODVEN = :CODVEN ';
  End;

  If (Not fEmptyStr(edtCodDepVen.Text)) And (fEmptyStr(edtCodVen.Text)) Then
  Begin
    strSQL := strSQL + '  AND O.OPE_CODDEP = :DEPVEN ';
  End;

  If (Not fEmptyStr(edtCodIte.Text)) Then
  Begin
    strSQL := strSQL + '  AND D.FDO_CODITE = :CODITE ';
  End;

  If (Not fEmptyStr(edtCodDepIte.Text)) And (fEmptyStr(edtCodIte.Text)) Then
  Begin
    strSQL := strSQL + '  AND C.ITE_CODDEP = :DEPITE ';
  End;

  If (Not fEmptyStr(edtCodReg.Text)) Then
  Begin
    strSQL := strSQL + '  AND N.ETC_CODREG = :CODREG ';
  End;

  if (not fEmptyStr(edtPedCli.Text)) then
    strSQL := strSQL + '  AND E.FDO_NUMCMP = :PEDCLI ';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
  Begin
    strSQL := strSQL + '  AND G.FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  End;

  If (Not fEmptyStr(edtNumPed.Text)) Then
  Begin
    strSQL := strSQL + '  AND G.FGO_NUMDOC = :NUMDOC ';
  End;

  strSQL := strSQL + '   ORDER BY ';
  strSQL := strSQL + '     E.FDO_ENTRET DESC, ';
  strSQL := strSQL + '     E.FDO_DTENTR, ';
  strSQL := strSQL + '     D.FDO_DESCRI, ';
  strSQL := strSQL + '     D.FDO_CODEMP, ';
  strSQL := strSQL + '     D.FDO_ESPDOC, ';
  strSQL := strSQL + '     D.FDO_NUMDOC  ';


  Result := strSQL;
End;

end.
