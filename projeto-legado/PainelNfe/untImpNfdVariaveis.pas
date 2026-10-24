unit untImpNfdVariaveis;

{
  Editor da impressao dinamica: variaveis do fr3 (IMPNFE_VAR) de um provedor.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxTextEdit, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog,
  {$ENDIF}
{$IF Defined(UNIDAC)}
  Uni;
{$ELSE}
  ZConnection, ZDataset;
{$IFEND}

type
  TfrmImpNfdVariaveis = class(TForm)
    grdVar: TcxGrid;
    tbvVar: TcxGridDBTableView;
    tbvVarVAR_NOME: TcxGridDBColumn;
    tbvVarVAR_ORIGEM: TcxGridDBColumn;
    tbvVarVAR_CAMPO: TcxGridDBColumn;
    tbvVarVAR_TIPO: TcxGridDBColumn;
    tbvVarVAR_FUNC: TcxGridDBColumn;
    tbvVarVAR_DEFAUL: TcxGridDBColumn;
    tbvVarVAR_ORDEM: TcxGridDBColumn;
    lvlVar: TcxGridLevel;
    pnlCampos: TPanel;
    lblNome: TLabel;
    dbeNome: TDBEdit;
    dbrOrigem: TDBRadioGroup;
    dbrTipo: TDBRadioGroup;
    lblCampo: TLabel;
    dbeCampo: TDBEdit;
    lblFormat: TLabel;
    dbeFormat: TDBEdit;
    lblFunc: TLabel;
    dbcFunc: TDBComboBox;
    lblOrdem: TLabel;
    dbeOrdem: TDBEdit;
    lblDefault: TLabel;
    dbeDefault: TDBEdit;
    lblCdsVar: TLabel;
    dbeCdsVar: TDBEdit;
    lblSelect: TLabel;
    dbmSelect: TDBMemo;
    btnSalvar: TButton;
    btnNovo: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    btnFechar: TButton;
    dtsVar: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dtsVarStateChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    qryVar: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    // coluna VAR_CDS existe (script 003)
    FblnVarCds: Boolean;
    procedure qryVarNewRecord(DataSet: TDataSet);
    procedure pAbrir(const ALocalizar: String = '');
    procedure pAjustaBotoes;
    procedure pHabilitaCampos(AHabilita: Boolean);
    function fEmEdicao: Boolean;
    function fTemRegistro: Boolean;
  public
    NomePrv: String;   // chave do provedor (PRV_NOME)
  end;

var
  frmImpNfdVariaveis: TfrmImpNfdVariaveis;

implementation

uses
  untUtil;

{$R *.dfm}

{ TfrmImpNfdVariaveis }

procedure TfrmImpNfdVariaveis.FormCreate(Sender: TObject);
var
  strCampos: String;
begin
  FblnVarCds := fCampoExiste('IMPNFE_VAR', 'VAR_CDS');
  lblCdsVar.Visible := FblnVarCds;
  dbeCdsVar.Visible := FblnVarCds;
  if FblnVarCds then
    dbeCdsVar.DataField := 'VAR_CDS';

  strCampos :=
    'SELECT VAR_CODPRV, VAR_NOME, VAR_ORIGEM, VAR_CAMPO, VAR_SELECT, VAR_TIPO, ' +
    'VAR_FORMAT, VAR_FUNC, VAR_DEFAUL, VAR_ORDEM';
  if FblnVarCds then
    strCampos := strCampos + ', VAR_CDS';

  qryVar := fCriaQuery(Self);
  qryVar.SQL.Text :=
    strCampos + ' ' +
    'FROM IMPNFE_VAR WHERE VAR_CODPRV = :PRV ORDER BY VAR_ORDEM, VAR_NOME';
{$IF Defined(UNIDAC)}
  qryVar.KeyFields := 'VAR_CODPRV;VAR_NOME';
{$IFEND}
  qryVar.OnNewRecord := qryVarNewRecord;
  dtsVar.DataSet := qryVar;
end;

procedure TfrmImpNfdVariaveis.FormShow(Sender: TObject);
begin
  Caption := 'Variáveis - Provedor: ' + NomePrv;
  pAbrir;
end;

procedure TfrmImpNfdVariaveis.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fEmEdicao then
  begin
    if MessageDlg('Existem alterações não salvas. Deseja descartá-las e sair?',
         mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      qryVar.Cancel
    else
      CanClose := False;
  end;
end;

procedure TfrmImpNfdVariaveis.qryVarNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('VAR_CODPRV').AsString  := NomePrv;
  DataSet.FieldByName('VAR_ORIGEM').AsString  := 'C';
  DataSet.FieldByName('VAR_TIPO').AsString    := 'STR';
  DataSet.FieldByName('VAR_ORDEM').AsInteger  := 0;
end;

procedure TfrmImpNfdVariaveis.pAbrir(const ALocalizar: String);
begin
  qryVar.Close;
  qryVar.ParamByName('PRV').AsString := NomePrv;
  qryVar.Open;
  if ALocalizar <> '' then
    qryVar.Locate('VAR_NOME', ALocalizar, []);
  pAjustaBotoes;
end;

function TfrmImpNfdVariaveis.fEmEdicao: Boolean;
begin
  Result := Assigned(qryVar) and (qryVar.State in [dsEdit, dsInsert]);
end;

function TfrmImpNfdVariaveis.fTemRegistro: Boolean;
begin
  Result := Assigned(qryVar) and qryVar.Active and (not qryVar.IsEmpty);
end;

procedure TfrmImpNfdVariaveis.pHabilitaCampos(AHabilita: Boolean);
var
  i: Integer;
begin
  for i := 0 to pnlCampos.ControlCount - 1 do
  begin
    if pnlCampos.Controls[i] is TLabel then
      Continue;

    // memo fica habilitado (para rolar/copiar), apenas somente-leitura fora da edicao
    if pnlCampos.Controls[i] is TDBMemo then
    begin
      TDBMemo(pnlCampos.Controls[i]).ReadOnly := not AHabilita;
      if AHabilita then
        TDBMemo(pnlCampos.Controls[i]).Color := clWindow
      else
        TDBMemo(pnlCampos.Controls[i]).Color := clBtnFace;
      Continue;
    end;

    pnlCampos.Controls[i].Enabled := AHabilita;
  end;
end;

procedure TfrmImpNfdVariaveis.pAjustaBotoes;
var
  blnEdicao, blnReg: Boolean;
begin
  if (csDestroying in ComponentState) or (not Assigned(qryVar)) then
    Exit;

  blnEdicao := fEmEdicao;
  blnReg    := fTemRegistro;

  btnSalvar.Enabled   := blnEdicao;
  btnCancelar.Enabled := blnEdicao;
  btnNovo.Enabled     := qryVar.Active and (not blnEdicao);
  btnEditar.Enabled   := blnReg and (not blnEdicao);
  btnExcluir.Enabled  := blnReg and (not blnEdicao);

  grdVar.Enabled := not blnEdicao;
  pHabilitaCampos(blnEdicao);
  // o nome da variável é chave (PK): só pode ser informado na inclusão
  dbeNome.Enabled := blnEdicao and (qryVar.State = dsInsert);
end;

procedure TfrmImpNfdVariaveis.dtsVarStateChange(Sender: TObject);
begin
  pAjustaBotoes;
end;

procedure TfrmImpNfdVariaveis.btnNovoClick(Sender: TObject);
begin
  if fEmEdicao then
    Exit;
  qryVar.Append;
  dbeNome.SetFocus;
end;

procedure TfrmImpNfdVariaveis.btnEditarClick(Sender: TObject);
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;
  qryVar.Edit;
  dbeCampo.SetFocus;
end;

procedure TfrmImpNfdVariaveis.btnCancelarClick(Sender: TObject);
begin
  if fEmEdicao then
    qryVar.Cancel;
end;

procedure TfrmImpNfdVariaveis.btnSalvarClick(Sender: TObject);
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  blnInserindo: Boolean;
  intQtd: Integer;
  strOrigem, strNome: String;
begin
  if not fEmEdicao then
    Exit;

  qryVar.UpdateRecord;

  strNome := Trim(qryVar.FieldByName('VAR_NOME').AsString);
  if fEmptyStr(strNome) then
  begin
    MessageDlg('Informe o nome da variável.', mtInformation, [mbOk], 0);
    dbeNome.SetFocus;
    Exit;
  end;

  strOrigem := UpperCase(Trim(qryVar.FieldByName('VAR_ORIGEM').AsString));

  if (strOrigem = 'C') and fEmptyStr(Trim(qryVar.FieldByName('VAR_CAMPO').AsString)) then
  begin
    MessageDlg('Para a origem Campo informe o campo do dataset.', mtInformation, [mbOk], 0);
    dbeCampo.SetFocus;
    Exit;
  end;

  if (strOrigem = 'S') and fEmptyStr(Trim(qryVar.FieldByName('VAR_SELECT').AsString)) then
  begin
    MessageDlg('Para a origem Select informe o SELECT.', mtInformation, [mbOk], 0);
    dbmSelect.SetFocus;
    Exit;
  end;

  blnInserindo := (qryVar.State = dsInsert);

  // o nome da variável é chave: não pode repetir no provedor
  if blnInserindo then
  begin
    qry := fCriaQuery(Self);
    try
      qry.SQL.Text :=
        'SELECT COUNT(*) AS QTD FROM IMPNFE_VAR ' +
        'WHERE VAR_CODPRV = :PRV AND VAR_NOME = :NOME';
      qry.ParamByName('PRV').AsString  := NomePrv;
      qry.ParamByName('NOME').AsString := strNome;
      qry.Open;
      intQtd := qry.FieldByName('QTD').AsInteger;
      qry.Close;
    finally
      FreeAndNil(qry);
    end;

    if intQtd > 0 then
    begin
      MessageDlg('Já existe a variável "' + strNome + '" para este provedor.', mtInformation, [mbOk], 0);
      dbeNome.SetFocus;
      Exit;
    end;

    qryVar.FieldByName('VAR_NOME').AsString := strNome;
  end;

  try
    qryVar.Post;
  except
    on E: Exception do
    begin
      MessageDlg('Não foi possível salvar a variável.' + sLineBreak + E.Message, mtError, [mbOk], 0);
      Exit;
    end;
  end;

  pAbrir(strNome);
end;

procedure TfrmImpNfdVariaveis.btnExcluirClick(Sender: TObject);
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;

  if MessageDlg('Deseja realmente excluir a variável "' + qryVar.FieldByName('VAR_NOME').AsString + '"?',
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  qryVar.Delete;
  pAjustaBotoes;
end;

procedure TfrmImpNfdVariaveis.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
