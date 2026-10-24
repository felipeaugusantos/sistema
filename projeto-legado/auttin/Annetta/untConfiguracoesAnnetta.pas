unit untConfiguracoesAnnetta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, FilenameEditFocus, DirectoryEditFocus, StrUtils,
  untIConfTinta, AppEvnts, Uni, untPaiSimples, ComCtrls, untConfConsulta,
  untIConsultaTinta, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmConfiguracoesAnnetta = class(TfrmPaiSimples)
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
    edtPathTD3: TEditFocus;
    sbPathTD3: TSpeedButton;
    dlgPathTD3: TOpenDialog;
    edtPathTD4: TEditFocus;
    Label1: TLabel;
    sbPathTD4: TSpeedButton;
    edtPathMain: TEditFocus;
    Label2: TLabel;
    sbPathMain: TSpeedButton;
    dlgPathTD4: TOpenDialog;
    dlgPathMain: TOpenDialog;
    edtDesOpe: TEditFocus;
    Label7: TLabel;
    Label3: TLabel;
    edtApreve: TEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure sbPathTD3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbPathTD4Click(Sender: TObject);
    procedure sbPathMainClick(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaAnnetta: TfrmConfConsulta;
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
  frmConfiguracoesAnnetta: TfrmConfiguracoesAnnetta;

implementation

uses untFuncoesSimples,
     untPai, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracoesAnnetta }

function TfrmConfiguracoesAnnetta.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtPathTD3) Then
  Begin
    If (fEmptyStr(edtPathTD3.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo "TD3" deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtPathTD4) Then
  Begin
    If (fEmptyStr(edtPathTD4.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo "TD4" deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtPathMain) Then
  Begin
    If (fEmptyStr(edtPathMain.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo "Main" deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtNfmCor) Then
  Begin
    If (fEmptyStr(edtNfmCor.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O próximo código para novas fórmulas deve ser preenchido!', ['&Ok']);
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

procedure TfrmConfiguracoesAnnetta.pCarregaArqIni;
begin
  conf := fGetConfTinta('ANN');

  chkUsaCor.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtPathTD3.Text   := conf.fGet('TXTTD3');
  edtPathTD4.Text   := conf.fGet('TXTTD4');
  edtPathMain.Text  := conf.fGet('TXTMAI');
  edtNfmCor.Text := conf.fGet('NFMCOR');
  edtTraCor.Text := conf.fGet('TRACOR');
  edtFatCor.Text := conf.fGet('FATCOR');
  edtMarCor.Text := conf.fGet('MARCOR');

  edtDtaAtu.Text := conf.fGet('DTAATU');
  edtVersao.Text := conf.fGet('VERSAO');

  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesAnnetta.pGravaArqIni;
begin
  conf.pSetBoolean('USATIN', chkUsaCor.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('TXTTD3', edtPathTD3.Text);
  conf.pSet('TXTTD4', edtPathTD4.Text);
  conf.pSet('TXTMAI', edtPathMain.Text);
  conf.pSet('NFMCOR', edtNfmCor.Text);
  conf.pSet('TRACOR', edtTraCor.Text);
  conf.pSet('FATCOR', edtFatCor.Text);
  conf.pSet('MARCOR', edtMarCor.Text);
  conf.pSet('DTAATU', edtDtaAtu.Text);
  conf.pSet('VERSAO', edtVersao.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaAnnetta.pSalvarConfs;

end;

procedure TfrmConfiguracoesAnnetta.sbPathMainClick(Sender: TObject);
begin
  inherited;
  If dlgPathMain.Execute Then
    edtPathMain.Text := dlgPathMain.FileName;
end;

procedure TfrmConfiguracoesAnnetta.sbPathTD3Click(Sender: TObject);
begin
  inherited;
  If dlgPathTD3.Execute Then
    edtPathTD3.Text := dlgPathTD3.FileName;
end;

procedure TfrmConfiguracoesAnnetta.sbPathTD4Click(Sender: TObject);
begin
  inherited;
  If dlgPathTD4.Execute Then
    edtPathTD4.Text := dlgPathTD4.FileName;
end;

procedure TfrmConfiguracoesAnnetta.btnGravarConfClick(Sender: TObject);
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

procedure TfrmConfiguracoesAnnetta.FormCreate(Sender: TObject);
begin
  inherited;
  conf := fGetConfTinta('ANN');
  tinta := fGetConsultaTinta('ANN');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');
  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('TXTTD3', 'Path para o arquivo TD3', '');
  conf.pInsereCodigo('TXTTD4', 'Path para o arquivo TD4', '');
  conf.pInsereCodigo('TXTMAI', 'Path para o arquivo Main', '');
  conf.pInsereCodigo('NFMCOR', 'Próximo Código Nova Fórmulas', '1');
  conf.pInsereCodigo('TRACOR', 'Trava de Preço', 'ven');
  conf.pInsereCodigo('FATCOR', 'Fator da Trava', '1,00');
  conf.pInsereCodigo('MARCOR', 'Margem de Lucro', '0');
  conf.pInsereCodigo('VERSAO', 'Versão da máquina', '');
  conf.pInsereCodigo('DTAATU', 'Data da Ultima Atualização', '');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  frmConfConsultaAnnetta := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  pCarregaArqIni;
end;

procedure TfrmConfiguracoesAnnetta.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl.ClassName = 'TGroupButton') Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfiguracoesAnnetta.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(chkUsaCor);
end;

procedure TfrmConfiguracoesAnnetta.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaAnnetta.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesAnnetta.Destroy;
begin
  if Assigned(frmConfConsultaAnnetta) then FreeAndNil(frmConfConsultaAnnetta);  
  inherited;
end;

procedure TfrmConfiguracoesAnnetta.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesAnnetta.ApplicationEventsMessage(
  var Msg: tagMSG; var Handled: Boolean);
begin
  inherited;
  If Msg.message = WM_KEYFIRST Then
    If Msg.wParam = 27 then
      btnSair.Click;
end;

end.
