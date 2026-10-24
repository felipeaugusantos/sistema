unit untDadosContaPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untFrameCtaPagar, EditFocus, ContaPagar.TFrameCtaPagar, Uni,
  untFuncoesSimples, untTypesSistema, untConsultas, untPesqAux;

type
  TfrmDadosContaPagar = class(TfrmPai)
    btnConfirmaDados: TBitBtnLocked;
    pnlPortador: TPanel;
    Label31: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    fraCtaPagar: TfraCtaPagar;
    pnlFornecedor: TPanel;
    lblFornecedor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraCtaPagaredtCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraCtaPagaredtCodEveKeyPress(Sender: TObject; var Key: Char);
  private
    qryConFor: TUniQuery;
    qryConPor: TUniQuery;

    FMemHis     : String;
    FForm :TForm;
    objFrameCtaPagar: TFrameContaPagar;

    procedure pCarregaFornecedor;
    procedure pCarregaPortador;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    FCodFor : String;
    FCodCta : String;
    FCodPor : String;
    FTipTri : String;

    FGnrePE : Boolean; // Chamada da untGNREPernambucoWS
    blnConfirma: Boolean;
    property strMemHis  : String read FMemHis write FMemHis;
    property objForm    : TForm  read FForm   write FForm;
    procedure CarregarDados;
  end;

var
  frmDadosContaPagar: TfrmDadosContaPagar;

implementation

{$R *.dfm}

{ TfrmDadosContaPagar }

procedure TfrmDadosContaPagar.CarregarDados;
  Var
    Key : Char;
begin
  Key:= #13;

  If FGnrePE Then
  Begin
    Try
      Self.Caption := 'GNRE PE - Exportação de Saída';
      fraCtaPagar.InicializaObjetoFrameContaPagar;
      fraCtaPagar.objFrameCtaPagar.pCarregaGuiasETributos(False,'7');

      fraCtaPagar.edtTipDoc.Text := '2';
      fraCtaPagar.objFrameCtaPagar.pValidaGuiaTributo;
       fraCtaPagar.edtTipDoc.Enabled := False;

      fraCtaPagar.LcbGuiaTributo.KeyValue := 7;
      fraCtaPagar.objFrameCtaPagar.pChamaEventoSairComponenteGuiaTributo;
      fraCtaPagar.LcbGuiaTributo.Enabled := False;

      fraCtaPagar.LcbTipoTributo.KeyValue := FTipTri;
      fraCtaPagar.LcbTipoTributo.Enabled  := False;

      edtCodFor.Text := FCodFor;
      edtCodForExit(edtCodFor);
      edtCodFor.Enabled := False;

      edtCodPor.Text := FCodPor;
      edtCodPorExit(edtCodPor);
      edtCodPor.Enabled := False;

      fraCtaPagar.edtCodCta.Text := FCodCta;
      fraCtaPagar.edtCodCtaKeyPress(fraCtaPagar.edtCodCta, Key);
      fraCtaPagar.edtCodCta.Enabled := False;

      pSetFocus(edtCodFor);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmDadosContaPagar.CarregarDados]');
      End;
    End;
  End;

end;

procedure TfrmDadosContaPagar.edtCodForExit(Sender: TObject);
begin
  inherited;
  If Not(fEmptyStr(edtCodFor.Text)) Then
    pCarregaFornecedor;
end;

procedure TfrmDadosContaPagar.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

  If (Key = #13) And Not FGnrePE Then
  Begin
    If fraCtaPagar.edtTipDoc.Enabled Then
      pSetFocus(fraCtaPagar.edtTipDoc)
    Else
      pSetFocus(fraCtaPagar.edtVeiobo);
  End;

end;

procedure TfrmDadosContaPagar.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If Not(fEmptyStr(edtCodPor.Text)) Then
    pCarregaPortador;
end;

procedure TfrmDadosContaPagar.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
    If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrSel) then
      Self.SelectNext(ActiveControl, True, True);

  If (Key = #13) And Not FGnrePE Then
  Begin
    If pnlFornecedor.Visible Then
      pSetFocus(EdtCodFor)
    Else
    If fraCtaPagar.edtTipDoc.Enabled Then
      pSetFocus(fraCtaPagar.edtTipDoc);
  End;
end;

procedure TfrmDadosContaPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = mrOk Then
  Begin
    If Not fraCtaPagar.fValidaCampos(Nil, False, True) Then
    Begin
      Action := caNone;
      Exit;
    End;

    If Not fVerificaCampos Then
    Begin
      Action := caNone;
      Exit;
    End;

    blnConfirma := True;
  End;

  If FMemHis <> fraCtaPagar.MemHisto.Text then
    FMemHis := fraCtaPagar.MemHisto.Text;
end;

procedure TfrmDadosContaPagar.FormCreate(Sender: TObject);
begin
  inherited;
  objFrameCtaPagar:= TFrameContaPagar.Create;
  fraCtaPagar.objFrameCtaPagar := objFrameCtaPagar;
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConPor := fCriaQuery(Self);
  blnConfirma := False;
  FMemHis     := '';
  edtCodFor.Text:= fCfgSis('FORPGR');
  pCarregaFornecedor;
end;

procedure TfrmDadosContaPagar.FormShow(Sender: TObject);
begin
  inherited;

  fraCtaPagar.objForm       := objForm;

  If Not FGnrePE Then
  Begin
    fraCtaPagar.objFrameCtaPagar.blnHabilitaTipoDocumento := False;

    If (Length(edtCodFor.Text) < edtCodFor.MaxLength) Then
      edtCodFor.Text:= fStrZero(edtCodFor.Text, edtCodFor.MaxLength);

    fraCtaPagar.strCodFor     := edtCodFor.Text;
    pCarregaFornecedor;
    pCarregaPortador;

    fraCtaPagar.InicializaObjetoFrameContaPagar;
    fraCtaPagar.MemHisto.Lines.Add(FMemHis);

    If edtCodPor.Enabled Then
      pSetFocus(edtCodPor);
  End;
end;

procedure TfrmDadosContaPagar.fraCtaPagaredtCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraCtaPagar.edtCodCtaKeyPress(Sender, Key);

end;

function TfrmDadosContaPagar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodFor) Then
  Begin

    If (fEmptyStr(edtCodFor.Text)) Then
    Begin
      fMensagem('', 'O fornecedor deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaFornecedor;
      If (qryConFor.FieldByName('FOR_CODFOR').IsNull) Then
      Begin
        fMensagem('', 'Esse fornecedor não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If qryConFor.FieldByName('FOR_STATUS').AsString <> 'A' Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse fornecedor está inativo!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCodPor) Then
  Begin
    If not fEmptyStr(edtCodPor.Text) Then
    Begin
      edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
      If fEmptyStr(edtNomPor.Text) Then
      Begin
        pMensagemOk('Portador não econtrado!');
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('', 'Portador deve ser preenchido', ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmDadosContaPagar.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  edtNomFor.Text :=  qryConFor.FieldByName('FOR_NOMFOR').AsString;

  If FGnrePE Then
  Begin
    objFrameCtaPagar.strCodigo_Fornecedor := edtCodFor.Text;
    objFrameCtaPagar.pCarregaDadosBancariosFornecedor;
  End;
end;

procedure TfrmDadosContaPagar.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  edtNomPor.Text := qryConPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmDadosContaPagar.fraCtaPagaredtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraCtaPagar.edtCodEveKeyPress(Sender, Key);

end;

end.
