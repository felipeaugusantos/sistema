unit untFatDigTabPrecoBaixaEmprestimos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, QColorLabel, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  ComboBoxFocus;

type
  TfrmFatDigTabPrecoBaixaEmprestimos = class(TfrmPai)
    btnConfirmaDados: TBitBtnLocked;
    pnlCentral: TPanel;
    lblTabPreco: TLabel;
    cbTabPreco: TComboBoxFocus;
    rdgDataTab: TRadioGroup;
    chkManPreEP: TCheckBox;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkManPreEPClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmFatDigTabPrecoBaixaEmprestimos: TfrmFatDigTabPrecoBaixaEmprestimos;

implementation

uses untFuncoesSimples, untPesqAux, untConsultas, StrUtils,
  Data.DB, untTypesSistema;

{$R *.dfm}

{ TfrmFatDigTabPrecoBaixaEmprestimos }

procedure TfrmFatDigTabPrecoBaixaEmprestimos.chkManPreEPClick(Sender: TObject);
begin
  inherited;
  rdgDataTab.Enabled := True;
  cbTabPreco.Enabled := True;

  If chkManPreEP.Checked Then
  Begin
    rdgDataTab.Enabled := False;
    cbTabPreco.Enabled := False;
    cbTabPreco.ItemIndex := -1;
  End;
end;

procedure TfrmFatDigTabPrecoBaixaEmprestimos.FormCreate(Sender: TObject);
  Var
    intcont: Integer;
begin
  inherited;
  cbTabPreco.Clear;
  For intcont := 1 To Length(VS_strTabVen) Do
    If (VS_strTabVen[intcont] = 'S') Then
      cbTabPreco.Items.Add(IntToStr(intcont));
  chkManPreEP.Checked := True;
end;

function TfrmFatDigTabPrecoBaixaEmprestimos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = cbTabPreco) And cbTabPreco.Enabled Then
  Begin
    If fEmptyStr(cbTabPreco.Text) Then
    Begin
      pMensagemOk('Selecione a tabela de preço!');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigTabPrecoBaixaEmprestimos.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

end.

