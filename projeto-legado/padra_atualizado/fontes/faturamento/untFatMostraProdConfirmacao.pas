unit untFatMostraProdConfirmacao;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus, AppEvnts, BitBtnLockedIncrem,
  Data.DB, frxClass, frxExportCSVTestabilidade {Qt};

type
  TfrmFatMostraProdConfirmacao = class(TfrmPaiSimples)
    dbgItens: TDBGridCitel;
    pnlTotais: TPanel;
    Label32: TLabel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    lblTotGer: TLabel;
    Label3: TLabel;
    edtTotGer: TEditFocus;
    edtDesEsp: TEditFocus;
    edtTotLiq: TEditFocus;
    lblTotSer: TLabel;
    edtTotSer: TEditFocus;
    btnConfirma: TBitBtnLocked;
    lblValFre: TLabel;
    edtValFre: TEditFocus;
    lblTotIpi: TLabel;
    edtTotIpi: TEditFocus;
    lblTotST: TLabel;
    edtTotST: TEditFocus;
    lblTotCBS: TLabel;
    lblTotIBS: TLabel;
    lblTotIS: TLabel;
    edtTotCBS: TEditFocus;
    edtTotIBS: TEditFocus;
    edtTotIS: TEditFocus;
    procedure btnFecharClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FblnNovosImpostosAlimentados: Boolean;
    procedure pAjustarNovosImpostos;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnExibeFrete: Boolean;
    procedure pExibirNovosImpostos(const AValorCBS, AValorIBS, AValorIS: Double);
  end;


implementation

uses  untfuncoesSimples;

{$R *.dfm}

procedure TfrmFatMostraProdConfirmacao.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraProdConfirmacao.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    btnFechar.Click;
end;

procedure TfrmFatMostraProdConfirmacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not btnConfirma.Visible) Then
    Exit;

  If fMensagem('', 'Confirma Itens?', ['&Sim', '&Não']) = 1 Then
  Begin
    blnConfirma := True;
    Close;
  End;
  
end;

procedure TfrmFatMostraProdConfirmacao.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
  blnExibeFrete := False;
  FblnNovosImpostosAlimentados := False;

  If (Not fCfgSis('USASER', varBoolean)) Then
  Begin
    lblTotSer.Visible := False;
    edtTotSer.Visible := False;
  End;

end;

procedure TfrmFatMostraProdConfirmacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End;
end;

procedure TfrmFatMostraProdConfirmacao.FormShow(Sender: TObject);
begin
  inherited;
  If Not blnExibeFrete Then
  Begin
    lblValFre.Visible := False;
    edtValFre.Visible := False;

    edtTotSer.Left := edtTotGer.Left;
    lblTotSer.Left := edtTotSer.Left - lblTotSer.Width -1;

    edtTotGer.Left := edtValFre.Left;
    lblTotGer.Left := edtTotGer.Left - lblTotGer.Width -1;

    edtTotIPI.Left := edtTotGer.Left;
    lblTotIPI.Left := edtTotIPI.Left - lblTotIPI.Width -1;

    edtTotST.Left := edtDesEsp.Left;
    lblTotST.Left := edtTotST.Left - lblTotST.Width -1;

    edtTotCBS.Left := edtTotIPI.Left;
    lblTotCBS.Left := edtTotCBS.Left - lblTotCBS.Width -1;

    edtTotIBS.Left := edtTotST.Left;
    lblTotIBS.Left := edtTotIBS.Left - lblTotIBS.Width -1;

    edtTotIS.Left := edtTotLiq.Left;
    lblTotIS.Left := edtTotIS.Left - lblTotIS.Width -1;
  End;

  pAjustarNovosImpostos;
end;

procedure TfrmFatMostraProdConfirmacao.pExibirNovosImpostos(const AValorCBS, AValorIBS, AValorIS: Double);
begin
  FblnNovosImpostosAlimentados := True;
  edtTotCBS.Text := FormatFloat('#,##0.00', AValorCBS);
  edtTotIBS.Text := FormatFloat('#,##0.00', AValorIBS);
  edtTotIS.Text  := FormatFloat('#,##0.00', AValorIS);
end;

procedure TfrmFatMostraProdConfirmacao.pAjustarNovosImpostos;
  Var
    intCont: Integer;
    intAlturaLinha: Integer;
begin
  If FblnNovosImpostosAlimentados And fSomarNovosImpostosDaReformaAoValorContabil Then
    Exit;

  lblTotCBS.Visible := False;
  edtTotCBS.Visible := False;
  lblTotIBS.Visible := False;
  edtTotIBS.Visible := False;
  lblTotIS.Visible  := False;
  edtTotIS.Visible  := False;

  // Recolhe a linha dos novos impostos, que fica no topo do painel
  intAlturaLinha := edtTotIpi.Top - edtTotCBS.Top;
  For intCont := 0 To pnlTotais.ControlCount - 1 Do
    pnlTotais.Controls[intCont].Top := pnlTotais.Controls[intCont].Top - intAlturaLinha;
  pnlTotais.Height := pnlTotais.Height - intAlturaLinha;
end;

end.

