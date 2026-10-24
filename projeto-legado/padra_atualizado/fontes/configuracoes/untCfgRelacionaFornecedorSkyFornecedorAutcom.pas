unit untCfgRelacionaFornecedorSkyFornecedorAutcom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UNI,
  Datasnap.DBClient, UniClientDataSet, cxGridBandedTableView,
  cxGridDBBandedTableView, untZClient, SkyPecas.Comunicacao, cxTextEdit;

type
  TfrmCfgRelacionaForncedorSkyFornecedorAutcom = class(TfrmPaiConfirma)
    cxlDados: TcxGridLevel;
    cxgDados: TcxGridCitel;
    dtsDados: TDataSource;
    cxgDadosDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    cxgDadosDBBandedTableViewCitel1SKYCODIGO: TcxGridDBBandedColumn;
    cxgDadosDBBandedTableViewCitel1SKYNOME: TcxGridDBBandedColumn;
    cxgDadosDBBandedTableViewCitel1CIDADE: TcxGridDBBandedColumn;
    cxgDadosDBBandedTableViewCitel1UF: TcxGridDBBandedColumn;
    cxgDadosDBBandedTableViewCitel1FOR_CODFOR: TcxGridDBBandedColumn;
    cxgDadosDBBandedTableViewCitel1FOR_NOMFOR: TcxGridDBBandedColumn;
    cxvDados: TcxGridDBBandedTableViewCitel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvDadosSKY_FORSKY: TcxGridDBBandedColumn;
    cxvDadosSKY_FORAUT: TcxGridDBBandedColumn;
    cxvDadosSKY_NOMFOR: TcxGridDBBandedColumn;
    cxvDadosSKY_CIDADE: TcxGridDBBandedColumn;
    cxvDadosSKY_FOR_UF: TcxGridDBBandedColumn;
    cxvDadosSKY_TELEFO: TcxGridDBBandedColumn;
    cxvDadosFOR_NOMFOR: TcxGridDBBandedColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxvDadosKeyPress(Sender: TObject; var Key: Char);
    procedure cdsFORSKYOnBeforePost(DataSet: TDataSet);
    procedure cxvDadosEditKeyPress(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);

  private
    { Private declarations }
    RedeSkyPecas: TRedeSkyPecas;
    cdsFORSKY: TZClient;
    procedure pCarregaDados;
    function fGetSQLFORSKY: String;
  public
    cdsCfgSis: TUniClientDataSet;
    procedure pIniciaConfiguracao;
    class function fFornecedorRelacaoSky(ACodForSky: String): String;
    class function fFornecedorSky(ACodFor: String): integer;

    { Public declarations }
  end;

var
  frmCfgRelacionaForncedorSkyFornecedorAutcom: TfrmCfgRelacionaForncedorSkyFornecedorAutcom;

implementation

uses
  untFuncoesSimples,
  SkyPecas.Classes.EndPoint, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCfgRelacionaForncedorSkyFornecedorAutcom }

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.btnConfirmaClick(Sender: TObject);
var qryCommand: TUniQuery;
begin
  inherited;
  qryCommand := fCriaQuery;
  Try
    qryCommand.SQL.Add('REPLACE INTO SKYFOR (');
    qryCommand.SQL.Add('SKY_FORSKY,');
    qryCommand.SQL.Add('SKY_FORAUT,');
    qryCommand.SQL.Add('SKY_NOMFOR,');
    qryCommand.SQL.Add('SKY_CIDADE,');
    qryCommand.SQL.Add('SKY_FOR_UF,');
    qryCommand.SQL.Add('SKY_TELEFO');
    qryCommand.SQL.Add(') VALUES(');
    qryCommand.SQL.Add(':SKY_FORSKY,');
    qryCommand.SQL.Add(':SKY_FORAUT,');
    qryCommand.SQL.Add(':SKY_NOMFOR,');
    qryCommand.SQL.Add(':SKY_CIDADE,');
    qryCommand.SQL.Add(':SKY_FOR_UF,');
    qryCommand.SQL.Add(':SKY_TELEFO)');

    cdsFORSKY.First;

    while not cdsFORSKY.Eof do
    Begin
      qryCommand.ParamByName('SKY_FORSKY').AsString := cdsFORSKY.FieldByName('SKY_FORSKY').AsString;
      If fEmptyStr(cdsFORSKY.FieldByName('SKY_FORAUT').AsString) Then
        qryCommand.ParamByName('SKY_FORAUT').Clear
      Else
        qryCommand.ParamByName('SKY_FORAUT').AsString := cdsFORSKY.FieldByName('SKY_FORAUT').AsString;
      qryCommand.ParamByName('SKY_NOMFOR').AsString := cdsFORSKY.FieldByName('SKY_NOMFOR').AsString;
      qryCommand.ParamByName('SKY_CIDADE').AsString := cdsFORSKY.FieldByName('SKY_CIDADE').AsString;
      qryCommand.ParamByName('SKY_FOR_UF').AsString := cdsFORSKY.FieldByName('SKY_FOR_UF').AsString;
      qryCommand.ParamByName('SKY_TELEFO').AsString := cdsFORSKY.FieldByName('SKY_TELEFO').AsString;
      qryCommand.ExecSQL;
      cdsFORSKY.Next;
    End;
  Finally
    FreeAndNil(qryCommand);
  End;
end;

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.cdsFORSKYOnBeforePost(DataSet: TDataSet);
var lCodFor: String;
begin
  cdsFORSKY.FieldByName('FOR_NOMFOR').AsString := '';
  lCodFor := fStrZero(cdsFORSKY.FieldByName('SKY_FORAUT').AsString, 8);
  cdsFORSKY.FieldByName('SKY_FORAUT').AsString := lCodFor;
  If Not fEmptyStr(lCodFor) Then
    cdsFORSKY.FieldByName('FOR_NOMFOR').AsString := fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR'], [lCodFor]);
  If (Not fEmptyStr(cdsFORSKY.FieldByName('SKY_FORAUT').AsString)) And
     (fEmptyStr(cdsFORSKY.FieldByName('FOR_NOMFOR').AsString)) Then
   cdsFORSKY.FieldByName('SKY_FORAUT').AsString := '';
end;

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.cxvDadosEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var arrLinFor: TConsultasArray;
    qryFornecedor: TUniQuery;
begin
  inherited;
  If AItem = cxvDadosSKY_FORAUT Then
  Begin
    qryFornecedor := fCriaQuery;
    try
      If fEntraCons(Key) Then
      Begin
        If fPesqFornecedor(conForSimples, Self, nil, nil, qryFornecedor, Key, arrLinFor, False) Then
        begin
          AEdit.EditValue := qryFornecedor.FieldByName('FOR_CODFOR').AsString;
          cdsFORSKY.Edit;
          cdsFORSKY.FieldByName('SKY_FORAUT').AsString := qryFornecedor.FieldByName('FOR_CODFOR').AsString;
          cdsFORSKY.post;
        End;
      End
      Else If not (CharInSet(Key,['0'..'9',#8])) then
        key := #0;
    Finally
      FreeAndNil(qryFornecedor);
    End;
  End;

end;

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.cxvDadosKeyPress(
  Sender: TObject; var Key: Char);
var arrLinFor: TConsultasArray;
    qryFornecedor: TUniQuery;
begin
  inherited;
  If cxvDadosSKY_FORAUT.Focused Then
  Begin
    qryFornecedor := fCriaQuery;
    try
      If fPesqFornecedor(conForSimples, Self, nil, nil, qryFornecedor, Key, arrLinFor, False) Then
      Begin
        cdsFORSKY.Edit;
        cdsFORSKY.FieldByName('SKY_FORAUT').AsString := qryFornecedor.FieldByName('FOR_CODFOR').AsString;
        cdsFORSKY.Post;
      End;
    Finally
      FreeAndNil(qryFornecedor);
    End;
  End;
end;

class function TfrmCfgRelacionaForncedorSkyFornecedorAutcom.fFornecedorRelacaoSky(ACodForSky: String): String;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT  SKY_FORAUT FROM   SKYFOR WHERE SKY_FORSKY = "'+ACodForSky+'"');
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('SKY_FORAUT').AsString;
  Finally
    FreeAndNil(qryConsulta)
  End;
end;

class function TfrmCfgRelacionaForncedorSkyFornecedorAutcom.fFornecedorSky(ACodFor: String): integer;
var qryConsulta: TUniQuery;
begin
  Result := -1;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT  SKY_FORSKY FROM   SKYFOR WHERE SKY_FORAUT = "'+ACodFor+'"');
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
      Result := qryConsulta.FieldByName('SKY_FORSKY').AsInteger;
  Finally
    FreeAndNil(qryConsulta)
  End;
end;

function TfrmCfgRelacionaForncedorSkyFornecedorAutcom.fGetSQLFORSKY: String;
begin
  Result := '';
  Result := Result + 'SELECT SKY_FORSKY,';
  Result := Result + '       SKY_NOMFOR,';
  Result := Result + '       SKY_CIDADE,';
  Result := Result + '       SKY_FOR_UF,';
  Result := Result + '       SKY_TELEFO,';
  Result := Result + '       SKY_FORAUT,';
  Result := Result + '       FOR_NOMFOR';
  Result := Result + '  FROM SKYFOR';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = SKY_FORAUT;';
end;

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.FormCreate(
  Sender: TObject);
begin
  inherited;
  cdsFORSKY := TZClient.Create(nil, fGetSQLFORSKY);
  cdsFORSKY.fAbreClient(False,'FormCreate');
  dtsDados.DataSet := cdsFORSKY;
end;

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.FormDestroy(
  Sender: TObject);
begin
  freeAndNil(cdsFORSKY);
  inherited;
end;

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.FormShow(
  Sender: TObject);
begin
  pCarregaDados;
end;

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.pCarregaDados;
var SkyPecasLoja: TSkyPecasLoja;
begin
  For SkyPecasLoja in RedeSkyPecas.ParamSkyPecas.SkyPecasConexao.SkyPecasLojas do
  Begin
    If Not cdsFORSKY.Locate('SKY_FORSKY', SkyPecasLoja.cod, []) Then
    Begin
      cdsFORSKY.Insert;
      cdsFORSKY.FieldByName('SKY_FORSKY').AsInteger := SkyPecasLoja.cod;
      cdsFORSKY.FieldByName('SKY_NOMFOR').AsString := SkyPecasLoja.nome;
      cdsFORSKY.FieldByName('SKY_CIDADE').AsString := SkyPecasLoja.cidade;
      cdsFORSKY.FieldByName('SKY_FOR_UF').AsString := SkyPecasLoja.uf;
      cdsFORSKY.FieldByName('SKY_TELEFO').AsString := SkyPecasLoja.telefone;
      cdsFORSKY.Post;
    End;
  End;
  cdsFORSKY.Beforepost := cdsFORSKYOnBeforePost;
end;

procedure TfrmCfgRelacionaForncedorSkyFornecedorAutcom.pIniciaConfiguracao;
var strFalha: string;
begin
  cdsCfgSis.Filtered := False;
  strFalha := '';

  If (cdsCfgSis.FindKey(['CFG_SKYURL'])) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Then
    strFalha := strFalha  + 'Configuração Não definida [CFG_SKYURL]  Sky Peças - URL do Web Service.' + #13;

  If (cdsCfgSis.FindKey(['CFG_SKYUSU'])) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Then
    strFalha := strFalha  + 'Configuração Não definida [CFG_SKYUSU]  Sky Peças - Usuário.' + #13;

  If (cdsCfgSis.FindKey(['CFG_SKYPAS'])) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Then
    strFalha := strFalha  + 'Configuração Não definida [CFG_SKYPAS]  Sky Peças - Senha.' + #13;

  If (cdsCfgSis.FindKey(['CFG_SKYCNP'])) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Then
    strFalha := strFalha  + 'Configuração Não definida [CFG_SKYCNP]  Sky Peças - CNPJ.' + #13;

  cdsCfgSis.Filtered := True;

  If not fEmptyStr(strFalha) Then
    pMensagemOk('Para realizar esta relação precisa ajustar estas configurações: '+ #13 + strFalha)
  Else
  Begin
    Try
      RedeSkyPecas := TRedeSkyPecas.Create;
      If Not RedeSkyPecas.fLogin() Then
        pMensagemOk(RedeSkyPecas.ParamSkyPecas.RetornoApi.Falha)
      Else
        frmCfgRelacionaForncedorSkyFornecedorAutcom.Showmodal;
    Finally
      FreeAndNil(RedeSkyPecas);
    End;
  End;

end;

end.
