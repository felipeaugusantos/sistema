unit untOpcRelEstruturaIndustrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  ComboBoxFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmOpcRelEstruturaIndustrial = class(TfrmPai)
    Panel1: TPanel;
    gpbPreco: TGroupBox;
    rdbPrecoCus: TRadioButton;
    rdbSemPreco: TRadioButton;
    lblTabPreco: TLabel;
    cbTabPreco: TComboBoxFocus;
    gpbImprimir: TGroupBox;
    rdbDescricao: TRadioButton;
    rdbReferenc: TRadioButton;
    rdbPrecoVen: TRadioButton;
    chkExcel: TCheckBox;
    btnImprimir: TBitBtnLocked;
    GroupBox1: TGroupBox;
    rdbImprimiForSubSim: TRadioButton;
    rdbImprimiForSubNao: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure rdbSemPrecoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdbImprimiForSubSimClick(Sender: TObject);
    procedure rdbImprimiForSubNaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmOpcRelEstruturaIndustrial.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;
  cbTabPreco.Clear;
  For intCont := 1 To 7 Do
  Begin
    If (VS_strTabPrc[intCont] = 'S') Then
      cbTabPreco.Items.Add(IntToStr(intCont));
  End;
  cbTabPreco.ItemIndex := 0;
end;

procedure TfrmOpcRelEstruturaIndustrial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    Close;
  End;
end;

procedure TfrmOpcRelEstruturaIndustrial.FormShow(Sender: TObject);
begin
  inherited;
  rdbPrecoCus.Visible := fVerificaAcessoSistema('PIPCEST');
  chkExcel.Visible    := fCfgSis('UTIIND', varBoolean);
  pSetFocus(rdbDescricao);
end;

procedure TfrmOpcRelEstruturaIndustrial.rdbImprimiForSubNaoClick(
  Sender: TObject);
begin
  inherited;
  If rdbImprimiForSubNao.Checked Then
    chkExcel.Visible:= True;
end;

procedure TfrmOpcRelEstruturaIndustrial.rdbImprimiForSubSimClick(
  Sender: TObject);
begin
  inherited;
  If rdbImprimiForSubSim.Checked Then
    chkExcel.Visible:= False;
end;

procedure TfrmOpcRelEstruturaIndustrial.rdbSemPrecoClick(Sender: TObject);
begin
  If rdbSemPreco.Checked Or rdbPrecoCus.Checked Then
  Begin
    lblTabPreco.Visible := False;
    cbTabPreco.Visible  := False;
  End
  Else
  Begin
    lblTabPreco.Visible := True;
    cbTabPreco.Visible  := True;
  End;
end;

procedure TfrmOpcRelEstruturaIndustrial.btnImprimirClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
