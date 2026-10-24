unit untItensDocumento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxTextEdit;

type
  TfrmItensDocumento = class(TfrmPai)
    cxgItens: TcxGridCitel;
    cxgItensTv: TcxGridDBTableViewCitel;
    cxgItensLevel1: TcxGridLevel;
    cxgItensTvCODITE: TcxGridDBColumn;
    cxgItensTvDESITE: TcxGridDBColumn;
    cxgItensTvMARCA_: TcxGridDBColumn;
    cxgItensTvCODFAB: TcxGridDBColumn;
    cxgItensTvUNIDAD: TcxGridDBColumn;
    cxgItensTvQTDITE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    dtsItens : TDataSource;
    qryItens : TUniQuery;
    FstrTabela: String;
    FstrAutInc: String;
  published
    property strTabela: String read FstrTabela write FstrTabela;
    property strAutInc: String read FstrAutInc write FstrAutInc;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmItensDocumento.FormCreate(Sender: TObject);
begin
  inherited;
  qryItens := fCriaQuery;
  dtsItens := fCriaDataSource(qryItens);
  cxgItensTv.DataController.DataSource := dtsItens;
end;

procedure TfrmItensDocumento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsItens);
  FreeAndNil(qryItens);
end;

procedure TfrmItensDocumento.FormShow(Sender: TObject);
  Var
    strPrefixo : String;
begin
  inherited;

  strPrefixo := 'DET_';
  If (strTabela = 'FATDOR') Then
    strPrefixo := 'FDO_';

  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add(' SELECT                  ');
  qryItens.SQL.Add('   '+strPrefixo+'CODITE AS CODITE, ');
  qryItens.SQL.Add('   ITE_DESITE AS DESITE, ');
  qryItens.SQL.Add('   MAR_DESMAR AS MARCA_, ');
  qryItens.SQL.Add('   ITE_CODFAB AS CODFAB, ');
  qryItens.SQL.Add('   UNI_DESUNI AS UNIDAD, ');
  qryItens.SQL.Add('   '+strPrefixo+'QTDITE AS QTDITE  ');
  qryItens.SQL.Add(' FROM '+strTabela+'      ');
  qryItens.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = '+strPrefixo+'CODITE ');
  qryItens.SQL.Add(' INNER JOIN CADMAR ON MAR_CODMAR = '+strPrefixo+'CODMAR ');
  qryItens.SQL.Add(' INNER JOIN CADUNI ON UNI_CODUNI = '+strPrefixo+'UNIDAD ');
  qryItens.SQL.Add(' WHERE '+strPrefixo+'SEQGER = :AUTINC; ');
  qryItens.ParamByName('AUTINC').AsString := strAutInc;
  qryItens.Open;

  If (Not qryItens.IsEmpty) Then
    TFloatField(qryItens.FieldByName('QTDITE')).DisplayFormat := '#,##0.00';
end;

end.
