unit untTefCitelDadosCartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, Uni, untLiberacao, Datasnap.DBClient, UniClientDataSet, shellapi;

type
  TfrmTefCitelDadosCartao = class(TfrmPai)
    Panel1: TPanel;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1DBTableViewCitel1TFT_DTATRA: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    dtsDados: TDataSource;
    cxGridCitel1DBTableViewCitel1TFT_NUMDOC: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1TFT_NUMNSU: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1TFT_VALTRA: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1TFT_HRATRA: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1TFT_STATUS: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1SERVIDOR: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1USUARIO: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1MAQUINA: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitelNUMCUPOM: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitelVALOR: TcxGridDBColumn;
    CdsDados: TUniClientDataSet;
    CdsDadosCUPOM: TStringField;
    CdsDadosIDCUPOM: TStringField;
    CdsDadosDATA: TDateField;
    CdsDadosHORA: TTimeField;
    cxGridCitel1DBTableViewCitelDATA: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitelHORA: TcxGridDBColumn;
    Panel2: TPanel;
    Label1: TLabel;
    btnLinkCliSitef: TBitBtnLocked;
    CdsDadosVALOR: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnLinkCliSitefClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untTefCitelUtil;

{$R *.dfm}

procedure TfrmTefCitelDadosCartao.btnLinkCliSitefClick(Sender: TObject);
begin
  inherited;
  pBrowserNavigate(PChar(btnLinkCliSitef.Caption));
end;

procedure TfrmTefCitelDadosCartao.FormShow(Sender: TObject);
begin
  inherited;
  dtsDados.DataSet := CdsDados;
end;

end.
