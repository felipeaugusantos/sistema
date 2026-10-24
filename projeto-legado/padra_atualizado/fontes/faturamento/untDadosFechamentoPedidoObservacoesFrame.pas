unit untDadosFechamentoPedidoObservacoesFrame;

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
  TfraDadosFechamentoPedidoObservacoesFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlObservacoes: TGroupBox;
    Label1: TLabel;
    lblMenExp: TLabel;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    edtMenExp: TEditFocus;
    edtMenEx2: TEditFocus;
    edtMenEx3: TEditFocus;
    edtMenEx4: TEditFocus;
    edtMens03: TEditFocus;
    edtMens04: TEditFocus;
    edtMens05: TEditFocus;
  private
    { Private declarations }
    blnIniciandoTela: Boolean;
    procedure pOnShow;
    function  fMsgObrigatoria: Boolean;
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

uses Math, untfuncoesSimples;

{$R *.dfm}

function TfraDadosFechamentoPedidoObservacoesFrame.fConfirmaDados: Boolean;
begin
  If fMsgObrigatoria Then
    Exit(False);

  objVenda.strMen001 := edtMens01.Text;
  objVenda.strMen002 := edtMens02.Text;
  objVenda.strMen003 := edtMens03.Text;
  objVenda.strMen004 := edtMens04.Text;
  objVenda.strMen005 := edtMens05.Text;

  objVenda.strMenExp := edtMenExp.Text;
  objVenda.strMenEx2 := edtMenEx2.Text;
  objVenda.strMenEx3 := edtMenEx3.Text;
  objVenda.strMenEx4 := edtMenEx4.Text;

  Result := True;
end;

procedure TfraDadosFechamentoPedidoObservacoesFrame.OnFormCreate;
begin
  inherited;
end;

procedure TfraDadosFechamentoPedidoObservacoesFrame.OnFormDestroy;
begin
  inherited;
end;

function TfraDadosFechamentoPedidoObservacoesFrame.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Not Result Then
    pSetFocus(Sender);
end;

function TfraDadosFechamentoPedidoObservacoesFrame.fMsgObrigatoria: Boolean;
Var
  intQtdMsg,
  intQtdMin,
  intQtdCom : Integer;
  strMSG    : String;
begin

  Result := False;

  If (fCfgSis('OBRMSG') = 'S') And (Not objVenda.fEhVendaRapida(objVenda.strCodCli)) Then
  Begin

    If (edtMens01.Text = '') Or (edtMens02.Text = '') Then
    Begin
      fMensagem('ATENÇÃO!', 'Mensagem obrigatória!', ['&Ok']);
      If (edtMens01.Text = '') Then
      Begin
        pSetFocus(edtMens01);
      End
      Else
      Begin
        pSetFocus(edtMens02);
      End;
      Exit(True);
    End;

    {Quantidade mínima de caracteres}
    intQtdMsg := fCfgSis('QTPDOR', varInteger);
    intQtdMin := fCfgSis('QTDCAR', varInteger);
    strMSG    := '';

    For intQtdCom := 1 to intQtdMsg Do
      If (FindComponent('edtMens0' + intQtdCom.ToString) <> Nil) Then
        strMSG := strMSG + TEditFocus(FindComponent('edtMens0' + intQtdCom.ToString)).Text;

    strMSG := fSubstituirSequenciaDeEspacos_PorUmUnicoEspaco(strMSG);
    If (Length(strMSG) < intQtdMin) Then
    Begin
      fMensagem('ATENÇÃO!', 'Mensagem não atingiu quantidade mínima de caracteres!', ['&Ok']);
      Exit(True);
    End;

  End;

end;

procedure TfraDadosFechamentoPedidoObservacoesFrame.pOnShow;
  Var
    intContador,
    intQtdMsg,
    intDeslocaExp: Integer;
    objEdit: TObject;
begin
  inherited;

  edtMens01.Text := objVenda.strMen001;
  edtMens02.Text := objVenda.strMen002;
  edtMens03.Text := objVenda.strMen003;
  edtMens04.Text := objVenda.strMen004;
  edtMens05.Text := objVenda.strMen005;

  intDeslocaExp := 0;
  intQtdMsg :=  fCfgSis('QTPDOR', varInteger);
  Label1.Visible := intQtdMsg > 0;

  For intContador := intQtdMsg + 1 To 5 Do
  Begin
    objEdit := FindComponent('edtMens0'+IntToStr(intContador));
    TEditFocus(objEdit).Visible := False;
    TEditFocus(objEdit).Text := '';
    Self.Height := Self.Height - TEditFocus(objEdit).Height;
    intDeslocaExp := intDeslocaExp + TEditFocus(objEdit).Height;
  End;

  edtMenExp.Text := objVenda.strMenExp;
  edtMenEx2.Text := objVenda.strMenEx2;
  edtMenEx3.Text := objVenda.strMenEx3;
  edtMenEx4.Text := objVenda.strMenEx4;

  If (objVenda.strEspDoc = 'OR') And (Not fCfgSis('ORMSEX', varBoolean)) Then
  Begin
    edtMenExp.Visible := False;
    edtMenEx2.Visible := False;
    edtMenEx3.Visible := False;
    edtMenEx4.Visible := False;
    lblMenExp.Visible := False;
    Self.Height := (Self.Height - (edtMenExp.Height * 4));
  End
  Else If (objVenda.strEspDoc = 'PD') And (Not fCfgSis('NVORPD', varBoolean)) Then
  Begin
    Self.Height := (Self.Height + (edtMenExp.Height * 3));
  End;

  If (intDeslocaExp > 0) And (lblMenExp.Visible) Then
  Begin
    edtMenExp.Top := edtMenExp.Top - intDeslocaExp;
    edtMenEx2.Top := edtMenEx2.Top - intDeslocaExp;
    edtMenEx3.Top := edtMenEx3.Top - intDeslocaExp;
    edtMenEx4.Top := edtMenEx4.Top - intDeslocaExp;
    lblMenExp.Top := lblMenExp.Top - intDeslocaExp;
  End;

end;

procedure TfraDadosFechamentoPedidoObservacoesFrame.OnFormShow;
begin
  blnIniciandoTela := True;
  Try
    pOnShow;
  Finally
    blnIniciandoTela := False;
  End;
end;

end.

