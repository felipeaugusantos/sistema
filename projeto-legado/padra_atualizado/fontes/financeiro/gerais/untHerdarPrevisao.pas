unit untHerdarPrevisao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, EditFocus, CurrencyEditFocus, DB, Uni, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxCurrencyEdit, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmHerdarPrevisao = class(TfrmPai)
    Panel1: TPanel;
    gpbOrigem: TGroupBox;
    gpbDestino: TGroupBox;
    edtCodEmpOrig: TEditFocus;
    lbl3: TLabel;
    edtDesEmpOrig: TEditFocus;
    Label1: TLabel;
    edtCodEmpDest: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtDesEmpDest: TEditFocus;
    edtFatorDest: TCurrencyEditFocus;
    Label4: TLabel;
    btnConfirmar: TBitBtnLocked;
    mskAnoOrig: TEditFocus;
    mskAnoDest: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodEmpOrigKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpDestKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function fValidaAno(strAno: String): Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmHerdarPrevisao: TfrmHerdarPrevisao;

implementation

uses  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmHerdarPrevisao.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if not fValidacampos(edtCodEmpOrig, True) Then
    Exit;
  if not fValidacampos(mskAnoOrig, True) Then
    Exit;
  if not fValidacampos(edtCodEmpDest, True) Then
    Exit;
  if not fValidacampos(mskAnoDest, True) Then
    Exit;
  if not fValidacampos(edtFatorDest, True) Then
    Exit;

  ModalResult := mrOk;

end;

procedure TfrmHerdarPrevisao.edtCodEmpDestKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpDest, edtDesEmpDest, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpDest) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmHerdarPrevisao.edtCodEmpOrigKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpOrig, edtDesEmpOrig, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpOrig) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmHerdarPrevisao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEmpOrig);
  edtFatorDest.Value := 1;
end;

function TfrmHerdarPrevisao.fValidaAno(strAno: String): Boolean;
VAR
  strData: String;
begin
  Try
    strData := ('01/01/' + strAno);

   If (StrToDateDef(strData, 0) <= 0) then
     Result := False
   else
    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmHerdarPrevisao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskAnoOrig) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskAnoOrig.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informar o ano de origem desejado!', ['&O k']);
        Result := False;
        pSetFocus(mskAnoOrig);
      End
      Else If (Not fValidaAno(fTiraCaracEspeciais(mskAnoOrig.Text))) or (Length(Trim(fTiraCaracEspeciais(mskAnoOrig.Text))) < 4) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um ano de origem válido!', ['&O K']);
        Result := False;
        pSetFocus(mskAnoOrig);
      End;
    End
    Else If (Sender = mskAnoDest) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskAnoDest.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informar o ano de destino desejado!', ['&O k']);
        Result := False;
        pSetFocus(mskAnoDest);
      End
      Else If (Not fValidaAno(fTiraCaracEspeciais(mskAnoDest.Text))) or (Length(Trim(fTiraCaracEspeciais(mskAnoDest.Text))) < 4) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um ano de destino válido!', ['&O K']);
        Result := False;
        pSetFocus(mskAnoDest);
      End;
    End
    Else If (Sender = edtCodEmpOrig) Then
    Begin

      If fEmptyStr(edtCodEmpOrig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa Origem deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmpOrig.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtDesEmpOrig.Text := fRetNomeEmpresaSelec(edtCodEmpOrig.Text);
          If fEmptyStr(edtDesEmpOrig.Text) Then
          Begin
            fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = edtCodEmpDest) Then
    Begin

      If fEmptyStr(edtCodEmpDest.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa Destino deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmpOrig.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtDesEmpDest.Text := fRetNomeEmpresaSelec(edtCodEmpDest.Text);
          If fEmptyStr(edtDesEmpDest.Text) Then
          Begin
            fMensagem('','Essa empresa não está cadastrada!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = edtFatorDest) Then
    Begin

      If edtFatorDest.Value <= 0 Then
      Begin
        fMensagem('','O fator aplicado aos valores deve ser maior que 0 (zero)!', ['&O K']);
        Result := False;
      End;

    End;

    If Not Result Then
      pSetFocus(Sender);

  End;

end;

end.

