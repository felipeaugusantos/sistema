unit untConsMovBanIgnorados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxButtonEdit, cxTextEdit, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Uni,
  untFuncoesConsulta, untTypesSistema;

type
  TArrSelIDX = TArray<String>;

  TfrmConsMovBanIgnorados = class(TfrmPai)
    grdLancIgnorados: TcxGrid;
    grdLancIgnoradosDBTableView1: TcxGridDBTableView;
    grdLanIgnDBAUTOINCREM: TcxGridDBColumn;
    grdLanIgnDBCTB_DTALAN: TcxGridDBColumn;
    grdLanIgnDBCTB_CODEMP: TcxGridDBColumn;
    grdLanIgnDBCTB_CREDEB: TcxGridDBColumn;
    grdLanIgnDBCTB_VALLAN: TcxGridDBColumn;
    grdLanIgnDBCTB_HIST01: TcxGridDBColumn;
    grdLanIgnDBCTB_IGNORA: TcxGridDBColumn;
    grdLanIgnDBCTB_PAGCON: TcxGridDBColumn;
    grdLanIgnDBCTB_ORIGEM: TcxGridDBColumn;
    grdLanIgnDBCTB_CODCTA: TcxGridDBColumn;
    grdLancIgnoradosLevel1: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure grdLanIgnDBAUTOINCREMPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grdLancIgnoradosDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    FqryMovBanIgn: TUniQuery;
    FdtsMovBanIgn: TDataSource;
    procedure CarregaMovIgnorados;
    function RecomporLancamento(AAutInc: String): Boolean;
    procedure ConfirmaRecomposicao;
    function fRetornaIndiceMarcados(ADragView: TcxGridDBTableView): TArrSelIDX;
    function ValidaTotalSelecionado: Boolean;
    procedure ChamarTelaDetalhe(ASeqLan, AOrigem: String);
  public
    { Public declarations }
    DtaIni : TDateTime;
    DtaFin : TDateTime;
    CodPor : String;
    CodCta : String;
    ArrCta : TConsultasArray;
  end;

implementation

uses
  untFuncoesSimples, untLogCba, untFuncoesRel;

{$R *.dfm}

procedure TfrmConsMovBanIgnorados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    btnConfirmar.Click
  Else If (Key = VK_ESCAPE) Then
    Close;
end;

procedure TfrmConsMovBanIgnorados.FormShow(Sender: TObject);
begin
  inherited;
  CarregaMovIgnorados;
end;

function TfrmConsMovBanIgnorados.ValidaTotalSelecionado: Boolean;
Var
  LArrIdxSel : TArrSelIDX;
  LEncontrou : Boolean;
  LTotRec    : Double;
  LTotRecPos : Double;
  LTotRecNeg : Double;
  LCount     : Integer;
begin
  SetLength(LArrIdxSel, 0);

  LTotRecPos := 0;
  LTotRecNeg := 0;
  LEncontrou := False;

  LArrIdxSel := fRetornaIndiceMarcados(grdLancIgnoradosDBTableView1);

  For LCount := 0 To Length(LArrIdxSel)-1 Do
  Begin
    If (LArrIdxSel[LCount] <> '') Then
    Begin
      If grdLancIgnoradosDBTableView1.DataController.Values[LArrIdxSel[LCount].ToInteger(), grdLanIgnDBCTB_IGNORA.Index] = 'S' Then
      Begin
        LEncontrou := True;
        If grdLancIgnoradosDBTableView1.DataController.Values[LArrIdxSel[LCount].ToInteger(), grdLanIgnDBCTB_CREDEB.Index] = 'C' Then
          LTotRecPos := LTotRecPos + grdLancIgnoradosDBTableView1.DataController.Values[LArrIdxSel[LCount].ToInteger(), grdLanIgnDBCTB_VALLAN.Index]
        Else
          LTotRecNeg := LTotRecNeg - grdLancIgnoradosDBTableView1.DataController.Values[LArrIdxSel[LCount].ToInteger(), grdLanIgnDBCTB_VALLAN.Index];
      End;
    End;
  End;

  If (Not LEncontrou) Then
  Begin
    fMensagem('Aviso', 'Não Foram encontrados lançamentos para recompor!', ['&O k']);
    Abort;
  End;

  LTotRec := fFormataFloat(LTotRecPos, 2) + fFormataFloat(LTotRecNeg, 2);

  Result := (LTotRec = 0);
end;

procedure TfrmConsMovBanIgnorados.ConfirmaRecomposicao;
Var
  LConfirma  : Boolean;
  LArrIdxSel : TArrSelIDX;
  LCount     : Integer;
  LAutInc    : String;
begin
  If (FqryMovBanIgn.IsEmpty) Then
  Begin
    fMensagem('Aviso', 'Não há dados para serem processados!', ['&O k']);
    Exit;
  End;

  If (grdLancIgnoradosDBTableView1.DataController.GetSelectedCount = 0) Then
  Begin
    fMensagem('Aviso', 'Selecione um lançamento para recompor!', ['&O k']);
    Exit;
  End;



  If (Not ValidaTotalSelecionado) Then
  Begin
    fMensagem('Aviso', 'Só é permitido recompor lançamentos da movimentação bancária,' + #13+
                       'em situação de estorno, sendo necessário que a soma dos lançamentos ' + #13 +
                       'a recompor seja igual a 0!', ['&O k']);
    Exit;
  End;

  If (fMensagem('Atenção', 'Deseja recompor os lançamentos selecionados?', ['&S i m', '&N ã o']) = 2) Then
    Exit;

  fStartTransaction();

  LConfirma := False;

  LArrIdxSel := fRetornaIndiceMarcados(grdLancIgnoradosDBTableView1);

  Try
    For LCount := 0 To Length(LArrIdxSel)-1 Do
    Begin
      If (LArrIdxSel[LCount] <> '') Then
      Begin
        If (grdLancIgnoradosDBTableView1.DataController.Values[LArrIdxSel[LCount].ToInteger(), grdLanIgnDBCTB_IGNORA.index] = 'S') Then
        Begin
          LAutInc := grdLancIgnoradosDBTableView1.DataController.GetRecordId(LArrIdxSel[LCount].ToInteger());

          LConfirma := RecomporLancamento(LAutInc);

          If (Not LConfirma) Then
            Break;

          untLogCba.GravaLogCba(LAutInc, 'RECOMPÔS LANÇAMENTO IGNORADO', self.Name);
        End;
      End;
    End;

    If (LConfirma) Then
    Begin
      fCommit();
      fMensagem('Aviso', 'Recomposição realizada com sucesso!', ['&O k']);
      Close;
    End
    Else
    Begin
      fRollBack();
      fMensagem('Aviso', 'Atenção: Não foi possível recompor o lançamento selecionado!', ['&O k']);
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack();
      pMensagensErro('Erro: ' + E.Message,'[ConfirmaRecomposicao]');
    End;
  End;
end;

function TfrmConsMovBanIgnorados.RecomporLancamento(AAutInc: String): Boolean;
Var
  LSQL: String;
  LqryAtuMov: TUniQuery;
begin
  LSQL := ' UPDATE MOVBAN ' +
            ' SET ' +
            '   CTB_DTACON = NULL, ' +
            '   CTB_HORCON = NULL, ' +
            '   CTB_OPECON = NULL, ' +
            '   CTB_IGNORA = "N",  ' +
            '   CTB_OCOIGN = NULL  ' +
            ' WHERE ' +
            '   AUTOINCREM = :AUTINC';

  LqryAtuMov := fCriaQuery();
  LqryAtuMov.SQL.Text := LSQL;

  Try
    LqryAtuMov.ParamByName('AUTINC').AsString := AAutInc;
    Try
      LqryAtuMov.ExecSQL;
      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro('Erro: ' + E.Message,'[RecomporLancamento]');
      End;
    End;
  Finally
    FreeAndNil(LqryAtuMov);
  End;
end;

procedure TfrmConsMovBanIgnorados.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  case Msg.Message of
    WM_KEYDOWN:
      begin
        if (Msg.wParam = VK_ESCAPE) then
        begin
          Msg.wParam := 0;
          Close;
        end;
      end;
  end;
end;

function TfrmConsMovBanIgnorados.fRetornaIndiceMarcados(
  ADragView: TcxGridDBTableView): TArrSelIDX;
var
  LSelIdx: String;
  LCount : Integer;
  LRowIdx: Integer;
  LRecIdx: Integer;
begin
  SetLength(Result, 0);
  LSelIdx := '';

  For LCount := 0 To ADragView.DataController.GetSelectedCount - 1 Do
  Begin
    LRowIdx    := ADragView.DataController.GetSelectedRowIndex(LCount);
    LRecIdx := ADragView.Controller.SelectedRecords[LCount].RecordIndex;

    If ADragView.DataController.GetRowInfo(LRowIdx).Level = ADragView.DataController.Groups.GroupingItemCount Then
      LRecIdx     := ADragView.DataController.GetRowInfo(LRowIdx).RecordIndex;

    if Pos(Formatfloat('0000000', LRecIdx)+'_', LSelIdx) <= 0  then
      LSelIdx := Formatfloat('0000000', LRecIdx) + '_' + LSelIdx;
  End;

  Result := LSelIdx.Split(['_']);
end;

procedure TfrmConsMovBanIgnorados.ChamarTelaDetalhe(ASeqLan,AOrigem: String);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(78, 5338, [5339,5340,5341,5342,5343],
                        ['SEQLAN'],
                        [ASeqLan],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmConsMovBanIgnorados.grdLancIgnoradosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  LValor: String;
begin
 inherited;
  If AViewInfo.GridRecord.Selected Then
  Begin
    ACanvas.Brush.Color := clNavy;
    ACanvas.Font.Color  := clWhite;
  End;

  LValor := VarAsType(grdLancIgnoradosDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdLanIgnDBCTB_CREDEB.Index], varString);

  If LValor = 'D' Then
    ACanvas.Font.Color  := clRed;
end;

procedure TfrmConsMovBanIgnorados.grdLanIgnDBAUTOINCREMPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
    ChamarTelaDetalhe(FqryMovBanIgn.FieldByName('CTB_SEQLAN').AsString,
                     FqryMovBanIgn.FieldByName('CTB_ORIGEM').AsString);
end;

procedure TfrmConsMovBanIgnorados.btnConfirmarClick(Sender: TObject);
begin
  ConfirmaRecomposicao;
end;

procedure TfrmConsMovBanIgnorados.CarregaMovIgnorados;
Var
  LSQL  : String;
  LLinha: String;
begin
  LSQL := ' SELECT   ' +
            '   AUTOINCREM, ' +
            '   CTB_DTALAN, ' +
            '   CTB_CODEMP, ' +
            '   CTB_CREDEB, ' +
            '   CTB_VALLAN, ' +
            '   CTB_HIST01, ' +
            '   CTB_IGNORA, ' +
            '   CTB_PAGCON, ' +
            '   CTB_CODCTA, ' +
            '   CTB_SEQLAN, ' +
            '   CTB_ORIGEM  ' +
            ' FROM MOVBAN ' +
            ' WHERE  ' +
            '   CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN AND ' +
            '   CTB_IGNORA = "S" AND ' +
            '   CTB_DTACON IS NOT NULL ';

  If (CodPor  <> '') Then
    LSQL := LSQL + '   AND CTB_CODPOR = :CODPOR ';

  If (Not fEmptyStr(CodCta)) Then
    LSQL := LSQL + fStrLocate(CodCta, arrCta, 'CTB_CODCTA', 'CODCTA');

  LSQL := LSQL + ' ORDER BY CTB_DTALAN  ';

  FqryMovBanIgn := fCriaQuery();
  FqryMovBanIgn.Close;
  FqryMovBanIgn.SQL.Clear;
  FqryMovBanIgn.SQL.Add(LSQL);
  FqryMovBanIgn.ParamByName('DTAINI').AsDate := dtaIni;
  FqryMovBanIgn.ParamByName('DTAFIN').AsDate := dtaFin;
  pSetaParam(CodCta, arrCta, LLinha, 'CODCTA', FqryMovBanIgn);

  If (CodPor  <> '') Then
    FqryMovBanIgn.ParamByName('CODPOR').AsString := CodPor;

  FqryMovBanIgn.Open;

  FdtsMovBanIgn := fCriaDataSource(FqryMovBanIgn);
  grdLancIgnoradosDBTableView1.DataController.DataSource := FdtsMovBanIgn;
end;

end.
