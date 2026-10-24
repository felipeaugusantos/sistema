unit untCadCtaPagarSimples;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, UntConsultas, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, untTypesSistema, untFuncoes,
  MaskEditFocus, EditFocus, untfuncoesSimples, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCadCtaPagarSimples = class(TfrmPaiConfirma)
    pnlGeral: TPanel;
    lblVencimento: TLabel;
    lblPortador: TLabel;
    edtNomCta: TEditFocus;
    lblPlanoContas: TLabel;
    edtNomPor: TEditFocus;
    edtCodPor: TEditFocus;
    mskDtaVenc: TMaskEditFocus;
    edtCodCta: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    strCodEmp: string;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TfrmCadCtaPagarSimples.edtCodCtaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPlanoConta: TConsultasArray;
begin
  inherited;

  If fPesqCentroCusto(Self, edtCodCta, edtNomCta, Nil, Key, arrPlanoConta) Then
    If (fValidaCampos(edtCodCta, True)) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCtaPagarSimples.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPortador: TConsultasArray;
begin
  inherited;

  If (fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrPortador, False,
                    'Consulta de Portadores', '', False, False, strCodEmp)) Then
    If (fValidaCampos(edtCodPor)) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCtaPagarSimples.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodCta);
end;

procedure TfrmCadCtaPagarSimples.FormShow(Sender: TObject);
begin
  inherited;

  strCodEmp := fGetEmpresaLogada;
end;

function TfrmCadCtaPagarSimples.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(edtCodCta.Text)) Then
      Begin
        edtNomCta.Text := fRetNomeConta(edtCodCta.Text);
        If fEmptyStr(edtNomCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If (fRetTipoEvento(edtCodCta.Text) = 'R') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas pode ser aplicado somente às contas a receber!', ['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO', 'Informe um Plano de Contas!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = mskDtaVenc) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenc.Text)) Then
      Begin
        If (StrToDate(mskDtaVenc.Text) < Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Vencimento deve ser maior que a Data Atual!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO', 'Informe uma Data Vencimento!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
        If fEmptyStr(edtNomPor.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, strCodEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Você não tem permissão para utilizar este portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO', 'Informe um Portador!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
