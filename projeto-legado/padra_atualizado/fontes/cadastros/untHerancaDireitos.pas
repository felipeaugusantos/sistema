unit untHerancaDireitos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, StrUtils, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmHerancaDireitos = class(TfrmPai)
    Panel1: TPanel;
    lblDo: TLabel;
    edtDesDo: TEditFocus;
    edtCodDo: TEditFocus;
    btnConfirma: TBitBtnLocked;
    lblPara: TLabel;
    edtCodPara: TEditFocus;
    edtDesPara: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodDoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodParaKeyPress(Sender: TObject; var Key: Char);
  private
    FTipDir : String;
    procedure pSetaTipoDireito;
    procedure pBuscaOperador(var Key: Char; edtCodigo, edtNome: TEditFocus);
    procedure pBuscaGrupo(var Key: Char; edtCodigo, edtNome: TEditFocus);
    function fGetTipoDireito: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnConfirma: Boolean;
    property strTipDir : String read FTipDir Write FTipDir;
  end;

var
  frmHerancaDireitos: TfrmHerancaDireitos;

implementation

uses  untFuncoesSimples, DB, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmHerancaDireitos.edtCodDoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If SameText(FTipDir, 'Operador') Then
    pBuscaOperador(Key, edtCodDo, edtDesDo)
  Else If SameText(FTipDir, 'Grupo') Then
    pBuscaGrupo(Key, edtCodDo, edtDesDo);
end;

procedure TfrmHerancaDireitos.edtCodParaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If SameText(FTipDir, 'Operador') Then
    pBuscaOperador(Key, edtCodPara, edtDesPara)
  Else If SameText(FTipDir, 'Grupo') Then
    pBuscaGrupo(Key, edtCodPara, edtDesPara);
end;

function TfrmHerancaDireitos.fGetTipoDireito: String;
begin
  Result := FTipDir;
end;

procedure TfrmHerancaDireitos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodDo);
end;

procedure TfrmHerancaDireitos.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  strTipDir := '';
end;

procedure TfrmHerancaDireitos.FormShow(Sender: TObject);
begin
  inherited;
  If fEmptyStr(FTipDir) Then
    Raise Exception.Create('O tipo requerido para esta tela não foi identificado!');

  pSetaTipoDireito;
end;

procedure TfrmHerancaDireitos.pBuscaGrupo(var Key: Char; edtCodigo, edtNome: TEditFocus);
  Var
    arrTmp : TConsultasArray;
begin
  If fPesqGrupoOperador(Self, edtCodigo, edtNome, Nil, Key, arrTmp) Then
  Begin
    If fValidaCampos(edtCodigo, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmHerancaDireitos.pBuscaOperador(var Key: Char; edtCodigo, edtNome: TEditFocus);
  Var
    arrTmp : TConsultasArray;
begin
  If fPesqOperador(Self, edtCodigo, edtNome, Nil, Key, arrTmp) then
  Begin
    If fValidaCampos(edtCodigo, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmHerancaDireitos.pSetaTipoDireito;
begin
  If SameText(FTipDir, 'Grupo') Then
  Begin
    lblDo.Caption := 'Do Grupo:';
    lblPara.Caption := 'Para o Grupo:';

    edtCodDo.MaxLength := 5;
    edtCodDo.TamCampo  := 5;
    edtCodDo.CompZeros := False;
    edtCodDo.TipoTexto := ttInteiro;

    edtCodPara.CompZeros := False;
    edtCodPara.TipoTexto := ttInteiro;
  End
  Else If SameText(FTipDir, 'Operador') Then
  Begin
    lblDo.Caption := 'Do Operador:';
    lblPara.Caption := 'Para o Operador:';

    edtCodDo.MaxLength := 3;
    edtCodDo.TamCampo  := 3;
    edtCodDo.CompZeros := True;
    edtCodDo.TipoTexto := ttAlfanumerico;

    edtCodPara.MaxLength := 3;
    edtCodPara.TamCampo  := 3;
    edtCodPara.CompZeros := True;
    edtCodPara.TipoTexto := ttAlfanumerico;
  End;
end;

procedure TfrmHerancaDireitos.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

function TfrmHerancaDireitos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodDo) Then
    Begin
      If fEmptyStr(edtCodDo.Text) Then
      Begin
        fMensagem('', 'O código do ' + fGetTipoDireito + ' de origem deve ser preenchido!', ['&OK']);
        Result := False
      End
      Else
      Begin
        If SameText(FTipDir, 'Operador') Then
          edtDesDo.Text := fRetNomeOperador(edtCodDo.Text)
        Else If SameText(FTipDir, 'Grupo') Then
          edtDesDo.Text := fRetNomCadGpo(edtCodDo.Text);

        If (fEmptyStr(edtDesDo.Text)) Then
        Begin
          fMensagem('', 'O  ' + fGetTipoDireito + ' de origem não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodPara) Then
    Begin
      If fEmptyStr(edtCodPara.Text) Then
      Begin
        fMensagem('', 'O código do ' + fGetTipoDireito + ' de destino deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If SameText(FTipDir, 'Operador') Then
          edtDesPara.Text := fRetNomeOperador(edtCodPara.Text)
        Else If SameText(FTipDir, 'Grupo') Then
          edtDesPara.Text := fRetNomCadGpo(edtCodPara.Text);

        If (fEmptyStr(edtDesPara.Text)) Then
        Begin
          fMensagem('', 'O  ' + fGetTipoDireito + ' de destino não está cadastrado!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          If SameText(edtCodDo.Text, edtCodPara.Text) Then
          Begin
            fMensagem('', 'O código do ' + fGetTipoDireito + ' de origem deve ser diferente do código do ' + fGetTipoDireito + ' destino!', ['&OK']);
            Result := False;
          End;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

End;

end.


