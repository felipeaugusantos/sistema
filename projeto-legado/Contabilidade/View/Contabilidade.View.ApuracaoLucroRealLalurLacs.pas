unit Contabilidade.View.ApuracaoLucroRealLalurLacs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, cxControls, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni,
  Contabilidade.Classes.ApuracaoLucroRealLalurLacs;

type
  TfrmApuracaoLucroRealLalurLacs = class(TfrmPaiContabilidade)
    btnIncluir: TcxButton;
    btnEditar: TcxButton;
    btnExcluir: TcxButton;
    TableViewCitel: TcxGridDBTableViewCitel;
    GridCitelLevel: TcxGridLevel;
    GridCitel: TcxGridCitel;
    dsApuracao: TDataSource;
    TableViewCitelPRE_CODPRE: TcxGridDBColumn;
    TableViewCitelPRE_DTAINI: TcxGridDBColumn;
    TableViewCitelPRE_DTAFIN: TcxGridDBColumn;
    TableViewCitelPRE_CODEMP: TcxGridDBColumn;
    TableViewCitelEMP_NOMEMP: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure TableViewCitelDblClick(Sender: TObject);
  private
    { Private declarations }
    FQryApuracao: TUniQuery ;
    FBlnModoIncluir: boolean ;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples ;

{ TfrmApuracaoLucroRealLalurLacs }

procedure TfrmApuracaoLucroRealLalurLacs.btnEditarClick(Sender: TObject);
var
  LStrAutoInc: string ;
begin
  inherited;
  if not fValidaRegistroSelecionado(FQryApuracao) then
  begin
    exit ;
  end;

  FBlnModoIncluir := False ;
  if fIncluiAlteraApuracao(FBlnModoIncluir, FQryApuracao) then
  begin
    LStrAutoInc := FQryApuracao.FieldByName('AUTOINCREM').AsString ;
    pCarregaApuracao(FQryApuracao) ;
    FQryApuracao.Locate('AUTOINCREM', LStrAutoInc, [loCaseInsensitive] ) ;
    pSetFocus(GridCitel);
  end;

end;

procedure TfrmApuracaoLucroRealLalurLacs.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if not fValidaRegistroSelecionado(FQryApuracao) then
  begin
    exit ;
  end;

  if fMensagem('ATENÇÃO!','Confirma a exclusão? ', ['&Sim', '&Não'], 2) = 2 then
  begin
    Exit;
  end;

  if fExcluiApuracao(FQryApuracao.FieldByName('AUTOINCREM').AsString) then
  begin
    pCarregaApuracao(FQryApuracao) ;
    pSetFocus(GridCitel) ;
  end;

end;

procedure TfrmApuracaoLucroRealLalurLacs.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FBlnModoIncluir := True ;
  if fIncluiAlteraApuracao(FBlnModoIncluir, FQryApuracao) then
  begin
    pCarregaApuracao(FQryApuracao) ;
    FQryApuracao.Last ;
    pSetFocus(GridCitel);
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacs.FormCreate(Sender: TObject);
begin
  inherited;
  FQryApuracao := fCriaQuery ;
  FBlnModoIncluir := False ;
end;

procedure TfrmApuracaoLucroRealLalurLacs.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQryApuracao) ;
end;

procedure TfrmApuracaoLucroRealLalurLacs.FormShow(Sender: TObject);
begin
  inherited;
  dsApuracao.Enabled := False ;
  try
    pCarregaApuracao(FQryApuracao) ;
    dsApuracao.DataSet := FQryApuracao ;
  finally
    dsApuracao.Enabled := True ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacs.TableViewCitelDblClick(
  Sender: TObject);
begin
  inherited;
  btnEditar.Click ;
end;

end.
