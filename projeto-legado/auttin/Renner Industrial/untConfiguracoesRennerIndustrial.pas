unit untConfiguracoesRennerIndustrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, FilenameEditFocus, DirectoryEditFocus, StrUtils,
  untIConfTinta, AppEvnts, Uni, untPaiSimples, ComCtrls, untConfConsulta,
  untIConsultaTinta, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmConfiguracoesRennerIndustrial = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    chkUsaCor: TCheckBox;
    edtTraCor: TEditFocus;
    edtFatCor: TEditFocus;
    edtNfmCor: TEditFocus;
    edtMarCor: TEditFocus;
    pnlCabecalho: TPanel;
    chkUsaFor: TCheckBox;
    tbsConfCampos: TTabSheet;
    lblDtaAtu: TLabel;
    edtDtaAtu: TMaskEditFocus;
    lblVersao: TLabel;
    edtVersao: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    edtPath: TEditFocus;
    sbPath: TSpeedButton;
    dlgPath: TOpenDialog;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label63: TLabel;
    edtApreve: TEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure sbPathClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaRennerIndustrial: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesRennerIndustrial: TfrmConfiguracoesRennerIndustrial;

implementation

uses untFuncoes, untModuloCons, untFuncoesSimples,
  untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracoesRennerIndustrial }

function TfrmConfiguracoesRennerIndustrial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtPath) Then
  Begin
    If (fEmptyStr(edtPath.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtNfmCor) Then
  Begin
    If (fEmptyStr(edtNfmCor.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O próximo codigo para novas formulas deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTraCor) Then
  Begin
    If (fEmptyStr(edtTraCor.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraCor.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraCor.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatCor) Then
  Begin
    If (fEmptyStr(edtFatCor.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatCor.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtMarCor) Then
  Begin
    If (fEmptyStr(edtMarCor.Text)) Then
    Begin
      edtMarCor.Text := '0,00';
    End
    Else If fStrToFloat(edtMarCor.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A margem de lucro do colorante deve ser maior que Zero!', ['&Ok']);
      Result := False;
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
  End

end;

procedure TfrmConfiguracoesRennerIndustrial.pCarregaArqIni;
begin
  conf := fGetConfTinta('REN');

  chkUsaCor.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtPath.Text   := conf.fGet('TXTCOR');
  edtNfmCor.Text := conf.fGet('NFMCOR');
  edtTraCor.Text := conf.fGet('TRACOR');
  edtFatCor.Text := conf.fGet('FATCOR');
  edtMarCor.Text := conf.fGet('MARCOR');

  edtDtaAtu.Text := conf.fGet('DTAATU');
  edtVersao.Text := conf.fGet('VERSAO');

  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');

end;

procedure TfrmConfiguracoesRennerIndustrial.pGravaArqIni;
begin
  conf.pSetBoolean('USATIN', chkUsaCor.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('TXTCOR', edtPath.Text);
  conf.pSet('NFMCOR', edtNfmCor.Text);
  conf.pSet('TRACOR', edtTraCor.Text);
  conf.pSet('FATCOR', edtFatCor.Text);
  conf.pSet('MARCOR', edtMarCor.Text);
  conf.pSet('DTAATU', edtDtaAtu.Text);
  conf.pSet('VERSAO', edtVersao.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));


  frmConfConsultaRennerIndustrial.pSalvarConfs;

end;

procedure TfrmConfiguracoesRennerIndustrial.sbPathClick(Sender: TObject);
begin
  inherited;
  If dlgPath.Execute Then
    edtPath.Text := dlgPath.FileName;
end;

procedure TfrmConfiguracoesRennerIndustrial.btnGravarConfClick(Sender: TObject);
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

procedure TfrmConfiguracoesRennerIndustrial.FormCreate(Sender: TObject);
begin
  inherited;
  conf := fGetConfTinta('REN');
  tinta := fGetConsultaTinta('REN');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');
  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('TXTCOR', 'Path para os arquivos', '');
  conf.pInsereCodigo('NFMCOR', 'Próximo Código Nova Fórmulas', '1');
  conf.pInsereCodigo('TRACOR', 'Trava de Preço', 'ven');
  conf.pInsereCodigo('FATCOR', 'Fator da Trava', '1,00');
  conf.pInsereCodigo('MARCOR', 'Margem de Lucro', '0');
  conf.pInsereCodigo('VERSAO', 'Versão da máquina', '');
  conf.pInsereCodigo('DTAATU', 'Data da Ultima Atualização', '');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  frmConfConsultaRennerIndustrial := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  pCarregaArqIni;
end;

procedure TfrmConfiguracoesRennerIndustrial.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl.ClassName = 'TGroupButton') Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfiguracoesRennerIndustrial.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(chkUsaCor);
end;

procedure TfrmConfiguracoesRennerIndustrial.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaRennerIndustrial.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesRennerIndustrial.Destroy;
begin
  if Assigned(frmConfConsultaRennerIndustrial) then FreeAndNil(frmConfConsultaRennerIndustrial);  
  inherited;
end;

procedure TfrmConfiguracoesRennerIndustrial.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesRennerIndustrial.ApplicationEventsMessage(
  var Msg: tagMSG; var Handled: Boolean);
begin
  inherited;
  If Msg.message = WM_KEYFIRST Then
    If Msg.wParam = 27 then
      btnSair.Click;
end;

end.
