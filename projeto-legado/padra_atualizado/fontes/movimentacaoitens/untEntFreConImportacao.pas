unit untEntFreConImportacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Mask, MaskEditFocus, StdCtrls, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, FilenameEditFocus,
  Uni, strUtils, untEntFreCon, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFramePlanoDeContasMaskEdit;

type
  TfrmEntFreConImportacao = class(TfrmPaiSimples)
    pnlTopo: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    mskDtaEnt: TMaskEditFocus;
    mskConPag: TMaskEditFocus;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    Label30: TLabel;
    Label1: TLabel;
    Panel2: TPanel;
    memErr: TMemo;
    memLog: TMemo;
    Panel1: TPanel;
    lblCliFor: TLabel;
    edtCodTra: TEditFocus;
    edtDesTra: TEditFocus;
    btnConfirma: TBitBtnLocked;
    flnArqTxt: TFilenameEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadFor: TUniQuery;
    qryConPor: TUniQuery;
    qryCadCta: TUniQuery;

    objFreCon: TFreCon;

    procedure pEscondePortador;
    procedure pCarregaCentroCusto;
    procedure pLimpaCampos;

  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;  
  end;

var
  frmEntFreConImportacao: TfrmEntFreConImportacao;

implementation

uses untPai, untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema;

{$R *.dfm}

procedure TfrmEntFreConImportacao.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadFor := fCriaQuery(Self);
  qryConPor := fCriaQuery(Self);
  qryCadCta := fCriaQuery(Self);

  mskDtaEnt.Text := DateToStr(VS_Date);
  flnArqTxt.Text := 'C:\';
  mskConPag.Text := '01000';

  pEscondePortador;

  objFreCon := TFreCon.Create(Self);

  flnArqTxt.Dialog.Dialog.Filter := 'Todos Arquivos Suportados|*.txt;*.xml|Aquivos de Texto (*.txt' +
                                    ')|*.txt|XML (*.xml)|*.xml|Todos Arquivos (*.*)|*.*';
end;

procedure TfrmEntFreConImportacao.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodPor) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntFreConImportacao.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;

Begin

  If fPesqFornecedor(conForSimples, Self, edtCodTra, edtDesTra, nil, Key, arrFornec) Then
  Begin

    If fValidaCampos(edtCodTra,True) Then
      Self.SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmEntFreConImportacao.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;

begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.mskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    begin
      if fValidaCampos(fraPlanoDeContas.mskCodCta) then
        SelectNext(ActiveControl, True, True);
    end;
  End
  Else
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.mskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, edtCodTra.Text) Then
    begin
      if fValidaCampos(fraPlanoDeContas.mskCodCta) then
        SelectNext(ActiveControl, True, True);
    end;
  End;

end;

function TfrmEntFreConImportacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodTra) Then
    Begin
      If fEmptyStr(edtCodTra.Text) Then
      Begin
        fMensagem('','O código da Transportadora deve ser informado !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesTra.Text := fRetNomFornecedor(edtCodTra.Text);
        If fEmptyStr(edtDesTra.Text) Then
        Begin
          fMensagem('','Código da transportadora incorreto !',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodPor) And (edtCodPor.Visible) Then
    Begin
      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('','O código do portador deve ser informado !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
        If fEmptyStr(edtNomPor.Text) Then
        Begin
          fMensagem('','Código do Portador incorreto !',['&O K']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.mskCodCta) Then
    Begin
      If fEmptyStr(fraPlanoDeContas.mskCodCta.Text) Then
      Begin
        fMensagem('','O código da Conta deve ser informado !',['&O K']);
        Result := False;
      End
      Else
      Begin
        If Not fCfgSis('USACTF', varBoolean) Then
           fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.mskCodCta.Text)
        Else
           pCarregaCentroCusto;
          
        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          fMensagem('','Código da Conta incorreto !',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskDtaEnt) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
      Begin
        fMensagem('','O Data de Entrada deve ser informada !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = mskConPag) Then
    Begin
      If fEmptyStr(mskConPag.Text) Then
      Begin
        fMensagem('','A condição de pagamento deve ser informada!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If Not fValidaCndPag(mskConPag.Text) Then
        Begin
          fMensagem('','Informe uma condição de pagamento válida !',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = flnArqTxt) Then
    Begin
      If fEmptyStr(flnArqTxt.Dialog.Dialog.FileName) Then
      Begin
        fMensagem('','O nome do arquivo deve ser informado !',['&O K']);
        Result := False;
      End
      Else
      Begin
        If Not FileExists(flnArqTxt.Dialog.Dialog.FileName) Then
        Begin
          fMensagem('','O arquivo informado não existe !',['&O K']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
    
end;

procedure TfrmEntFreConImportacao.btnConfirmaClick(Sender: TObject);
var
  blnNotaNaoIdentificada : Boolean;

begin

  inherited;
  If fVerificaCampos Then
  Begin
    Try
      objFreCon.strCodTra := edtCodTra.Text;
      objFreCon.strCodOpe := strLoginUsuarioLogado;
      objFreCon.strPorBai := edtCodPor.Text;
      objFreCon.strCodCta := fraPlanoDeContas.mskCodCta.Text;
      objFreCon.strDtaEnt := mskDtaEnt.Text;
      objFreCon.strCndPag := mskConPag.Text;

      If objFreCon.fCarregaArquivoFrete(flnArqTxt.Dialog.Dialog.FileName, memLog.Lines, memErr.Lines, True, blnNotaNaoIdentificada) Then
      Begin
        pLimpaCampos;
      End;
    Except
      On E: Exception Do
  			pMensagensErro(E.Message,'[TfrmEntFreConImportacao.btnConfirmaClick]');
    End;
  End;
end;

procedure TfrmEntFreConImportacao.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, fraPlanoDeContas.mskCodCta.Text, True, edtCodTra.Text);

  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmEntFreConImportacao.pEscondePortador;
  Var
    intContador: Integer;
    Sender : TControl;
begin
  If Not fCfgSis('CTPAVI', varBoolean) Then
  Begin
    For intContador := 0 To pnlTopo.ControlCount - 1 Do
    Begin
      Sender := pnlTopo.Controls[intContador];
      If Sender.Hint = '999' Then
        Sender.Top := Sender.Top - edtCodPor.Height
      Else If Sender.Hint = '888' Then
        Sender.Visible := False;
    End;
    pnlTopo.Height := pnlTopo.Height - edtCodPor.Height;
    Self.Height    := Self.Height - edtCodPor.Height;
  End;
end;

procedure TfrmEntFreConImportacao.pLimpaCampos;
begin
  edtCodTra.Clear;
  edtDesTra.Clear;
  edtCodPor.Clear;
  edtNomPor.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  flnArqTxt.Clear;

  memLog.Clear;
  memErr.Clear;

  pSetFocus(edtCodTra);

end;

end.
