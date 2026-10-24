unit untConfiguracoesSherwin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  FilenameEditFocus, DirectoryEditFocus, AppEvnts, ComCtrls,
  untConfConsulta, untIConfTinta, untIConsultaTinta, MaskEditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesSherwin = class(TfrmPai)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    chkUsaShe: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    edtTraShe: TEditFocus;
    edtFatShe: TEditFocus;
    Label4: TLabel;
    edtNfmShe: TEditFocus;
    Label5: TLabel;
    chkUsaFor: TCheckBox;
    rgEmbalagem: TRadioGroup;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    edtDtaAtu: TMaskEditFocus;
    lblDtaAtu: TLabel;
    lblVersao: TLabel;
    edtVersao: TEditFocus;
    lbl1: TLabel;
    edtRegShe: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label22: TLabel;
    edtApreve: TEditFocus;
    fraTxtShe: TfraDirectoryEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
  private
    frmConfConsultaSherwin: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;
    procedure pGravaArqIni;
    { Private declarations }
    procedure pCarregaArqIni;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesSherwin: TfrmConfiguracoesSherwin;

implementation

uses  untFuncoesSimples, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracoesSherwin }

function TfrmConfiguracoesSherwin.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtTraShe) Then
    Begin
      If (fEmptyStr(edtTraShe.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraShe.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraShe.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtFatShe) Then
    Begin
      If (fEmptyStr(edtFatShe.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatShe.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtNfmShe) Then
    Begin
      If (fEmptyStr(edtNfmShe.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O próximo código para novas fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If StrToInt(edtNfmShe.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O próximo código para novas fórmulas deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = fraTxtShe) Then
    Begin
      If (fEmptyStr(fraTxtShe.edtDirectory.text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para os arquivos deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        fraTxtShe.edtDirectory.text := fGetPath(fraTxtShe.edtDirectory.text);
        If (Not DirectoryExists(fraTxtShe.edtDirectory.text)) Then
          CreateDir(fraTxtShe.edtDirectory.text);
      End;
    End

    Else If (Sender = edtDesOpe) Then
    Begin
      If fEmptyStr(edtDesOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtApreve) Then
    Begin
      If fEmptyStr(edtApreve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtApreve.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesSherwin.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA Sherwin             *}
  {**************************************MV*}
  chkUsaShe.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtTraShe.Text    := conf.fGet('TRASHE');
  edtFatShe.Text    := conf.fGet('FATSHE');
  edtNfmShe.Text    := conf.fGet('NFMSHE');
  edtRegShe.Text    := conf.fGet('REGSHE');
  fraTxtShe.edtDirectory.text    := conf.fGet('TXTSHE');
  rgEmbalagem.ItemIndex := conf.fGetInteger('SHEEMB');

  edtDtaAtu.Text := conf.fGet('DTAATU');
  edtVersao.Text := conf.fGet('VERSAO');

  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesSherwin.pGravaArqIni;
begin

  {*****************************************}
  {* GRAVA DADOS DA Sherwin               *}
  {**************************************MV*}
  conf.pSetBoolean('USATIN', chkUsaShe.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('TRASHE', edtTraShe.Text);
  conf.pSet('FATSHE', edtFatShe.Text);
  conf.pSet('REGSHE', edtRegShe.Text);
  conf.pSet('NFMSHE', edtNfmShe.Text);
  conf.pSet('TXTSHE', fraTxtShe.edtDirectory.text);
  conf.pSetInteger('SHEEMB', rgEmbalagem.ItemIndex);

  conf.pSet('DTAATU', edtDtaAtu.Text);
  conf.pSet('VERSAO', edtVersao.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaSherwin.pSalvarConfs;
end;

procedure TfrmConfiguracoesSherwin.FormCreate(Sender: TObject);
begin
  inherited;

  conf := fGetConfTinta('SHE');
  tinta := fGetConsultaTinta('SHE');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');  
  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('TRASHE', 'Trava de Preço', 'S');
  conf.pInsereCodigo('FATSHE', 'Fator da Trava', '1,00');
  conf.pInsereCodigo('NFMSHE', 'Próximo Código Nova Fórmulas', '1');
  conf.pInsereCodigo('REGSHE', 'Região', '');
  conf.pInsereCodigo('TXTSHE', 'Path para os arquivos', '');
  conf.pInsereCodigo('SHEEMB', 'Embalagem', '0');
  conf.pInsereCodigo('VERSAO', 'Versão da máquina', '');
  conf.pInsereCodigo('DTAATU', 'Data da Ultima Atualização', '');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  frmConfConsultaSherwin := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  pCarregaArqIni;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmConfiguracoesSherwin.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;
      Close;
    End;
  End;
end;

procedure TfrmConfiguracoesSherwin.ApplicationEventsMessage(
  var Msg: tagMSG; var Handled: Boolean);
begin
  inherited;
  If Msg.message = WM_KEYFIRST Then
    If Msg.wParam = 27 then
      btnSair.Click;
end;

procedure TfrmConfiguracoesSherwin.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesSherwin.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaSherwin.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesSherwin.Destroy;
begin
  if Assigned(frmConfConsultaSherwin) then FreeAndNil(frmConfConsultaSherwin);
  inherited;
end;

end.
