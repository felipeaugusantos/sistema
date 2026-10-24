unit untConfiguracoesDacar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, StrUtils, AppEvnts, Uni, ComCtrls,
  untConfConsulta, untIConsultaTinta, untIConfTinta, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesDacar = class(TfrmPai)
    pnlCentral: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    chkUsaDac: TCheckBox;
    edtDesDac: TEditFocus;
    edtProDac: TEditFocus;
    edtTraDac: TEditFocus;
    edtFatDac: TEditFocus;
    edtNxtDac: TEditFocus;
    chkUsaFor: TCheckBox;
    pnlCabecalho: TPanel;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    chkGerAnt: TCheckBox;
    Label38: TLabel;
    edtApreve: TEditFocus;
    edtTxtDac: TFilenameEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure edtProDacKeyPress(Sender: TObject; var Key: Char);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
  private

    qryCadIte: TUniQuery;
    frmConfConsultaDacar: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesDacar: TfrmConfiguracoesDacar;

implementation

uses untFuncoesSimples,
     untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmConfiguracoesDacar.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('DAC');
  tinta := fGetConsultaTinta('DAC');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'DACAR', 'USATIN', ''));
  conf.pInsereCodigo('PRODAC', 'Produto para venda', fArqIniTinta(0, 'DACAR', 'PRODAC', ''));
  conf.pInsereCodigo('TRADAC', 'Trava para valor de venda DAC_PRE', fArqIniTinta(0, 'DACAR', 'TRADAC', ''));
  conf.pInsereCodigo('FATDAC', 'Fator', fArqIniTinta(0, 'DACAR', 'FATDAC', ''));
  conf.pInsereCodigo('TXTDAC', 'Path para arquivo', fArqIniTinta(0, 'DACAR', 'TXTDAC', ''));
  conf.pInsereCodigo('NXTDAC', 'Próximo código nova fórmula', fArqIniTinta(0, 'DACAR', 'NXTDAC', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'DAC', 'S'));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');
  conf.pInsereCodigo('GERANT', 'Utilizar Geração de Arquivo Antiga', 'N');

  pCarregaArqIni;
  edtDesDac.Text := fRetNomProduto(edtProDac.Text);
  qryCadIte := fCriaQuery(Self);
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaDacar := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);

  edtTxtDac.Dialog.Dialog.Filter := 'Arquivos Texto|*.xls|Todos os arquivos|*.*';
end;

procedure TfrmConfiguracoesDacar.btnGravarConfClick(Sender: TObject);
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

procedure TfrmConfiguracoesDacar.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaDacar.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesDacar.Destroy;
begin
  if Assigned(frmConfConsultaDacar) then FreeAndNil(frmConfConsultaDacar);
  inherited;
end;

procedure TfrmConfiguracoesDacar.edtProDacKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  if fPesqItem(conIteSimples, Self, edtProDac, edtDesDac, nil, Key, arrSel) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesDacar.pGravaArqIni;
begin

  {*****************************************}
  {* GRAVA DADOS DA DACAR                  *}
  {**************************************MV*}
{
  If chkUsaDac.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  If chkVenDin.Checked Then
    strVenDin := 'S'
  Else
    strVenDin := 'N';

  strUsaFor := IIF(chkUsaFor.Checked, 'S', 'N');

  fArqIniTinta(1, 'DACAR', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'DACAR', 'PRODAC', edtProDac.Text);
  fArqIniTinta(1, 'DACAR', 'TRADAC', edtTraDac.Text);
  fArqIniTinta(1, 'DACAR', 'FATDAC', edtFatDac.Text);
  fArqIniTinta(1, 'DACAR', 'TXTDAC', edtTxtDac.Text);
  fArqIniTinta(1, 'DACAR', 'NXTDAC', edtNxtDac.Text);
  fArqIniTinta(1, 'USA_FORMUL', 'DAC', strUsaFor);
}
  conf.pSetBoolean('USATIN', chkUsaDac.Checked);
  conf.pSet('PRODAC', edtProDac.Text);
  conf.pSet('TRADAC', edtTraDac.Text);
  conf.pSet('FATDAC', edtFatDac.Text);
  conf.pSet('TXTDAC', edtTxtDac.Dialog.Dialog.FileName);
  conf.pSet('NXTDAC', edtNxtDac.Text);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));
  conf.pSetBoolean('GERANT', chkGerAnt.Checked);

  frmConfConsultaDacar.pSalvarConfs;

end;

procedure TfrmConfiguracoesDacar.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA DACAR                *}
  {**************************************MV*}
  conf := fGetConfTinta('DAC');

  chkUsaDac.Checked := conf.fGetBoolean('USATIN');
  edtProDac.Text    := conf.fGet('PRODAC');
  edtTraDac.Text    := conf.fGet('TRADAC');
  edtFatDac.Text    := conf.fGet('FATDAC');
  edtTxtDac.Text    := conf.fGet('TXTDAC');
  edtNxtDac.Text    := conf.fGet('NXTDAC');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');
  chkGerAnt.Checked := conf.fGetBoolean('GERANT');

end;

procedure TfrmConfiguracoesDacar.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

function TfrmConfiguracoesDacar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtProDac) Then
  Begin
    If (fEmptyStr(edtProDac.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesDac.Text := fRetNomProduto(edtProDac.Text);
      If (fEmptyStr(edtDesDac.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtTraDac) Then
  Begin
    If (fEmptyStr(edtTraDac.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraDac.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraDac.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatDac) Then
  Begin
    If (fEmptyStr(edtFatDac.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatDac.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTxtDac) Then
  Begin
    If (fEmptyStr(edtTxtDac.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo TXT deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtTxtDac.Text := fGetPath(edtTxtDac.Text);
      If (RightStr(edtTxtDac.Text, 1) = '\') Then
        edtTxtDac.Text := Copy(edtTxtDac.Text, 1, Length(edtTxtDac.Text)-1);
    End;
  End

  Else If (Sender = edtDesOpe) Then
  begin
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
  begin
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


end;

end.
