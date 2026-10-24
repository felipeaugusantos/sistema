unit untTriggerCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, strUtils,
  cxLookAndFeelPainters, cxStyles, cxProgressBar, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Datasnap.DBClient, UniClientDataSet,
  cxButtonEdit, cxEditRepositoryItems, System.Actions, Vcl.ActnList, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmTriggerCRM = class(TfrmPai)
    cxGridTriggerCRMLevel1: TcxGridLevel;
    TriggerCRMTableView: TcxGridDBTableViewCitel;
    cxGridTriggerCRM: TcxGridCitel;
    TriggerCRMTableViewDescri: TcxGridDBColumn;
    cdsDados: TUniClientDataSet;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDESCRI: TStringField;
    cdsDadosCODSIT: TStringField;
    cdsDadosCODPAI: TIntegerField;
    dtsDados: TDataSource;
    TriggerCRMTableViewCodPai: TcxGridDBColumn;
    TriggerCRMTableViewCodSit: TcxGridDBColumn;
    cdsDadosDESSIT: TStringField;
    cxEditRepository: TcxEditRepository;
    cxButtonItem: TcxEditRepositoryButtonItem;
    ActionList1: TActionList;
    LimparVinculo: TAction;
    AdicionarVinculo: TAction;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure TriggerCRMTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure TriggerCRMTableViewCodSitGetProperties(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure cdsDadosAfterScroll(DataSet: TDataSet);
    procedure LimparVinculoExecute(Sender: TObject);
    procedure AdicionarVinculoExecute(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure TriggerCRMTableViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pAddRegistro(intCodigo : Integer; strDescri : String; intCodPai : Integer);
    function fGravaProgress(cxProgress: TcxProgressBar): Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untGravando, untTypesCRM;

procedure TfrmTriggerCRM.AdicionarVinculoExecute(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    qryConsul : TUniQuery;
    strCodToc : String;
    strMens: String;
begin
  inherited;
  Try
    case TTriggerCRMGroup(cdsDados.FieldByName('CODPAI').AsInteger DIV 100) of
      tcgOrcamentoVenda: strCodToc := fCfgSis('VENORC', varString);
      tcgPedidoVenda,
      tcgExpedicaoTipo2,
      tcgExpedicaoTipo3,
      tcgExpedicaoTipo4,
      tcgRomaneioComExpedicao234,

      tcgExpedicaoTipo5: strCodToc := fCfgSis('VENPED', varString);
      tgcGarantia: strCodToc := fCfgSis('VENDEV', varString);

      tgcConfirmacaoDocumento : Begin
                                  strCodToc := fCfgSis('TOCCNF', varString);

                                  If fEmptyStr(strCodToc) Then
                                  Begin
                                    strMens := '[CFG_TOCCNF] Tipo de Ocorrência - Confirmação de Documento.' + #13#10;
                                    fMensagem('Informação',strMens + 'Favor configurar antes de prosseguir !', ['&O K']);
                                    Exit;
                                  End;
                                End;
    else
      strCodToc := '';
    end;

    qryConsul := fCriaQuery;
    chrKey := '/';
    If fPesqSitOcorrencias(Self, nil, nil, qryConsul, chrKey, arrSel, True, True, strCodToc) Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('CODSIT').AsString := qryConsul.FieldByName('SIT_CODSIT').AsString;
      cdsDados.FieldByName('DESSIT').AsString := qryConsul.FieldByName('SIT_CODSIT').AsString + ' - ' +
                                                 qryConsul.FieldByName('SIT_DESSIT').AsString;
      cdsDados.Post;
    End;
  Finally
    FreeAndNil(qryConsul);
  End;
end;

procedure TfrmTriggerCRM.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fMensagem('','Deseja gravar alterações?', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fGravaProgress;
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando);
      ModalResult := mrOK;
    End;
  End;

end;

Function TfrmTriggerCRM.fGravaProgress(cxProgress : TcxProgressBar) : Boolean;
  Var
    qryInsUpt : TUniQuery;
Begin
  Try
    Result := True;
    qryInsUpt := fCriaQuery(Self);
    With qryInsUpt, SQL Do
    Begin
      Close;
      Clear;
      Add(' REPLACE CRMTRG(TRG_CODTRG, TRG_CODSIT) VALUES (:CODTRG, :CODSIT) ');
    End;

    cxProgress.Properties.Max := cdsDados.RecordCount;
    cxProgress.Position := 0;

    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      qryInsUpt.ParamByName('CODTRG').AsInteger := cdsDadosCODIGO.Value;
      qryInsUpt.ParamByName('CODSIT').AsString  := cdsDadosCODSIT.AsString;
      qryInsUpt.ExecSQL;

      cdsDados.Next;

      cxProgress.Position := cdsDados.RecNo;
    End;
  Finally
    cdsDados.EnableControls;
    FreeAndNil(qryInsUpt);
  End;

End;

procedure TfrmTriggerCRM.cdsDadosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  TriggerCRMTableViewCodSit.Options.Editing := cdsDadosCODPAI.Value > 0;
end;

procedure TfrmTriggerCRM.FormCreate(Sender: TObject);
Var
  tcgGroup: TTriggerCRMGroup;
  tciItem: TTriggerCRMItem;
begin
  inherited;
  cdsDados.EmptyDataSet;

  For tcgGroup := Low(TTriggerCRMGroup) To High(TTriggerCRMGroup) Do
  Begin
    If (Not tcgGroup.fAtivo()) Then
      Continue;

    pAddRegistro(tcgGroup.fGetCodigo(), tcgGroup.fGetDescricao(), 0);
    For tciItem := Low(TTriggerCRMItem) To High(TTriggerCRMItem) Do
    Begin
      If (Not tciItem.fAtivo(tcgGroup)) Or
        (Not (tciItem.fPertenceAoGrupo(tcgGroup))) Then
        Continue;

      pAddRegistro(tciItem.fGetCodigo(), tciItem.fGetDescricao(), tcgGroup.fGetCodigo());
    End;
  End;

  cdsDados.First;
end;

procedure TfrmTriggerCRM.LimparVinculoExecute(Sender: TObject);
begin
  inherited;
  cdsDados.Edit;
  cdsDados.FieldByName('CODSIT').Clear;
  cdsDados.FieldByName('DESSIT').Clear;
  cdsDados.Post;
end;

procedure TfrmTriggerCRM.pAddRegistro(intCodigo: Integer; strDescri: String; intCodPai: Integer);
begin
  cdsDados.Append;
  cdsDados.FieldByName('CODIGO').AsInteger := intCodigo;
  cdsDados.FieldByName('DESCRI').AsString  := strDescri;
  cdsDados.FieldByName('CODPAI').AsInteger := intCodPai;
  If intCodPai > 0 Then
  Begin
    cdsDados.FieldByName('CODSIT').AsString  := fCampoTabela('TRG_CODSIT', 'CRMTRG', ['TRG_CODTRG'], [IntToStr(intCodigo)], False);
    cdsDados.FieldByName('DESSIT').AsString  := cdsDados.FieldByName('CODSIT').AsString + ' - ' +
                                                fRetDesSitOco( cdsDados.FieldByName('CODSIT').AsString );
  End;
  cdsDados.Post;
end;

procedure TfrmTriggerCRM.TriggerCRMTableViewCodSitGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Not Assigned(ARecord) Then
    Exit;

  If ARecord.ViewData.DataController.Values[ARecord.ViewInfo.GridRecord.RecordIndex, TriggerCRMTableViewCodPai.Index] > 0 Then
    AProperties := cxButtonItem.Properties;
end;

procedure TfrmTriggerCRM.TriggerCRMTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.GridRecord.RecordIndex < 0 Then
    Exit;

  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  TriggerCRMTableViewCodPai.Index] = 0 Then
  Begin
    ACanvas.Canvas.Brush.Color := clGray;
    ACanvas.Canvas.Font.Color  := clWhite;
    ADone := False;
  End;

end;

procedure TfrmTriggerCRM.TriggerCRMTableViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    pEscapePressed;
end;

end.
