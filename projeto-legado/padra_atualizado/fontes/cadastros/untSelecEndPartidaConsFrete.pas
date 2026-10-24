unit untSelecEndPartidaConsFrete;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Uni, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TfrmSelecEndPartidaConsFrete = class(TfrmPaiConfirma)
    dtsEndere: TDataSource;
    cxgEndereTableView: TcxGridDBTableViewCitel;
    cxgEndereLevel: TcxGridLevel;
    cxgEndere: TcxGridCitel;
    cxgEndereTableViewEND_DESCRI: TcxGridDBColumn;
    cxgEndereTableViewEND_ENDERE: TcxGridDBColumn;
    cxgEndereTableViewEND_BAIRRO: TcxGridDBColumn;
    cxgEndereTableViewEND_NOMCID: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qryEndere: TUniQuery;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmSelecEndPartidaConsFrete.btnConfirmaClick(Sender: TObject);
begin
 // inherited;
  If Not qryEndere.IsEmpty Then
    ModalResult := mrOk;
end;

procedure TfrmSelecEndPartidaConsFrete.FormCreate(Sender: TObject);
begin
  inherited;
  qryEndere := fCriaQuery;
  dtsEndere.DataSet := qryEndere;
end;

procedure TfrmSelecEndPartidaConsFrete.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryEndere);
end;

procedure TfrmSelecEndPartidaConsFrete.FormShow(Sender: TObject);
begin
  inherited;
  qryEndere.SQL.Add('SELECT ENPAFR.AUTOINCREM,');
  qryEndere.SQL.Add('       END_DESCRI,');
  qryEndere.SQL.Add('       END_C_E_P_,');
  qryEndere.SQL.Add('       END_CODCID,');
  qryEndere.SQL.Add('       CONCAT(END_ENDERE, ", ", END_NUMERO) AS END_ENDERE,');
  qryEndere.SQL.Add('       END_BAIRRO,');
  qryEndere.SQL.Add('       END_ENDPAD,');
  qryEndere.SQL.Add('       CONCAT(CID_NOMCID, "/", CID_ESTADO) AS END_NOMCID');
  qryEndere.SQL.Add('FROM ENPAFR');
  qryEndere.SQL.Add('LEFT JOIN CADCID ON CID_CODCID = END_CODCID');
  qryEndere.SQL.Add('WHERE END_CODEMP = :CODEMP');
  qryEndere.SQL.Add('  AND END_SITUAC = "A"');

  qryEndere.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryEndere.Open;

  qryEndere.Locate('END_ENDPAD', 'S', []);
end;

end.
