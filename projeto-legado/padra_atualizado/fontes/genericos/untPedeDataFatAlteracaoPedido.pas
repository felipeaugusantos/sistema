unit untPedeDataFatAlteracaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, Vcl.Mask,
  MaskEditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmPedeDataFatAlteracaoPedido = class(TfrmPaiConfirma)
    mskDtaEntPed: TMaskEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    mmoMotivo: TMemo;
    Panel1: TPanel;
    lblFornecedor: TLabel;
    lblPedido: TLabel;
    Label3: TLabel;
    mskDataFatAtual: TMaskEditFocus;
    Label4: TLabel;
    mskDataEntrega: TMaskEditFocus;
    Panel2: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    class procedure pPedeMotivo_e_NovaDataDeFaturamento(var dtaNovaData, dtaDataEnt, dtaDataFat: TDate; var strMotivo: string; strPedido: string; strFornecedor: string; var blnAlteraItens: Boolean);
  end;

var
  frmPedeDataFatAlteracaoPedido: TfrmPedeDataFatAlteracaoPedido;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmPedeDataFatAlteracaoPedido }

procedure TfrmPedeDataFatAlteracaoPedido.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaEntPed);
end;

function TfrmPedeDataFatAlteracaoPedido.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  if (Sender = mskDtaEntPed) Then
  Begin
    If (not fEmptyDate(mskDtaEntPed.Text)) And (StrToDateDef(mskDtaEntPed.Text, 0) <= 0) Then
    Begin
      pMensagemOk('Data Inválida!');
      Result := False;
    End
    Else If fEmptyDate(mskDtaEntPed.Text) Then
    Begin
      pMensagemOk('Data deve ser informada!');
      Result := False;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);

end;

class procedure TfrmPedeDataFatAlteracaoPedido.pPedeMotivo_e_NovaDataDeFaturamento(
  var dtaNovaData, dtaDataEnt, dtaDataFat: TDate; var strMotivo: string; strPedido: string; strFornecedor: string; var blnAlteraItens: Boolean);
begin
  pCriarFormularios(TfrmPedeDataFatAlteracaoPedido, frmPedeDataFatAlteracaoPedido);
  frmPedeDataFatAlteracaoPedido.lblFornecedor.Caption := frmPedeDataFatAlteracaoPedido.lblFornecedor.Caption + strFornecedor;
  frmPedeDataFatAlteracaoPedido.lblPedido.Caption     := frmPedeDataFatAlteracaoPedido.lblPedido.Caption + strPedido;
  frmPedeDataFatAlteracaoPedido.mskDataEntrega.Text  := DateToStr(dtaDataEnt);
  frmPedeDataFatAlteracaoPedido.mskDataFatAtual.Text := DateToStr(dtaDataFat);
  Try
    blnAlteraItens := False;
    frmPedeDataFatAlteracaoPedido.ShowModal;
    If fEmptyDate(frmPedeDataFatAlteracaoPedido.mskDtaEntPed.Text) Then
      dtaNovaData := 0
    Else
    Begin
      dtaNovaData := StrToDate(frmPedeDataFatAlteracaoPedido.mskDtaEntPed.Text);
      blnAlteraItens := fMensagem('ATENÇÃO!', 'Deseja recalcular as datas de entrega dos itens?', ['&Sim', '&Não'], 2) = 1;
    End;
    strMotivo      := frmPedeDataFatAlteracaoPedido.mmoMotivo.Text;
  Finally
    FreeAndNil(frmPedeDataFatAlteracaoPedido);
  End;
end;

end.




