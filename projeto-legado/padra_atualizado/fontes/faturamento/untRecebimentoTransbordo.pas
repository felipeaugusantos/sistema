unit untRecebimentoTransbordo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.ComCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Uni, cxProgressBar,
  System.UITypes, System.StrUtils, untFuncoesRel;

type
  TfrmRecebimentoTransbordo = class(TfrmPaiConfirma)
    grdTransbordoTv: TcxGridDBTableViewCitel;
    grdTransbordoLvl: TcxGridLevel;
    grdTransbordo: TcxGridCitel;
    dtsTransbordo: TDataSource;
    grdTransbordoTvDTHREN: TcxGridDBColumn;
    grdTransbordoTvNUMROM: TcxGridDBColumn;
    grdTransbordoTvEMPORI: TcxGridDBColumn;
    grdTransbordoTvNUMDOC: TcxGridDBColumn;
    grdTransbordoTvESPDOC: TcxGridDBColumn;
    grdTransbordoTvCODEMP: TcxGridDBColumn;
    grdTransbordoTvCLIENTE: TcxGridDBColumn;
    grdTransbordoTvNOMCID: TcxGridDBColumn;
    grdTransbordoTvESTCON: TcxGridDBColumn;
    grdTransbordoTvPESBRU: TcxGridDBColumn;
    grdTransbordoTvPESLIQ: TcxGridDBColumn;
    grdTransbordoTvVOLUME: TcxGridDBColumn;
    grdTransbordoTvVLRCON: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    grdTransbordoTvMARDES: TcxGridDBColumn;
    btnItensDocumento: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdTransbordoTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdTransbordoTvCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnItensDocumentoClick(Sender: TObject);
  private
    { Private declarations }
    FqryTransbordo: TUniQuery;

    procedure pAbreDados;
    function fAbreDados(pgbStatus: TcxProgressBar) : Boolean;
    
    function fGetSqlTransbordo: String;

    procedure pMarcarDesmarcar(blnMarcar: Boolean; pgbStatus: TcxProgressBar);
    function fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    function fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;

    function fReceberTransbordo(pgbStatus: TcxProgressBar): Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  untGravando, untFuncoesSimples, untRomGer;

procedure TfrmRecebimentoTransbordo.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  if (not FqryTransbordo.Active) or FqryTransbordo.IsEmpty then
    Exit;

  fChamaTelaGravando(fReceberTransbordo, 'Aguarde, Recebendo o(s) Transbordo(s)...');
end;

procedure TfrmRecebimentoTransbordo.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fDesmarcaTodos, 'Desmarcando documentos...');
end;

procedure TfrmRecebimentoTransbordo.btnItensDocumentoClick(Sender: TObject);
var
  strDocumentos: string;
  intRecNo: Integer;
begin
  inherited;

  if (not FqryTransbordo.Active) or FqryTransbordo.IsEmpty then
    Exit;

  strDocumentos := '';

  if fVerificaAcessoSistema('RTPVID') then
  begin

    intRecNo := FqryTransbordo.RecNo;
    FqryTransbordo.DisableControls;
    try
      FqryTransbordo.First;
      while not FqryTransbordo.Eof do
      begin
        if FqryTransbordo.FieldByName('MARDES').AsString = 'M' then
          strDocumentos := strDocumentos + IfThen(fEmptyStr(strDocumentos), '', ',') + '"' + FqryTransbordo.FieldByName('GER_NUMDOC').AsString + '-' + FqryTransbordo.FieldByName('GER_ESPDOC').AsString + '-' + FqryTransbordo.FieldByName('GER_CODEMP').AsString + '"';
        FqryTransbordo.Next;
      end;
    finally
      FqryTransbordo.RecNo := intRecNo;
      FqryTransbordo.EnableControls;
    end;

    if fEmptyStr(strDocumentos) then
      strDocumentos := '"' + FqryTransbordo.FieldByName('GER_NUMDOC').AsString + '-' + FqryTransbordo.FieldByName('GER_ESPDOC').AsString + '-' + FqryTransbordo.FieldByName('GER_CODEMP').AsString + '"';

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(352, 16334, [], ['RELDOC'], [strDocumentos], nil, nil, True);
    End;
  end
  else
    pMensagemOk('Atenção! Usuário sem direito de acesso para visualizar os itens dos documentos no recebimento do transbordo.');

end;

procedure TfrmRecebimentoTransbordo.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fMarcaTodos, 'Marcando documentos...');
end;

function TfrmRecebimentoTransbordo.fAbreDados(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;
  Try
    FqryTransbordo.Close;
    FqryTransbordo.ParamByName('EMPDES').AsString := VS_strCodEmp;
    FqryTransbordo.Open;

    TDateTimeField(FqryTransbordo.FieldByName('TRA_DTHREN')).DisplayFormat := 'dd/MM/yyyy hh:nn:ss';
    TFloatField(FqryTransbordo.FieldByName('GER_PESBRU')).DisplayFormat := '#,##0.000';
    TFloatField(FqryTransbordo.FieldByName('GER_PESLIQ')).DisplayFormat := '#,##0.000';
    TFloatField(FqryTransbordo.FieldByName('GER_VLRCON')).DisplayFormat := '#,##0.00';

    grdTransbordoTv.ApplyBestFit();
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fAbreDados - untRecebimentoTransbordo]');
    End;
  End;
end;

function TfrmRecebimentoTransbordo.fGetSqlTransbordo: String;
begin
  Result := '';
  Result := Result + 'SELECT ROMTRAX.AUTOINCREM, ';
  Result := Result + '       TIMESTAMP(TRA_DTATRA, TRA_HRATRA) AS TRA_DTHREN, ';
  Result := Result + '       GER_NUMROM, ';
  Result := Result + '       TRA_EMPORI, ';
  Result := Result + '       "D" AS MARDES, ';
  Result := Result + '       GER_NUMDOC, ';
  Result := Result + '       GER_ESPDOC, ';
  Result := Result + '       GER_CODEMP, ';
  Result := Result + '       CONCAT(GER_CODCLI, " - ", CLI_NOMCLI) AS CLIENTE, ';
  Result := Result + '       CID_NOMCID, ';
  Result := Result + '       GER_ESTCON, ';
  Result := Result + '       GER_PESBRU, ';
  Result := Result + '       GER_PESLIQ, ';
  Result := Result + '       GER_VOLUME, ';
  Result := Result + '       GER_VLRCON ';
  Result := Result + '  FROM ROMTRAX ';
  Result := Result + ' INNER JOIN ROMGERX ON ROMGERX.AUTOINCREM = TRA_SEQGER ';
  Result := Result + '  LEFT JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  Result := Result + '  LEFT JOIN CADCID ON GER_CIDCON = CID_CODCID ';
  Result := Result + 'WHERE TRA_DTAREC IS NULL ';
  Result := Result + '  AND TRA_EMPDES = :EMPDES ';
  Result := Result + 'ORDER BY TRA_DTATRA, TRA_HRATRA, GER_NUMDOC, GER_ESPDOC, GER_CODEMP ';
end;

procedure TfrmRecebimentoTransbordo.FormCreate(Sender: TObject);
begin
  inherited;
  FqryTransbordo := fCriaQuery(Self);
  FqryTransbordo.SQL.Text := fGetSqlTransbordo;
  dtsTransbordo.DataSet := FqryTransbordo;

  FqryTransbordo.Options.SetFieldsReadOnly := False;
  FqryTransbordo.CachedUpdates := True;
end;

procedure TfrmRecebimentoTransbordo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10: btnConfirma.Click;
    VK_F7 : btnMarcarTodos.Click;
    VK_F8 : btnDesmarcarTodos.Click;
    VK_F5 : btnItensDocumento.Click;
  end;
end;

procedure TfrmRecebimentoTransbordo.FormShow(Sender: TObject);
begin
  inherited;
  pAbreDados;

end;

function TfrmRecebimentoTransbordo.fReceberTransbordo(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;
  FqryTransbordo.DisableControls;
  try
    try
      FqryTransbordo.Filtered := False;
      FqryTransbordo.Filter := 'MARDES = "M"';
      FqryTransbordo.Filtered := True;

      if FqryTransbordo.IsEmpty then
      begin
        Result := False;
        pMensagemOk('Nenhum Transbordo Selecionado!');
        Exit;
      end;

      fStartTransaction;
      FqryTransbordo.First;
      while not FqryTransbordo.Eof do
      begin
        Result := untRomGer.fRecebeTransbordo(FqryTransbordo.FieldByName('AUTOINCREM').AsString);

        if not Result then
          Break;

        FqryTransbordo.Next;
        pProgresso(FqryTransbordo.RecNo, FqryTransbordo.RecordCount, pgbStatus);
      end;

      if Result then
        fCommit
      else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message,'[fReceberTransbordo - untRecebimentoTransbordo]');
      End;
    End;
  finally
    FqryTransbordo.EnableControls;
    FqryTransbordo.Filtered := False;
    FqryTransbordo.Filter := '';
  end;

  if Result then
  begin
    pMensagemOk('Recebimento do transbordo realizado com sucesso!');
    pAbreDados;
  end;
end;

procedure TfrmRecebimentoTransbordo.grdTransbordoTvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdTransbordoTvMARDES.Index]) = 'M' Then
  Begin
    If ACanvas.Brush.Color = clHighlight Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmRecebimentoTransbordo.grdTransbordoTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) then
  begin
     FqryTransbordo.Edit;
     FqryTransbordo.FieldByName('MARDES').AsString := IfThen(FqryTransbordo.FieldByName('MARDES').AsString = 'D', 'M', 'D');
     FqryTransbordo.Post;
  end;
end;

procedure TfrmRecebimentoTransbordo.pAbreDados;
begin
  fChamaTelaGravando(fAbreDados, 'Aguarde... Carregando.');
end;

procedure TfrmRecebimentoTransbordo.pMarcarDesmarcar(blnMarcar: Boolean; pgbStatus: TcxProgressBar);
var
  intRecNo: Integer;
begin
  if (not FqryTransbordo.Active) or FqryTransbordo.IsEmpty then
    Exit;

  intRecNo := FqryTransbordo.RecNo;
  try
    FqryTransbordo.DisableControls;
    FqryTransbordo.First;
    while not FqryTransbordo.Eof do
    begin
      FqryTransbordo.Edit;
      FqryTransbordo.FieldByName('MARDES').AsString := IfThen(blnMarcar, 'M', 'D');
      FqryTransbordo.Post;

      FqryTransbordo.Next;
      pProgresso(FqryTransbordo.RecNo, FqryTransbordo.RecordCount, pgbStatus);
    end;
  finally
    FqryTransbordo.RecNo := intRecNo;
    FqryTransbordo.EnableControls;
  end;
end;

function TfrmRecebimentoTransbordo.fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  pMarcarDesmarcar(True, pgbStatus);
  Result := True;
end;

function TfrmRecebimentoTransbordo.fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  pMarcarDesmarcar(False, pgbStatus);
  Result := True;
end;

end.
