unit untManOrdProIndustrialLotesMP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, Uni, cxProgressBar,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, System.UITypes, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, untZClient, untPai, cxTextEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmManOrdProIndustrialLotesMP = class(TfrmPaiConfirma)
    cxgOrdLotLevel1: TcxGridLevel;
    cxgOrdLotTableView: TcxGridDBTableViewCitel;
    cxgOrdLot: TcxGridCitel;
    cxgOrdLotTableViewCODITE: TcxGridDBColumn;
    cxgOrdLotTableViewDESITE: TcxGridDBColumn;
    cxgOrdLotTableViewNEWLOT: TcxGridDBColumn;
    cxgOrdLotTableViewNUMLOT: TcxGridDBColumn;
    shpAlterados: TShape;
    Label1: TLabel;
    procedure cxgOrdLotTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
  private
    cdsOrdLot : TZClient;
    function fGetSQL : String;
    function fGetUpdate: String;
    function fGrava(cxProgressBar: TcxProgressBar): Boolean;
  public
    class procedure pManutencaoLotesMP(strAutInc : String);
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando;

{ TfrmManOrdProIndustrialLotesMP }

procedure TfrmManOrdProIndustrialLotesMP.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  If (fMensagem('','Confirma as alterações realizadas?', ['&Sim', '&Não'], 2) = 2) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGrava;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

  fMensagem('','Lote(s) atualizado(s) com sucesso!', ['&OK']);

  ModalResult := MrOK;

end;

function TfrmManOrdProIndustrialLotesMP.fGrava(cxProgressBar : TcxProgressBar):Boolean;
  Var
    qryUpdate : TUniQuery;
Begin
  Try
    Result := True;
    qryUpdate := fCriaQuery(nil);
    qryUpdate.SQL.Text := fGetUpdate;

    cdsOrdLot.CheckBrowseMode;
    cdsOrdLot.Filter := ' ODL_NUMLOT <> NEW_NUMLOT ';
    cdsOrdLot.Filtered := True;
    cdsOrdLot.DisableControls;

    cxProgressBar.Properties.Max := cdsOrdLot.RecordCount;

    While not cdsOrdLot.Eof Do
    Begin
      qryUpdate.ParamByName('AUTINC').AsString := cdsOrdLot.FieldByName('AUTOINCREM').AsString;
      qryUpdate.ParamByName('NUMLOT').AsString := cdsOrdLot.FieldByName('NEW_NUMLOT').AsString;
      qryUpdate.ExecSQL;

      cdsOrdLot.Next;
      cxProgressBar.Position := cdsOrdLot.RecNo;
    End;

  Finally
    cdsOrdLot.Filtered := False;
    cdsOrdLot.Filter := '';
    cdsOrdLot.EnableControls;
    FreeAndNil(qryUpdate);
  End;
End;

function TfrmManOrdProIndustrialLotesMP.fGetUpdate : String;
Begin
  Result := 'UPDATE ORDLOT SET ODL_NUMLOT = :NUMLOT WHERE AUTOINCREM = :AUTINC';
End;

procedure TfrmManOrdProIndustrialLotesMP.cxgOrdLotTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If ( not cdsOrdLot.Active ) or cdsOrdLot.IsEmpty Then
    Exit;

  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgOrdLotTableViewNUMLOT.Index] <>
     Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgOrdLotTableViewNEWLOT.Index] Then
  Begin
    ACanvas.Font.Color := shpAlterados.Brush.Color;
  End;
end;

function TfrmManOrdProIndustrialLotesMP.fGetSQL: String;
begin
  Result := Result + ' SELECT ITE_CODITE,                                      ';
  Result := Result + '        ITE_DESITE,                                      ';
  Result := Result + '        ODL_NUMLOT,                                      ';
  Result := Result + '        ODL_NUMLOT AS NEW_NUMLOT,                        ';
  Result := Result + '        L.AUTOINCREM                                     ';
  Result := Result + ' FROM ORDGER GR                                          ';
  Result := Result + ' INNER JOIN GEIMAT G ON GR.ORD_CODITE = G.GMT_CODITE AND ';
  Result := Result + '                           GMT_STATUS = "A"          AND ';
  Result := Result + '                           GMT_CODCOR = ORD_CODCOR       ';
  Result := Result + ' INNER JOIN DEIMAT D ON G.AUTOINCREM = D.DMT_SEQGER      ';
  Result := Result + ' INNER JOIN CADITE F ON F.ITE_CODITE = D.DMT_ITESUB      ';
  Result := Result + ' INNER JOIN ORDLOT L ON L.ODL_SEQGER = GR.AUTOINCREM     ';
  Result := Result + '                    AND L.ODL_CODITE = D.DMT_ITESUB      ';
  Result := Result + ' WHERE GR.AUTOINCREM = :AUTINC                           ';
  Result := Result + ' ORDER BY DMT_SEQUEN                                     ';
end;

class procedure TfrmManOrdProIndustrialLotesMP.pManutencaoLotesMP(strAutInc : String);
  var
    frmManOrdProIndustrialLotesMP: TfrmManOrdProIndustrialLotesMP;
begin
  Try
    pCriarFormularios(TfrmManOrdProIndustrialLotesMP, frmManOrdProIndustrialLotesMP);
    With frmManOrdProIndustrialLotesMP Do
    Begin
      cdsOrdLot := TZClient.Create(frmManOrdProIndustrialLotesMP, fGetSQL);
      cdsOrdLot.qryQuery.ParamByName('AUTINC').AsString := strAutInc;
      cdsOrdLot.fAbreClient(True, 'TfrmManOrdProIndustrialLotesMP.FormShow');
      cxgOrdLotTableView.DataController.DataSource := cdsOrdLot.dtsSource;

      If not cdsOrdLot.IsEmpty Then
        ShowModal;
    End;
  Finally
    FreeAndNil(frmManOrdProIndustrialLotesMP);
  End;

end;

end.
