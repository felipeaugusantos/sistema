unit untLiberaRomaneiosAppEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, System.UITypes,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Uni, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxProgressBar;

type
  TfrmLiberaRomaneiosAppEntrega = class(TfrmPai)
    cxgDadosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGridCitel;
    cxgDadosGER_SEQATV: TcxGridDBColumn;
    cxgDadosGER_NUMROM: TcxGridDBColumn;
    cxgDadosGER_DTAROM: TcxGridDBColumn;
    cxgDadosGER_HORROM: TcxGridDBColumn;
    cxgDadosMOTORISTA: TcxGridDBColumn;
    cxgDadosGER_PLAVEI: TcxGridDBColumn;
    cxgDadosQTDDOCS: TcxGridDBColumn;
    cxgDadosGER_PESBRU: TcxGridDBColumn;
    cxgDadosGER_MARDES: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgDadosDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDadosDBTableViewCitel1DblClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxgDadosDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgDadosDBTableViewCitel1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    cdsDados: TUniClientDataSet;
    dtsDados: TDataSource;
    intRecNo: Integer;

    procedure pCarregaRomaneios;
    procedure pAlinhaCelula;
    procedure pSelecionaRomaneio(strMarDes: String = '');
    function fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    function fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    function fIntRecNo: Integer;
  public
    { Public declarations }
  end;

implementation

uses untfuncoesSimples, untGravando, untTypesSistema;

{$R *.dfm}

procedure TfrmLiberaRomaneiosAppEntrega.FormCreate(Sender: TObject);
begin
  inherited;
  dtsDados := fCriaDataSource(cdsDados);
  cxgDadosDBTableViewCitel1.DataController.DataSource := dtsDados;
end;

procedure TfrmLiberaRomaneiosAppEntrega.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsDados);
  FreeAndNil(cdsDados);
end;

procedure TfrmLiberaRomaneiosAppEntrega.pAlinhaCelula;
begin
  cdsDados.FieldByName('GER_SEQATV').Alignment := taCenter;
  cdsDados.FieldByName('GER_NUMROM').Alignment := taCenter;
  cdsDados.FieldByName('GER_DTAROM').Alignment := taCenter;
  cdsDados.FieldByName('GER_HORROM').Alignment := taCenter;
  cdsDados.FieldByName('GER_PLAVEI').Alignment := taCenter;
  cdsDados.FieldByName('GER_PESBRU').Alignment := taRightJustify;
end;

procedure TfrmLiberaRomaneiosAppEntrega.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCarregaRomaneios, 'Aguarde, Carregando romaneios para liberação...', '');
end;

procedure TfrmLiberaRomaneiosAppEntrega.pCarregaRomaneios;
var
  qryRomaneios: TUniQuery;
begin

  qryRomaneios := fCriaQuery(Self);
  try
    qryRomaneios.Close;
    qryRomaneios.SQL.Text :=
    ' SELECT '+
    '   "D" AS GER_MARDES, '+
    '   IFNULL(GER_SEQATV, "") AS GER_SEQATV, '+
    '   GER_NUMROM, '+
    '   GER_DTAROM, '+
    '   GER_HORROM, '+
    '   CONCAT(GER_CODMOT, " - ", MOT_NOMMOT) AS MOTORISTA, '+
    '   GER_PLAVEI, '+
    '   COUNT(*) AS QTDDOCS, '+
    '   CONCAT(GER_PESBRU, "kg") AS GER_PESBRU '+

    ' FROM '+
    '   ROMGERX '+

    ' LEFT JOIN CADMOT '+
    '   ON GER_CODMOT = MOT_CODMOT '+

    ' WHERE '+
    '   GER_EMPROM = :EMPROM AND '+
    '   GER_LIBAPP = :LIBAPP AND '+
    '   GER_STATUS = "A" AND '+
    '   GER_DTABAI IS NULL '+

    ' GROUP BY '+
    '   GER_MARDES, '+
    '   GER_SEQATV, '+
    '   GER_NUMROM, '+
    '   GER_DTAROM, '+
    '   GER_HORROM, '+
    '   MOTORISTA,  '+
    '   GER_PLAVEI, '+
    '   GER_PESBRU  '+

    ' ORDER BY '+
        IIF(fCfgSis('TIPEXP', varString) = '5', ' GER_SEQATV, GER_NUMROM ', ' GER_NUMROM ');

    qryRomaneios.ParamByName('EMPROM').AsString:= VS_strCodEmp;
    qryRomaneios.ParamByName('LIBAPP').AsString:= 'N';
    qryRomaneios.Open;

    if Assigned(cdsDados) then
      FreeAndNil(cdsDados);

    cdsDados := fCriaClientDatset(qryRomaneios);
    pSetaClient(cdsDados);
    cdsDados.First;

    pAlinhaCelula;
    dtsDados.DataSet := cdsDados;
  finally
    FreeAndNil(qryRomaneios);
  end;

end;

procedure TfrmLiberaRomaneiosAppEntrega.pSelecionaRomaneio(strMarDes: String = '');
var
  intRecNo,
  intSeqAtv: Integer;
begin
  if not Assigned(cdsDados) then
    Exit;

  if not cdsDados.Active then
    Exit;

  if cdsDados.IsEmpty then
    Exit;

  if (fCfgSis('TIPEXP', varString) = '5') and (not fEmptyStr(cdsDados.FieldByName('GER_SEQATV').AsString)) then
  begin
    intSeqAtv := cdsDados.FieldByName('GER_SEQATV').AsInteger;
    intRecNo := cdsDados.RecNo;

    cdsDados.DisableControls;
    cdsDados.First;
    while not cdsDados.Eof do
    begin
      if cdsDados.FieldByName('GER_SEQATV').AsInteger = intSeqAtv then
      begin
        cdsDados.Edit;
        cdsDados.FieldByName('GER_MARDES').AsString := IIF(cdsDados.FieldByName('GER_MARDES').AsString = 'D', 'M', 'D');
        cdsDados.Post;
      end;
      cdsDados.Next;
    end;
    cdsDados.EnableControls;
    cdsDados.RecNo := intRecNo;
  end
  else
  begin
    cdsDados.Edit;
    if fEmptyStr(strMarDes) then
      cdsDados.FieldByName('GER_MARDES').AsString := IIF(cdsDados.FieldByName('GER_MARDES').AsString = 'D', 'M', 'D')
    else
      cdsDados.FieldByName('GER_MARDES').AsString := strMarDes;

    cdsDados.Post;
  end;
end;

procedure TfrmLiberaRomaneiosAppEntrega.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fMarcaTodos, 'Marcando documentos...');
end;

function TfrmLiberaRomaneiosAppEntrega.fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  if Assigned(cdsDados) then
  begin
    cdsDados.First;
    cdsDados.DisableControls;
    While Not cdsDados.Eof Do
    begin
      if cdsDados.FieldByName('GER_MARDES').AsString = 'D' then
        pSelecionaRomaneio;

      cdsDados.Next;
      pProgresso(cdsDados.RecNo, cdsDados.RecordCount, pgbStatus);
    end;
    cdsDados.EnableControls;
  end;
  Result := True;
end;

procedure TfrmLiberaRomaneiosAppEntrega.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fDesmarcaTodos, 'Desmarcando documentos...');
end;

function TfrmLiberaRomaneiosAppEntrega.fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  if Assigned(cdsDados) then
  begin
    cdsDados.First;
    cdsDados.DisableControls;
    While Not cdsDados.Eof Do
    begin
      if cdsDados.FieldByName('GER_MARDES').AsString = 'M' then
        pSelecionaRomaneio;

      cdsDados.Next;
      pProgresso(cdsDados.RecNo, cdsDados.RecordCount, pgbStatus);
    end;
    cdsDados.EnableControls;
  end;
  Result := True;
end;

procedure TfrmLiberaRomaneiosAppEntrega.cxgDadosDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not Assigned(cdsDados) then
    Exit;

  if not cdsDados.Active then
    Exit;

  inherited;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosGER_MARDES.Index]) = 'M' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end;

end;

procedure TfrmLiberaRomaneiosAppEntrega.cxgDadosDBTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaRomaneio;
end;

function TfrmLiberaRomaneiosAppEntrega.fIntRecNo: Integer;
begin
  Result := intRecNo;
  if Result = 0 then
     Result := cdsDados.RecNo;
end;

procedure TfrmLiberaRomaneiosAppEntrega.cxgDadosDBTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_RETURN,
    VK_SPACE: pSelecionaRomaneio;

    VK_F3: if Shift = [ssCtrl] then
             btnMarcaTodos.Click;

    VK_F4: if Shift = [ssCtrl] then
             btnDesmarcaTodos.Click;

    VK_F10: btnConfirma.Click;

    VK_ESCAPE: btnSair.Click;

    VK_UP: if (Shift = [ssShift]) and (fEmptyStr(cdsDados.FieldByName('GER_SEQATV').AsString)) then
           begin
             intRecNo := fIntRecNo;

             if intRecNo >= cdsDados.RecNo then
             begin
                pSelecionaRomaneio('M');
                cdsDados.Prior;
                pSelecionaRomaneio('M');
                cdsDados.Next;
             end
             else
               pSelecionaRomaneio('D');
           end;

    VK_DOWN: if (Shift = [ssShift]) and (fEmptyStr(cdsDados.FieldByName('GER_SEQATV').AsString)) then
             begin
               intRecNo := fIntRecNo;

               if intRecNo <= cdsDados.RecNo then
               begin
                 pSelecionaRomaneio('M');
                 cdsDados.Next;
                 pSelecionaRomaneio('M');
                 cdsDados.Prior;
               end
               else
                 pSelecionaRomaneio('D');
             end;
  end;
end;

procedure TfrmLiberaRomaneiosAppEntrega.cxgDadosDBTableViewCitel1KeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    intRecNo := 0;
end;

procedure TfrmLiberaRomaneiosAppEntrega.btnConfirmaClick(Sender: TObject);
var
  qryLibApp: TUniQuery;
begin
  inherited;

  qryLibApp := fCriaQuery(Self);
  try
    cdsDados.DisableControls;
    cdsDados.Filtered := False;
    cdsDados.Filter := 'GER_MARDES = '+QuotedStr('M');
    cdsDados.Filtered := True;

    if not cdsDados.IsEmpty then
    begin
      if fPergunta('Confirma a liberação do(s) romaneio(s) selecionado(s)?') then
      begin
        cdsDados.First;
        while not cdsDados.Eof do
        begin
          qryLibApp.Close;
          qryLibApp.SQL.Text :=
          ' UPDATE '+
          '   ROMGERX '+
          ' SET '+
          '   GER_LIBAPP = :LIBAPP '+
          ' WHERE '+
          '   GER_EMPROM = :EMPROM AND '+
          '   GER_NUMROM = :NUMROM ';

          qryLibApp.ParamByName('LIBAPP').AsString := 'S';
          qryLibApp.ParamByName('EMPROM').AsString := VS_strCodEmp;
          qryLibApp.ParamByName('NUMROM').AsString := cdsDados.FieldByName('GER_NUMROM').AsString;
          qryLibApp.ExecSQL;

          cdsDados.Next;
        end;

        fMensagem('ATENÇÃO!', 'Romaneio(s) liberado(s) com sucesso!', ['&OK']);
        pCarregaRomaneios;
      end;
    end
    else
      fMensagem('ATENÇÃO!', 'Nenhum romaneio selecionado para liberação!', ['&OK']);

  finally
    cdsDados.Filtered := False;
    cdsDados.EnableControls;

    FreeAndNil(qryLibApp);
  end;
end;

end.
