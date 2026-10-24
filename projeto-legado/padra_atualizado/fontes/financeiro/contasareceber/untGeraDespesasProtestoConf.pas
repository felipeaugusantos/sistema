unit untGeraDespesasProtestoConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, QColorLabel, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxCheckBox;

type
  TfrmGeraDespesasProtestoConf = class(TfrmPaiEdit)
    Label5: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    Label1: TLabel;
    lbl1: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    btnGravar: TBitBtnLocked;
    edtDescon: TcxDateEdit;
    chbRepassa: TcxCheckBox;
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmGeraDespesasProtestoConf: TfrmGeraDespesasProtestoConf;

implementation

{$R *.dfm}

Uses untFuncoesSimples, untPai, untConsultas, untTypesSistema,
  untGeraDespesasProtesto;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}  
procedure TfrmGeraDespesasProtestoConf.edtCodPorKeyPress(Sender: TObject;
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

function TfrmGeraDespesasProtestoConf.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodVen) Then
    Begin

      If Not fEmptyStr(edtCodVen.Text) Then
      Begin
        edtDesVen.Text := fRetNomeOperador(edtCodVen.Text);

        If fEmptyStr(edtDesVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
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

procedure TfrmGeraDespesasProtestoConf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) Then
  Begin

    if (not fEmptyStr( edtDescon.Text)) and (StrToDate(edtDescon.Text) < Date )  then
    begin
      fMensagem('Atenção','Data de vencimento deve ser maior ou igual a data atual.',['&OK']);
      modalResult := mrNone;
      Action := caNone;
      exit
    end;

    If ( fEmptyStr(edtDescon.Text) ) And
       ( fEmptyStr(edtCodPor.Text) ) And
       ( fEmptyStr(edtCodVen.Text) ) Then
    begin
      // fMensagem('', 'Alteração de pelo menos 1 campo obrigatória',['&OK']);
      modalResult := mrNo;
      // Action := caNone;
    end;


    If ( Not fEmptyStr(edtDescon.Text) ) Or
       ( Not fEmptyStr(edtCodPor.Text) ) Or
       ( Not fEmptyStr(edtCodVen.Text) ) Then
    Begin
      If (Not fVerificaCampos) Or
         (fMensagem('', 'Confirma a alteração dos títulos?',[' &Sim ', ' &Não ']) = 2) Then
        Action := caNone;
    End;

  End;

end;

procedure TfrmGeraDespesasProtestoConf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnGravar.Click;
  End;

end;

procedure TfrmGeraDespesasProtestoConf.FormShow(Sender: TObject);
begin
  inherited;
  pnlInfo.Font.Color := clRed;
  pnlInfo.Caption := 'Deixando o campo em BRANCO, o campo não será alterado nas duplicatas.';

end;

procedure TfrmGeraDespesasProtestoConf.edtCodPorExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodPor.Text) Then
  Begin
    edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
  End;
end;

procedure TfrmGeraDespesasProtestoConf.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVendedor: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  if fPesqOperador(Self, edtCodVen, edtDesVen, Nil, Key, arrVendedor) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraDespesasProtestoConf.edtCodVenExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodVen.Text) Then
  Begin
    edtDesVen.Text := fRetNomeOperador(edtCodVen.Text);
  End;
end;

End.

