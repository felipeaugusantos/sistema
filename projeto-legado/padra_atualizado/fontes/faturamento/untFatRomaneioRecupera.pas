unit untFatRomaneioRecupera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Uni;

type
  TfrmFatRomaneioRecupera = class(TfrmPaiConfirma)
    btnDescarta: TBitBtnLocked;
    cxgRomaneio: TcxGridCitel;
    cxvRomaneios: TcxGridDBTableViewCitel;
    cxvRomaneiosColumn1: TcxGridDBColumn;
    cxvRomaneiosColumn2: TcxGridDBColumn;
    cxvRomaneiosColumn3: TcxGridDBColumn;
    cxvRomaneiosNUMROM: TcxGridDBColumn;
    cxvRomaneiosColumn7: TcxGridDBColumn;
    cxgRomaneioLevel1: TcxGridLevel;
    dsGrid: TDataSource;
    cxvRomaneiosColumn4: TcxGridDBColumn;
    Panel2: TPanel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDescartaClick(Sender: TObject);
    procedure cxvRomaneiosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FQryGrid: TUniQuery;
  public
    { Public declarations }
    class function fSeleciona: String;
  end;

var
  frmFatRomaneioRecupera: TfrmFatRomaneioRecupera;

implementation

uses
  untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmFatRomaneioRecupera.btnDescartaClick(Sender: TObject);
begin
  inherited;
  if FQryGrid.IsEmpty then
    Exit;

  If fPergunta('Confirma o descarte da cópia de segurança do romaneio selecionado?') Then
    FQryGrid.Delete;
end;

procedure TfrmFatRomaneioRecupera.cxvRomaneiosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Shift <> [ssCtrl]) Then
  Begin

    If (Key = VK_RETURN) Then
    Begin

      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(205, 7604, [],
                              ['CODGER'],
                              [FQryGrid.FieldByname('GER_CODGER').AsString],
                              Sender,
                              nil,
                              True);
      End;

    End;

  End;

end;

procedure TfrmFatRomaneioRecupera.FormCreate(Sender: TObject);
begin
  inherited;
  FQryGrid := fCriaQuery(Nil);
  dsGrid.DataSet := FQryGrid;
end;

procedure TfrmFatRomaneioRecupera.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQryGrid);
end;

procedure TfrmFatRomaneioRecupera.FormShow(Sender: TObject);
begin
  inherited;
  FQryGrid.SQL.Add('SELECT R.*, O.OPE_NOMOPE, G.GER_DTABAI');
  FQryGrid.SQL.Add(' FROM ROMGER_RES R');
  FQryGrid.SQL.Add(' LEFT JOIN CADOPE O ON R.GER_CODOPE = O.OPE_CODOPE');
  FQryGrid.SQL.Add(' LEFT JOIN ROMGERX G ON R.GER_NUMROM = G.GER_NUMROM AND G.GER_EMPROM = :EMPROM ');
  FQryGrid.SQL.Add('WHERE R.GER_CODOPE = :CODOPE AND G.GER_DTABAI IS NULL');
  FQryGrid.SQL.Add(' ORDER BY R.GER_DTACAD DESC, R.GER_HORCAD DESC');
  FQryGrid.ParamByName('EMPROM').AsString := VS_strCodEmp;
  FQryGrid.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

  FQryGrid.Open;
end;

class function TfrmFatRomaneioRecupera.fSeleciona: String;
begin
  frmFatRomaneioRecupera := TfrmFatRomaneioRecupera.Create(nil);
  try
    if frmFatRomaneioRecupera.ShowModal = MrOk then
      if not frmFatRomaneioRecupera.FQryGrid.IsEmpty then
        Result := frmFatRomaneioRecupera.FQryGrid.FieldByName('GER_CODGER').AsString;

  finally
    pFreeAndNil(frmFatRomaneioRecupera);
  end;
end;

end.
