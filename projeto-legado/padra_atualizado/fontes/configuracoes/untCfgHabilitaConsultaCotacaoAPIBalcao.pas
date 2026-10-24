unit untCfgHabilitaConsultaCotacaoAPIBalcao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, uni,UniClientDataSet,
  Cotacao.ApiPrecos.ConstAndTypes;

type
  TfrmCfgHabilitaConsultaCotacaoAPIBalcao = class(TfrmPaiConfirma)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dtsDados: TDataSource;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure pBeforePost(DataSet: TDataSet);

  private
    qryConsulta: TZClient;
    function fValidaAtivacaoAncora: Boolean;
    { Private declarations }
  public
    cdsCfgSis: TUniClientDataSet;
    class function fBalcaoHabilitado(AidAapi: Integer = -1): Boolean;
    class function fApiHabilitada(AidAapi: Integer): Boolean;

    { Public declarations }
  end;



var
  frmCfgHabilitaConsultaCotacaoAPIBalcao: TfrmCfgHabilitaConsultaCotacaoAPIBalcao;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmCfgHabilitaConsultaCotacaoAPIBalcao.btnConfirmaClick(
  Sender: TObject);
var qryComand: TUniQuery;
begin
  inherited;

  qryComand := fCriaQuery;
  try
    qryComand.SQL.Add('REPLACE INTO APIBAL(API_CODEMP, API_HABBAL, API_ID_API, API_HABILI) VALUES (:API_CODEMP, :API_HABBAL, :API_ID_API, :API_HABILI);');
    qryConsulta.First;
    while not qryConsulta.Eof do
    begin
      qryComand.ParamByName('API_CODEMP').AsString := VS_StrCodEmp;
      qryComand.ParamByName('API_HABBAL').AsString := qryConsulta.FieldByName('API_HABBAL').AsString;
      qryComand.ParamByName('API_ID_API').AsString := qryConsulta.FieldByName('API_IDENTI').AsString;
      qryComand.ParamByName('API_HABILI').AsString := qryConsulta.FieldByName('API_HABILI').AsString;
      qryConsulta.Next;
      qryComand.ExecSQL;
    end;
  finally
    freeAndNil(qryComand);
  end;

end;

class function TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fBalcaoHabilitado(AidAapi: Integer = -1): Boolean;
var qryHab: TUniQuery;
begin
  qryHab := fCriaQuery;
  Try
    qryHab.SQL.Add('SELECT COUNT(1) QTD FROM APIBAL WHERE API_HABBAL = 1 AND API_CODEMP = "'+VS_StrCodEmp+'"');
    If AidAapi > -1 Then
      qryHab.SQL.Add('AND API_ID_API = '+AidAapi.ToString);
    qryHab.Open;

    Result := qryHab.FieldByName('QTD').AsInteger > 0;

  Finally
    FreeAndNil(qryHab);
  End;

end;

class function TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fApiHabilitada(AidAapi: Integer): Boolean;
var qryHab: TUniQuery;
begin
  qryHab := fCriaQuery;
  Try
    qryHab.SQL.Add('SELECT COUNT(1) QTD FROM APIBAL WHERE API_HABILI = 1 AND API_CODEMP = "'+VS_StrCodEmp+'" AND API_ID_API = ' + IntToStr(AidAapi));
    qryHab.Open;

    Result :=qryHab.FieldByName('QTD').AsInteger > 0;

  Finally
    FreeAndNil(qryHab);
  End;

end;


procedure TfrmCfgHabilitaConsultaCotacaoAPIBalcao.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := TZClient.Create(nil);
  qryConsulta.qryQuery.SQL.Add('SELECT API_IDENTI,');
  qryConsulta.qryQuery.SQL.Add('       API_NOMAPI,');
  qryConsulta.qryQuery.SQL.Add('       IF(API_HABBAL IS NULL, 0, API_HABBAL) API_HABBAL,');
  qryConsulta.qryQuery.SQL.Add('       IF(API_HABILI IS NULL, 0, API_HABILI) API_HABILI,');
  qryConsulta.qryQuery.SQL.Add('       API_CODEMP,');
  qryConsulta.qryQuery.SQL.Add('       API_ID_API');
  qryConsulta.qryQuery.SQL.Add('  FROM APICOT');
  qryConsulta.qryQuery.SQL.Add('  LEFT JOIN APIBAL ON API_ID_API = API_IDENTI AND API_CODEMP = "' + VS_StrCodEmp + '"');
  qryConsulta.fAbreClient(False, 'TfrmCfgHabilitaConsultaCotacaoAPIBalcao.FormCreate');
  dtsDados.DataSet := qryConsulta;

  qryConsulta.BeforePost := pBeforePost;
end;

procedure TfrmCfgHabilitaConsultaCotacaoAPIBalcao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConsulta);
  inherited;
end;

procedure TfrmCfgHabilitaConsultaCotacaoAPIBalcao.pBeforePost(
  DataSet: TDataSet);
begin
  If (DataSet.FieldByName('API_HABBAL').AsInteger = 1) And
     (DataSet.FieldByName('API_HABILI').AsInteger = 0) Then
  begin
    pMensagemOk('Para ativar o uso no balcão é preciso habilitar primeiro o uso da API!');
    DataSet.FieldByName('API_HABBAL').AsInteger := 0;
  End;

  If (DataSet.FieldByName('API_HABILI').AsInteger = 1) And
     (DataSet.FieldByName('API_IDENTI').AsInteger = idRedeAncora) Then
     If Not fValidaAtivacaoAncora Then
       DataSet.FieldByName('API_HABILI').AsInteger := 0;
end;

function TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fValidaAtivacaoAncora: Boolean;
begin
  cdsCfgSis.Filtered := False;
  Result := True;
  If (cdsCfgSis.FindKey(['CFG_ANCTOK'])) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Then
  begin
    fMensagem('ATENÇÃO!', 'Não é permitida habiltar consulta ancora sem definir o token [CFG_ANCTOK]. Verifique!', ['&Ok']);
    Result := False;
  End;
  If (cdsCfgSis.FindKey(['CFG_ANCURL'])) Then
  If (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Then
  begin
    fMensagem('ATENÇÃO!', 'Não é permitida habiltar consulta ancora sem definir a url [CFG_ANCURL]. Verifique!', ['&Ok']);
    Result := False;
  End;
  cdsCfgSis.Filtered := True;
end;


end.
