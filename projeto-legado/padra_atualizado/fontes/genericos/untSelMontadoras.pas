unit untSelMontadoras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCheckBox, untZClient;

type
  TfrmSelMontadoras = class(TfrmPaiConfirma)
    cxgMontadora: TcxGridDBTableViewCitel;
    cxlMontadora: TcxGridLevel;
    cxMontadora: TcxGridCitel;
    dtsDados: TDataSource;
    cxgMontadoraCODMOM: TcxGridDBColumn;
    cxgMontadoraDESCRI: TcxGridDBColumn;
    cxgMontadoraMARCADA: TcxGridDBColumn;
  private
    FCodIte: String;
    { Private declarations }
  protected
    FListaSelecionados: String;
    qryMontadoras: TZClient;
    procedure pPreparaDataSet;
    function fMontaResultado: String;

  public
    { Public declarations }

    class function fSelecionaMontadoras(strCodIte: String; strListaSelecionados: String = ''): string;
  end;

var
  frmSelMontadoras: TfrmSelMontadoras;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmSelMontadoras }

function TfrmSelMontadoras.fMontaResultado: String;
begin
  qryMontadoras.First;
  Result := '';
  while not qryMontadoras.Eof Do
  Begin
    If qryMontadoras.FieldByName('MARCAD').AsString = 'S' Then
      Result := Result + IIf(Result <> '', ',', '') + qryMontadoras.FieldByName('MON_CODMON').AsString;
    qryMontadoras.Next;
  End

end;

class function TfrmSelMontadoras.fSelecionaMontadoras(strCodIte,
  strListaSelecionados: String): string;
begin
  Result := strListaSelecionados;
  pCriarFormularios(TfrmSelMontadoras, frmSelMontadoras);
  Try
    frmSelMontadoras.FListaSelecionados := strListaSelecionados;
    frmSelMontadoras.FCodIte := strCodIte;
    frmSelMontadoras.pPreparaDataSet;
    If frmSelMontadoras.ShowModal = mrOk Then
    begin
      Result := frmSelMontadoras.fMontaResultado;
      If (strListaSelecionados <> '') And (Result = '') Then
        Result := 'Limpar';
    End;
  Finally
    FreeAndNil(frmSelMontadoras);
  End;
end;

procedure TfrmSelMontadoras.pPreparaDataSet;
begin
  qryMontadoras := TZClient.Create(Self);
  qryMontadoras.qryQuery.SQL.Add('SET @LISTA = "'+FListaSelecionados+'";');
  qryMontadoras.qryQuery.SQL.Add('SELECT MON_CODMON,');
  qryMontadoras.qryQuery.SQL.Add('       MON_DESCRI,');
  qryMontadoras.qryQuery.SQL.Add('       IF((SELECT COUNT(1) FROM ITEMON WHERE ITM_CODMON = MON_CODMON AND ITM_CODITE = "'+FCodIte+'") > 0, "S",');
  qryMontadoras.qryQuery.SQL.Add('        IF(LOCATE(MON_CODMON, @LISTA) > 0, "S", "N")) AS MARCAD');
  qryMontadoras.qryQuery.SQL.Add(' FROM CADMON');
  qryMontadoras.fAbreClient(False,  'TfrmSelMontadoras.pPreparaDataSet');
  dtsDados.DataSet := qryMontadoras;

end;

end.
