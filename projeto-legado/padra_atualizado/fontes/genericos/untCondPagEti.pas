unit untCondPagEti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ExtCtrls, EditFocus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  Types, untPaiSimples,Uni, strUtils, Data.DB;

type
  TfrmCondPagEti = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    lblCondicao: TLabel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    edtCndDes: TEditFocus;
    edtCodCnd: TEditFocus;
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    fltMedPag : Double;
    strCndPag : String;

  end;


implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConPagEti }

procedure TfrmCondPagEti.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmCondPagEti.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtCodCnd, True) Then
  Begin
     blnConfirma := True;
     Close;
  End
  Else
     ModalResult := mrNone;
end;

procedure TfrmCondPagEti.edtCodCndKeyPress(Sender: TObject; var Key: Char);
Var
  arrCnd: TConsultasArray;
begin
  inherited;

  If fPesqCondicoesPgto(Self, edtCodCnd, Nil, Nil, Key, arrCnd) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCondPagEti.FormCreate(Sender: TObject);
begin
  inherited;
  qryConCnd := fCriaQuery(Self);
  blnConfirma := False;
  strQtdParcelasCondPgto := '';
  fltTaxaJuros := 0;
  fltMedPag := 0;
  strCndPag := '';
end;

procedure TfrmCondPagEti.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConCnd);
end;

procedure TfrmCondPagEti.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: btnCancelaDados.Click;
  end;
end;

procedure TfrmCondPagEti.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCnd);
end;

function TfrmCondPagEti.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmCondPagEti.pCarregaCadCnd;
begin
  Try
    qryConCnd.Close;
    qryConCnd.SQL.Clear;
    qryConCnd.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
    qryConCnd.ParamByName('CODCND').AsString := edtCodCnd.Text;
    qryConCnd.Open;

    If Not qryConCnd.Isempty Then
    Begin
      edtCndDes.Text := qryConCnd.FieldByName('CND_DESCRI').AsString;
      strQtdParcelasCondPgto := LeftStr(qryConCnd.FieldByName('CND_CNDPAG').AsString,2);
      fltTaxaJuros := qryConCnd.FieldByName('CND_TXJURO').AsFloat;
      strCndPag := qryConCnd.FieldByName('CND_CNDPAG').AsString;
      fltMedPag := fFormataFloat((fltTaxaJuros / 30) *fCalcMediaPagto(strCndPag), 2);
      strCndPag := StringReplace(FloatToStr(fltMedPag), ',', '.', []);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmDigConPagEti.pCarregaCadCnd]');
    End;
  End;

end;

end.

