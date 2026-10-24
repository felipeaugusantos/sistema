unit untFatConfOrcamentos_ItensSeries;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxButtonEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  System.Math, UniClientDataSet, untFuncFat, untFatGor;

type
  TfrmFatConfOrcamentos_ItensSeries = class(TfrmPai)
    cxgItensTableView: TcxGridDBTableViewCitel;
    cxgItensLevel: TcxGridLevel;
    cxgItens: TcxGridCitel;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensAUTOINCREM: TStringField;
    cdsItensFDO_CODITE: TStringField;
    cdsItensFDO_DESCRI: TStringField;
    cdsItensFDO_QTDITE: TFloatField;
    cxgItensTableViewFDO_CODITE: TcxGridDBColumn;
    cxgItensTableViewFDO_DESCRI: TcxGridDBColumn;
    cxgItensTableViewFDO_QTDITE: TcxGridDBColumn;
    cxgItensTableViewSERIES: TcxGridDBColumn;
    cdsItensSERIES: TIntegerField;
    btnConfirmar: TBitBtnLocked;
    cdsItensFDO_SEQFDO: TStringField;
    cdsItensFDO_EMPITE: TStringField;
    cdsItensFDO_TEMNSE: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensTableViewSERIESPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    intDecQtd: Integer;
    procedure pAbreFormSeries;
    function fValidaQuantSerieItens: Boolean;
    function fGravaSeriesNseDor: Boolean;
  public
    { Public declarations }
    fatVenda: TFatVenda
  end;

implementation

uses
  untFuncoesSimples, untFatMultiSerie;

{$R *.dfm}

procedure TfrmFatConfOrcamentos_ItensSeries.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If Not fValidaQuantSerieItens Then
  Begin
    pMensagemOk('A quantidade total das séries está divergente da quantidade do item "'+ cdsItensFDO_DESCRI.AsString +'".'+
      sLineBreak + '-Quantidade informada: '+ FloatToStrF(fatVenda.objFatSerieItem.fGetTotQuant, ffFixed, 12, intDecQtd) +
      sLineBreak + '-Quantidade do Pedido: '+ FloatToStrF(cdsItensFDO_QTDITE.AsFloat, ffFixed, 12, intDecQtd));
    Exit;
  End;

  If Not fPergunta('Confirma a gravação das séries no Pedido?') Then
    Exit;

  If fGravaSeriesNseDor Then
    ModalResult := mrOK;
end;

procedure TfrmFatConfOrcamentos_ItensSeries.cxgItensTableViewSERIESPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pAbreFormSeries;
end;

procedure TfrmFatConfOrcamentos_ItensSeries.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If ModalResult = mrCancel Then
    CanClose := fPergunta('Deseja realmente cancelar?', False);
end;

procedure TfrmFatConfOrcamentos_ItensSeries.FormCreate(Sender: TObject);
begin
  inherited;
  intDecQtd := fCfgSis('DECQTD', varInteger);
  cdsItensFDO_QTDITE.DisplayFormat := fDisplayFormat(intDecQtd);
  cdsItens.CreateDataSet;
  cdsItens.LogChanges := False;
end;

procedure TfrmFatConfOrcamentos_ItensSeries.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: pEscapePressed;
    VK_F10: btnConfirmar.Click;
  End;
end;

procedure TfrmFatConfOrcamentos_ItensSeries.FormShow(Sender: TObject);
begin
  inherited;
  cdsItens.First;
end;

function TfrmFatConfOrcamentos_ItensSeries.fGravaSeriesNseDor: Boolean;
begin
  Result := True;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If Not fEmptyStr(cdsItensFDO_SEQFDO.AsString) Then
      Begin
        pLimpaNseDor(cdsItensFDO_SEQFDO.AsString);
        fatVenda.objFatSerieItem.AutoincItem := cdsItensFDO_SEQFDO.AsString;
        fatVenda.objFatSerieItem.pFiltraDataSet;

        fatVenda.objFatSerieItem.cdsFatSeries.First;
        While Not fatVenda.objFatSerieItem.cdsFatSeries.Eof Do
        Begin
          Result := fGravaNseDor(cdsItensFDO_SEQFDO.AsString,
                                 fatVenda.objFatSerieItem.cdsFatSeries.FieldByName('NUMSER').AsString,
                                 fatVenda.objFatSerieItem.cdsFatSeries.FieldByName('QTDSER').AsFloat);

          If Not Result Then
            Exit;

          fatVenda.objFatSerieItem.cdsFatSeries.Next;
        End;

        If Result Then
        Begin
          fExecutaSQL('UPDATE EXTDOR SET FDO_TEMNSE = "S" WHERE FDO_SEQFDO = '+ QuotedStr(cdsItensFDO_SEQFDO.AsString));
          cdsItens.Edit;
          cdsItensFDO_TEMNSE.AsString := 'S';
          cdsItens.Post;
        End;
      End;

      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

function TfrmFatConfOrcamentos_ItensSeries.fValidaQuantSerieItens: Boolean;
begin
  Result := True;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      fatVenda.objFatSerieItem.AutoincItem := IIF(fEmptyStr(cdsItensFDO_SEQFDO.AsString),
                                                  cdsItensAUTOINCREM.AsString,
                                                  cdsItensFDO_SEQFDO.AsString);
      fatVenda.objFatSerieItem.pFiltraDataSet;

      If Not SameValue(fFormataFloat(fatVenda.objFatSerieItem.fGetTotQuant, intDecQtd),
                       fFormataFloat(cdsItensFDO_QTDITE.AsFloat, intDecQtd)) Then
      Begin
        Result := False;
        Break;
      End;

      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmFatConfOrcamentos_ItensSeries.pAbreFormSeries;
  Var
    frmFatMultiSerie: TfrmFatMultiSerie;
begin
  pCriarFormularios(TfrmFatMultiSerie, frmFatMultiSerie);
  Try
    fatVenda.objFatSerieItem.AutoincItem := IIF(fEmptyStr(cdsItensFDO_SEQFDO.AsString),
                                                cdsItensAUTOINCREM.AsString,
                                                cdsItensFDO_SEQFDO.AsString);
    fatVenda.objFatSerieItem.pFiltraDataSet;

    If fatVenda.objFatSerieItem.cdsFatSeries.IsEmpty Then
      fatVenda.objFatSerieItem.pCarregaSeriesItem(cdsItensFDO_CODITE.AsString, cdsItensFDO_EMPITE.AsString);

    frmFatMultiSerie.pAlimentaCdsSeriesInformadoCtrlF3DoCaixa(fatVenda.objFatSerieItem.cdsFatSeries, fatVenda.objFatSerieItem.cdsSeries);
    frmFatMultiSerie.fltQtdItemPed := cdsItensFDO_QTDITE.AsFloat;
    frmFatMultiSerie.ShowModal;

    If frmFatMultiSerie.ModalResult <> mrOk Then
      Exit;

    fatVenda.objFatSerieItem.pApagaSeries;
    fatVenda.objFatSerieItem.pApagaSeriesGravacao;

    frmFatMultiSerie.cdsSeries.First;
    While Not frmFatMultiSerie.cdsSeries.Eof Do
    Begin
      fatVenda.objFatSerieItem.pInsereSerie(frmFatMultiSerie.cdsSeriesNUMSER.AsString,
                                            frmFatMultiSerie.cdsSeriesQTDSER.AsFloat);

      If (frmFatMultiSerie.cdsSeriesQTDSER.AsFloat > 0) Then
      Begin
        fatVenda.objFatSerieItem.pInsereSerieParaGravacao(frmFatMultiSerie.cdsSeriesNUMSER.AsString,
                                                          frmFatMultiSerie.cdsSeriesQTDSER.AsFloat);
      End;

      frmFatMultiSerie.cdsSeries.Next;
    End;
  Finally
    pFreeAndNil(frmFatMultiSerie);
  End;
end;

end.
