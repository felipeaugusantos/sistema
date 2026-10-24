unit untAltPrecoMedio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  untAlteraPrecoMedio,  untPai, frxClass, frxExportCSVTestabilidade;

type
  TfrmAltPrecoMedio = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodIte: TEditFocus;
    edtLinGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtDesUni: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    pnlPreMed: TPanel;
    Label8: TLabel;
    Label10: TLabel;
    edtPreMedAtu: TEditFocus;
    edtPreMedNov: TEditFocus;
    pnlPreUlt: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    edtPreUltAtu: TEditFocus;
    edtPreUltNov: TEditFocus;
    pnlImpUlt: TPanel;
    Label4: TLabel;
    edtUltImpAtu: TEditFocus;
    Label12: TLabel;
    edtUltImpNov: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    objAltPre: TAlteraPrecoMedio;
    intDecUni: Integer;

    procedure pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
    procedure pLimpaEdits;
    procedure pLimpaPanel(Owner: TWinControl);
    procedure pCarregaCampos;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmAltPrecoMedio: TfrmAltPrecoMedio;

implementation
uses
    untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmAltPrecoMedio.pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
  Var
    intContador: Integer;
    edtTemp: TEdit;
begin

  For intContador := 0 To Owner.ControlCount -1 Do
  Begin

    If (Owner.Controls[intContador] Is TEdit) Then
    Begin

      edtTemp := (Owner.Controls[intContador] As TEdit);
      If edtTemp.Tag = 99 Then
      Begin
        edtTemp.Enabled := blnHabilita;
      End;

    End;

  End;

end;

procedure TfrmAltPrecoMedio.pLimpaEdits;
Begin
  pHabilitaCampos(pnlCabecalho, True);
  pHabilitaCampos(pnlPreMed, False);
  pHabilitaCampos(pnlPreUlt, False);
  pHabilitaCampos(pnlImpUlt, False);

  btnConfirma.Enabled := False;

  pLimpaPanel(pnlCabecalho);
  pLimpaPanel(pnlPreMed);
  pLimpaPanel(pnlPreUlt);
  pLimpaPanel(pnlImpUlt);
  pSetFocus(edtCodIte);
End;

procedure TfrmAltPrecoMedio.pLimpaPanel(Owner: TWinControl);
  Var
    intContador: Integer;
    edtTemp: TEdit;
begin

  For intContador := 0 To Owner.ControlCount -1 Do
  Begin

    If (Owner.Controls[intContador] Is TEdit) Then
    Begin

      edtTemp := (Owner.Controls[intContador] As TEdit);
      edtTemp.Clear;

    End;

  End;
End;

procedure TfrmAltPrecoMedio.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos And fPergunta('Confirma a alteração de preços para o item ' + edtCodIte.Text + '?') Then
  Begin

    If objAltPre.fAtualizaPrecos(fStrToFloat(edtPreMedNov.Text),
                                 fStrToFloat(edtPreUltNov.Text),
                                 fStrToFloat(edtUltImpNov.Text)) Then
    Begin
      pMensagemOk('Preços atualizados com sucesso!');
      pLimpaEdits;
    End;

  End;
end;

procedure TfrmAltPrecoMedio.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltPrecoMedio.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') And
     fValidaCampos(edtCodIte, True) Then
  Begin
    pSetFocus(edtPreMedNov);
  End;

end;

procedure TfrmAltPrecoMedio.FormCreate(Sender: TObject);
begin
  inherited;

  objAltPre := TAlteraPrecoMedio.Create(Self);
  intDecUni := fCfgSis('DECUNI', varInteger);
end;

procedure TfrmAltPrecoMedio.FormShow(Sender: TObject);
begin
  inherited;

  edtPreMedAtu.EditFormat := fMskDigitos(intDecUni);
  edtPreMedNov.EditFormat := fMskDigitos(intDecUni);

  edtPreUltAtu.EditFormat := fMskDigitos(intDecUni);
  edtPreUltNov.EditFormat := fMskDigitos(intDecUni);

  edtUltImpAtu.EditFormat := fMskDigitos(intDecUni);
  edtUltImpNov.EditFormat := fMskDigitos(intDecUni);

  pLimpaEdits;

  pSetaCodIte( edtCodIte );

end;

function TfrmAltPrecoMedio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomEdt: String;
begin

  Result := True;

  strNomEdt := UpperCase(Sender.Name);

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else If Not objAltPre.fLeDados(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
        pLimpaEdits;
        Result := False;
      End;

      If Result And blnBuscaPorChave Then
      Begin
        pCarregaCampos;
        pHabilitaCampos(pnlPreMed, True);
        pHabilitaCampos(pnlPreUlt, True);
        pHabilitaCampos(pnlImpUlt, True);
        btnConfirma.Enabled := True;
      End;

    End

    Else If (Sender = edtPreMedNov) Then
    Begin

      If fStrToFloat(edtPreMedNov.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Novo Preço Médio deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtPreUltNov) Then
    Begin

      If fStrToFloat(edtPreUltNov.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Novo Preço de Última Comnpra deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtUltImpNov) Then
    Begin

      If fStrToFloat(edtUltImpNov.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Novo Preço de Última Comnpra com Impostos deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;

    End

  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End;

end;

procedure TfrmAltPrecoMedio.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlPreMed) Or
     (ActiveControl.Parent = pnlPreUlt) Or
     (ActiveControl.Parent = pnlImpUlt) Then
  Begin
    pLimpaEdits;
  End
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmAltPrecoMedio.pCarregaCampos;
Begin
  With objAltPre.qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('DESITE').AsString;
    edtLinGru.Text := FieldByName('CODGRU').AsString + ' - ' + FieldByName('DESGRU').AsString;
    edtRefere.Text := FieldByName('REFERE').AsString;
    edtDesUni.Text := FieldByName('SIGUNI').AsString;
    edtDesMar.Text := FieldByName('CODMAR').AsString + ' - ' + FieldByName('DESMAR').AsString;
    edtNomFor.Text := FieldByName('CODFOR').AsString + ' - ' + FieldByName('NOMFOR').AsString;

    edtPreMedAtu.Text := FormatFloat(fMskDigitos(intDecUni), FieldByName('PREMED').AsFloat);
    edtPreMedNov.Text := FormatFloat(fMskDigitos(intDecUni), FieldByName('PREMED').AsFloat);

    edtPreUltAtu.Text := FormatFloat(fMskDigitos(intDecUni), FieldByName('PREULT').AsFloat);
    edtPreUltNov.Text := FormatFloat(fMskDigitos(intDecUni), FieldByName('PREULT').AsFloat);

    edtUltImpAtu.Text := FormatFloat(fMskDigitos(intDecUni), FieldByName('IMPULT').AsFloat);
    edtUltImpNov.Text := FormatFloat(fMskDigitos(intDecUni), FieldByName('IMPULT').AsFloat);
  End;
End;

end.
