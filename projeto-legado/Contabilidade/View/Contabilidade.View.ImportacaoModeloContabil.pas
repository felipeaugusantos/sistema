unit Contabilidade.View.ImportacaoModeloContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxProgressBar, System.Generics.Collections;

type
  TfrmImportacaoModeloContabil = class(TfrmPaiConfirmaContabilidade)
    GroupBox1: TGroupBox;
    lblVersao: TLabel;
    lblTplacoEmpresa: TLabel;
    chkConEmp: TCheckBox;
    chkHistpl: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkHistplClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FstrCaminho: string;
    FblnValidouTplacoAbertura: Boolean;
    function fMontarOverlayCfgView: TDictionary<string, string>;
    function fImportar(pgbProgresso: TcxProgressBar): Boolean;
    procedure pVerificaTplacoEmpresaLogada;
    procedure pAtualizaInfoTplacoEmpresaLogada;
    procedure pAjustaEstadoConEmp;
  public
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples,
  Uni, Data.Db,
  Contabilidade.Classes.ImportacaoModeloContabil,
  Contabilidade.Classes.ImportacaoModeloContabilOrquestrador,
  Contabilidade.Funcoes,
  Contabilidade.View.TipoDePlanoDeContaContabil;

procedure TfrmImportacaoModeloContabil.FormCreate(Sender: TObject);
begin
  inherited;
  FblnValidouTplacoAbertura := False;
  blnVerificaCampos := False;
  lblVersao.Caption := 'Layout do modelo: ' + CSV_DEFAULT_VERSION;
  pAjustaEstadoConEmp;
end;

procedure TfrmImportacaoModeloContabil.FormShow(Sender: TObject);
begin
  inherited;

  if not FblnValidouTplacoAbertura then
  begin
    FblnValidouTplacoAbertura := True;
    pVerificaTplacoEmpresaLogada;
  end;

  pAjustaEstadoConEmp;
  pAtualizaInfoTplacoEmpresaLogada;
end;

procedure TfrmImportacaoModeloContabil.pAjustaEstadoConEmp;
begin
  if chkHistpl.Checked then
    chkConEmp.Checked := True;

  chkConEmp.Enabled := not chkHistpl.Checked;
end;

procedure TfrmImportacaoModeloContabil.chkHistplClick(Sender: TObject);
begin
  pAjustaEstadoConEmp;
end;

procedure TfrmImportacaoModeloContabil.pVerificaTplacoEmpresaLogada;
var
  LfrmTipoPlano: TfrmTipoDePlanoDeContaContabil;
begin
  if Trim(fRetTplacoEmpresaLogada) <> '000000' then
    Exit;

  if fMensagem('ATENÇÃO', 'A empresa logada não possui Tipo de Plano de Contas cadastrado.' +#10#13+ 'Deseja cadastrar agora e vincular a empresa?', ['&Sim', '&Não'], 1) <> 1 then
    Exit;

  pCriarFormularios(TfrmTipoDePlanoDeContaContabil, LfrmTipoPlano);
  try
    LfrmTipoPlano.ModoVinculoEmpresaLogada := True;
    LfrmTipoPlano.ShowModal;
  finally
    pFreeAndNil(LfrmTipoPlano);
  end;

  pAtualizaInfoTplacoEmpresaLogada;
end;

procedure TfrmImportacaoModeloContabil.pAtualizaInfoTplacoEmpresaLogada;
var
  LqryAux: TUniQuery;
  LstrTplaco: string;
  LstrDescri: string;
begin
  LstrTplaco := '';
  LstrDescri := '';

  LqryAux := fCriaQuery(Self);
  try
    LqryAux.SQL.Text :=
      'SELECT IFNULL(C.EMP_TPLACO, "") AS EMP_TPLACO, ' +
      '       IFNULL(T.ACO_DESCRI, "") AS ACO_DESCRI ' +
      'FROM CADEMP C ' +
      'LEFT JOIN TPLACO T ON T.ACO_CODIGO = C.EMP_TPLACO ' +
      'WHERE C.EMP_CODEMP = :CODEMP ' +
      'LIMIT 1';
    LqryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LqryAux.Open;

    if not LqryAux.IsEmpty then
    begin
      LstrTplaco := Trim(LqryAux.FieldByName('EMP_TPLACO').AsString);
      LstrDescri := Trim(LqryAux.FieldByName('ACO_DESCRI').AsString);
    end;
  finally
    FreeAndNil(LqryAux);
  end;

  if fEmptyStr(LstrTplaco) then
    LstrTplaco := '000000';

  if fEmptyStr(LstrDescri) then
    lblTplacoEmpresa.Caption := 'Tipo de Plano (empresa logada): ' + LstrTplaco
  else
    lblTplacoEmpresa.Caption := 'Tipo de Plano (empresa logada): ' + LstrTplaco + ' - ' + LstrDescri;
end;

function TfrmImportacaoModeloContabil.fMontarOverlayCfgView: TDictionary<string, string>;
var
  LblnConEmp, LblnHistPl: Boolean;
begin
  Result := TDictionary<string, string>.Create;

  LblnConEmp := chkConEmp.Checked;
  LblnHistPl := chkHistpl.Checked;

  if LblnHistPl then
    LblnConEmp := True;

  if LblnConEmp then
    Result.AddOrSetValue('CONEMP', 'S')
  else
    Result.AddOrSetValue('CONEMP', 'N');

  if LblnHistPl then
    Result.AddOrSetValue('HISTPL', 'S')
  else
    Result.AddOrSetValue('HISTPL', 'N');
end;

function TfrmImportacaoModeloContabil.fImportar(pgbProgresso: TcxProgressBar): Boolean;
var
  LOrquestrador: TImportacaoModeloContabilOrquestrador;
  LOverlayCfgView: TDictionary<string, string>;
begin
  LOrquestrador := TImportacaoModeloContabilOrquestrador.Create;
  LOverlayCfgView := nil;
  try
    LOverlayCfgView := fMontarOverlayCfgView;
    Result := LOrquestrador.fImportarArquivo(FstrCaminho, pgbProgresso, LOverlayCfgView);
  finally
    if Assigned(LOverlayCfgView) then
      FreeAndNil(LOverlayCfgView);
    FreeAndNil(LOrquestrador);
  end;
end;

procedure TfrmImportacaoModeloContabil.btnConfirmaClick(Sender: TObject);
var
  LDlgOpen: TOpenDialog;
begin
  LDlgOpen := TOpenDialog.Create(Self);
  try
    LDlgOpen.Title  := 'Importar Modelo Contábil';
    LDlgOpen.Filter := 'Arquivo CSV (*.csv)|*.csv|Todos os arquivos (*.*)|*.*';

    if not LDlgOpen.Execute then
      Exit;

    FstrCaminho := LDlgOpen.FileName;
  finally
    FreeAndNil(LDlgOpen);
  end;

  if fChamaTelaGravando(fImportar) then
    fMensagem('ATENÇÃO', 'Modelo contábil importado com sucesso!', ['&Ok']);
end;

end.
