unit untLibCartoesFiltroInconsistencias;

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
  TfrmLibCartoesFiltroInconsistencias = class(TfrmPai)
    btnImprimir: TBitBtnLocked;
    pnlOpcoes: TPanel;
    chkValDif: TCheckBox;
    chkCarBai: TCheckBox;
    chkRegNEn: TCheckBox;
    chkResCai: TCheckBox;
    chkLisArq: TCheckBox;
    chkLisSem: TCheckBox;
    rdgOrdenar: TRadioGroup;
    chkResBan: TCheckBox;
    chkPonVen: TCheckBox;
    chkTaxDif: TCheckBox;
    chkCarPen: TCheckBox;
    chkValZer: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    FValorBrutoDiferente,
    FRegistroNaoEncontrado,
    FCaixaNaoTransferidos,
    FExibirCartoesPendente,
    FValorTaxaDiferente,
    FCartoesBaixados,

    FExibeTotaisBandeira,
    FExibeTotaisPontoDeVenda,
    FExibeListaArquivos,
    FExibeListaSemRegistros,

    FEsconderCartoesVlrLiqZerado: Boolean;

    FOrdenacao: Integer;
  public
    { Public declarations }

    blnConRed: Boolean;
    blnExCarPen: Boolean;

    property ValorBrutoDiferente: Boolean Read FValorBrutoDiferente Default True;
    property RegistroNaoEncontrado: Boolean Read FRegistroNaoEncontrado Default True;
    property CaixaNaoTransferidos: Boolean Read FCaixaNaoTransferidos Default True;
    property CartoesBaixados: Boolean Read FCartoesBaixados Default True;
    property ValorTaxaDiferente: Boolean Read FValorTaxaDiferente;

    property ExibeTotaisBandeira: Boolean Read FExibeTotaisBandeira Default True;
    property ExibeTotaisPontoDeVenda: Boolean Read FExibeTotaisPontoDeVenda Default True;
    property ExibeListaArquivos: Boolean Read FExibeListaArquivos Default True;
    property ExibeListaSemRegistros: Boolean Read FExibeListaSemRegistros;

    property ExibirCartoesPendente: Boolean Read FExibirCartoesPendente;
    property EsconderCartoesVlrLiqZerado: Boolean Read FEsconderCartoesVlrLiqZerado default False;

    property Ordenacao: Integer Read FOrdenacao Write FOrdenacao Default -1;
  end;

implementation
Uses untTLibCartoesFuncoes;
{$R *.dfm}

procedure TfrmLibCartoesFiltroInconsistencias.btnImprimirClick(Sender: TObject);
begin
  inherited;

  FValorBrutoDiferente := chkValDif.Checked;
  FCartoesBaixados := chkCarBai.Checked;
  FRegistroNaoEncontrado := chkRegNEn.Checked;
  FCaixaNaoTransferidos := chkResCai.Checked;
  FExibeListaArquivos := chkLisArq.Checked;
  FExibeListaSemRegistros := chkLisSem.Checked;
  FExibeTotaisBandeira := chkResBan.Checked;
  FExibeTotaisPontoDeVenda := chkPonVen.Checked;
  FValorTaxaDiferente := chkTaxDif.Checked;
  FOrdenacao := rdgOrdenar.ItemIndex;
  FExibirCartoesPendente := chkCarPen.Checked;
  FEsconderCartoesVlrLiqZerado := not chkValZer.Checked;

  Self.Close;
  Self.ModalResult := mrOK;
end;

procedure TfrmLibCartoesFiltroInconsistencias.btnSairClick(Sender: TObject);
begin
  If TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Tem certeza que deseja cancelar a conciliação?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  inherited;

end;

procedure TfrmLibCartoesFiltroInconsistencias.FormCreate(Sender: TObject);
begin
  inherited;
  blnConRed := False;
end;

procedure TfrmLibCartoesFiltroInconsistencias.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    btnSair.Click;
  End;

  inherited;

end;

procedure TfrmLibCartoesFiltroInconsistencias.FormShow(Sender: TObject);
begin
  inherited;
  chkLisSem.Visible := blnConRed;
  rdgOrdenar.Visible := blnConRed;

  If (Not blnConRed) And (Not BlnExCarPen) Then
    Height := 310;

  FValorBrutoDiferente := False;
  FRegistroNaoEncontrado := False;
  FCaixaNaoTransferidos := False;
  FCartoesBaixados := False;
  FExibeListaArquivos := False;
  FExibeListaSemRegistros := False;
  FExibeTotaisBandeira := False;
  FExibeTotaisPontoDeVenda := False;
  FValorTaxaDiferente := False;

  chkTaxDif.Checked := (chkTaxDif.Visible);

  rdgOrdenar.Visible := (FOrdenacao > -1);
  If Not rdgOrdenar.Visible Then
    Height := Height - rdgOrdenar.Height
  Else
    rdgOrdenar.ItemIndex := FOrdenacao;

  If Not chkCarPen.Visible Then
    Self.Height := 360;
end;

end.
