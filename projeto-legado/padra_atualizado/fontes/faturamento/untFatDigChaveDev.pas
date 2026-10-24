unit untFatDigChaveDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, frxClass,
  frxExportCSVTestabilidade, AppEvnts, Menus, Buttons, BitBtnLockedIncrem,
  ExtCtrls;

type
  TTipoChave = (tcDevolucao, tcReferencia);
  TTipoGenero = (tgMasculino, tgFeminino);

  TfrmFatDigChaveDev = class(TfrmPaiConfirma)
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
    lblObsIF: TLabel;
    procedure FormShow(Sender: TObject);
    procedure rdgDocVenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    intHeightNF,
    intHeightIF: Integer;

    procedure pLimpaCampos;
    function fTipoChaveDesc(const Genero: TTipoGenero): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnAtualizaForm: Boolean;
    FTipoChave: TTipoChave;
  end;

var
  frmFatDigChaveDev: TfrmFatDigChaveDev;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmFatDigChaveDev }

procedure TfrmFatDigChaveDev.FormCreate(Sender: TObject);
begin
  inherited;
  FTipoChave := tcDevolucao;
end;

procedure TfrmFatDigChaveDev.FormShow(Sender: TObject);
begin
  inherited;
  intHeightNF := pnlNF.Height;
  intHeightIF := pnlIF.Height;
  rdgDocVenClick(Nil);
  SelectFirst;
end;

function TfrmFatDigChaveDev.fTipoChaveDesc(const Genero: TTipoGenero): String;
begin
  case FTipoChave of
    tcDevolucao:
      begin
        case Genero of
          tgMasculino: Result := 'devolvido';
          tgFeminino:  Result := 'devolvida';
        end;
      end;

    tcReferencia:
      begin
        case Genero of
          tgMasculino: Result := 'referencido';
          tgFeminino:  Result := 'referencida';
        end;
      end;
  end;
end;

function TfrmFatDigChaveDev.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If pnlNF.Visible Then
    Begin
      If (Sender = edtChave) Then
      Begin
        If fEmptyStr(edtChave.Text) and (FTipoChave = tcReferencia) Then
          Result := True
        Else
        If fEmptyStr(edtChave.Text) and (FTipoChave = tcDevolucao) Then
        Begin
          fMensagem('Atenção', 'Defina uma Chave da ' + IIF(rdgDocVen.ItemIndex = 0, 'NFe.', 'NFCe.'), ['&Ok']);
          Result := False;
        End
        Else
        Begin
          Result := fValidaChaveAcessoNFE(edtChave.Text);

          If Not Result Then
            fMensagem('ATENÇÃO!', 'A Chave da ' + IIF(rdgDocVen.ItemIndex = 0, 'NFe', 'NFCe') + ' informada é Inválida!', ['&Ok']);
        End;
      End;
    End
    Else If pnlIF.Visible and (FTipoChave = tcDevolucao) Then
    Begin
      If (Sender = edtNumCOO) Then
      Begin
        If fEmptyStr(edtNumCOO.Text) Then
        Begin
          fMensagem('Atenção', 'Defina um número do COO.', ['&Ok']);
          Result := False;
        End
        Else If (Length(edtNumCOO.Text) < 6)  Then
        Begin
          fMensagem('Atenção', 'O número do COO deve ter 6 ou mais digitos!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtNumSer) Then
      Begin
        If fEmptyStr(edtNumSer.Text) Then
        Begin
          fMensagem('Atenção', 'Defina um número de série.', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtCodNSU) Then
      Begin
        If fEmptyStr(edtCodNSU.Text) Then
        Begin
          fMensagem('Atenção', 'Defina um código da ECF.', ['&Ok']);
          Result := False;
        End;
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
end;

procedure TfrmFatDigChaveDev.rdgDocVenClick(Sender: TObject);
begin
  If blnAtualizaForm Then
  Begin
    pnlNF.Visible := (rdgDocVen.ItemIndex = 0) Or (rdgDocVen.ItemIndex = 2);
    pnlIF.Visible := rdgDocVen.ItemIndex = 1;

    If (rdgDocVen.ItemIndex = 0) Then
    Begin
      lblTituloNF.Caption := 'Chave NFe (Nota Fiscal à ser ' + fTipoChaveDesc(tgFeminino) + ')';
      lblObsNF.Caption := '**Só é permitido informar somente uma chave de acesso.' + #13#10 +
                          '**A chave da NFe deve referenciar a todos os itens informados ' +
                          IIF(FTipoChave = tcDevolucao, 'nesta devolução.', 'neste documento.');
    End
    Else If (rdgDocVen.ItemIndex = 1) Then
    Begin
      lblObsIF.Caption := '**Só é permitido informar somente um Cupom de refência. **Os dados ' +
                          'acima do Cupom deve referenciar a todos os itens informados ' +
                          IIF(FTipoChave = tcDevolucao, 'nesta devolução.', 'neste documento.');
    End
    Else If (rdgDocVen.ItemIndex = 2) Then
    Begin
      lblTituloNF.Caption := 'Chave NFCe (Cupom Fiscal à ser ' + fTipoChaveDesc(tgMasculino) + ')';
      lblObsNF.Caption := '**Só é permitido informar somente uma chave de acesso.' + #13#10 +
                          '**A chave da NFCe deve referenciar a todos os itens informados ' +
                          IIF(FTipoChave = tcDevolucao, 'nesta devolução.', 'neste documento.');
    End;

    If (rdgDocVen.ItemIndex = 0) Then
      Self.Caption := 'Chave NFe à ser ' + fTipoChaveDesc(tgFeminino)
    Else If (rdgDocVen.ItemIndex = 1) Then
      Self.Caption := 'Cupom Fiscal à ser ' + fTipoChaveDesc(tgMasculino)
    Else
      Self.Caption := 'Chave NFCe à ser ' + fTipoChaveDesc(tgFeminino);

    Self.Height := 28 +
                   pnlBotoes.Height +
                   pnlStatus.Height +
                   pnlButtons.Height +
                   IIF(pnlNF.Visible, intHeightNF, 0) +
                   IIF(pnlIF.Visible, intHeightIF, 0);

    If Sender <> Nil Then
      pLimpaCampos;

    If pnlNF.Visible Then
      pSetFocus(edtChave)
    Else If pnlIF.Visible Then
      pSetFocus(edtNumCOO);

    Repaint;
  End;
end;

end.
