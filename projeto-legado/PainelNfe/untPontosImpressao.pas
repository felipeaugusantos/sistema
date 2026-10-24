unit untPontosImpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, AppEvnts, Menus, Grids, DBGridCitel, DBGrids,
{$IF Defined(UNIDAC)}
  Uni,
{$ELSE}
  ZConnection, ZDataset,
{$IFEND}
  ExtCtrls, ComCtrls;

type
  TfrmPontosImpressao = class(TForm)
    dbgPonImp: TDBGridCitel;
    mnuAuxiliar: TPopupMenu;
    mnuConfigurarRel: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    dtsPonImp: TDataSource;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    procedure dbgPonImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qryPon: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strPonImp: String;
  end;

var
  frmPontosImpressao: TfrmPontosImpressao;

implementation

{$R *.dfm}

procedure TfrmPontosImpressao.dbgPonImpKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_RETURN) Then
  Begin
    strPonImp := qryPon.FieldByName('PON_NOMPON').AsString;
    ModalResult := mrOk;
  End;

end;

procedure TfrmPontosImpressao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (ModalResult <> mrOk) Then
    Action := caNone
  Else
    inherited;

end;

procedure TfrmPontosImpressao.FormShow(Sender: TObject);
begin

  dtsPonImp.DataSet := qryPon;
  dbgPonImp.DataSource := dtsPonImp;
  qryPon.Open;

  pnlInfo.Caption := 'Tecle Enter ao escolher';

end;

end.
