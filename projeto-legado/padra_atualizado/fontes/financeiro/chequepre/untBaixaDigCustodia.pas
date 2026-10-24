{***************************}
{* qryConPor -> CADPOR     *}
{************************JB*}

unit untBaixaDigCustodia;

interface

uses
  Classes, Controls, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ComboBoxFocus;

type
  TfrmBaixaDigCustodia = class(TfrmPaiSimples)
    Label2: TLabel;
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    edtDocCus: TEditFocus;
    Label1: TLabel;
    chkExportaTxt: TCheckBox;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    mskDtaRep: TcxDateEdit;
    lblBanco: TLabel;
    cbxBanco: TComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure chkExportaTxtClick(Sender: TObject);
  private
    { Private declarations }
    qryConPor: TUniQuery;

    procedure pCarregaPortador;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    blnConfirma : Boolean;
    strPorCus   : String;
    dtaDtaCad   : TDateTime;
    dtaDtaCus   : TDateTime;
    strDocCus   : String;
    blnExporta  : Boolean;
    strCodBco   : String;

  end;


implementation

uses SysUtils, Forms, untFuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmBaixaDigCustodia }

function TfrmBaixaDigCustodia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodPor) Then
    Begin
      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Portador ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(qryConPor.FieldByName('POR_CODPOR').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = mskDtaRep) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaRep.Text))) And (StrToDateDef(mskDtaRep.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data dá custódia informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else If fEmptyStr(fTiraCaracEspeciais(mskDtaRep.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data da custódia deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaRep.Text, 0) < dtaDtaCad) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de custódia deve ser maior ou igual à data de cadastro!' + #13#10 +
                              'Maior data de cadastro: ' + DateToStr(dtaDtaCad), ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtDocCus) Then
    Begin

      If fEmptyStr(edtDocCus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Documento da custódia deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = cbxBanco) Then
    Begin
      if chkExportaTxt.Checked and (cbxBanco.ItemIndex = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário selecionar um banco para exportação do arquivo!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaDigCustodia.pCarregaPortador;
begin

  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmBaixaDigCustodia.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor := fCriaQuery(Self);
end;

procedure TfrmBaixaDigCustodia.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodPor.Text) Then
    pCarregaPortador;

  If fCfgSis('ARQCUS', varBoolean) Then
  Begin
    chkExportaTxt.Visible := True;
    chkExportaTxt.Checked := True;
  end
  Else
  Begin
    chkExportaTxt.Visible := False;
    chkExportaTxt.Checked := False;
  End;
end;

procedure TfrmBaixaDigCustodia.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBaixaDigCustodia.btnConfirmaDadosClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    strPorCus   := edtCodPor.Text;
    dtaDtaCus   := StrToDate(mskDtaRep.Text);
    strDocCus   := edtDocCus.Text;
    blnExporta  := chkExportaTxt.Checked;
    Case cbxBanco.ItemIndex Of
      0: strCodBco := '001';
      1: strCodBco := '341';
      2: strCodBco := '033';
      3: strCodBco := '041';
    End;

    Close;
  End;
end;

procedure TfrmBaixaDigCustodia.chkExportaTxtClick(Sender: TObject);
begin
  inherited;
  lblBanco.Visible := chkExportaTxt.Checked;
  cbxBanco.Visible := chkExportaTxt.Checked;
end;

procedure TfrmBaixaDigCustodia.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, qryConPor, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodPor) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

end.

