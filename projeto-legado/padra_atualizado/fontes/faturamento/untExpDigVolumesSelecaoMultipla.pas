unit untExpDigVolumesSelecaoMultipla;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, cxCheckBox;

type
  TfrmExpDigVolumesSelecaoMultipla = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    btnConfirma: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    grdEtiDespachoDBTableView: TcxGridDBTableView;
    grdEtiDespachoLevel1: TcxGridLevel;
    grdEtiDespacho: TcxGrid;
    cdsEtiquetas: TUniClientDataSet;
    cdsEtiquetasNUMDOC: TStringField;
    cdsEtiquetasESPDOC: TStringField;
    cdsEtiquetasDOCESP: TStringField;
    cdsEtiquetasCODEMP: TStringField;
    cdsEtiquetasCODCLI: TStringField;
    cdsEtiquetasNOMCLI: TStringField;
    cdsEtiquetasCODNOM: TStringField;
    cdsEtiquetasPESBRU: TFloatField;
    cdsEtiquetasVOLUME: TIntegerField;
    dtaEtiquetas: TDataSource;
    grdEtiDespachoDOCESP: TcxGridDBColumn;
    grdEtiDespachoCODEMP: TcxGridDBColumn;
    grdEtiDespachoCODNOM: TcxGridDBColumn;
    grdEtiDespachoPESBRU: TcxGridDBColumn;
    grdEtiDespachoVOLUME: TcxGridDBColumn;
    cdsEtiquetasIMPETI: TBooleanField;
    grdEtiDespachoIMPETI: TcxGridDBColumn;
    cdsEtiquetasPESLIQ: TFloatField;
    grdEtiDespachoPESLIQ: TcxGridDBColumn;
    grdEtiDespachoVOLEXS: TcxGridDBColumn;
    grdEtiDespachoVOLEXN: TcxGridDBColumn;
    cdsEtiquetasVOLEXS: TIntegerField;
    cdsEtiquetasVOLEXN: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsEtiquetasBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    blnUtilizaSeparacaoExclusiva: Boolean;
    function fValidarEtiquetasParaImpressao: Boolean;
    procedure pMarcaDesmarcaTodasEtiquetasParaImpressao(AMarca: Boolean = True);
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmExpDigVolumesSelecaoMultipla.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if (fValidarEtiquetasParaImpressao) then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmExpDigVolumesSelecaoMultipla.btnDesmarcaClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodasEtiquetasParaImpressao(False);
end;

procedure TfrmExpDigVolumesSelecaoMultipla.btnMarcaClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodasEtiquetasParaImpressao;
end;

procedure TfrmExpDigVolumesSelecaoMultipla.cdsEtiquetasBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  If blnUtilizaSeparacaoExclusiva Then
  Begin
    cdsEtiquetas.FieldByName('VOLEXN').AsFloat := cdsEtiquetas.FieldByName('VOLUME').AsFloat - cdsEtiquetas.FieldByName('VOLEXS').AsFloat;

    If fFormataFloat(cdsEtiquetas.FieldByName('VOLEXN').AsFloat, 3) < 0.0 Then
    Begin
      pMensagemOk('O campo "Volume dos itens de Separação não Exclusiva" não pode ficar negativo. '+
        'Ajuste o Volume para poder continuar (ele deve ser maior ou igual ao volume dos itens '+
        'de separação exclusiva) ou revise as configurações de cálculo de volume, pois o volume '+
        'dos itens de separação exclusiva devem seguir as configurações de cálculo de volume do Sistema.');
      Abort;
    End;

    If fFormataFloat(cdsEtiquetas.FieldByName('VOLUME').AsFloat, 3) <>
       fFormataFloat(cdsEtiquetas.FieldByName('VOLEXS').AsFloat + cdsEtiquetas.FieldByName('VOLEXN').AsFloat, 3) Then
    Begin
      pMensagemOk('O Volume deve ser igual à soma dos campos "Volume dos itens de Separação Exclusiva" e '+
        '"Volume dos itens de Separação Não Exclusiva". Realize o ajuste do campo do volume para poder continuar.');
      Abort;
    End;
  End;
end;

procedure TfrmExpDigVolumesSelecaoMultipla.FormCreate(Sender: TObject);
begin
  inherited;
  cdsEtiquetas.CreateDataSet;
end;

procedure TfrmExpDigVolumesSelecaoMultipla.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F2: btnMarca.Click;
    VK_F3: btnDesmarca.Click;
    VK_F10: btnConfirma.Click;
  end;
end;

procedure TfrmExpDigVolumesSelecaoMultipla.FormShow(Sender: TObject);
begin
  inherited;
  grdEtiDespachoPESLIQ.Visible := (fCfgSis('PESLIQ') = 'SOMA');

  blnUtilizaSeparacaoExclusiva := fCfgSis('SEPEXC', varBoolean);

  If Not blnUtilizaSeparacaoExclusiva Then
  Begin
    grdEtiDespachoVOLEXS.Visible := False;
    grdEtiDespachoVOLEXN.Visible := False;
    Self.Width := Self.Width - 200;
  End;
end;

function TfrmExpDigVolumesSelecaoMultipla.fValidarEtiquetasParaImpressao: Boolean;
var
  LEtiquetasMarcadasParaImprimir: integer;
begin
  Result := True;
  LEtiquetasMarcadasParaImprimir := 0;
  cdsEtiquetas.DisableControls;

  try
    cdsEtiquetas.First;

    while not cdsEtiquetas.Eof do
    begin
      if (fEmptyStr(cdsEtiquetasPESBRU.AsString)) then
      begin
        fMensagem('ATENÇÃO!', 'Peso bruto não informado para o documento '+cdsEtiquetasDOCESP.AsString+'', ['&Ok']);
        Exit(False);
      end;

      if (cdsEtiquetasPESBRU.AsFloat < 0) then
      begin
        fMensagem('ATENÇÃO!', 'Peso bruto do documento '+cdsEtiquetasDOCESP.AsString+' inválido.', ['&Ok']);
        Exit(False);
      end;

      if (grdEtiDespachoPESLIQ.Visible) then
      begin
        if (fEmptyStr(cdsEtiquetasPESLIQ.AsString)) then
        begin
          fMensagem('ATENÇÃO!', 'Peso líquido não informado para o documento '+cdsEtiquetasDOCESP.AsString+'', ['&Ok']);
          Exit(False);
        end;

        if (cdsEtiquetasPESLIQ.AsFloat < 0) then
        begin
          fMensagem('ATENÇÃO!', 'Peso líquido do documento '+cdsEtiquetasDOCESP.AsString+' inválido.', ['&Ok']);
          Exit(False);
        end;
      end;

      if (fEmptyStr(cdsEtiquetasVOLUME.AsString)) then
      begin
        fMensagem('ATENÇÃO!', 'Volume não informado para o documento  '+cdsEtiquetasDOCESP.AsString+'', ['&Ok']);
        Exit(False);
      end;

      if (cdsEtiquetasVOLUME.AsInteger < 1) then
      begin
        if (cdsEtiquetasIMPETI.AsBoolean) then
        begin
          fMensagem('ATENÇÃO!', 'Documento '+cdsEtiquetasDOCESP.AsString+' marcado para imprimir com volume inválido.', ['&Ok']);
          Exit(False);
        end;
      end;

      if (cdsEtiquetasIMPETI.AsBoolean) then
      begin
        Inc(LEtiquetasMarcadasParaImprimir);
      end;

      cdsEtiquetas.Next;
    end;

    if (LEtiquetasMarcadasParaImprimir = 0) then
    begin
      fMensagem('ATENÇÃO!', 'Não foi marcado nenhuma etiqueta para impressão.', ['&Ok']);
      Exit(False);
    end;
  finally
    cdsEtiquetas.First;
    cdsEtiquetas.EnableControls;
  end;
end;

procedure TfrmExpDigVolumesSelecaoMultipla.pMarcaDesmarcaTodasEtiquetasParaImpressao(
  AMarca: Boolean);
begin
  cdsEtiquetas.DisableControls;

  try
    cdsEtiquetas.First;

    while not cdsEtiquetas.Eof do
    begin
      cdsEtiquetas.Edit;
      cdsEtiquetasIMPETI.AsBoolean := AMarca;
      cdsEtiquetas.Post;
      cdsEtiquetas.Next;
    end;

    cdsEtiquetas.First;
  finally
    cdsEtiquetas.EnableControls;
  end;
end;

end.
