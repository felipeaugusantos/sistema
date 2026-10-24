unit untFatManutRomaneioEntEsp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Uni;

type
  TfrmFatManutRomaneioEntEsp = class(TfrmPai)
    Panel1: TPanel;
    cxGrdResumoView: TcxGridDBTableViewCitel;
    cxGrdResumoLevel: TcxGridLevel;
    cxGrdResumo: TcxGridCitel;
    Panel2: TPanel;
    cxGrdPedidosView: TcxGridDBTableViewCitel;
    cxGrdPedidosLevel: TcxGridLevel;
    cxGrdPedidos: TcxGridCitel;
    Splitter1: TSplitter;
    Label1: TLabel;
    Label2: TLabel;
    cxGrdPedItensLevel: TcxGridLevel;
    cxGrdPedItensView: TcxGridDBTableViewCitel;
    cxGrdResumoViewCODITE: TcxGridDBColumn;
    cxGrdResumoViewDESCRI: TcxGridDBColumn;
    cxGrdResumoViewQTDITE: TcxGridDBColumn;
    cxGrdPedidosViewNUMDOC: TcxGridDBColumn;
    cxGrdPedidosViewDTAENT: TcxGridDBColumn;
    cxGrdPedidosViewNOMCLI: TcxGridDBColumn;
    cxGrdPedItensViewNUMDOC: TcxGridDBColumn;
    cxGrdPedItensViewCODITE: TcxGridDBColumn;
    cxGrdPedItensViewDESCRI: TcxGridDBColumn;
    cxGrdPedItensViewQTDITE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryResumo: TUniQuery;
    qryPedidos: TUniQuery;
    qryItens: TUniQuery;
    procedure pAbreConsultas;
  public
    { Public declarations }
    strNumRom: String;
  end;

implementation

uses
  untFuncoesSimples, untSalvaConfiguracaoGrid;

{$R *.dfm}

procedure TfrmFatManutRomaneioEntEsp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not qryResumo.IsEmpty Then
  Begin
    TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxGrdResumoView, Self.Name +'_res');
    TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxGrdPedidosView, Self.Name +'_ped');
    TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxGrdPedItensView, Self.Name +'_ite');
  End;
end;

procedure TfrmFatManutRomaneioEntEsp.FormCreate(Sender: TObject);
begin
  inherited;
  cxGrdResumoView.OnKeyDown  := pOnKeyDown;
  cxGrdPedidosView.OnKeyDown := pOnKeyDown;

  qryResumo  := fCriaQuery;
  qryPedidos := fCriaQuery;
  qryItens   := fCriaQuery;

  cxGrdResumoView.DataController.DataSource   := fCriaDataSource(qryResumo);
  cxGrdPedidosView.DataController.DataSource  := fCriaDataSource(qryPedidos);
  cxGrdPedItensView.DataController.DataSource := fCriaDataSource(qryItens);
end;

procedure TfrmFatManutRomaneioEntEsp.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryResumo);
  FreeAndNil(qryPedidos);
  FreeAndNil(qryItens);
end;

procedure TfrmFatManutRomaneioEntEsp.FormShow(Sender: TObject);
begin
  inherited;
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxGrdResumoView, Self.Name +'_res');
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxGrdPedidosView, Self.Name +'_ped');
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxGrdPedItensView, Self.Name +'_ite');

  pAbreConsultas;

  If qryResumo.IsEmpty Then
  Begin
    pMensagemOk('Não há itens com Entrega Especial neste Romaneio!');
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  End;
end;

procedure TfrmFatManutRomaneioEntEsp.pAbreConsultas;
begin
  qryResumo.SQL.Add('SELECT DET_CODITE');
  qryResumo.SQL.Add('      ,DET_DESCRI');
  qryResumo.SQL.Add('      ,SUM(DET_QTDITE) AS DET_QTDITE');
  qryResumo.SQL.Add('FROM ROMGERX R');
  qryResumo.SQL.Add('JOIN ROMDETX D ON D.DET_SEQGER = R.AUTOINCREM');
  qryResumo.SQL.Add('JOIN CADITE I  ON I.ITE_CODITE = D.DET_CODITE AND I.ITE_ENTESP = "S"');
  qryResumo.SQL.Add('WHERE GER_NUMROM = :NUMROM');
  qryResumo.SQL.Add('  AND GER_EMPROM = :EMPROM');
  qryResumo.SQL.Add('GROUP BY DET_CODITE, DET_DESCRI');
  qryResumo.SQL.Add('ORDER BY DET_DESCRI');
  qryResumo.ParamByName('NUMROM').AsString := strNumRom;
  qryResumo.ParamByName('EMPROM').AsString := VS_strCodEmp;
  qryResumo.Open;

  qryPedidos.SQL.Add('SELECT CONCAT(GER_NUMDOC,"-",GER_ESPDOC) AS GER_NUMDOC');
  qryPedidos.SQL.Add('      ,GER_DTAENT');
  qryPedidos.SQL.Add('      ,CLI_NOMCLI');
  qryPedidos.SQL.Add('FROM ROMGERX R');
  qryPedidos.SQL.Add('JOIN CADCLI C ON C.CLI_CODCLI = R.GER_CODCLI');
  qryPedidos.SQL.Add('WHERE R.GER_NUMROM = :NUMROM');
  qryPedidos.SQL.Add('  AND R.GER_EMPROM = :EMPROM');
  qryPedidos.SQL.Add('  AND EXISTS(');
  qryPedidos.SQL.Add('    SELECT 1 FROM ROMDETX D');
  qryPedidos.SQL.Add('    JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE AND I.ITE_ENTESP = "S"');
  qryPedidos.SQL.Add('    WHERE D.DET_SEQGER = R.AUTOINCREM)');
  qryPedidos.SQL.Add('ORDER BY GER_NUMDOC');
  qryPedidos.ParamByName('NUMROM').AsString := strNumRom;
  qryPedidos.ParamByName('EMPROM').AsString := VS_strCodEmp;
  qryPedidos.Open;

  qryItens.SQL.Add('SELECT CONCAT(GER_NUMDOC,"-",GER_ESPDOC) AS GER_NUMDOC');
  qryItens.SQL.Add('      ,DET_CODITE');
  qryItens.SQL.Add('      ,DET_DESCRI');
  qryItens.SQL.Add('      ,SUM(DET_QTDITE) AS DET_QTDITE');
  qryItens.SQL.Add('FROM ROMGERX R');
  qryItens.SQL.Add('JOIN ROMDETX D ON D.DET_SEQGER = R.AUTOINCREM');
  qryItens.SQL.Add('JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE AND I.ITE_ENTESP = "S"');
  qryItens.SQL.Add('WHERE GER_NUMROM = :NUMROM');
  qryItens.SQL.Add('  AND GER_EMPROM = :EMPROM');
  qryItens.SQL.Add('GROUP BY GER_NUMDOC, GER_ESPDOC, DET_CODITE, DET_DESCRI');
  qryItens.SQL.Add('ORDER BY GER_NUMDOC, DET_DESCRI');
  qryItens.ParamByName('NUMROM').AsString := strNumRom;
  qryItens.ParamByName('EMPROM').AsString := VS_strCodEmp;
  qryItens.Open;

  TFloatField(qryResumo.FieldByName('DET_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(qryItens.FieldByName('DET_QTDITE')).DisplayFormat  := fMskDigitos(fCfgSis('DECQTD', varInteger));
end;

end.
