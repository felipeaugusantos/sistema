unit untFatAlteraTransRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, EditFocus, UniDataSetProvider, DB, UniClientDataSet, untAtualizaOcorrenciasCRM,
  Uni, Mask, DBCtrls, DBEditFocus, MaskEditFocus, strUtils,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, cxProgressBar, DBGridCitel;

type
  TfrmFatAlteraTransRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblRomaneio: TLabel;
    edtNumRom: TEditFocus;
    dbgDocumentos: TDBGridCitel;
    dtsDocumentos: TDataSource;
    cdsDocumentos: TUniClientDataSet;
    dspDocumentos: TUniDataSetProvider;
    qryDocumentos: TUniQuery;
    btnConfirma: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cdsDocumentosAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure edtNumRomEnter(Sender: TObject);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);

  private
    { Private declarations }
    strAceRom : String;
    strCodTra : String;
    strNumRom : String;

    procedure pLimparRomaneio;
    procedure pCarregaDocumentos;
    procedure pSelecionaDocumento;

    Function fAlteraPD(ProgressBar : TcxProgressBar ) : Boolean;
    Function fRomaneioEncontrado: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untRomGer, untFatRomTransMot, untFatGerarNovoPreRomaneio,
  untHisPed, untFuncoesCRM, untGravando, untFatDigTransportadora;

{$R *.dfm}

{ TfrmFatBaixaRomaneio }

function TfrmFatAlteraTransRomaneio.fRomaneioEncontrado: Boolean;
  Var
    qryGen   : TUniQuery;
begin
  Try
    Result := False;
    qryGen := fCriaQuery;

    strNumRom := fTrataNumRom(edtNumRom);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  G.*, R.GER_STATUS ');
      SQL.Add('FROM ');
      SQL.Add('  ROMGERX R INNER JOIN FATGOR G ON R.GER_CODEMP = G.FGO_CODEMP ');
      SQL.Add('                               AND R.GER_NUMDOC = G.FGO_NUMDOC ');
      SQL.Add('                               AND R.GER_ESPDOC = G.FGO_ESPDOC ');
      SQL.Add('                               AND R.GER_CODCLI = G.FGO_CODCLI ');
      SQL.Add('WHERE ');
      SQL.Add('   R.GER_EMPROM     = :CODEMP AND ');
      SQL.Add('   IFNULL(G.FGO_JAFATU,0) = 0 AND ');

      If (strNumRom.Length > 6) Then
        SQL.Add('   R.GER_CODBAR = :NUMDOC ')
      Else
        SQL.Add('   R.GER_NUMROM = :NUMDOC ');

      SQL.Add('ORDER BY G.AUTOINCREM ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('NUMDOC').AsString := strNumRom;
      Open;

      If Not IsEmpty Then
      Begin
        If (FieldByName('GER_STATUS').AsString <> 'P') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Romaneio já foi ativado!', ['&O k']);
          Result := False;
        End
        Else
          Result := True;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Romaneio não encontrado!', ['&O k']);
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmFatAlteraTransRomaneio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNumRom) Then
  Begin

    If Not fRomaneioEncontrado Then
      Result := False

    Else
    Begin
      pCarregaDocumentos;
    End;

  End;

  If (Not Result) Then
  Begin
    pLimparRomaneio;
    pSetFocus(Sender);
  End;

end;

function TfrmFatAlteraTransRomaneio.fAlteraPD(ProgressBar : TcxProgressBar ) : Boolean;
  Var
    blnConfirma: Boolean;

    Function fGravaPD(strNumDoc, strCodEmp, strCodCli, strCodTra: String): Boolean;
      Var
        qryGenGer: TUniQuery;
        strSQL   : String;
    Begin
      Result := True;

      Try
        qryGenGer := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  FATGOR ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  FGO_CODTRA = :CODTRA ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  FGO_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  FGO_CODCLI = :CODCLI ';

        With qryGenGer Do
        Begin
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODTRA').AsString := strCodTra;
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := 'PD';
          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('CODCLI').AsString := strCodCli;
          ExecSQL;
        End;

        strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'FATGOR','ROMGERX'),'FGO_','GER_');
        strSQL := strSQL + ' AND GER_NUMROM = :NUMROM ';

        With qryGenGer Do
        Begin
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODTRA').AsString := strCodTra;
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := 'PD';
          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('CODCLI').AsString := strCodCli;
          ParamByName('NUMROM').AsString := strNumRom;
          ExecSQL;
        End;

        FreeAndNil(qryGenGer);

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[fGravaPD]');
        End;
      End;
    End;

begin
  blnConfirma := True;

  Try
    ProgressBar.Properties.Max := cdsDocumentos.RecordCount;
    fStartTransaction;

    With cdsDocumentos Do
    Begin

      First;
      While Not EOF Do
      Begin
        blnConfirma := fGravaPD(FieldByName('GER_NUMDOC').AsString,
                                FieldByName('GER_CODEMP').AsString,
                                FieldByName('GER_CODCLI').AsString,
                                strCodTra);

        If Not blnConfirma Then
          Last;

        ProgressBar.Position := RecNo;
        Application.ProcessMessages;
        Next;
      End;

    End;

    Result := blnConfirma;

    If Result Then
      fCommit
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fAlteraPD]');
    End;
  End;
end;

procedure TfrmFatAlteraTransRomaneio.pCarregaDocumentos;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_DOCUME, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) GER_NOMCLI, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  GER_NUMDOC, ';
  strSQL := strSQL + '  GER_CODCLI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  "D" AS GER_MARDES, ';
  strSQL := strSQL + '  GER_VLRCON  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN FATGOR ON FGO_NUMDOC = GER_NUMDOC AND ';
  strSQL := strSQL + '                      FGO_ESPDOC = GER_ESPDOC AND ';
  strSQL := strSQL + '                      FGO_CODEMP = GER_CODEMP AND ';
  strSQL := strSQL + '                      FGO_CODCLI = GER_CODCLI     ';
  strSQL := strSQL + '       JOIN CADCLI ON GER_CODCLI = CLI_CODCLI     ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM AND ';
  strSQL := strSQL + '  GER_STATUS = "P"     AND ';
  strSQL := strSQL + '  FGO_JAFATU = 0       AND ';
  strSQL := strSQL + '  LOCATE(FGO_CODEMP,' + QuotedStr(strAceRom) + ' ) > 0 ';
  strSQL := strSQL + 'ORDER BY GER_DTAENT, GER_NUMDOC, GER_NOMCLI ';

  cdsDocumentos.Close;

  With qryDocumentos Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMROM').AsString := fNumeroRomaneio(edtNumRom.Text);
    ParamByName('EMPROM').AsString := VS_strCodEmp;
    Open;
  End;

  pSetaClient(qryDocumentos);
  cdsDocumentos.Open;
  pSetaClient(cdsDocumentos);
end;

procedure TfrmFatAlteraTransRomaneio.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumRom);
end;

procedure TfrmFatAlteraTransRomaneio.FormCreate(Sender: TObject);
begin
  inherited;
  strAceRom := fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
end;

procedure TfrmFatAlteraTransRomaneio.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
   VK_F10   : btnConfirma.Click;
   VK_F2    : btnMarcarTodos.Click;
   VK_F3    : btnDesmarcarTodos.Click;
   VK_ESCAPE: If dbgDocumentos.Focused Then pSetFocus(edtNumRom) Else btnSairClick(Sender);
  End;
end;

procedure TfrmFatAlteraTransRomaneio.btnConfirmaClick(Sender: TObject);
  Var
    frmFatDigTransportadora : TfrmFatDigTransportadora;
begin
  inherited;

  cdsDocumentos.DisableControls;

  With cdsDocumentos Do
  Begin
    Filtered := False;
    Filter   := ' GER_MARDES = ' + QuotedStr('M') + ' ';
    Filtered := True;

    If IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Nenhum pedido foi marcado!', ['&O k']);
      Filtered := False;
      Exit;
    End;
  End;

  strCodTra := '';

  If fMensagem('AVISO', 'Confirma operação?', ['&Sim', '&Não']) = 1 then
  Begin

    Try
      pCriarFormularios(TfrmFatDigTransportadora, frmFatDigTransportadora);
      frmFatDigTransportadora.ShowModal;

      If (frmFatDigTransportadora.blnConfirma) Then
        strCodTra := frmFatDigTransportadora.edtCodTra.Text;

    Finally
      pFreeAndNil(frmFatDigTransportadora);
    End;

    If fEmptyStr(strCodTra) Then
    Begin
      cdsDocumentos.Filtered := False;
      Exit;
    End;

    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fAlteraPD;
      frmGravando.lblGravando.Caption := 'Alterando pedidos...';
      frmGravando.ShowModal;

      If frmGravando.blnConfirma Then
      Begin
        fMensagem('ATENÇÃO!', 'Pedidos alterados com sucesso!', ['&O k']);
        pLimparRomaneio;
        pSetFocus(edtNumRom);
      End;
    Finally
      FreeAndNil(frmGravando);
    End;

  End;

  cdsDocumentos.Filtered := False;
  cdsDocumentos.EnableControls;
end;

procedure TfrmFatAlteraTransRomaneio.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  With cdsDocumentos Do
  Begin
    DisableControls;
    If Not IsEmpty Then
    Begin
      First;
      While Not EOF Do
      Begin
        Edit;
        FieldByName('GER_MARDES').AsString := 'D';
        Post;
        Next;
      End;
      First;
    End;
    EnableControls;
  End;
end;

procedure TfrmFatAlteraTransRomaneio.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  With cdsDocumentos Do
  Begin
    DisableControls;
    If Not IsEmpty Then
    Begin
      First;
      While Not EOF Do
      Begin
        Edit;
        FieldByName('GER_MARDES').AsString := 'M';
        Post;
        Next;
      End;
      First;
    End;
    EnableControls;
  End;
end;

procedure TfrmFatAlteraTransRomaneio.cdsDocumentosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  With Dataset Do
  Begin
    TFloatField(FieldByName('GER_VLRCON')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmFatAlteraTransRomaneio.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  With cdsDocumentos Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If (FindField('GER_MARDES') = Nil) Then
      Exit;

    If (FieldByName('GER_MARDES').AsString = 'M') Then
      dbgDocumentos.Canvas.Font.Color := clBlue
    Else
      dbgDocumentos.Canvas.Font.Color := clBlack;
  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatAlteraTransRomaneio.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) Then
    pSelecionaDocumento;
end;

procedure TfrmFatAlteraTransRomaneio.edtNumRomEnter(Sender: TObject);
begin
  inherited;
  pLimparRomaneio;
end;

procedure TfrmFatAlteraTransRomaneio.pLimparRomaneio;
begin
  edtNumRom.Text := EmptyStr;

  If cdsDocumentos.Active And Not cdsDocumentos.IsEmpty Then
    cdsDocumentos.EmptyDataSet;
end;

procedure TfrmFatAlteraTransRomaneio.pSelecionaDocumento();
begin
  If (Not cdsDocumentos.Active) Or
     (cdsDocumentos.IsEmpty)    Then
    Exit;

  cdsDocumentos.Edit;

  If (Pos(cdsDocumentos.FieldByName('GER_MARDES').AsString, 'M') > 0) Then
  Begin
    cdsDocumentos.FieldByName('GER_MARDES').AsString := 'D';
    cdsDocumentos.Post;
  End
  Else
  Begin
    cdsDocumentos.FieldByName('GER_MARDES').AsString := 'M';
    cdsDocumentos.Post;
  End;
end;

end.
