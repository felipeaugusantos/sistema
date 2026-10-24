unit Contabilidade.View.ConferenciaNaturezaOperacaoParcon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls,
  Contabilidade.Interfaces.TConferenciaNaturezaOperacaoParconService, Data.DB,
  Datasnap.DBClient, UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni,
  untGeraExcel, untExcel, cxTextEdit;

type
  TfrmConferenciaNaturezaOperacaoParcon = class(TfrmPaiContabilidade)
    dsConferencia: TDataSource;
    TableView: TcxGridDBTableViewCitel;
    GridLevel1: TcxGridLevel;
    Grid: TcxGridCitel;
    TableViewCON_TIPLAN: TcxGridDBColumn;
    TableViewCON_DESVAL: TcxGridDBColumn;
    TableViewCON_CLAFIS: TcxGridDBColumn;
    TableViewCON_NATCFO: TcxGridDBColumn;
    TableViewDES_NATCFO: TcxGridDBColumn;
    btnExportar: TBitBtnLocked;
    btnParametros: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnParametrosClick(Sender: TObject);
  private
    { Private declarations }
    FService: IConferenciaNaturezaOperacaoParconService;
    FDadosConferencia: TUniClientDataSet;
    FMensagemErro: string;
    FFiltro: string;
    function fExecutaConferencia(pgbProgresso: TcxProgressBar): Boolean;
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    function  fPermissaoOk(const ANomeForm: String): Boolean;
  public
    { Public declarations }
    function pCarregaDados(const AFiltro: string): TDataSet;
    class function fEhTipoComNatureza(const ATipo: String): Boolean;
    property MensagemErro: string read FMensagemErro;
  end;

implementation

uses
  Contabilidade.Classes.TConferenciaNaturezaOperacaoParconService,
  untFuncoesSimples, System.StrUtils,
  Contabilidade.View.ParametrosContabilizacao;

{$R *.dfm}

procedure TfrmConferenciaNaturezaOperacaoParcon.btnExportarClick(
  Sender: TObject);
begin
  inherited;
  If TGeraExcel.fGerarRelatorio(TableView, 'Exportar...', OnGeraExcel) Then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmConferenciaNaturezaOperacaoParcon.btnParametrosClick(
  Sender: TObject);
begin
  inherited;
  If Not fPermissaoOk('frmParametrosContabilizacao') Then
  begin
    pMensagemOk('Operador sem permissão no módulo!');
    Exit;
  end;
  pCriarForm(TfrmParametrosContabilizacao) ;
end;

class function TfrmConferenciaNaturezaOperacaoParcon.fEhTipoComNatureza(
  const ATipo: String): Boolean;
var
  LArr: array of string;
begin
  LArr := ['COE', 'COS', 'CMV', 'ENT', 'SAI'];
  Result := MatchStr(ATipo, LArr);
end;

function TfrmConferenciaNaturezaOperacaoParcon.fExecutaConferencia(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  if not Assigned(FDadosConferencia) then
    FDadosConferencia := TUniClientDataSet(self.pCarregaDados(FFiltro));

  if not Assigned(FDadosConferencia) then
    Exit;

  dsConferencia.Enabled := False;
  try
    dsConferencia.DataSet := FDadosConferencia;
  finally
    dsConferencia.Enabled := True;
  end;

  Result := True;
end;

procedure TfrmConferenciaNaturezaOperacaoParcon.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TConferenciaNaturezaOperacaoParconService.New;
  FDadosConferencia := nil;
  FMensagemErro := EmptyStr;
  FFiltro := EmptyStr;
end;

procedure TfrmConferenciaNaturezaOperacaoParcon.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FDadosConferencia) then
    FreeAndNil(FDadosConferencia);
end;

procedure TfrmConferenciaNaturezaOperacaoParcon.FormShow(Sender: TObject);
begin
  inherited;
  if not fChamaTelaGravando(fExecutaConferencia) then
  begin
    pMensagensErro(FMensagemErro,'[Contabilidade.View.ConferenciaNaturezaOperacaoParcon]');
    Self.Close;
  end;
  pSetFocus(Grid);
end;

function TfrmConferenciaNaturezaOperacaoParcon.fPermissaoOk(
  const ANomeForm: String): Boolean;
begin
  Result := fVerificaAcessoSistema(ANomeForm);
end;

procedure TfrmConferenciaNaturezaOperacaoParcon.OnGeraExcel(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
begin
  //
end;

function TfrmConferenciaNaturezaOperacaoParcon.pCarregaDados(
  const AFiltro: string): TDataSet;
begin
  FFiltro := AFiltro;
  Result := FDadosConferencia;
  if Assigned(FDadosConferencia) then
    Exit;

  try
    FDadosConferencia := TUniClientDataSet(FService.fConferir(FFiltro));
  except
    on E: Exception do
    begin
      FMensagemErro := E.Message;
      exit;
    end;
  end;

  Result := FDadosConferencia;
end;

end.
