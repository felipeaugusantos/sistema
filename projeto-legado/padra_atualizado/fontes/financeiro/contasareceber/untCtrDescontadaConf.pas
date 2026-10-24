unit untCtrDescontadaConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, QColorLabel, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus,
  untFrameCentroCustoEditFocus, untFramePlanoDeContasMaskEdit, Data.DB;

type
  TfrmCtrDescontadaConf = class(TfrmPaiEdit)
    Label5: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    Label1: TLabel;
    edtDescon: TEditFocus;
    ColorLabel2: TColorLabel;
    btnGravar: TBitBtnLocked;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodPorExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    stlListSelecao: TStringList;

    dtsConsulta: TDataSource;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCtrDescontadaConf: TfrmCtrDescontadaConf;

implementation

{$R *.dfm}

Uses untFuncoesSimples, untPai, untConsultas, untTypesSistema, untCadCta,
     untFuncoes;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}  
procedure TfrmCtrDescontadaConf.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     edtNomPor,
                     nil,
                     Key,
                     arrSel)  then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmCtrDescontadaConf.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
  Begin
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);
  End;
end;

procedure TfrmCtrDescontadaConf.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.MskCodCta.Text);
  fraPlanoDeContas.MskCodCtaExit(Sender);

end;

procedure TfrmCtrDescontadaConf.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
    arrCentCusto: TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCtrDescontadaConf.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDescon) Then
    Begin

      If Not fEmptyStr(edtDescon.Text) Then
      Begin
        If Pos(edtDescon.Text,'SN') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe "S" para duplicata descontada ou "N" não descontada!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='P') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a pagar!',['&OK']);
          Result := False;
        End;

      End;

    End

    {***************************************}
    {* VALIDA CENTRO DE CUSTO              *}
    {************************************JU*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        If fraPlanoDeContas.MskCodCta.Text <> '0' Then
           fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.MskCodCta.Text);

        If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
          Result := False;
        End
        Else
        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Clear;
      End;
    End

    Else If (Sender = edtCodPor) Then
    Begin

      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtNomPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End

        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCtrDescontadaConf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) Then
  Begin

    If ( fEmptyStr(edtDescon.Text) ) And
       ( fEmptyStr(edtCodPor.Text) ) And
       ( fEmptyStr(fraCentroCusto.edtCodEve.Text) ) And
       ( fEmptyStr(fraPlanoDeContas.MskCodCta.Text) ) Then
    begin
      fMensagem('', 'Alteração de pelo menos 1 campo obrigatória',['&OK']);
      modalResult := mrNone;
      Action := caNone;
      Exit;
    end;


    If ( Not fEmptyStr(edtDescon.Text) ) Or
       ( Not fEmptyStr(edtCodPor.Text) ) Or
       ( Not fEmptyStr(fraCentroCusto.edtCodEve.Text) ) Or
       ( Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) ) Then
    Begin
      If (Not fVerificaCampos) Or
         (fMensagem('', 'Confirma a alteração das duplicatas?',[' &Sim ', ' &Não ']) = 2) Then
       Action := caNone;
    End;

  End;

end;

procedure TfrmCtrDescontadaConf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnGravar.Click;
  End;

end;

procedure TfrmCtrDescontadaConf.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDescon);
end;

procedure TfrmCtrDescontadaConf.btnGravarClick(Sender: TObject);
  Var
    strEmpSemAcesso: String;
begin
  If Not fEmptyStr(edtCodPor.Text) Then
  Begin
    {*REQ*145940**********RP*}
    If Not fEmpresasTemAcessoPortador(edtCodPor.Text,
                                      dtsConsulta.DataSet,
                                      'CTR_CODEMP',
                                      strEmpSemAcesso,
                                      'AUTOINCREM IN('+ fCommaText(stlListSelecao) +')') Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
      Exit;
    End;
  End;

  inherited;

end;

procedure TfrmCtrDescontadaConf.edtCodPorExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodPor.Text) Then
  Begin
    edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
  End;
end;

End.

