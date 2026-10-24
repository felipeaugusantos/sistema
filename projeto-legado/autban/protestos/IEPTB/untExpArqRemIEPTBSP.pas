unit untExpArqRemIEPTBSP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncoesBco341, Vcl.Mask,
  DirectoryEditFocus, EditFocus, untFuncoesSimples, untFuncoes, Uni,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, untConsultas, untConstantes, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemIEPTBSP = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    Label1: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    Label2: TLabel;
    cmbBanco: TComboBox;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbBancoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemIEPTBSP: TfrmExpArqRemIEPTBSP;

implementation
uses DB, untTypesSistema;
{$R *.dfm}

procedure TfrmExpArqRemIEPTBSP.btnGerarClick(Sender: TObject);
Var
    objFuncoesBco341: TFuncoesBco341;
begin
  If Not fVerificaCampos Then
    Exit;

  If (fEmptyStr(fraPathRemessa.edtDirectory.text)) Or (Not DirectoryExists(fraPathRemessa.edtDirectory.text)) Then
  Begin
    fMensagem('Path:', 'Pasta inválida para geração do arquivo de protesto.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If (fEmptyStr(edtNomArquivo.Text)) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário digitar o nome do arquivo para geração do arquivo de protesto.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  If fMensagem('','Confirma geração do arquivo de protesto?',['&Sim','&Não']) = 2 Then
    Exit;

  If (cmbBanco.ItemIndex = 0) Then
  Begin
    objFuncoesBco341 := TFuncoesBco341.Create;
    objFuncoesBco341.blnEnvPro := True;
    objFuncoesBco341.fExpArqRem('CONFIG341-0-', edtCodPor.Text, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
    If Assigned(objFuncoesBco341) Then
      FreeAndNil(objFuncoesBco341);
  End;
end;

procedure TfrmExpArqRemIEPTBSP.cmbBancoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmExpArqRemIEPTBSP.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemIEPTBSP.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmExpArqRemIEPTBSP.FormShow(Sender: TObject);
begin
  inherited;
  edtNomArquivo.Text := 'RELATO' + FormatDateTime('yyyymmdd', VS_Date) + '.REM';
  pSetFocus(edtCodPor);
end;

function TfrmExpArqRemIEPTBSP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If Not CarregaPortador(edtCodPor.Text) Then
           Result := False
        Else
        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
