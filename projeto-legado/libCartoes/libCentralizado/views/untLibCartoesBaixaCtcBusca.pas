unit untLibCartoesBaixaCtcBusca;

interface

uses
  Vcl.Controls, Vcl.StdCtrls, ComCtrls, Buttons, ExtCtrls, Forms,
  Vcl.AppEvnts, Vcl.Mask, Vcl.Menus, System.Classes,

  EditFocus, MaskEditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,

  untLibCartoesPaiSimples, untTLibCartoesFuncoes, untEditTipoCgcCpf,
  untPaiSimples;

type
  TfrmBaixaCtcBusca = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNumDup: TEditFocus;
    edtValor: TEditFocus;
    edtNumNSU: TEditFocus;
    mskDtaCad: TcxDateEdit;
    mskDtaVen: TcxDateEdit;
    edtNomeCliente: TEditFocus;
    Label6: TLabel;
    Label12: TLabel;
    edtSelCliCgcCpf: TEditFocus;
    mskCgcCpf: TMaskEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtSelCliCgcCpfChange(Sender: TObject);
    procedure mskCgcCpfExit(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strValorFiltro: String;
    strCampoFiltro: String;
    blnConfirma: Boolean;
  end;


implementation

{$R *.dfm}

{ TfrmBaixaCtcBusca }

function TfrmBaixaCtcBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtValor) Then
    Begin
      If Not TLibCartoesFuncoes.fEmptyStr(edtNumDup.Text) Then
      Begin
        strValorFiltro := edtNumDup.Text;
        strCampoFiltro := 'MCA_NUMCCD';
        blnConfirma    := True;
      End
      Else If Not TLibCartoesFuncoes.fEmptyStr(edtNumNSU.Text) Then
      Begin
        strValorFiltro := edtNumNSU.Text;
        strCampoFiltro := 'MCA_NUMNSU';
        blnConfirma    := True;
      End
      Else If Not TLibCartoesFuncoes.fEmptyStr(edtNomeCliente.Text) Then
      Begin
        strValorFiltro := edtNomeCliente.Text;
        strCampoFiltro := 'CLI_NOMCLI';
        blnConfirma    := True;
      End
      Else If Not TLibCartoesFuncoes.fEmptyStr(mskCgcCpf.Text) Then
      Begin
        strValorFiltro := mskCgcCpf.Text;
        strCampoFiltro := 'CLI_C_G_C_';
        blnConfirma    := True;
      End
	    Else If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaCad.Text))) Then
      Begin
        strValorFiltro := mskDtaCad.Text;
        strCampoFiltro := 'MCA_DTACAD';
        blnConfirma    := True;
      End
      Else If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaVen.Text))) Then
      Begin
        strValorFiltro := mskDtaVen.Text;
        strCampoFiltro := 'MCA_DTAVEN';
        blnConfirma    := True;
      End
      Else If Not TLibCartoesFuncoes.fEmptyStr(edtValor.Text) Then
      Begin
        strValorFiltro := edtValor.Text;
        strCampoFiltro := 'MCA_VALSTA';
        blnConfirma    := True;
      End;

      If (blnConfirma) Then
        Close;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaCtcBusca.mskCgcCpfExit(Sender: TObject);
begin
  inherited;
  if (TLibCartoesFuncoes.fTiraCaracEspeciais(mskCgcCpf.Text, True, True, True) <> '') and (not TLibCartoesFuncoes.fValidaCnpjCpf(mskCgcCpf.Text, true)) then
    psetFocus(mskCgcCpf);
end;

procedure TfrmBaixaCtcBusca.edtSelCliCgcCpfChange(Sender: TObject);
begin
  inherited;
  if (edtSelCliCgcCpf.Text = '1') then
    mskCgcCpf.EditMask := '>aa\.aaa\.aaa/aaaa-99;0;'
  else
    mskCgcCpf.EditMask := '999.999.999-99;0;';
end;

procedure TfrmBaixaCtcBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;
end;

procedure TfrmBaixaCtcBusca.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  edtSelCliCgcCpfChange(nil);
end;

end.

