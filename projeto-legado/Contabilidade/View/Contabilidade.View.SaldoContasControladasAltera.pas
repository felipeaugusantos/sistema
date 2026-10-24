unit Contabilidade.View.SaldoContasControladasAltera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, cxControls, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxDropDownEdit,
  cxCalendar, cxCalc, cxMemo, cxGroupBox, cxCheckBox, cxLabel, EditFocus,
  MemoFocus, cxCurrencyEdit, CurrencyEditFocus, cxTextEdit, cxMaskEdit;

type
  TfrmSaldoContasControladasAltera = class(TfrmPaiContabilidade)
    btnConfirmar: TcxButton;
    edtSAL_DTALAN: TcxDateEdit;
    edtSAL_CREDEB: TcxComboBox;
    gbAjusteLucroLiquido: TcxGroupBox;
    edtSAL_AJLUCR: TcxCheckBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    edtSAL_HISPAD: TEditFocus;
    edtSAL_DESPAD: TEditFocus;
    edtSAL_HISTOR: TMemoFocus;
    edtSAL_NATAJU: TEditFocus;
    edtNAT_DESCRI: TEditFocus;
    edtSAL_VALLAN: TCurrencyEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtSAL_HISPADKeyPress(Sender: TObject; var Key: Char);
    procedure edtSAL_NATAJUKeyPress(Sender: TObject; var Key: Char);
    procedure edtSAL_AJLUCRPropertiesEditValueChanged(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FblnConfirma : Boolean ;
    FstrCodigoCtaCon: String ;
    FstrEmpLan: string;
    function fValidaNaturezaAjustes(edtCodigo, edtDscricao: TEditFocus;
      ATipMov: string): Boolean;
    function fValidaHistoricoPadrao(edtCodigo, edtDscricao: TEditFocus): Boolean ;
    procedure pCarregaNaturezaAjustes(strCodigo: String;
      edtDscricao: TEditFocus; ATipMov: string);
    function fCarregaHistoricoPadrao(const ACodigo: string): string;
    procedure pHabilitaNaturezaAjuste(const AblnHabilitar: boolean) ;
    function fValidaValoresInformados:boolean ;
    procedure pCarregaDados ;
  public
    { Public declarations }
    property blnConfirma: boolean read FblnConfirma ;
    property CodigoCtaCon: String read FstrCodigoCtaCon write FstrCodigoCtaCon ;
    property strEmpLan: string read FstrEmpLan write FstrEmpLan;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untTypesSistema, untFuncoesSimples, Contabilidade.Consultas, Contabilidade.Funcoes,
     Contabilidade.Classes.TSaldoContasControladas ;

{$R *.dfm}

procedure TfrmSaldoContasControladasAltera.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if not fValidaValoresInformados then
  begin
    exit ;
  end;

  FblnConfirma := True ;
  close ;
end;

procedure TfrmSaldoContasControladasAltera.edtSAL_AJLUCRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pHabilitaNaturezaAjuste(TcxCheckBox(Sender).Checked) ;
end;

procedure TfrmSaldoContasControladasAltera.edtSAL_HISPADKeyPress(
  Sender: TObject; var Key: Char);
var
  arrHisPad : TConsultasArray;
begin
  inherited;
  If fPesqHistoricoPadrao(Self, edtSAL_HISPAD, edtSAL_DESPAD, Nil, Key, arrHisPad, True, FstrEmpLan) Then
  Begin
    If fValidaCampos(edtSAL_HISPAD, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSaldoContasControladasAltera.edtSAL_NATAJUKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCons: TConsultasArray;
begin
  inherited;
  If fPesqNaturezaDosAjustes(Self, edtSAL_NATAJU, edtNAT_DESCRI, Nil, Key, arrCons) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSaldoContasControladasAltera.FormCreate(Sender: TObject);
begin
  inherited;
  FblnConfirma := False ;
  edtSAL_DTALAN.Date := VS_Date ;
end;

procedure TfrmSaldoContasControladasAltera.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaNaturezaAjuste(edtSAL_AJLUCR.Checked) ;
  pCarregaDados ;
end;

function TfrmSaldoContasControladasAltera.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtSAL_NATAJU) Then
    Begin
      Result := fValidaNaturezaAjustes(edtSAL_NATAJU, edtNAT_DESCRI, '');
    End
    else if (Sender = edtSAL_HISPAD) then
    begin
      result := fValidaHistoricoPadrao(edtSAL_HISPAD, edtSAL_DESPAD) ;
    end ;
  End ;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmSaldoContasControladasAltera.fValidaHistoricoPadrao(edtCodigo,
  edtDscricao: TEditFocus): Boolean;
begin
  Result := True;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    edtDscricao.Text := fCarregaHistoricoPadrao(edtCodigo.Text);

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Histórico Padrão não encontrado!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    edtDscricao.Clear;
end;

function TfrmSaldoContasControladasAltera.fValidaNaturezaAjustes(edtCodigo: TEditFocus; edtDscricao: TEditFocus; ATipMov: string): Boolean;
begin
  Result := True;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    pCarregaNaturezaAjustes(edtCodigo.Text, edtDscricao, ATipMov);

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Natureza não encontrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    edtDscricao.Clear;
end;

function TfrmSaldoContasControladasAltera.fValidaValoresInformados: boolean;
begin
  result := False ;

  if fEmptyStr(edtSAL_DTALAN.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Data não informada!', ['&Ok']);
    pSetFocus(edtSAL_DTALAN);
    exit ;
  end;

  if fEmptyStr(edtSAL_HISPAD.Text) and fEmptyStr(edtSAL_HISTOR.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico Padrão/Complemento não informado!', ['&Ok']);
    pSetFocus(edtSAL_HISPAD);
    exit ;
  end;

  if edtSAL_VALLAN.Value <= 0.00 then
  begin
    fMensagem('ATENÇÃO!', 'Valor deve ser maior que zero!', ['&Ok']);
    pSetFocus(edtSAL_VALLAN);
    exit ;
  end;

  if edtSAL_AJLUCR.Checked then
  begin
    if fEmptyStr(edtSAL_NATAJU.Text) then
    begin
      fMensagem('ATENÇÃO!', 'Natureza do Ajuste não informado!', ['&Ok']);
      pSetFocus(edtSAL_NATAJU);
      exit ;
    end;
  end;

  if not TSaldoContasControladas.fPodeIncluirDataCtaCon(CodigoCtaCon, edtSAL_DTALAN.Date) then
  begin
    pSetFocus(edtSAL_DTALAN);
    exit ;
  end ;

  result := True ;
end;

procedure TfrmSaldoContasControladasAltera.pCarregaDados;
begin
  if not fEmptyStr(edtSAL_HISPAD.Text) then
  begin
    fValidaCampos(edtSAL_HISPAD, True) ;
  end;
  if not fEmptyStr(edtSAL_NATAJU.Text) then
  begin
    fValidaCampos(edtSAL_NATAJU, True) ;
  end;
end;

procedure TfrmSaldoContasControladasAltera.pCarregaNaturezaAjustes(strCodigo: String; edtDscricao: TEditFocus; ATipMov: string);
begin
  If Not fEmptyStr(strCodigo) Then
  begin
    if not fEmptyStr(ATipMov) then
    begin
      edtDscricao.Text := fCampoTabela('NAT_DESCRI', 'NATAJU', ['NAT_CODIGO','NAT_TIPMOV'], [strCodigo, ATipMov]) ;
    end
    else
    begin
      edtDscricao.Text := fCampoTabela('NAT_DESCRI', 'NATAJU', ['NAT_CODIGO'], [strCodigo]) ;
    end;
  end
  Else
  begin
    edtDscricao.Clear;
  end;
end;

procedure TfrmSaldoContasControladasAltera.pHabilitaNaturezaAjuste(
  const AblnHabilitar: boolean);
begin
  if not AblnHabilitar then
  begin
    edtSAL_NATAJU.Clear ;
    edtNAT_DESCRI.Clear ;
  end;

  edtSAL_NATAJU.Enabled := AblnHabilitar ;

end;

function TfrmSaldoContasControladasAltera.fCarregaHistoricoPadrao(
  const ACodigo: string): string;
begin
  result := fRetDescHistoricoPadrao(ACodigo, FstrEmpLan);
end;

end.
