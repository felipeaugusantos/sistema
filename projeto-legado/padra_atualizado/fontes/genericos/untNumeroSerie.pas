unit untNumeroSerie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel;

type
  TModoAbertura = (maEntrada, maCadProduto, maSaida);

  TfrmNumeroSerie = class(TfrmPaiConfirma)
    cxDadosTbl: TcxGridDBTableView;
    cxDadosLvl: TcxGridLevel;
    cxDados: TcxGrid;
    dtsDados: TDataSource;
    cxDadosLinha: TcxGridDBColumn;
    cxDadosNUMSER: TcxGridDBColumn;
    cxDadosMarcado: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cxDadosTblInitEdit(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
    procedure cxDadosTblEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FBeforePostBackup: TDataSetNotifyEvent;
    cdsBkp: TUniClientDataSet;
    FBlnSomenteLeitura: Boolean;
    FBlnDevolucao: Boolean;
    procedure onBeforePost(DataSet: TDataSet);
    function fNumeroSerieUtilizado(var UtilizadoEmBanco: Boolean): Boolean;
  public

   // Este ponteiro quando a lista de numeros de serie devolver um objeto de series é vinculado a propria lista aqui
   // para poder percorrer todos os objetos TNumeroSerie para saber se o numero de serie ja foi utilizado
    ListaSeries: Pointer;

    ModoAbertura: TModoAbertura;
    { Public declarations }
   published
    property blnSomenteLeitura: Boolean read FBlnSomenteLeitura Write FBlnSomenteLeitura;
    property blnDevolucao: Boolean read FBlnDevolucao Write FBlnDevolucao;
  end;

var
  frmNumeroSerie: TfrmNumeroSerie;

implementation

uses
  untFuncoesSimples, untTNumeroSerie;

{$R *.dfm}

procedure TfrmNumeroSerie.btnConfirmaClick(Sender: TObject);
begin
  pSetFocus(btnConfirma);
  inherited;

end;

procedure TfrmNumeroSerie.cxDadosTblEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    cxDadosTbl.Controller.FocusNextRecord(cxDadosTbl.Controller.FocusedRecordIndex, True, False, false, false);
end;

procedure TfrmNumeroSerie.cxDadosTblInitEdit(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
begin
  cdsBkp.Data := TUniClientDataSet(dtsDados.DataSet).Data;
end;

function TfrmNumeroSerie.fNumeroSerieUtilizado(var UtilizadoEmBanco: Boolean): Boolean;
begin
  Result := fNumeroSerieExiste(dtsDados.DataSet.FieldByName('SER_CODITE').AsString, dtsDados.DataSet.FieldByName('SER_NUMSER').NewValue, True);

  If blnDevolucao And Result Then
    Result := Not fNumeroSerieExiste(dtsDados.DataSet.FieldByName('SER_CODITE').AsString, dtsDados.DataSet.FieldByName('SER_NUMSER').NewValue, False);

  UtilizadoEmBanco := Result;
  If Not Result Then
  Begin
    Result := cdsBkp.Locate('SER_NUMSER', dtsDados.DataSet.FieldByName('SER_NUMSER').NewValue, []);
    If Result Then
      Result := cdsBkp.FieldByName('LINHA').AsInteger <> dtsDados.DataSet.FieldByName('LINHA').AsInteger;

    If Not Result Then
    Begin
      If Assigned(ListaSeries) Then
      Begin
        Result := TListaSeries(ListaSeries).fExiste(dtsDados.DataSet.FieldByName('SER_NUMSER').NewValue,
                                          dtsDados.DataSet.FieldByName('SER_CODITE').AsString, True);
      End;
    End;
  End;
End;

procedure TfrmNumeroSerie.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If (ModoAbertura = maEntrada) Or (ModoAbertura = maSaida) Then
    dtsDados.DataSet.BeforePost := FBeforePostBackup;

  inherited;
end;

procedure TfrmNumeroSerie.FormCreate(Sender: TObject);
begin
  inherited;
  cdsBkp := TUniClientDataSet.Create(nil);
  ModoAbertura := maCadProduto;
  FblnSomenteLeitura := False;
end;

procedure TfrmNumeroSerie.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsBkp);
end;

procedure TfrmNumeroSerie.FormShow(Sender: TObject);
begin
  inherited;
  cxDadosTbl.OptionsData.Editing := ((ModoAbertura = maEntrada) Or (ModoAbertura = maSaida)) And (Not FblnSomenteLeitura);
  If ModoAbertura = maEntrada Then
  begin
    FBeforePostBackup := dtsDados.DataSet.BeforePost;
    dtsDados.DataSet.BeforePost := onBeforePost;
  End;
end;

procedure TfrmNumeroSerie.onBeforePost(DataSet: TDataSet);
var blnUtilizadoEmBanco: Boolean;
begin
  If ModoAbertura = maEntrada Then
  Begin
    If fNumeroSerieUtilizado(blnUtilizadoEmBanco) Then
    Begin
      dtsDados.DataSet.FieldByName('SER_NUMSER').AsString := dtsDados.DataSet.FieldByName('SER_NUMSER').OldValue;
      fMensagem('Atenção', 'Número de Série já utilizado.', ['&OK']);
    End;
  End;
end;

end.
