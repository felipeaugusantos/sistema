unit untGruposDadosEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxTextEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid;

type
  TfrmGruposDadosEdicao = class(TfrmPaiConfirma)
    pgcGrupos: TPageControl;
    tbsGrupo1: TTabSheet;
    tbsGrupo2: TTabSheet;
    tbsGrupo3: TTabSheet;
    pnlDados: TPanel;
    EditFocus1: TEditFocus;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    pnlInterGrafica: TPanel;
    pnlTitGraf: TPanel;
    scrLinhas: TScrollBox;
    imgFundo: TImage;
    cxgTabCam: TcxGrid;
    cxgTabCamView: TcxGridDBTableView;
    cxgTabCamDESCAM: TcxGridDBColumn;
    cxgTabCamCODCAM: TcxGridDBColumn;
    cxgTabCamPOSDES: TcxGridDBColumn;
    cxgTabCamPOSCAM: TcxGridDBColumn;
    cxgTabCamLevel1: TcxGridLevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGruposDadosEdicao: TfrmGruposDadosEdicao;

implementation

{$R *.dfm}

end.
