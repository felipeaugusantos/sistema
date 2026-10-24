unit untFatMensagemNotaF11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

Type
  TTipoAlteracaoMensagem = (opcNenhuma, opcLibPedMen, opcLibPedObs);

type
  TfrmFatMensagemNotaF11 = class(TfrmPaiConfirma)
    edtMens01: TEditFocus;
    edtMens05: TEditFocus;
    edtMens04: TEditFocus;
    edtMens03: TEditFocus;
    edtMens02: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pAjustaTelaLibPedAltMen;
    procedure pAjustaTelaLibPedAltObs;
    procedure pAjustaTamanhoForm;
    procedure pHabilitaDesabilitaCamposMensagem(blnHabilita: Boolean);
  public
    blnConfirma: Boolean;
    opcTipoAlteraMensagem: TTipoAlteracaoMensagem;
  end;

var
  frmFatMensagemNotaF11: TfrmFatMensagemNotaF11;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMensagemNotaF11.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
end;

procedure TfrmFatMensagemNotaF11.FormCreate(Sender: TObject);
  Var
    intQtdMsg: Integer;
begin
  inherited;


  edtMens01.MaxLength := IIF(fCfgSis('QTCANF', varInteger) < fTamCampoMsgNF, fCfgSis('QTCANF', varInteger), fTamCampoMsgNF);;
  edtMens02.MaxLength := edtMens01.MaxLength;
  edtMens03.MaxLength := edtMens01.MaxLength;
  edtMens04.MaxLength := edtMens01.MaxLength;
  edtMens05.MaxLength := edtMens01.MaxLength;

  intQtdMsg := fCfgSis('QTDMSG', varInteger);

  edtMens02.Visible := intQtdMsg > 1;
  edtMens03.Visible := intQtdMsg > 2;
  edtMens04.Visible := intQtdMsg > 3;
  edtMens05.Visible := intQtdMsg > 4;

  pAjustaTamanhoForm;

  blnConfirma := False;
  opcTipoAlteraMensagem := opcNenhuma;
end;

procedure TfrmFatMensagemNotaF11.pAjustaTamanhoForm;
begin
  If Not edtMens02.Visible Then
    Height := Height - edtMens02.Height;

  If Not edtMens03.Visible Then
    Height := Height - edtMens03.Height;

  If Not edtMens04.Visible Then
    Height := Height - edtMens04.Height;

  If Not edtMens05.Visible Then
    Height := Height - edtMens05.Height;
end;

procedure TfrmFatMensagemNotaF11.FormShow(Sender: TObject);
begin
  inherited;
  case opcTipoAlteraMensagem of
    opcLibPedMen: pAjustaTelaLibPedAltMen;
    opcLibPedObs: pAjustaTelaLibPedAltObs;
  end;


  pSetFocus(edtMens01);
end;

procedure TfrmFatMensagemNotaF11.pAjustaTelaLibPedAltMen;
  Var
    intQtde: Integer;
    intCont: Integer;
begin
  pHabilitaDesabilitaCamposMensagem(False);

  intQtde := fCfgSis('QTPDOR', varInteger);

  For intCont := 1 To intQtde Do
  Begin
    If (FindComponent('edtMens0' + intCont.ToString) <> Nil) Then
    Begin
      TEditFocus(FindComponent('edtMens0' + intCont.ToString)).Visible := True;
      TEditFocus(FindComponent('edtMens0' + intCont.ToString)).MaxLength := 80;
    End;
  End;

  Height := 184;
  pAjustaTamanhoForm;
end;

procedure TfrmFatMensagemNotaF11.pHabilitaDesabilitaCamposMensagem(blnHabilita: Boolean);
begin
  edtMens05.Visible := blnHabilita;
  edtMens04.Visible := blnHabilita;
  edtMens03.Visible := blnHabilita;
  edtMens02.Visible := blnHabilita;
  edtMens01.Visible := blnHabilita;
end;

procedure TfrmFatMensagemNotaF11.pAjustaTelaLibPedAltObs;
begin
  edtMens01.MaxLength := 70;
  edtMens02.MaxLength := 70;
  edtMens03.MaxLength := 70;
  edtMens04.MaxLength := 70;

  edtMens01.Visible := True;
  edtMens02.Visible := True;
  edtMens03.Visible := True;
  edtMens04.Visible := True;
  edtMens05.Visible := False;

  Height := 184;
  Height := Height - edtMens05.Height;
end;

end.
