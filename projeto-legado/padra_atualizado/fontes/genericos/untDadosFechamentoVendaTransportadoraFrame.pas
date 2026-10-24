unit untDadosFechamentoVendaTransportadoraFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, MaskEditFocus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, ComboBoxFocus, EditFocus,
  Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaTransportadoraFrame = class(TFrame)
    pnlDados: TPanel;
    lblTransportadora: TLabel;
    lblValorDoFrete: TLabel;
    lblFretePorConta: TLabel;
    lblQuantidade: TLabel;
    lblEspecie: TLabel;
    lblMarca: TLabel;
    lblPesoBruto: TLabel;
    lblPesoLiquido: TLabel;
    lblDespAcessoria: TLabel;
    lblNumConhecimento: TLabel;
    btnCalcFreSug: TSpeedButton;
    btnCalcVolume: TSpeedButton;
    lblNumeracao: TLabel;
    lblEdiPes: TLabel;
    lblPlacaVeiculo: TLabel;
    lblValFreCot: TLabel;
    chkEst_Dv: TCheckBox;
    edtCodTra: TEditFocus;
    edtValFre: TEditFocus;
    edtQtdTra: TEditFocus;
    edtEspTra: TEditFocus;
    edtMarTra: TEditFocus;
    edtPesLiq: TEditFocus;
    edtPesBru: TEditFocus;
    edtNomTra: TEditFocus;
    edtDesAce: TEditFocus;
    edtNConhe: TEditFocus;
    chkEntUrg: TCheckBox;
    cmbTipFre: TComboBoxFocus;
    btnDespesasFaturamento: TBitBtnLocked;
    edtNumera: TEditFocus;
    mskPlaFat: TMaskEditFocus;
    edtValFreCot: TEditFocus;
    pnlDadosAux: TPanel;
    pnlVolumeSepExc: TPanel;
    lblQtdTraSepExc: TLabel;
    lblQtdTraSepNExc: TLabel;
    edtQtdTraSepExc: TEditFocus;
    edtQtdTraSepNExc: TEditFocus;
    pnlTraRedesp: TPanel;
    Label21: TLabel;
    edtTraRedNom: TEditFocus;
    edtTraRedCod: TEditFocus;
    lblOutros: TLabel;
    edtOutros: TEditFocus;
    btnHlpDes: TBitBtnLocked;
    chkRetornoPorRecusa: TCheckBox;
  private
    { Private declarations }
    blnIniciandoTela: Boolean;
    procedure pOnShow;
  public
    { Public declarations }
    procedure OnFormShow;
    procedure pAdicionaElementoFreteConta(const strElemento: String);
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfraDadosFechamentoVendaTransportadoraFrame }

procedure TfraDadosFechamentoVendaTransportadoraFrame.OnFormShow;
begin
  blnIniciandoTela := True;
  Try
    pOnShow;
  Finally
    blnIniciandoTela := False;
  End;
end;

procedure TfraDadosFechamentoVendaTransportadoraFrame.pAdicionaElementoFreteConta(
  const strElemento: String);
begin
  If (Self.cmbTipFre.Items.IndexOf(strElemento) >= 0) Then
    Exit;
  Self.cmbTipFre.Items.Add(strElemento);
end;

procedure TfraDadosFechamentoVendaTransportadoraFrame.pOnShow;
begin
  pnlVolumeSepExc.Visible := fCfgSis('SEPEXC', varBoolean);
  If Not pnlVolumeSepExc.Visible Then
    Self.Height := Self.Height - pnlVolumeSepExc.Height;

  pnlTraRedesp.Visible := fCfgSis('UTTRDP', varBoolean);
  If Not pnlTraRedesp.Visible Then
    Self.Height := Self.Height - pnlTraRedesp.Height;
end;

end.
