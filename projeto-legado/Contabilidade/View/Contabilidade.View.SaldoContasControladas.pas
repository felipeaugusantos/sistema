unit Contabilidade.View.SaldoContasControladas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, cxButtons,
  MemDS, DBAccess, Uni, cxCalendar, cxCalc, cxCheckBox, cxBlobEdit, cxRadioGroup;

type

  TfrmSaldoContasControladas = class(TfrmPaiContabilidade)
    gbFiltroInicial: TGroupBox;
    GridTab: TcxGridDBTableViewCitel;
    GridCitelLevel1: TcxGridLevel;
    GridCitel: TcxGridCitel;
    Label15: TLabel;
    edtEmpLan: TEditFocus;
    edtNomEmp: TEditFocus;
    Label1: TLabel;
    edtCtaCon: TEditFocus;
    edtNomCon: TEditFocus;
    btnAbrir: TcxButton;
    btnIncluir: TcxButton;
    btnEditar: TcxButton;
    btnExcluir: TcxButton;
    dsDados: TDataSource;
    GridTabAUTOINCREM: TcxGridDBColumn;
    GridTabSAL_CTACON: TcxGridDBColumn;
    GridTabSAL_DTALAN: TcxGridDBColumn;
    GridTabSAL_HISPAD: TcxGridDBColumn;
    GridTabSAL_HISTOR: TcxGridDBColumn;
    GridTabSAL_VALLAN: TcxGridDBColumn;
    GridTabSAL_CREDEB: TcxGridDBColumn;
    GridTabSAL_AJLUCR: TcxGridDBColumn;
    GridTabSAL_NATAJU: TcxGridDBColumn;
    GridTabNAT_DESCRI: TcxGridDBColumn;
    GridTabSAL_CODEMP: TcxGridDBColumn;
    btnFechar: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure edtEmpLanKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaConKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure GridTabEditDblClick(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
  private
    { Private declarations }
    FQryDados: TUniQuery ;
    function fValidaEntradaDadosAbrir:boolean ;
    procedure pHabilitaManutencao(const AblnHabilita:boolean);
    function fEhOrigemAutomatica(const AIntCodigo: integer):Boolean ;
    function fConsultaVaziaSaldos:boolean ;
    procedure pDesabilitaBotoesLancAut(const AintCodigo: integer) ;
    procedure pAfterScroll(DataSet: TDataSet) ;
    function fCarregaDados(var AQryDados: TUniQuery; const ACodEmp, ACntCon: string): Boolean ;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Consultas, untTypesSistema, untConsultas,
  Contabilidade.Classes.TSaldoContasControladas ;

{$R *.dfm}

{ TfrmSaldoContasControladas }

procedure TfrmSaldoContasControladas.btnAbrirClick(Sender: TObject);
begin
  inherited;
  If Not fValidaEntradaDadosAbrir Then
    Exit;

  if fCarregaDados(FQryDados, edtEmpLan.Text, edtCtaCon.Text) then
  begin
    pHabilitaManutencao(True);
  end;

end;

procedure TfrmSaldoContasControladas.btnEditarClick(Sender: TObject);
var
  LregDados: TRegSaldoContaControlada ;
begin
  inherited;

  if fConsultaVaziaSaldos then
    exit ;

  if fEhOrigemAutomatica(FQryDados.FieldByName('AUTOINCREM').AsInteger) then
    exit ;

  LregDados := TSaldoContasControladas.fPreparaDadosAlterar(FQryDados) ;

  if not TSaldoContasControladas.fPodeIncluirDataCtaCon(edtCtaCon.Text, LregDados.SAL_DTALAN) then
    exit ;

  if TSaldoContasControladas.fAlteraDados(FQryDados, LregDados, edtCtaCon.Text) then
  begin
    fCarregaDados(FQryDados, edtEmpLan.Text, edtCtaCon.Text)
  end;
end;

procedure TfrmSaldoContasControladas.btnExcluirClick(Sender: TObject);
begin
  inherited;

  if fConsultaVaziaSaldos then
    exit ;

  if fEhOrigemAutomatica(FQryDados.FieldByName('AUTOINCREM').AsInteger) then
    exit ;

  if not TSaldoContasControladas.fPodeIncluirDataCtaCon(edtCtaCon.Text, FQryDados.FieldByName('SAL_DTALAN').AsDateTime) then
    exit ;

  if fMensagem('ATENÇÃO!','Confirma a exclusão ? ', ['&Sim', '&Não'], 1) = 2 then
  begin
    Exit;
  end;

  if TSaldoContasControladas.fDeletaDados(FQryDados.FieldByName('AUTOINCREM').AsInteger) then
  begin
    fCarregaDados(FQryDados, edtEmpLan.Text, edtCtaCon.Text) ;
  end;

end;

procedure TfrmSaldoContasControladas.btnFecharClick(Sender: TObject);
begin
  inherited;
  pHabilitaManutencao(False);
  fCarregaDados(FQryDados, '', '') ;
  pSetFocus(edtEmpLan) ;
end;

procedure TfrmSaldoContasControladas.btnIncluirClick(Sender: TObject);
var
  LregDados: TRegSaldoContaControlada ;
begin
  inherited;
  LregDados.AUTOINCREM := 0 ;
  LregDados.SAL_CTACON := edtCtaCon.Text ;
  LregDados.SAL_CODEMP := edtEmpLan.Text ;
  if TSaldoContasControladas.fAlteraDados(FQryDados, LregDados, edtCtaCon.Text) then
  begin
    fCarregaDados(FQryDados, edtEmpLan.Text, edtCtaCon.Text) ;
  end;
end;

procedure TfrmSaldoContasControladas.edtCtaConKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCons: TConsultasArray;
begin
  inherited;
  If fPesqContaControlada(Self, edtCtaCon, Nil, Nil, Key, arrCons) Then
  Begin
    If fValidaCampos(edtCtaCon) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSaldoContasControladas.edtEmpLanKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpLan, edtNomEmp, Nil, Key, arrEmpSel) Then
  Begin
    If fValidaCampos(edtEmpLan) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmSaldoContasControladas.fCarregaDados(var AQryDados: TUniQuery;
  const ACodEmp, ACntCon: string): Boolean;
begin
  AQryDados.AfterScroll := nil ;
  try
    result := TSaldoContasControladas.fCarregaDados(AQryDados, ACodEmp, ACntCon) ;
    pAfterScroll(AQryDados) ;
  finally
    AQryDados.AfterScroll := pAfterScroll;
  end ;
end;

function TfrmSaldoContasControladas.fConsultaVaziaSaldos: boolean;
begin
  Result := True ;
  if FQryDados.IsEmpty then
    exit ;
  Result := False ;
end;

function TfrmSaldoContasControladas.fEhOrigemAutomatica(
  const AIntCodigo: integer): Boolean;
begin
  Result := TSaldoContasControladas.fOrigemAutomatica(AIntCodigo) ;
  if Result then
    fMensagem('ATENÇÃO!', 'Lançamento de origem automática!', ['&Ok']);
end;

procedure TfrmSaldoContasControladas.FormCreate(Sender: TObject);
begin
  inherited;
  FQryDados := fCriaQuery() ;
  edtEmpLan.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  pHabilitaManutencao(False) ;
end;

procedure TfrmSaldoContasControladas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQryDados) ;
end;

procedure TfrmSaldoContasControladas.FormShow(Sender: TObject);
begin
  inherited;
  fCarregaDados(FQryDados, '', '') ;
  dsDados.DataSet := FQryDados ;
end;


function TfrmSaldoContasControladas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpLan) Then
    Begin
      if fEmptyStr(edtEmpLan.Text) then
      begin
        edtNomEmp.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end;
      End;
    end
    else If (Sender = edtCtaCon) Then
    Begin
      if fEmptyStr(edtCtaCon.Text) then
      begin
        edtNomCon.Clear;
        Result := True;
      end
      else
      Begin
        edtNomCon.Text := fCampoTabela('CTA_DESCRI', 'CTACON', ['CTA_CODCON'], [edtCtaCon.Text], False);
        If (fEmptyStr(edtNomCon.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa conta controlada não está cadastrada!', ['&Ok']);
          Result := False;
        end;
      End;
    End;
  end;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmSaldoContasControladas.fValidaEntradaDadosAbrir: boolean;
begin
  result := False ;
  If fEmptyStr(edtNomCon.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Conta Controlada deve ser preenchida!', ['&Ok']);
    pSetFocus(edtCtaCon);
    Exit ;
  End;
  If fEmptyStr(edtNomEmp.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Empresa deve ser preenchida!', ['&Ok']);
    pSetFocus(edtNomEmp);
    Exit ;
  End;
  result := True ;
end;

procedure TfrmSaldoContasControladas.GridTabEditDblClick(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit);
begin
  inherited;

  if fConsultaVaziaSaldos then
    exit ;

  if fEhOrigemAutomatica(FQryDados.FieldByName('AUTOINCREM').AsInteger) then
    exit ;

  if btnEditar.Enabled then
  begin
    btnEditar.Click ;
  end;
end;

procedure TfrmSaldoContasControladas.pAfterScroll(DataSet: TDataSet);
begin
  pDesabilitaBotoesLancAut(DataSet.FieldByName('AUTOINCREM').AsInteger) ;
end;

procedure TfrmSaldoContasControladas.pDesabilitaBotoesLancAut(
  const AintCodigo: integer);
var
  LblnFlag: boolean ;
begin
  if AintCodigo <> 0 then
    LblnFlag := TSaldoContasControladas.fOrigemAutomatica(AintCodigo)
  else
    LblnFlag := True ;
  btnEditar.Enabled := not LblnFlag ;
  btnExcluir.Enabled := not LblnFlag ;
end;

procedure TfrmSaldoContasControladas.pHabilitaManutencao(
  const AblnHabilita: boolean);
begin
  btnIncluir.Enabled := AblnHabilita ;
  btnEditar.Enabled := AblnHabilita ;
  btnExcluir.Enabled := AblnHabilita ;

  edtEmpLan.Enabled := not AblnHabilita ;
  edtCtaCon.Enabled := not AblnHabilita ;

  btnAbrir.Enabled := not AblnHabilita ;
  btnFechar.Enabled := AblnHabilita ;
end;

end.
