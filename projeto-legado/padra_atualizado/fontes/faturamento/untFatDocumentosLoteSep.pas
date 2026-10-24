unit untFatDocumentosLoteSep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient, Datasnap.DBClient,
  UniClientDataSet;

type
  TfrmFatDocumentosLoteSep = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label1: TLabel;
    grdDados: TcxGridCitel;
    grdDadosTv: TcxGridDBTableViewCitel;
    grdDadosLvl: TcxGridLevel;
    grdDadosTvSELECI: TcxGridDBColumn;
    grdDadosTvDOCUME: TcxGridDBColumn;
    grdDadosTvCLIENT: TcxGridDBColumn;
    grdDadosTvDTAENT: TcxGridDBColumn;
    cdsDados: TUniClientDataSet;
    dtsDados: TDataSource;
    cdsDadosSELECI: TBooleanField;
    cdsDadosAUTINC: TStringField;
    cdsDadosNUMDOC: TStringField;
    cdsDadosESPDOC: TStringField;
    cdsDadosCODEMP: TStringField;
    cdsDadosCODCLI: TStringField;
    cdsDadosNOMCLI: TStringField;
    cdsDadosDTAENT: TDateField;
    cdsDadosDOCUME: TStringField;
    cdsDadosCLIENT: TStringField;
    cdsDadosLOTSEP: TStringField;
    grdDadosTvColumn1: TcxGridDBColumn;
    cdsDadosAUTINCLOTSEP: TStringField;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
  private
    { Private declarations }
    procedure pMarcaDesmarca(blnMarca: Boolean);
  public
    { Public declarations }
    function fMontaTela(cdsPedidos: TDataSet; stlPedidos: TStringList): Boolean;
  end;

implementation

uses
  untFuncoesSimples, untRomLge;

{$R *.dfm}

procedure TfrmFatDocumentosLoteSep.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarca(False);
end;

procedure TfrmFatDocumentosLoteSep.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarca(True);
end;

function TfrmFatDocumentosLoteSep.fMontaTela(cdsPedidos: TDataSet; stlPedidos: TStringList): Boolean;
var
  strAutIncPed: String;
  strAutIncLotSep: String;
  strNumLote: String;
begin
  cdsDados.CreateDataSet;

  For strAutIncPed In stlPedidos Do
    If (Not strAutIncPed.IsEmpty) Then
      If cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
      Begin
        strAutIncLotSep := fRetLoteSeparacao(
          cdsPedidos.FieldByName('NUMDOC').AsString,
          cdsPedidos.FieldByName('ESPDOC').AsString,
          cdsPedidos.FieldByName('CODEMP').AsString);

        if not fEmptyStr(strAutIncLotSep) then
        begin
          strNumLote := fCampoTabela('RLG_NUMLOT', 'ROMLGE', ['AUTOINCREM'], [strAutIncLotSep], False);

          cdsDados.Append;
          cdsDados.FieldByName('SELECI').AsBoolean := False;
          cdsDados.FieldByName('AUTINC').AsString := cdsPedidos.FieldByName('AUTINC').AsString;
          cdsDados.FieldByName('NUMDOC').AsString := cdsPedidos.FieldByName('NUMDOC').AsString;
          cdsDados.FieldByName('ESPDOC').AsString := cdsPedidos.FieldByName('ESPDOC').AsString;
          cdsDados.FieldByName('CODEMP').AsString := cdsPedidos.FieldByName('CODEMP').AsString;
          cdsDados.FieldByName('CODCLI').AsString := cdsPedidos.FieldByName('CODCLI').AsString;
          cdsDados.FieldByName('NOMCLI').AsString := cdsPedidos.FieldByName('NOMCLI').AsString;
          cdsDados.FieldByName('DTAENT').AsDateTime := cdsPedidos.FieldByName('DTAENT').AsDateTime;
          cdsDados.FieldByName('LOTSEP').AsString := strNumLote;
          cdsDados.FieldByName('AUTINCLOTSEP').AsString := strAutIncLotSep;

          cdsDados.FieldByName('DOCUME').AsString := cdsPedidos.FieldByName('NUMDOC').AsString + '-' +
                                                     cdsPedidos.FieldByName('ESPDOC').AsString + '-' +
                                                     cdsPedidos.FieldByName('CODEMP').AsString;
          cdsDados.FieldByName('CLIENT').AsString := cdsPedidos.FieldByName('CODCLI').AsString + '-' +
                                                     cdsPedidos.FieldByName('NOMCLI').AsString;

          cdsDados.Post;
        end;
      End;

  cdsDados.First;
  Result := not cdsDados.IsEmpty;
end;

procedure TfrmFatDocumentosLoteSep.pMarcaDesmarca(blnMarca: Boolean);
begin
  cdsDados.DisableControls;
  try
    cdsDados.First;
    while not cdsDados.Eof do
    begin
      cdsDados.Edit;
      cdsDados.FieldByName('SELECI').AsBoolean := blnMarca;
      cdsDados.Post;
      cdsDados.Next;
    end;
  finally
    cdsDados.EnableControls;
  end;
end;

end.
