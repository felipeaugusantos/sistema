unit untPaiConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid,   Uni,
  cxEditRepositoryItems;

type
  TfrmPaiConfig = class(TfrmPaiSimples)
    tsConfConsulta: TTabSheet;
    dbgViewConfTinta: TcxGridDBTableView;
    dbgLvlConfTinta: TcxGridLevel;
    dbgConfTinta: TcxGrid;
    qryConf: TUniQuery;
    dtsConf: TDataSource;
    qryConfCFG_CODCFG: TStringField;
    qryConfCFG_VALCFG: TStringField;
    qryConfCFG_DESCRI: TStringField;
    qryConfCFG_GRUCFG: TStringField;
    dbgViewConfTintaCFG_CODCFG: TcxGridDBColumn;
    dbgViewConfTintaCFG_VALCFG: TcxGridDBColumn;
    dbgViewConfTintaCFG_DESCRI: TcxGridDBColumn;
    cxdtrpstryRepositorio: TcxEditRepository;
    rgbSimNao: TcxEditRepositoryRadioGroupItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    lstCampos: TStringList;
    lstPropriedades: TList;
  public
    { Public declarations }
  end;

var
  frmPaiConfig: TfrmPaiConfig;

implementation

uses
  untModulo;

{$R *.dfm}

procedure TfrmPaiConfig.FormCreate(Sender: TObject);
begin
  inherited;
  lstCampos := TStringList.Create;
  lstPropriedades := TList.Create;
end;

end.
