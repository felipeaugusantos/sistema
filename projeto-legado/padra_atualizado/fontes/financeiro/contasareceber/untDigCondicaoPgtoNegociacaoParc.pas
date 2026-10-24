unit untDigCondicaoPgtoNegociacaoParc;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Windows, Messages, strUtils;

type
  TfrmDigCondicaoPgtoNegociacaoParc = class(TfrmPaiSimples)
    edtCndDes: TEditFocus;
    pnlFundo: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    lblCondicao: TLabel;
    edtCodCnd: TEditFocus;
    rdgTaxas: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryConCnd: TUniQuery;
    procedure pCarregaCadCnd;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strQtdParcelasCondPgto: String;
    fltTaxaJuros,
    fltTaxaDespeAcessoria,
    fltTaxaCnd : Double;
  end;

implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmDigCondicaoPgtoNegociacaoParc }

function TfrmDigCondicaoPgtoNegociacaoParc.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCnd) And (edtCodCnd.Enabled) Then
    Begin
      If fEmptyStr(edtCodCnd.Text) Then
      Begin
         fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
         Result := False;
      End
      Else
      Begin

        pCarregaCadCnd;
        If (qryConCnd.IsEmpty) Then
        Begin
           fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&Ok']);
           Result := False;
        End;

      End;
    End;

  End;

  If Not Result Then
  Begin
     pSetFocus(Sender);
     if Sender is TEditFocus then
       (Sender as TEditFocus).SelectAll;
  End;

end;

procedure TfrmDigCondicaoPgtoNegociacaoParc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(qryConCnd) Then
     FreeAndNil(qryConCnd);
end;

procedure TfrmDigCondicaoPgtoNegociacaoParc.FormCreate(Sender: TObject);
begin
  inherited;

  qryConCnd := fCriaQuery(Self);

end;

procedure TfrmDigCondicaoPgtoNegociacaoParc.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: btnCancelaDados.Click;
  end;

end;

procedure TfrmDigCondicaoPgtoNegociacaoParc.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCnd);
end;

procedure TfrmDigCondicaoPgtoNegociacaoParc.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmDigCondicaoPgtoNegociacaoParc.btnConfirmaDadosClick(Sender: TObject);
begin
  If fValidaCampos(edtCodCnd, True) Then
  Begin
     blnConfirma := True;
     Close;
  End
  Else
     ModalResult := mrNone;
end;

procedure TfrmDigCondicaoPgtoNegociacaoParc.edtCodCndKeyPress(Sender: TObject; var Key: Char);
 Var
     arrCnd: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE COND. PGTO *}
  {****************************RV*}
  If fPesqCondicoesPgto(Self, edtCodCnd, Nil, Nil, Key, arrCnd) Then
  Begin
     If fValidaCampos(edtCodCnd, True) Then
        SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigCondicaoPgtoNegociacaoParc.pCarregaCadCnd;
begin

  Try
    qryConCnd.SQL.Clear;
    qryConCnd.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
    qryConCnd.ParamByName('CODCND').AsString := edtCodCnd.Text;
    qryConCnd.Open;

    If Not qryConCnd.Isempty Then
    Begin

       edtCndDes.Text         := qryConCnd.FieldByName('CND_DESCRI').AsString;
       strQtdParcelasCondPgto := LeftStr(qryConCnd.FieldByName('CND_CNDPAG').AsString,2);
       fltTaxaJuros           := qryConCnd.FieldByName('CND_TXJURO').AsFloat;
       fltTaxaDespeAcessoria  := qryConCnd.FieldByName('CND_PEDEAC').AsFloat;

       If RdgTaxas.ItemIndex = 0 Then
          fltTaxaCnd := fltTaxaJuros
       Else
          fltTaxaCnd := fltTaxaDespeAcessoria;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmDigCondicaoPgtoNegociacaoParc.pCarregaCadCnd]');
  End;

end;

end.

