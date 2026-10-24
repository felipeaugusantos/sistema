unit untConfiguracoesRennerImob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  FilenameEditFocus, AppEvnts, Uni, StrUtils, ComCtrls,
  untConfConsulta, untIConsultaTinta, untIConfTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesRennerImob = class(TfrmPai)
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    pnlCentral: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    chkUsaRei: TCheckBox;
    edtTraRei: TEditFocus;
    edtFatRei: TEditFocus;
    edtProCod: TEditFocus;
    pnlCabecalho: TPanel;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    rgImpressaoOrdemproducao: TRadioGroup;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label63: TLabel;
    edtApreve: TEditFocus;
    edtTxtRei: TFilenameEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaRennerImob: TfrmConfConsulta;
    consulta: IConsultaTinta;
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
  frmConfiguracoesRennerImob: TfrmConfiguracoesRennerImob;

implementation

uses
    untFuncTinta, untFuncoesSimples;

{$R *.dfm}

{ TfrmConfiguracoesRennerImob }

function TfrmConfiguracoesRennerImob.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtTraRei) Then
  Begin
    If (fEmptyStr(edtTraRei.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraRei.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraRei.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatRei) Then
  Begin
    If (fEmptyStr(edtFatRei.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatRei.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTxtRei) Then
  Begin
    If (fEmptyStr(edtTxtRei.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo TXT deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin

    End;
  End

  Else if (Sender = edtDesOpe) Then
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

  Else if (Sender = edtApreve) Then
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

procedure TfrmConfiguracoesRennerImob.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA RENNER IMOBILIARIA   *}
  {**************************************MV*}
{
  chkUsaRei.Checked := (fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'USATIN', '') = 'S');
  edtTraRei.Text    := fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TRAREI', '');
  edtFatRei.Text    := fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'FATREI', '');
  edtTxtRei.Text    := fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TXTREI', '');

  edtProCod.Text := fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'PROCOD', '');
}

  conf := fGetConfTinta('REI');

  chkUsaRei.Checked := conf.fGetBoolean('USATIN'); //(fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'USATIN', '') = 'S');
  edtTraRei.Text    := conf.fGet('TRAREI');        //fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TRAREI', '');
  edtFatRei.Text    := conf.fGet('FATREI');        //fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'FATREI', '');
  edtTxtRei.Text    := conf.fGet('TXTREI');        //fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TXTREI', '');
  edtProCod.Text    := conf.fGet('PROCOD');        //fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'PROCOD', '');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');

  rgImpressaoOrdemproducao.ItemIndex := conf.fGetInteger('UNIOPR') - 1;
end;

procedure TfrmConfiguracoesRennerImob.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesRennerImob.pGravaArqIni;
begin

  {*****************************************}
  {* GRAVA DADOS DA RENNER IMOBILIARIA     *}
  {**************************************MV*}
{
  If chkUsaRei.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'TRAREI', edtTraRei.Text);
  fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'FATREI', edtFatRei.Text);
  fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'TXTREI', edtTxtRei.Text);

  fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'PROCOD', edtProCod.Text);
  fArqIniTinta(1, 'USA_FORMUL', 'REI', 'S');
}

  conf.pSetBoolean('USATIN', chkUsaRei.Checked); //fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'USATIN', strUsaTin);
  conf.pSet('TRAREI', edtTraRei.Text); //fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'TRAREI', edtTraRei.Text);
  conf.pSet('FATREI', edtFatRei.Text); //fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'FATREI', edtFatRei.Text);
  conf.pSet('TXTREI', edtTxtRei.Text); //fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'TXTREI', edtTxtRei.Text);

  conf.pSet('PROCOD', edtProCod.Text); //fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'PROCOD', edtProCod.Text);
  conf.pSet('USAFOR', 'S'); //fArqIniTinta(1, 'USA_FORMUL', 'REI', 'S');
  conf.pSetInteger('UNIOPR', rgImpressaoOrdemproducao.ItemIndex + 1);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaRennerImob.pSalvarConfs;
end;

procedure TfrmConfiguracoesRennerImob.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaRennerImob.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesRennerImob.Destroy;
begin
  if Assigned(frmConfConsultaRennerImob) then FreeAndNil(frmConfConsultaRennerImob);
  inherited;
end;

procedure TfrmConfiguracoesRennerImob.FormCreate(Sender: TObject);
begin
  inherited;
  conf     := fGetConfTinta('REI');
  consulta := fGetConsultaTinta('REI');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'USATIN', ''));
  conf.pInsereCodigo('TRAREI', 'Trava para valor de venda', fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TRAREI', ''));
  conf.pInsereCodigo('FATREI', 'Fator', fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'FATREI', ''));
  conf.pInsereCodigo('TXTREI', 'Path para arquivo txt', fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TXTREI', ''));

  conf.pInsereCodigo('PROCOD', 'Venda dinâmica', fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'PROCOD', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', 'S');
  conf.pInsereCodigo('UNIOPR', 'Unidade da Impressão de Ordem de Produção', '1');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregaArqIni;
  frmConfConsultaRennerImob := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex  := 0;

  edtTxtRei.Dialog.Dialog.Filter := 'Arquivos Texto|*.txt|Todos os arquivos|*.*';
end;

procedure TfrmConfiguracoesRennerImob.btnGravarConfClick(Sender: TObject);
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

end.
