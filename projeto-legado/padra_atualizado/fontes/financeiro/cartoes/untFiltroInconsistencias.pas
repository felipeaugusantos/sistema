unit untFiltroInconsistencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit,
  cxGroupBox, cxCheckGroup, frxClass, frxExportCSVTestabilidade, AppEvnts,
  Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls;

type
  TfrmFiltroInconsistencias = class(TfrmPai)
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
    FExibirCartoesPendente : Boolean;
    FEsconderCartoesVlrLiqZerado : Boolean;
  public
    { Public declarations }
    blnValDif,
    blnValNEn,
    blnValRcx,
    blnValBai,
    blnLisArq,
    blnLisSem,
    blnResBan,
    blnPonVen,
    blnTaxDif: Boolean;
    intOrdena: Integer;
    blnConRed: Boolean;
    blnExCarPen: Boolean;

    property ExibirCartoesPendente: Boolean Read FExibirCartoesPendente;
    property EsconderCartoesVlrLiqZerado: Boolean Read FEsconderCartoesVlrLiqZerado default False;
  end;

implementation

Uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFiltroInconsistencias.btnImprimirClick(Sender: TObject);
begin
  inherited;

  blnValDif := chkValDif.Checked;
  blnValBai := chkCarBai.Checked;
  blnValNEn := chkRegNEn.Checked;
  blnValRcx := chkResCai.Checked;
  blnLisArq := chkLisArq.Checked;
  blnLisSem := chkLisSem.Checked;
  blnResBan := chkResBan.Checked;
  blnPonVen := chkPonVen.Checked;
  blnTaxDif := chkTaxDif.Checked;
  intOrdena := rdgOrdenar.ItemIndex;
  FExibirCartoesPendente := chkCarPen.Checked;
  FEsconderCartoesVlrLiqZerado := not chkValZer.Checked;

  Close;
  Self.ModalResult := mrOK;
end;

procedure TfrmFiltroInconsistencias.btnSairClick(Sender: TObject);
begin
  If fMensagem('ATENÇÃO', 'Tem certeza que deseja cancelar a conciliação?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  inherited;

end;

procedure TfrmFiltroInconsistencias.FormCreate(Sender: TObject);
begin
  inherited;
  blnConRed := False;
end;

procedure TfrmFiltroInconsistencias.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    btnSair.Click;
  End;

  inherited;

end;

procedure TfrmFiltroInconsistencias.FormShow(Sender: TObject);
begin
  inherited;
  chkLisSem.Visible := blnConRed;
  rdgOrdenar.Visible := blnConRed;

  If (Not blnConRed) And (Not BlnExCarPen) Then
    Height := 310;

  blnValDif := False;
  blnValNEn := False;
  blnValRcx := False;
  blnValBai := False;
  blnLisArq := False;
  blnLisSem := False;
  blnResBan := False;
  blnPonVen := False;
  blnTaxDif := False;

  chkTaxDif.Checked := (chkTaxDif.Visible);

  rdgOrdenar.Visible := (intOrdena > -1);
  If Not rdgOrdenar.Visible Then
    Height := Height - rdgOrdenar.Height
  Else
    rdgOrdenar.ItemIndex := intOrdena;

  If Not chkCarPen.Visible Then
    Self.Height := 360;
end;

end.
