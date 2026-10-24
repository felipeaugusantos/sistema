unit untSipagFiltroInconsistencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,

  cxGraphics, cxControls, cxLookAndFeels, cxGroupBox, cxCheckGroup, frxClass,
  frxExportCSVTestabilidade, cxLookAndFeelPainters, cxContainer, cxEdit,
  BitBtnLockedIncrem,

  untLibCartoesPai, untILibCartoesFactory;

type
  TfrmSipagFiltroInconsistencias = class(TfrmPai)
    btnImprimir: TBitBtnLocked;
    pnlOpcoes: TPanel;
    chkValDif: TCheckBox;
    chkCarBai: TCheckBox;
    chkRegNEn: TCheckBox;
    chkResCai: TCheckBox;
    chkLisArq: TCheckBox;
    rdgOrdenar: TRadioGroup;
    chkResBan: TCheckBox;
    chkPonVen: TCheckBox;
    chkTaxDif: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    FValorBrutoDiferente,
    FRegistroNaoEncontrado,
    FCaixaNaoTransferidos,
    FCartoesBaixados,
    FValorTaxaDiferente,

    FExibeTotaisBandeira,
    FExibeTotaisPontoDeVenda,
    FExibeListaArquivos: Boolean;

    FOrdenacao: Integer;
  public
    { Public declarations }
    property ValorBrutoDiferente: Boolean Read FValorBrutoDiferente Default True;
    property RegistroNaoEncontrado: Boolean Read FRegistroNaoEncontrado Default True;
    property CaixaNaoTransferidos: Boolean Read FCaixaNaoTransferidos Default True;
    property CartoesBaixados: Boolean Read FCartoesBaixados Default True;

    property ExibeTotaisBandeira: Boolean Read FExibeTotaisBandeira Default True;
    property ExibeTotaisPontoDeVenda: Boolean Read FExibeTotaisPontoDeVenda Default True;
    property ExibeListaArquivos: Boolean Read FExibeListaArquivos Default True;

    property ValorTaxaDiferente: Boolean Read FValorTaxaDiferente Default False;

    property Ordenacao: Integer Read FOrdenacao Write FOrdenacao Default -1;
  end;

implementation
Uses untTSipagFuncoes;
{$R *.dfm}

procedure TfrmSipagFiltroInconsistencias.btnImprimirClick(Sender: TObject);
begin
  inherited;

  FValorBrutoDiferente := chkValDif.Checked;
  FCartoesBaixados := chkCarBai.Checked;
  FRegistroNaoEncontrado := chkRegNEn.Checked;
  FCaixaNaoTransferidos := chkResCai.Checked;
  FExibeListaArquivos := chkLisArq.Checked;
  FExibeTotaisBandeira := chkResBan.Checked;
  FExibeTotaisPontoDeVenda := chkPonVen.Checked;
  FOrdenacao := rdgOrdenar.ItemIndex;
  
  Self.Close;
  Self.ModalResult := mrOK;
end;

procedure TfrmSipagFiltroInconsistencias.btnSairClick(Sender: TObject);
begin
  If TSipagFuncoes.fMensagem('ATENÇÃO', 'Tem certeza que deseja cancelar a conciliação?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  inherited;

end;

procedure TfrmSipagFiltroInconsistencias.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    btnSair.Click;
  End;

  inherited;

end;

procedure TfrmSipagFiltroInconsistencias.FormShow(Sender: TObject);
begin
  inherited;
  rdgOrdenar.Visible := True;

  FValorBrutoDiferente := False;
  FRegistroNaoEncontrado := False;
  FCaixaNaoTransferidos := False;
  FCartoesBaixados := False;
  FExibeListaArquivos := False;
  FExibeTotaisBandeira := False;
  FExibeTotaisPontoDeVenda := False;

  chkTaxDif.Checked := chkTaxDif.Visible;

  rdgOrdenar.Visible := (FOrdenacao > -1);
  If Not rdgOrdenar.Visible Then
    Height := Height - rdgOrdenar.Height
  Else
    rdgOrdenar.ItemIndex := FOrdenacao;
end;

end.
