unit Contabilidade.View.ConfigLucroPresumidoCopiarDe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, UniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  Contabilidade.Interfaces.ConfigLucroPresumido;

type
  TfrmConfigLucroPresumidoCopiarDe = class(TfrmPaiConfirmaContabilidade)
    cdsConfs: TUniClientDataSet;
    cdsConfsCODIGO: TStringField;
    cdsConfsCODEMP: TStringField;
    cdsConfsEXERCI: TIntegerField;
    dsConfs: TDataSource;
    GridConfsView: TcxGridDBTableViewCitel;
    GridConfsLevel1: TcxGridLevel;
    GridConfs: TcxGridCitel;
    GridConfsViewCODIGO: TcxGridDBColumn;
    GridConfsViewCODEMP: TcxGridDBColumn;
    GridConfsViewEXERCI: TcxGridDBColumn;
    cdsConfsNOMEMP: TStringField;
    GridConfsViewNOMEMP: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FblnConfirma: Boolean ;
    FintExercicio: Integer ;
    FstrCodEmp: String ;
  public
    { Public declarations }
    function fCarregarDados: Boolean ;
    property blnConfirma: Boolean read FblnConfirma ;
    property CodEmp: String read FstrCodEmp write FstrCodEmp ;
    property Exercicio: Integer read FintExercicio write FintExercicio ;
  end;

implementation

uses
  Contabilidade.Classes.ConfigLucroPresumidoComum, System.Generics.Collections;

{$R *.dfm}

procedure TfrmConfigLucroPresumidoCopiarDe.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FblnConfirma := True ;
  Close ;
end;

procedure TfrmConfigLucroPresumidoCopiarDe.FormCreate(Sender: TObject);
begin
  inherited;
  cdsConfs.CreateDataSet ;
  FblnConfirma := False ;
end;

function TfrmConfigLucroPresumidoCopiarDe.fCarregarDados: Boolean;
var
  LlstCopiarDe: TList<IDadosConfigLucroPresumidoCfgGeral> ;
  LObjItem: IDadosConfigLucroPresumidoCfgGeral ;
begin
  Result := False ;
  cdsConfs.EmptyDataSet ;
  LlstCopiarDe := TCopiarConfiguracaoLucroPresumidoDe.New.fConfiguracao ;
  for LObjItem in LlstCopiarDe do
  begin
    if (LObjItem.CodEmp <> FstrCodEmp) or (LObjItem.Exerci <> FintExercicio) then
    begin
      cdsConfs.Append ;
      cdsConfs.FieldByName('CODIGO').AsString := LObjItem.Codigo ;
      cdsConfs.FieldByName('CODEMP').AsString := LObjItem.CodEmp ;
      cdsConfs.FieldByName('NOMEMP').AsString := LObjItem.NomEmp ;
      cdsConfs.FieldByName('EXERCI').AsInteger := LObjItem.Exerci ;
      cdsConfs.Post ;
    end ;
  end ;

  if cdsConfs.IsEmpty then
    Exit ;

  Result := True ;
end;

end.
