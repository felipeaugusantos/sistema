unit untImportacaoSimilaridadeConfirma;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics, uni, untFuncoesSimples, untSalvaConfiguracaoGrid,
 Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
 frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
 BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
 cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
 cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
 cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
 untZClient, MyClassesUni, frxDBSet, Vcl.ComCtrls, cxContainer, cxProgressBar, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox, cxGridDBDataDefinitions,
  cxCurrencyEdit, cxGridBandedTableView, cxGridDBBandedTableView,
  System.StrUtils, dxLayoutContainer, cxGridViewLayoutContainer,
  cxGridLayoutView, cxGridCustomLayoutView, cxGridCitel;

 type
  TfrmImportacaoSimilaridadeConfirma = class(TfrmPaiConfirma)
    frxGen: TfrxUserDataSet;
    frxRelatorio: TfrxDBDataset;
    dtsItens: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    styDentro: TcxStyle;
    styFora: TcxStyle;
    styEditavel: TcxStyle;
    grpLegenda: TGroupBox;
    shpNaoImportados: TShape;
    lblNaoImportados: TLabel;
    cxDados: TcxGridCitel;
    cxgItensView: TcxGridDBTableViewCitel;
    cxgItensViewLinha: TcxGridDBColumn;
    cxgItensViewDesIte: TcxGridDBColumn;
    cxlDados: TcxGridLevel;
    cxgItensViewCodIte: TcxGridDBColumn;
    cxgItensViewPRISIM: TcxGridDBColumn;
    cxgItensViewCODSIM: TcxGridDBColumn;
    cxgItensViewIMPORT: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    cdsItens: TZClient;
    fContadorLinhas: Integer;

    { Private declarations }
    function fAtualizarCodSim(intLinha: Integer): Boolean;
    function fRetornaCodSim: string;
    function fGravar(pgbProgresso: TcxProgressBar): Boolean;
  public
    function ShowModal(cdsDadosItens: TZClient; intLinhas: Integer): integer; reintroduce;
    { Public declarations }
  end;

var
  frmImportacaoSimilaridadeConfirma: TfrmImportacaoSimilaridadeConfirma;

implementation

{$R *.dfm}

uses untGravando;

{ TfrmImportacaoSimilaridadeConfirma }
procedure TfrmImportacaoSimilaridadeConfirma.btnConfirmaClick(Sender: TObject);
begin
  Try
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fGravar;
      frmGravando.lblGravando.Caption := 'Aguarde... Gravando similaridades.';
      frmGravando.ShowModal;

      Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportacaoSimilaridadeConfirma.btnConfirmaClick]');
      End;
    End;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmImportacaoSimilaridadeConfirma.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewIMPORT.Index]) = '0' Then
  begin
    ACAnvas.Brush.Color := clRed;
    ACAnvas.Font.Color := clWhite;
  end;
end;

function TfrmImportacaoSimilaridadeConfirma.fAtualizarCodSim(intLinha: Integer): Boolean;
var
  qryUpdate: TUniQuery;
  strCodSim: string;
begin
  Result := True;

  qryUpdate := fCriaQuery;

  cdsItens.Filter := 'IMPORT = 1 AND LINHA = ' + IntToStr(intLinha);
  cdsItens.Filtered := True;
  cdsItens.First;

  Try
    Try
      if cdsItens.RecordCount > 0 then
      begin
        While not cdsItens.Eof Do
        Begin
          qryUpdate.SQL.Clear;
          qryUpdate.SQL.Add('UPDATE CADITE SET ITE_CODSIM = :CODSIM, ');
          qryUpdate.SQL.Add('ITE_PRISIM = :PRISIM WHERE ITE_CODITE = :CODITE');

          if fEmptyStr(strCodSim) then
          begin
            if fEmptyStr(cdsItens.FieldByName('ITE_CODSIM').AsString) then
              strCodSim := fRetornaCodSim
            else
              strCodSim := cdsItens.FieldByName('ITE_CODSIM').Value;
          end;

          qryUpdate.ParamByName('CODSIM').Value := strCodSim;
          qryUpdate.ParamByName('PRISIM').Value := cdsItens.FieldByName('ITE_PRISIM').Value;
          qryUpdate.ParamByName('CODITE').Value := cdsItens.FieldByName('ITE_CODITE').Value;
          qryUpdate.ExecSQL;

          cdsItens.Next;
        End;
      end;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmImportacaoSimilaridadeConfirma.fAtualizarCadIte]');
      End;
    End;
  Finally
    cdsItens.Filter := EmptyStr;
    cdsItens.Filtered := False;
    FreeAndNil(qryUpdate);
  End;
end;

function TfrmImportacaoSimilaridadeConfirma.fGravar(
  pgbProgresso: TcxProgressBar): Boolean;
var
  intContador: Integer;
begin
  Result := True;

  try
    cdsItens.DisableControls;

    pgbProgresso.Properties.Max := fContadorLinhas;

    fStartTransaction;

    for intContador := 0 To fContadorLinhas do
    begin
      if not fAtualizarCodSim(intContador) then
      begin
        Result := False;
        Exit;
      end;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    end;

    if Result then
    begin
      fCommit;

      fMensagem('Aviso', 'Processo concluído com sucesso!', ['&O k']);
    end
    else
    begin
      fRollBack;

      fMensagem('Aviso', 'Erro ao gravar similaridades!', ['&O k']);
    end;
  Finally
    cdsItens.EnableControls;
  End;
end;

function TfrmImportacaoSimilaridadeConfirma.fRetornaCodSim: string;
var
  qryBuscaCodSim: TUniQuery;
begin
  Result := EmptyStr;

  Try
    try
      qryBuscaCodSim := fCriaQuery;

      qryBuscaCodSim.Close;
      qryBuscaCodSim.SQL.Clear;
      qryBuscaCodSim.SQL.Add('SELECT                     ');
      qryBuscaCodSim.SQL.Add('  SIS_VALCFG               ');
      qryBuscaCodSim.SQL.Add('FROM                       ');
      qryBuscaCodSim.SQL.Add('  CFGSIS                   ');
      qryBuscaCodSim.SQL.Add('WHERE                      ');
      qryBuscaCodSim.SQL.Add('  SIS_CODEMP = :CODEMP AND ');
      qryBuscaCodSim.SQL.Add('  SIS_CODCFG = :CODCFG     ');
      qryBuscaCodSim.SQL.Add('FOR UPDATE                 ');

      qryBuscaCodSim.ParamByName('CODEMP').Value := VS_strCodEmp;
      qryBuscaCodSim.ParamByName('CODCFG').Value := 'CFG_CODSIM';
      qryBuscaCodSim.Open;

      If Not fEmptyStr(qryBuscaCodSim.FieldByName('SIS_VALCFG').AsString) Then
        Result := fStrZero(qryBuscaCodSim.FieldByName('SIS_VALCFG').AsString, 6)
      Else
        Result := fStrZero('1', 6);

      fAtuCfgSis('CODSIM', IntToStr(StrToInt(Result)+1));
    finally
      FreeAndNil(qryBuscaCodSim);
    end;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Não consegui pegar o proximo sequencial de CODSIM em CFGSIS!');
    End;
  End;
end;

function TfrmImportacaoSimilaridadeConfirma.ShowModal(cdsDadosItens: TZClient; intLinhas: Integer): integer;
begin
  cdsItens := cdsDadosItens;
  fContadorLinhas := intLinhas;

  cdsItens.Open;

  dtsItens.DataSet := cdsItens;

  pnlInfo.Caption := 'Itens Processados com sucesso: ' + IntToStr(cdsItens.RecordCount);
  Result := inherited ShowModal;
end;

end.
