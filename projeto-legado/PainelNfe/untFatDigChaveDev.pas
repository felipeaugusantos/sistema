unit untFatDigChaveDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EditFocus, frxClass,
  frxExportCSVTestabilidade, AppEvnts, Menus, Buttons, BitBtnLockedIncrem,
  ExtCtrls,
  {$IF Defined(UNIDAC)}
    Vcl.Mask,
  {$ELSE}
    Mask,
  {$IFEND}
  MaskEditFocus, ComboBoxFocus;

type
  TfrmFatDigChaveDev = class(TForm)
    pnlButtons: TPanel;
    pnlNF: TPanel;
    lblTituloNF: TLabel;
    lblObsNF: TLabel;
    edtChave: TEditFocus;
    pnlIF: TPanel;
    rdgDocVen: TRadioGroup;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNumCOO: TEditFocus;
    edtNumSer: TEditFocus;
    edtCodNSU: TEditFocus;
    Label6: TLabel;
    pnlBotoes: TPanel;
    btnSair: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlMod1A: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtSerA1: TEditFocus;
    cbbEstA1: TComboBoxFocus;
    mskDatA1: TMaskEditFocus;
    edtModA1: TEditFocus;
    edtNumA1: TEditFocus;
    Label7: TLabel;
    edtCPFA1: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure rdgDocVenClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    intHeightNF,
    intHeightIF,
    intHeightA1: Integer;

    procedure pLimpaCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  public
    { Public declarations }
    blnChaveDigitada: Boolean;
    blnCooDigitado: Boolean;
    blnNumDigitado: Boolean;
  end;

var
  frmFatDigChaveDev: TfrmFatDigChaveDev;

implementation

{$R *.dfm}

uses untUtil;

{ TfrmFatDigChaveDev }

procedure TfrmFatDigChaveDev.btnConfirmaClick(Sender: TObject);
begin
  If fValidaCampos(edtChave) And
     fValidaCampos(edtNumCOO) And
     fValidaCampos(edtNumSer) And
     fValidaCampos(edtCodNSU) And
     fValidaCampos(edtNumA1) And
     fValidaCampos(edtSerA1) And
     fValidaCampos(edtModA1) And
     fValidaCampos(edtCPFA1) And
     fValidaCampos(cbbEstA1) And
     fValidaCampos(mskDatA1) Then
  Begin
    If (rdgDocVen.ItemIndex = 1) And (Not fEmptyStr(edtNumCOO.Text)) Then
      edtNumCOO.Text := fStrZero(edtNumCOO.Text, 6);

    ModalResult := mrOk;
  End;
end;

procedure TfrmFatDigChaveDev.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFatDigChaveDev.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_RETURN Then
  Begin
    If fValidaCampos(ActiveControl) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatDigChaveDev.FormShow(Sender: TObject);
begin
  inherited;
  intHeightNF := pnlNF.Height;
  intHeightIF := pnlIF.Height;
  intHeighta1 := pnlMod1A.Height;
  rdgDocVenClick(Nil);
  SelectFirst;
end;

function TfrmFatDigChaveDev.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If pnlNF.Visible Then
  Begin
    If (Sender = edtChave) Then
    Begin
      If fEmptyStr(edtChave.Text) Then
      Begin
        pMensagemOk('Defina uma Chave da ' + IIF(rdgDocVen.ItemIndex = 0, 'NFe.', 'NFCe.'));
        Result := False;
      End
      Else
      Begin
        Result := fValidaChaveAcessoNFE(edtChave.Text);

        If Not Result Then
          pMensagemOk('A Chave da ' + IIF(rdgDocVen.ItemIndex = 0, 'NFe', 'NFCe') + ' informada é Inválida!');
      End;
    End;
  End
  Else If pnlIF.Visible Then
  Begin
    If (Sender = edtNumCOO) Then
    Begin
      If fEmptyStr(edtNumCOO.Text) Then
      Begin
        pMensagemOk('Defina um número do COO.');
        Result := False;
      End;
    End
    Else If (Sender = edtNumSer) Then
    Begin
      If fEmptyStr(edtNumSer.Text) Then
      Begin
        pMensagemOk('Defina um número de série.');
        Result := False;
      End;
    End
    Else If (Sender = edtCodNSU) Then
    Begin
      If fEmptyStr(edtCodNSU.Text) Then
      Begin
        pMensagemOk('Defina um código da ECF.');
        Result := False;
      End;
    End;
  End
  Else If pnlMod1A.Visible Then
  Begin
    If (Sender = edtNumA1) Then
    Begin
      If fEmptyStr(edtNumA1.Text) Then
      Begin
        pMensagemOk('Defina o Número.');
        Result := False;
      End;
    End
    Else If (Sender = edtSerA1) Then
    Begin
      If fEmptyStr(edtSerA1.Text) Then
      Begin
        pMensagemOk('Defina a Série.');
        Result := False;
      End;
    End
    Else If (Sender = edtModA1) Then
    Begin
      If fEmptyStr(edtModA1.Text) Then
      Begin
        pMensagemOk('Defina o Modelo.');
        Result := False;
      End;
    End
    Else If (Sender = edtCPFA1) Then
    Begin
      If fEmptyStr(edtCPFA1.Text) Then
      Begin
        pMensagemOk('Defina CPF ou CNPJ.');
        Result := False;
      End
      Else If Not fTestaCgc(edtCPFA1.Text) Then
      Begin
        pMensagemOk('CNPJ inválido!');
        Result := False;
      End
      Else
        edtCPFA1.Text := fFormataCpfCgc(edtCPFA1.Text, IIf(fCfgSis('SIGPAI', varString) = 'PAR', opcParaguai, opcBrasil));
    End
    Else If (Sender = cbbEstA1) Then
    Begin
      If fEmptyStr(cbbEstA1.Text) Then
      Begin
        pMensagemOk('Defina um Estado.');
        Result := False;
      End;
    End
    Else If (Sender = mskDatA1) Then
    Begin
      If fEmptyStr(mskDatA1.Text) Then
      Begin
        pMensagemOk('Defina o Mês e o Ano.');
        Result := False;
      End
      Else If StrToDateDef( '01/' + mskDatA1.Text, 0) = 0 Then
      Begin
        pMensagemOk('Mês e Ano inválidos.');
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigChaveDev.pLimpaCampos;
begin
  edtChave.Text := '';
  edtNumCOO.Text := '';
  edtNumSer.Text := '';
  edtCodNSU.Text := '';
  cbbEstA1.ItemIndex := -1;
  mskDatA1.Clear;
  edtCPFA1.Clear;
  edtModA1.Text := '01';
  edtSerA1.Clear;
  edtNumA1.Clear;
end;

procedure TfrmFatDigChaveDev.rdgDocVenClick(Sender: TObject);
begin
  If (Not blnChaveDigitada) And (rdgDocVen.ItemIndex In [0,2]) Then
  Begin
    rdgDocVen.ItemIndex := 1;
    pMensagemOk('Opção não disponível. Favor escolher um documento do Autcom.');
    Exit;
  End;

  If (Not blnCooDigitado) And (rdgDocVen.ItemIndex = 1) Then
  Begin
    rdgDocVen.ItemIndex := 0;
    pMensagemOk('Opção não disponível. Favor escolher um documento do Autcom.');
    Exit;
  End;

  If (Not blnNumDigitado) And (rdgDocVen.ItemIndex = 3) Then
  Begin
    rdgDocVen.ItemIndex := 0;
    pMensagemOk('Opção não disponível. Favor escolher um documento do Autcom.');
    Exit;
  End;

  pnlNF.Visible := (rdgDocVen.ItemIndex = 0) Or (rdgDocVen.ItemIndex = 2);
  pnlIF.Visible := rdgDocVen.ItemIndex = 1;
  pnlMod1A.Visible := rdgDocVen.ItemIndex = 3;

  If (rdgDocVen.ItemIndex = 0) Then
  Begin
    lblTituloNF.Caption := 'Chave NFe (Nota Fiscal à ser devolvida)';
    lblObsNF.Caption := '**Só é permitido informar somente uma chave de acesso.' + #13#10 +
                        '**A chave da NFe deve referenciar a todos os itens informados nesta devolução.';
  End
  Else If (rdgDocVen.ItemIndex = 2) Then
  Begin
    lblTituloNF.Caption := 'Chave NFCe (Cupom Fiscal à ser devolvido)';
    lblObsNF.Caption := '**Só é permitido informar somente uma chave de acesso.' + #13#10 +
                        '**A chave da NFCe deve referenciar a todos os itens informados nesta devolução.';
  End;

  If (rdgDocVen.ItemIndex = 0) Then
    Self.Caption := 'Chave NFe à ser devolvida'
  Else If (rdgDocVen.ItemIndex = 1) Then
    Self.Caption := 'Cupom Fiscal à ser devolvido'
  Else If (rdgDocVen.ItemIndex = 2) Then
    Self.Caption := 'Chave NFCe à ser devolvida'
  Else
    Self.Caption := 'Nota Fiscal Mod. A1 à ser devolvida';

  Self.Height := 38 +
                 pnlBotoes.Height +
                 pnlButtons.Height +
                 IIF(pnlNF.Visible, intHeightNF, 0) +
                 IIF(pnlIF.Visible, intHeightIF, 0) +
                 IIF(pnlMod1A.Visible, intHeightA1, 0) ;

  If Sender <> Nil Then
    pLimpaCampos;

  If pnlNF.Visible Then
    pSetFocus(edtChave)
  Else If pnlIF.Visible Then
    pSetFocus(edtNumCOO)
  Else If pnlMod1A.Visible Then
    pSetFocus(edtNumA1);

  Repaint;
end;

end.
