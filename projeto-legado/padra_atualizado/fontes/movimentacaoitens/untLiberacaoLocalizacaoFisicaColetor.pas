unit untLiberacaoLocalizacaoFisicaColetor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  EditFocus, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untZClient,
  cxLabel, MemDS, DBAccess, Uni;

type
  TTipoSeparacao = (tsRomaneio, tsPedido);

type
  TfrmLiberacaoLocalizacaoFisicaColetor = class(TfrmPaiConfirma)
    pnlBusca: TPanel;
    lblDocumentoRomaneio: TLabel;
    Label3: TLabel;
    edtDocRom: TEditFocus;
    edtLocFis: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    cxgLocalizacoes: TcxGridCitel;
    cxgLocalizacoesTBV: TcxGridDBTableViewCitel;
    cxgLocalizacoesTBVDocumentoRomaneio: TcxGridDBColumn;
    cxgLocalizacoesTBVLocalizacao: TcxGridDBColumn;
    cxgLocalizacoesTBVCodigoOperador: TcxGridDBColumn;
    cxgLocalizacoesLVL: TcxGridLevel;
    cxgLocalizacoesTBVNomeOperador: TcxGridDBColumn;
    cxgLocalizacoesTBVMARDES: TcxGridDBColumn;
    pnlLegenda: TPanel;
    shpSelecionado: TShape;
    Label4: TLabel;
    btnMarcaDesmarca: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    UniQuery1: TUniQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure cxgLocalizacoesTBVCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcaDesmarcaClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgLocalizacoesTBVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    TipoSeparacao : TTipoSeparacao;
    cdsLocalizacoes : TZClient;
    procedure pLimpaBusca;
    procedure pMarcaDesmarca(blnMarcar : Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples;



{$R *.dfm}

procedure TfrmLiberacaoLocalizacaoFisicaColetor.btnConfirmaClick(
  Sender: TObject);
  var
    qryQuery : TUniQuery;
begin
  inherited;
  if not cdsLocalizacoes.isEmpty then
  begin
    try
      cdsLocalizacoes.DisableControls;
      cdsLocalizacoes.Filter   := 'MARDES = ' + QuotedStr('S');
      cdsLocalizacoes.Filtered := True;

      if cdsLocalizacoes.isEmpty then
        pMensagemOk('Selecione ao menos uma localização para liberar!')
      else
      begin

        qryQuery := fCriaQuery;
        try
          fStartTransaction;
          try
            cdsLocalizacoes.First;
            while not cdsLocalizacoes.Eof do
            begin
              case TipoSeparacao of
                tsRomaneio: begin
                              qryQuery.SQL.Clear;
                              qryQuery.SQL.Add('UPDATE                                             ');
                              qryQuery.SQL.Add('  LOTDOR                                           ');
                              qryQuery.SQL.Add('  INNER JOIN FATDOR F ON F.AUTOINCREM = LDO_SEQFDO ');
                              qryQuery.SQL.Add('  INNER JOIN FATGOR G ON G.AUTOINCREM = FDO_SEQGER ');
                              qryQuery.SQL.Add('  INNER JOIN CADLOT   ON LOT_NUMLOT   = LDO_NUMLOT ');
                              qryQuery.SQL.Add('                     AND LOT_CODITE   = FDO_CODITE ');
                              qryQuery.SQL.Add('                     AND LOT_CODEMP   = FDO_CODEMP ');
                              qryQuery.SQL.Add('SET                                                ');
                              qryQuery.SQL.Add('  LDO_CODSEP = NULL                                ');
                              qryQuery.SQL.Add('WHERE                                              ');
                              qryQuery.SQL.Add('      FGO_NUMROM = :NUMROM                         ');
                              qryQuery.SQL.Add('  AND LOT_LOCFIS = :LOCFIS                         ');
                              qryQuery.SQL.Add('  AND LDO_SEPCOL = "N"                             ');

                              qryQuery.ParamByName('NUMROM').AsString := cdsLocalizacoes.FieldByName('DOCROM').AsString;
                              qryQuery.ParamByName('LOCFIS').AsString := cdsLocalizacoes.FieldByName('LOCFIS').AsString;
                            end;

                tsPedido:   begin
                              qryQuery.SQL.Clear;
                              qryQuery.SQL.Add('UPDATE                                             ');
                              qryQuery.SQL.Add('  LOTDOR                                           ');
                              qryQuery.SQL.Add('  INNER JOIN FATDOR F ON F.AUTOINCREM = LDO_SEQFDO ');
                              qryQuery.SQL.Add('  INNER JOIN CADLOT   ON LOT_NUMLOT   = LDO_NUMLOT ');
                              qryQuery.SQL.Add('                     AND LOT_CODITE   = FDO_CODITE ');
                              qryQuery.SQL.Add('                     AND LOT_CODEMP   = :CODEMP    ');
                              qryQuery.SQL.Add('SET                                                ');
                              qryQuery.SQL.Add('  LDO_CODSEP = NULL                                ');
                              qryQuery.SQL.Add('WHERE                                              ');
                              qryQuery.SQL.Add('      FDO_SEQGER = :AUTINC                         ');
                              qryQuery.SQL.Add('  AND LOT_LOCFIS = :LOCFIS                         ');
                              qryQuery.SQL.Add('  AND LDO_SEPCOL = "N"                             ');

                              qryQuery.ParamByName('AUTINC').AsString := cdsLocalizacoes.FieldByName('AUTINC').AsString;
                              qryQuery.ParamByName('LOCFIS').AsString := cdsLocalizacoes.FieldByName('LOCFIS').AsString;
                              qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
                            end;
              end;

              qryQuery.ExecSQL;
              cdsLocalizacoes.Next;
            end;

            if fCommit then
            begin
              pMensagemOk('Localizações Liberadas com Sucesso!');
              btnFiltrar.Click;
            end;

          except

            On E: Exception Do
            Begin
              fRollback;
              pMensagensErro(e.Message, 'TfrmLiberacaoLocalizacaoFisicaColetor.btnConfirmaClick');
            End;

          end;

        finally
          FreeAndNil(qryQuery);
        end;
      end;
    finally;
      cdsLocalizacoes.Filter   := '';
      cdsLocalizacoes.Filtered := False;
      cdsLocalizacoes.EnableControls;
    end;
  end;
end;

procedure TfrmLiberacaoLocalizacaoFisicaColetor.btnDesmarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  cdsLocalizacoes.First;
  while not cdsLocalizacoes.EOF do
  begin
    pMarcaDesmarca(False);
    cdsLocalizacoes.Next;
  end;
end;

procedure TfrmLiberacaoLocalizacaoFisicaColetor.btnFiltrarClick(
  Sender: TObject);
  Var
    strEmp_CD : String;
begin
  inherited;
  cdsLocalizacoes.Close;
  cdsLocalizacoes.qryQuery.Close;
  cdsLocalizacoes.qryQuery.SQL.Clear;

  case TipoSeparacao of
    tsRomaneio: begin
                  cdsLocalizacoes.qryQuery.SQL.Add('SELECT DISTINCT                                      ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  "N" AS MARDES,                                     ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  FGO_NUMROM AS DOCROM,                              ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  LOT_LOCFIS AS LOCFIS,                              ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  LDO_CODSEP AS CODOPE,                              ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  OPE_NOMOPE AS NOMOPE                               ');
                  cdsLocalizacoes.qryQuery.SQL.Add('FROM                                                 ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  LOTDOR                                             ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN FATDOR F ON F.AUTOINCREM = LDO_SEQFDO   ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN FATGOR G ON G.AUTOINCREM = F.FDO_SEQGER ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN CADLOT   ON LOT_NUMLOT = LDO_NUMLOT     ');
                  cdsLocalizacoes.qryQuery.SQL.Add('                     AND LOT_CODITE = FDO_CODITE     ');
                  cdsLocalizacoes.qryQuery.SQL.Add('                     AND LOT_CODEMP = FDO_CODEMP     ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP       ');
                  cdsLocalizacoes.qryQuery.SQL.Add('WHERE                                                ');
                  cdsLocalizacoes.qryQuery.SQL.Add('      LDO_SEPCOL = "N"                               ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  AND LDO_CODSEP IS NOT NULL                         ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  AND FGO_NUMROM IS NOT NULL                         ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  AND FGO_CODEMP = :CODEMP                           ');

                  if not fEmptyStr(edtDocRom.Text) then
                    cdsLocalizacoes.qryQuery.SQL.Add('  AND FGO_NUMROM = :DOCROM                         ');
                end;

    tsPedido:   begin
                  strEmp_CD := fCfgSis('EMP_CD', varString, VS_strCodEmp);

                  cdsLocalizacoes.qryQuery.SQL.Add('SELECT DISTINCT                                                  ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  "N" AS MARDES,                                                 ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  G.AUTOINCREM AS AUTINC,                                        ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  CONCAT(FGO_NUMDOC,"-", FGO_ESPDOC, "-", FGO_CODEMP) AS DOCROM, ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  LOT_LOCFIS AS LOCFIS,                                          ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  LDO_CODSEP AS CODOPE,                                          ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  OPE_NOMOPE AS NOMOPE                                           ');
                  cdsLocalizacoes.qryQuery.SQL.Add('FROM                                                             ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  LOTDOR                                                         ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN FATDOR F ON F.AUTOINCREM = LDO_SEQFDO               ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN FATGOR G ON G.AUTOINCREM = F.FDO_SEQGER             ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM             ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN CADLOT   ON LOT_NUMLOT = LDO_NUMLOT                 ');
                  cdsLocalizacoes.qryQuery.SQL.Add('                     AND LOT_CODITE = FDO_CODITE                 ');
                  cdsLocalizacoes.qryQuery.SQL.Add('                     AND LOT_CODEMP = :CODEMP                    ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP                   ');
                  cdsLocalizacoes.qryQuery.SQL.Add('WHERE                                                            ');
                  cdsLocalizacoes.qryQuery.SQL.Add('      LDO_SEPCOL = "N"                                           ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  AND LDO_CODSEP IS NOT NULL                                     ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  AND FGO_NUMROM IS NULL                                         ');
                  cdsLocalizacoes.qryQuery.SQL.Add('  AND FGO_ESPDOC = "PD"  AND                                     ');

                  cdsLocalizacoes.qryQuery.SQL.Add('   ((((IF(IFNULL(FGO_EMP_TE, "") = "", FDO_CODEMP, FGO_EMP_TE) = :CODEMP) AND (IFNULL(FDO_EMPITE, "") = "")) OR ');
                  cdsLocalizacoes.qryQuery.SQL.Add('     (FDO_EMPITE = :CODEMP)) ');

                  If (fCfgSis('ENT_CD', varBoolean, VS_strCodEmp)) And (VS_strCodEmp = strEmp_CD) Then
                  Begin
                    cdsLocalizacoes.qryQuery.SQL.Add('   OR ( FGO_ENT_CD = "S" AND ');
                    cdsLocalizacoes.qryQuery.SQL.Add('        IFNULL(FGO_EMP_CD, ' + QuotedStr(strEmp_CD) + ') = ' + QuotedStr(strEmp_CD) + ' ) ) ');
                  End
                  Else
                    cdsLocalizacoes.qryQuery.SQL.Add(' ) ');

                  if not fEmptyStr(edtDocRom.Text) then
                    cdsLocalizacoes.qryQuery.SQL.Add('  AND FGO_NUMDOC = :DOCROM  ');
                end;
  end;

  if not fEmptyStr(edtLocFis.Text) then
    cdsLocalizacoes.qryQuery.SQL.Add('  AND LOT_LOCFIS = :LOCFIS ');

  cdsLocalizacoes.qryQuery.SQL.Add('ORDER BY DOCROM, LOCFIS ');

  cdsLocalizacoes.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  if not fEmptyStr(edtLocFis.Text) then
    cdsLocalizacoes.qryQuery.ParamByName('LOCFIS').AsString := edtLocFis.Text;

  if not fEmptyStr(edtDocRom.Text) then
    cdsLocalizacoes.qryQuery.ParamByName('DOCROM').AsString := edtDocRom.Text;

  cdsLocalizacoes.fAbreClient(True, 'TfrmLiberacaoLocalizacaoFisicaColetor.btnFiltrarClick');
  pSetFocus(cxgLocalizacoes);
end;

procedure TfrmLiberacaoLocalizacaoFisicaColetor.pMarcaDesmarca(blnMarcar : Boolean);
begin
  cdsLocalizacoes.Edit;

  if blnMarcar then
    cdsLocalizacoes.FieldByName('MARDES').AsString := 'S'
  else
    cdsLocalizacoes.FieldByName('MARDES').AsString := 'N';

  cdsLocalizacoes.Post;
end;
procedure TfrmLiberacaoLocalizacaoFisicaColetor.btnMarcaDesmarcaClick(
  Sender: TObject);
begin
  inherited;
  if not cdsLocalizacoes.isEmpty then
    pMarcaDesmarca(cdsLocalizacoes.FieldByName('MARDES').AsString = 'N');

end;

procedure TfrmLiberacaoLocalizacaoFisicaColetor.btnMarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  cdsLocaLizacoes.First;
  while not cdsLocalizacoes.EOF do
  begin
    pMarcaDesmarca(True);
    cdsLocalizacoes.Next;
  end;
end;

procedure TfrmLiberacaoLocalizacaoFisicaColetor.cxgLocalizacoesTBVCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgLocalizacoesTBVMARDES.Index]) = 'S' then
    ACanvas.Font.Color := shpSelecionado.Brush.Color;
end;

procedure TfrmLiberacaoLocalizacaoFisicaColetor.cxgLocalizacoesTBVKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: btnMarcaDesmarca.Click;
  end;
end;

procedure TfrmLiberacaoLocalizacaoFisicaColetor.FormCreate(Sender: TObject);
begin
  inherited;
  if fCfgSis('TIPEXP', varInteger) = 5 Then
    TipoSeparacao := tsRomaneio
  Else
    TipoSeparacao := tsPedido;

  Case TipoSeparacao of
    tsRomaneio: begin
                  lblDocumentoRomaneio.Caption := 'Nº Romaneio:';
                  edtDocRom.MaxLength := 6;
                  edtDocRom.TamCampo  := 6;
                  cxgLocalizacoesTBVDocumentoRomaneio.Caption := 'Romaneio';
                  pLimpaBusca;
                end;

    tsPedido:   begin
                  lblDocumentoRomaneio.Caption := 'Documento:';
                  edtDocRom.MaxLength := 12;
                  edtDocRom.TamCampo  := 12;
                  cxgLocalizacoesTBVDocumentoRomaneio.Caption := 'Documento';
                  pLimpaBusca;
                end;
  end;


  cdsLocalizacoes := TZClient.Create(Self);
  cxgLocalizacoestbv.DataController.DataSource := cdsLocalizacoes.dtsSource;
end;

procedure TfrmLiberacaoLocalizacaoFisicaColetor.pLimpaBusca;
begin
 edtLocFis.Clear;
 edtDocRom.Clear;
end;

end.
