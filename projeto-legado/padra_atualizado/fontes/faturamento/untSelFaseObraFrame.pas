unit untSelFaseObraFrame;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  cxHint, TypInfo, DBEditFocus, ComboBoxFocus, dxScreenTip, cxClasses,
  dxCustomHint, frxClass, frxExportCSVTestabilidade, untFuncFatTypes, untLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox;

type
  TfraSelFaseObraFrame = class(TFrame)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtCodFas: TEditFocus;
    edtDescri: TEditFocus;
    procedure edtCodFasKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    blnIniciandoTela: Boolean;
    procedure pOnShow;
  public
    { Public declarations }
    objVenda: TFatVenda;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;

    function fConfirmaDados: Boolean;
  end;


implementation

uses Math, untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfraSelFaseObraFrame.edtCodFasKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFase: TConsultasArray;
begin
  If fPesqFaseObra(GetParentForm(self) as TForm, edtCodFas, edtDescri, Nil, Key, arrFase) Then
  Begin
    If fValidaCampos(edtCodFas) Then
      SelectNext(edtCodFas, True, True);
  End;
end;

function TfraSelFaseObraFrame.fConfirmaDados: Boolean;
begin
  Result := fValidaCampos(edtCodFas);
  If Result Then
    objVenda.strFasObr := edtCodFas.Text;
end;

procedure TfraSelFaseObraFrame.OnFormCreate;
begin
  inherited;
end;

procedure TfraSelFaseObraFrame.OnFormDestroy;
begin
  inherited;
end;

function TfraSelFaseObraFrame.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodFas) Then
  Begin

    If fEmptyStr(edtCodFas.Text) Then
    Begin
      Result := False;
      edtDescri.Text := '';
      pMensagemOk('Deve ser selecionado uma Fase da Obra!');
    End

    Else
    Begin

      edtDescri.Text :=  fRetNomFaseObra(edtCodFas.Text);

      If fEmptyStr(edtDescri.Text) Then
      Begin
        Result := False;
        pMensagemOk('O código da Fase da Obra não existe!');
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfraSelFaseObraFrame.pOnShow;
begin
  inherited;
  edtCodFas.Text := objVenda.strFasObr;
  If Not fEmptyStr(edtCodFas.Text) Then
    edtDescri.Text := fRetNomFaseObra(edtCodFas.Text);
end;

procedure TfraSelFaseObraFrame.OnFormShow;
begin
  blnIniciandoTela := True;
  Try
    pOnShow;
  Finally
    blnIniciandoTela := False;
  End;
end;

end.

