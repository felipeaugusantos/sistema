unit untRcxInfChqVista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Mask, MaskEditFocus, EditFocus,
  untFuncoesGenerica, Uni;

type
  TfrmRcxInfChqVista = class(TfrmPai)
    Panel1: TPanel;
    edtChqDep: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPortador: TEditFocus;
    edtDesCta: TEditFocus;
    mskCodCta: TMaskEditFocus;
    Label22: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    qryConCta: TUniQuery;

    procedure pCarregaCentroCusto;
    procedure pCarregaPortador;
  public
    { Public declarations }
    strDepos    : String;
    strPorDep   : String;
    strCtaDep   : String;    
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRcxInfChqVista: TfrmRcxInfChqVista;

implementation

uses untPesqAux, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmRcxInfChqVista.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  Close;

  ModalResult := mrOk; 

end;

procedure TfrmRcxInfChqVista.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPortador: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, nil, Key, arrPortador) Then
      If fValidaCampos(edtCodPor) Then
        SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmRcxInfChqVista.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = mrOk Then
  Begin
    strDepos  := edtChqDep.Text;
    strPorDep := edtCodPor.Text;
    strCtaDep := fTiraCaracEspeciais(mskCodCta.Text);
  End;

  FreeAndNil(qryConCta);
  FreeAndNil(qryConPor);

end;

procedure TfrmRcxInfChqVista.FormCreate(Sender: TObject);
begin
  inherited;

  qryConCta := fCriaQuery;
  qryConPor := fCriaQuery;

  If fCfgSis('RCXTCC') = '2' Then
  Begin
    edtChqDep.Visible := False;
    Label2.Visible := False;
  End;

end;

procedure TfrmRcxInfChqVista.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtChqDep);

end;

function TfrmRcxInfChqVista.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Sender = edtChqDep Then
  Begin
    If fEmptyStr(edtChqDep.Text) Then
    Begin
      fMensagem('', 'O campo Cheque a vista depositado deve ser preenchido!', ['&O K']);
      Result := False;
    End
    Else If Pos(edtChqDep.Text, 'N_S_') <= 0 Then
    Begin
      fMensagem('', 'O campo Cheque a vista depositado deve ser S ou N!', ['&O K']);
      Result := False;
    End
    Else
    Begin
      edtCodPor.Enabled := edtChqDep.Text = 'S';
      mskCodCta.Enabled := edtChqDep.Text = 'S';
    End;
  End

  Else If (Sender = edtCodPor) Then
  Begin
    If (fEmptyStr(edtCodPor.Text)) Then
    Begin
      fMensagem('','O campo Portador deve ser preenchido!', ['&O K']);
      edtDesPortador.Clear;
      Result := False;

    End
    Else
    Begin
      pCarregaPortador;
      If (qryConPor.FieldByName('POR_CODPOR').IsNull) Then
      Begin
        fMensagem('', 'Portador não está cadastrado!', ['&O K']);
        Result := False;
      End
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso ao lançamentos deste portador!', ['&O K']);
          Result := False;
        End;
      End;
    End;
  End

  Else If (Sender = mskCodCta) Then
  Begin
    If mskCodCta.Enabled Then
    Begin
      If Not fEmptyStr(mskCodCta.Text) Then
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('', 'Esse Plano de Contas não está cadastrado!', ['&O K']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('', 'O campo Plano de Contas deve ser preenchido!', ['&O K']);
        edtDesCta.Clear;
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRcxInfChqVista.mskCodCtaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCentCusto: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    If fPesqCentroCusto(Self, mskCodCta, edtDesCta, nil, Key, arrCentCusto) Then
    Begin
      Key := #0;
      If fValidaCampos(mskCodCta, True) Then
        SelectNext(ActiveControl, True, True);

    End;
  End;

end;

procedure TfrmRcxInfChqVista.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtDesPortador.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmRcxInfChqVista.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, mskCodCta.Text);
  With qryConCta Do
  Begin
    edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

end.
