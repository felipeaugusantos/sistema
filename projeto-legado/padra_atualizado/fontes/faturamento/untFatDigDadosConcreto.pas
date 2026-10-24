unit untFatDigDadosConcreto;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBEditFocus, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatDigDadosConcreto = class(TfrmPaiSimples)
    Label1: TLabel;
    edtLacre_: TEditFocus;
    pnlConfirma: TPanel;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    Label3: TLabel;
    mskPlaVei: TMaskEditFocus;
    edtDesVei: TEditFocus;
    lblMotorista: TLabel;
    edtCodMot: TEditFocus;
    edtNomMot: TEditFocus;
    Label8: TLabel;
    edtBetone: TEditFocus;
    Label140: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    ColorLabel1: TColorLabel;
    Label30: TLabel;
    edtAbatim: TEditFocus;
    edtTipMps: TEditFocus;
    edtBrita_: TEditFocus;
    edtConBom: TEditFocus;
    edtFckDia: TEditFocus;
    pnlTipoDeBomba: TPanel;
    ColorLabel2: TColorLabel;
    Label2: TLabel;
    edtTipoBomba: TEditFocus;
    pnlBombeamento: TPanel;
    lblTotalBombeamento: TLabel;
    lblQtdBombeamento: TLabel;
    lblPrecoBombeamento: TLabel;
    lblBombeamentoConcreto: TLabel;
    edtTotBom: TEditFocus;
    edtQtdBom: TEditFocus;
    edtPrcBom: TEditFocus;
    pnlDadSer: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtCodObr: TEditFocus;
    edtCodART: TEditFocus;
    Label4: TLabel;
    edtCodCno: TEditFocus;
    Label5: TLabel;
    edtInsImo: TEditFocus;
    Label6: TLabel;
    edtCodCib: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodObrKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodARTKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdBomExit(Sender: TObject);
    procedure edtPrcBomExit(Sender: TObject);
    procedure edtTotBomExit(Sender: TObject);
  private
    { Private declarations }
    function  fValidarCampoObrigatorio(Sender: TCustomEdit): Boolean;
    function  fValidarTodosCamposObrigatorios: Boolean;
    procedure pAtualizaEdits(blnSomVei: Boolean = False);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCalculaTotalGeral;
    procedure pCalculaTotalBombeamento;
  public
    { Public declarations }
    fatVenda: TFatVenda;
    blnConfirma: Boolean;
  end;

var
  frmFatDigDadosConcreto: TfrmFatDigDadosConcreto;

implementation

uses untfuncoesSimples, Math, untConsultas, untTypesSistema, untConstantes;

{$R *.dfm}

procedure TfrmFatDigDadosConcreto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigDadosConcreto.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos And fValidarTodosCamposObrigatorios Then
  Begin

    fatVenda.strPlaVei := fTiraCaracEspeciais(mskPlaVei.Text);
    fatVenda.strCodMot := edtCodMot.Text;
    fatVenda.strNomMot := edtNomMot.Text;
    fatVenda.strBetone := edtBetone.Text;
    fatVenda.strLacre_ := edtLacre_.Text;
    fatVenda.strTipMps := edtTipMps.Text;
    fatVenda.strAbatim := edtAbatim.Text;
    fatVenda.strBrita_ := edtBrita_.Text;
    fatVenda.strConBom := edtConBom.Text;
    fatVenda.strTipBom := edtTipoBomba.Text;
    fatVenda.strFckDia := edtFckDia.Text;

    If (pnlBombeamento.Visible) Then
    Begin
      fatVenda.fltQtdBom := fStrToFloat(edtQtdBom.Text);
      fatVenda.fltPrcBom := fStrToFloat(edtPrcBom.Text);
      fatVenda.fltTotBom := fStrToFloat(edtTotBom.Text);
    End;

    If (pnlDadSer.Visible) Then
    Begin
      fatVenda.strCodObr := edtCodObr.Text;
      fatVenda.strCodArt := edtCodART.Text;
      fatVenda.strCodCno := edtCodCno.Text;
      fatVenda.strInsImo := edtInsImo.Text;
      fatVenda.strCodCib := edtCodCib.Text;
    End;

    blnConfirma := True;
    Close;
  End;

end;

procedure TfrmFatDigDadosConcreto.edtCodARTKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If CharInSet(Key, [',', '.']) Then
  Begin
    Key := #0;
  End;

end;

procedure TfrmFatDigDadosConcreto.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  inherited;
  If edtCodMot.ReadOnly Then
    Exit;

  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigDadosConcreto.edtCodObrKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If CharInSet(Key, [',', '.']) Then
  Begin
    Key := #0;
  End;

end;

procedure TfrmFatDigDadosConcreto.edtPrcBomExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalGeral;
end;

procedure TfrmFatDigDadosConcreto.edtQtdBomExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalGeral;
end;

procedure TfrmFatDigDadosConcreto.edtTotBomExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalGeral;
end;

procedure TfrmFatDigDadosConcreto.FormCreate(Sender: TObject);
begin

  inherited;

  blnConfirma := False;
  If ((fCfgSis('TPNFCR') = SECOL) Or (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO)) Then
  Begin
    edtCodMot.TabStop     := True;
    edtCodMot.ReadOnly    := False;
    edtCodMot.Color       := clWindow;
    edtCodMot.FocusColor  := clWindow;
    edtCodMot.NormalColor := clWindow;
  End;

  If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
  Begin

    edtBetone.TabStop     := True;
    edtBetone.ReadOnly    := False;
    edtBetone.Color       := clWindow;
    edtBetone.FocusColor  := clWindow;
    edtBetone.NormalColor := clWindow;

    pnlBombeamento.Visible := True;

  end
  Else
  Begin
    pnlTipoDeBomba.Visible := False;
    pnlBombeamento.Visible := False;
    pnlDadSer.Visible      := False;
    Self.Height := (Self.Height - (pnlTipoDeBomba.Height + pnlBombeamento.Height + pnlDadSer.Height));
  End;

end;

function TfrmFatDigDadosConcreto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskPlaVei) Then
    Begin

      mskPlaVei.Text := fTiraCaracEspeciais(mskPlaVei.Text);

      If fVeiculoInativo(mskPlaVei.Text) Then
      Begin
        edtDesVei.Text := '';
        fMensagem('','Este veículo está inativo.',['&O k']);
        Result := False;
      End
      Else
      Begin
        fatVenda.strPlaVei := mskPlaVei.Text;
        pAtualizaEdits(True);

        Result := fValidarCampoObrigatorio(mskPlaVei) And
                  fValidarCampoObrigatorio(edtDesVei);

        {Na J.A valida no F10, pois vai ser informado em tela!}
        If (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) Then
          Result := fValidarCampoObrigatorio(edtBetone);

      End;
    End;

    If (Sender = edtCodMot) Then
    Begin
      edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text);

      If (fEmptyStr(edtCodMot.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Motorista deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If fEmptyStr(edtNomMot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Motorista não está cadastrado!', ['&Ok']);
        Result := False;
      End

      Else If (fRetStatusMotorista(edtCodMot.Text) = 'I') Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Motorista está inativo!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtLacre_) Then
      Result := fValidarCampoObrigatorio(edtLacre_);

    If (Sender = edtConBom) Then
    Begin
      Result := fValidarCampoObrigatorio(edtConBom);

      If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
        pnlTipoDeBomba.Visible := (Result) And (edtConBom.Text = 'B');

      If (pnlTipoDeBomba.Visible) Then
        If fEmptyStr(edtTipoBomba.Text) Then
          edtTipoBomba.Text := 'L';

      If Result And (Pos(edtConBom.Text, 'CB') <= 0) Then
      Begin
        Result := False;
        fMensagem('','Informe um valor válido ' + edtConBom.Hint + '!', ['&Ok']);
      End;
    End;

    If (Sender = edtTipoBomba) And (pnlTipoDeBomba.Visible) Then
    Begin

      Result := fValidarCampoObrigatorio(edtTipoBomba);

      If Result And (Pos(edtTipoBomba.Text, 'ML') <= 0) Then
      Begin
        Result := False;
        fMensagem('','Informe um valor válido ' + edtTipoBomba.Hint + '!', ['&Ok']);
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmFatDigDadosConcreto.fValidarCampoObrigatorio(
  Sender: TCustomEdit): Boolean;
begin
  Result := True;
  If fEmptyStr(fTiraCaracEspeciais(Sender.Text)) Then
  Begin
    Result := False;
    fMensagem('','O Campo ' + Sender.Hint + ' é obrigatorio!', ['&Ok']);
  End;
end;

function TfrmFatDigDadosConcreto.fValidarTodosCamposObrigatorios: Boolean;
  var
    intCont: integer;
begin
  Result := True;
  for intCont := 0 to pnlFundo.ControlCount - 1 do
  begin
    If pnlFundo.Controls[intCont] Is TCustomEdit Then
      If Not fValidarCampoObrigatorio(TCustomEdit(pnlFundo.Controls[intCont])) Then
        Result := False;
  end;
end;

procedure TfrmFatDigDadosConcreto.mskPlaVeiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVeic: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE VEÍCULOS   *}
  {****************************RV*}
  If fPesqVeiculos(Self, mskPlaVei, edtDesVei, Nil, Key, arrVeic, True, True,  ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigDadosConcreto.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaEdits;
end;

procedure TfrmFatDigDadosConcreto.pAtualizaEdits(blnSomVei: Boolean = False);
begin
  fatVenda.pIniciaVariaveisVendaConcreto(blnSomVei);

  mskPlaVei.Text := fatVenda.strPlaVei;
  edtDesVei.Text := fatVenda.strDesVei;

  If Not fEmptyStr(fatVenda.strBetone) Then
    edtBetone.Text := fatVenda.strBetone;

  If fEmptyStr(edtCodMot.Text) Or edtCodMot.ReadOnly Or Not blnSomVei Then
  Begin

    If Not fEmptyStr(fatVenda.strCodMot) Then
    Begin
      edtCodMot.Text := fatVenda.strCodMot;
      edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text);
    End;

    If Not fEmptyStr(fatVenda.strNomMot) Then
      edtNomMot.Text := fatVenda.strNomMot;

  End;

  If Not blnSomVei Then
  Begin
    edtLacre_.Text := fatVenda.strLacre_;
    edtTipMps.Text := fatVenda.strTipMps;
    edtAbatim.Text := fatVenda.strAbatim;
    edtBrita_.Text := fatVenda.strBrita_;
    edtConBom.Text := fatVenda.strConBom;
    edtFckDia.Text := fatVenda.strFckDia;
    edtTipoBomba.Text := fatVenda.strTipBom;
  End;

  If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
  Begin

    {Se carregou PD para faturar ou faturando na expedição (CP) não precisa mostrar a taxa,
     pois não terá taxa na nota de remessa (NF), somente na NS!}
    If ((fatVenda.strOpcDoc = 'VN') Or (fatVenda.strOpcDoc = 'CP')) And (fatVenda.strEspDoc = 'NF') Then
      pnlBombeamento.Visible := False;

    pnlTipoDeBomba.Visible := (edtConBom.Text = 'B');
    pnlDadSer.Visible      := (fatVenda.strOpcDoc = 'PD');

    If (pnlTipoDeBomba.Visible) Then
      If fEmptyStr(edtTipoBomba.Text) Then
        edtTipoBomba.Text := 'L';

    If (pnlBombeamento.Visible) Then
    Begin
      If (fatVenda.fltQtdBom > 0) Then
        edtQtdBom.Text := FormatFloat('#,##0.00', fatVenda.fltQtdBom);
      If (fatVenda.fltPrcBom > 0) Then
        edtPrcBom.Text := FormatFloat('#,##0.00', fatVenda.fltPrcBom);
      If (fatVenda.fltTotBom > 0) Then
        edtTotBom.Text := FormatFloat('#,##0.00', fatVenda.fltTotBom);
    End;

    If (pnlDadSer.Visible) Then
    Begin
      If Not fatVenda.strCodObr.IsEmpty Then
        edtCodObr.Text := fatVenda.strCodObr;
      If Not fatVenda.strCodArt.IsEmpty Then
        edtCodART.Text := fatVenda.strCodArt;
      If Not fatVenda.strCodCno.IsEmpty Then
        edtCodCno.Text := fatVenda.strCodCno;
      If Not fatVenda.strInsImo.IsEmpty Then
        edtInsImo.Text := fatVenda.strInsImo;
      If Not fatVenda.strCodCib.IsEmpty Then
        edtCodCib.Text := fatVenda.strCodCib;
    End;

  End;

end;

procedure TfrmFatDigDadosConcreto.pCalculaTotalBombeamento;
begin

  fatVenda.fltQtdBom := 0.0;
  fatVenda.fltPrcBom := 0.0;
  fatVenda.fltTotBom := 0.0;

  If (pnlBombeamento.Visible) Then
  Begin

    fatVenda.fltQtdBom := fStrToFloat(edtQtdBom.Text);
    fatVenda.fltPrcBom := fStrToFloat(edtPrcBom.Text);
    fatVenda.fltTotBom := fFormataFloat(fatVenda.fltQtdBom * fatVenda.fltPrcBom, 2);

    edtTotBom.Text := FormatFloat('#,##0.00', fatVenda.fltTotBom);

  End;

end;

procedure TfrmFatDigDadosConcreto.pCalculaTotalGeral;
begin
  pCalculaTotalBombeamento;
end;

end.

