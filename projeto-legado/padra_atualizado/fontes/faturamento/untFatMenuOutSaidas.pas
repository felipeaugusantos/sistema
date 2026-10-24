unit untFatMenuOutSaidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatMenuOutSaidas = class(TfrmPaiConfirma)
    rdgOpcao: TRadioGroup;
    procedure rdgOpcaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strOpcDoc: String;
    blnConEqu: Boolean;
  end;


implementation

{$R *.dfm}

Uses
   untFuncoesSimples, untFuncoesDiarias;
  
procedure TfrmFatMenuOutSaidas.rdgOpcaoClick(Sender: TObject);
  Var
    strMsgTmp: String;
begin
  inherited;
  blnConEqu := False;

  If rdgOpcao.ItemIndex = 3 Then
  Begin
    strMsgTmp := '';

    If fEmptyStr(fCfgSis('ITECON', VarString)) Or fEmptyStr(fCfgSis('CLASAI', VarString)) Then
    Begin
      If fEmptyStr(fCfgSis('ITECON', VarString)) Then
        strMsgTmp := 'CFG_ITECON';

      If fEmptyStr(fCfgSis('CLASAI', VarString)) Then
      Begin
        If fEmptyStr(strMsgTmp) Then
          strMsgTmp := 'A configuração CFG_CLASAI está'
        Else
          strMsgTmp := 'As configurações ' + strMsgTmp + ', CFG_CLASAI estão';
      End
      Else
      Begin
        If Not fEmptyStr(strMsgTmp) Then
          strMsgTmp := 'A configuração ' + strMsgTmp + ' está';
      End;

      fMensagem('', strMsgTmp + ' em branco. Configure-a(s) corretamente para prosseguir com este processo!' , ['&Ok']);
      rdgOpcao.ItemIndex := 0;
      Exit;
    End;
  End;

  Case rdgOpcao.ItemIndex Of
    0: strOpcDoc := 'OU';
    1: strOpcDoc := 'OV';
    2: strOpcDoc := 'OF';
    3: Begin
      strOpcDoc := 'OU';
      blnConEqu := True;
    End;
  End;
end;

procedure TfrmFatMenuOutSaidas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult <> mrok Then
  Begin
    strOpcDoc := '';
    blnConEqu := False;
  End;
end;

procedure TfrmFatMenuOutSaidas.FormCreate(Sender: TObject);
begin
  inherited;
  strOpcDoc := 'OU';
  blnConEqu := False;
end;

procedure TfrmFatMenuOutSaidas.FormShow(Sender: TObject);
begin
  inherited;

  pGeraTransferencias;
  pGeraRequisicoesCompra;
  
  pSetFocus(rdgOpcao.Controls[0] As TWinControl);
end;

end.

