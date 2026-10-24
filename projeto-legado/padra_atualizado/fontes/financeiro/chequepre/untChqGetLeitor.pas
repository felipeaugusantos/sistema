unit untChqGetLeitor;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, AppEvnts, BitBtnLockedIncrem;

type
  TfrmChqGetLeitor = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    edtCheque: TEditFocus;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure pModCheque1;
    procedure pModCheque2;
    procedure edtChequeChange(Sender: TObject);

  private
    { Private declarations }
    strCheque: String;
    protected
      function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }

  end;


implementation

uses SysUtils, StrUtils, untCadCheques, untfuncoesSimples, untPai;

{$R *.dfm}

procedure TfrmChqGetLeitor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
  Begin
    blnDigLei := False;
    edtCheque.Clear;
    strCodBan := '';
    strNumChq := '';
    strConCor := '';
    strNumAge := '';
    btnSair.Click;
  End;

end;


function TfrmChqGetLeitor.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;

begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCheque) Then
    Begin

      If fCfgSis('MODCHQ') = '1' Then
        pModCheque1
      Else
      If fCfgSis('MODCHQ') = '2' Then
        pModCheque2;

    End;
  End;


  If Not Result Then
    pSetFocus(Sender)
  Else
    btnSair.Click;

end;

procedure TfrmChqGetLeitor.pModCheque1;
  Var
    blnVerifica: Boolean;
begin
  strCheque := Trim(edtCheque.Text);
  blnVerifica := True;
    //********************************************//
    // VERIFICA SE A LEITORA DE CHEQUES RETORNOU  //
    // INFORMAÇÕES VÁLIDAS. A STRING DEVER SER    //
    // DIFERENTE DE "!" E NÃO PODE ESTA EM BRANCO //
    //*****************************************ED*//
    If (strCheque = '!') Or
       fEmptyStr(strCheque) Then
    Begin
      fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
      edtCheque.SelectAll;
      pSetFocus(edtCheque);
      blnVerifica := False;
    End;

    If blnVerifica Then
    Begin

      strCodBan := '';
      strNumChq := '';
      strConCor := '';
      strNumAge := '';

      //*************************************//
      // VERIFICA SE O PRIMEIRO CARACTER DA  //
      // STRING E IGUAL A "<" E O ÚLTIMO     //
      // CARACTER E IGUAL A "?". SE SIM      //
      // ENTAO QUER DIZER QUE A LEITURA ESTÁ //
      // CORRETA                             //
      //**********************************ED*//
      If (LeftStr(strCheque, 1) = '<') And
         (RightStr(strCheque, 1) = ':') Then
      Begin

        strCodBan := Copy(strCheque, 02, 03);
        strNumChq := Copy(strCheque, 14, 06);
        strConCor := Copy(strCheque, 25, 07);
        strNumAge := Copy(strCheque, 05, 04);

      End
      Else
      Begin
        fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
        edtCheque.SelectAll;
        pSetFocus(edtCheque);
      End;

    End;
end;

procedure TfrmChqGetLeitor.pModCheque2;
  Var
    blnVerifica: Boolean;
begin
  strCheque   := Trim(edtCheque.Text);
  blnVerifica := True;
    //********************************************//
    // VERIFICA SE A LEITORA DE CHEQUES RETORNOU  //
    // INFORMAÇÕES VÁLIDAS. A STRING DEVER SER    //
    // DIFERENTE DE "!" E NÃO PODE ESTA EM BRANCO //
    //*****************************************LB*//
    If (strCheque = '!') Or
       fEmptyStr(strCheque) Then
    Begin
      fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
      edtCheque.SelectAll;
      pSetFocus(edtCheque);
      blnVerifica := False;
    End;

    If blnVerifica Then
    Begin

      strCodBan := '';
      strNumChq := '';
      strConCor := '';
      strNumAge := '';

      //*************************************//
      // VERIFICA SE O PRIMEIRO CARACTER DA  //
      // STRING E IGUAL A "<" E O ÚLTIMO     //
      // CARACTER E IGUAL A "?". SE SIM      //
      // ENTAO QUER DIZER QUE A LEITURA ESTÁ //
      // CORRETA                             //
      //**********************************LB*//
      //If (LeftStr(strCheque, 1) = '<')  And
      //   (RightStr(strCheque, 1) = '?') Then

      If (LeftStr(strCheque, 1) = '<') And (Length(Trim(strCheque)) = 34) Then
      Begin
        strCodBan := Copy(strCheque, 02, 03);
        strNumChq := Copy(strCheque, 14, 06);
        strConCor := Copy(strCheque, 24, 09);
        strNumAge := Copy(strCheque, 05, 04);

        If fCfgSis('MODCHQ') = '2' Then
          btnSair.Click;

      End
      Else
      Begin
        fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
        edtCheque.SelectAll;
        pSetFocus(edtCheque);
      End;

    End;

end;

procedure TfrmChqGetLeitor.edtChequeChange(Sender: TObject);
begin

  If fCfgSis('MODCHQ') = '2' Then
  Begin
    If (Length(Trim(edtCheque.Text)) = 34) Then
      pModCheque2;
  End;

  inherited;

end;

end.

