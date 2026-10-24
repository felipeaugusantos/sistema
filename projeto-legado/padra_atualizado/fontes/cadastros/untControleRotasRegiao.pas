unit untControleRotasRegiao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, ComboBoxFocus, Mask, MaskEditFocus, Grids, DBGrids,
  Provider, DB, DBClient, strUtils, MemDS, DBAccess, Uni,
  frxExportCSVTestabilidade, DateUtils, DBGridCitel, UniClientDataSet, UniDataSetProvider,
  untFuncoesRel, untFuncoesRel2, frxClass;

type
  TLastField = Record
    intIndCol : Integer;
    ftyTipCam : TFieldType;
    strNomCam,
    strNomCol : String;
  End;

type
  TfrmControleRotasRegiao = class(TfrmPai)
    pnlGeral     : TPanel;
    pnlFiltro    : TPanel;
    pnlRotas     : TPanel;
    grbFiltros   : TGroupBox;
    Label6       : TLabel;
    mskDtaIni    : TMaskEditFocus;
    Label7       : TLabel;
    mskDtaFin    : TMaskEditFocus;
    Label1       : TLabel;
    Label2       : TLabel;
    cbStatus     : TComboBoxFocus;
    edtCodReg    : TEditFocus;
    edtDesReg    : TEditFocus;
    btnInsRota   : TBitBtnLocked;
    btnMudaOrdem : TBitBtnLocked;
    pnlPesquisa  : TPanel;
    dbgRotas     : TDBGridCitel;
    dtsConsulta  : TDataSource;
    cdsConsulta  : TUniClientDataSet;
    dspConsulta  : TUniDataSetProvider;
    Panel1       : TPanel;
    lblPesquisa  : TLabel;
    lblNomeCampo : TLabel;
    edtData      : TMaskEditFocus;
    edtNumero    : TEditFocus;
    edtString    : TEditFocus;
    edtValor     : TEditFocus;
    Shape1       : TShape;
    Shape2       : TShape;
    Label8       : TLabel;
    Label3       : TLabel;
    btnRelatorio : TBitBtnLocked;
    btnGeraAuto  : TBitBtnLocked;
    btnPesquisar : TBitBtnLocked;
    Label4       : TLabel;
    Label5       : TLabel;
    Panel2: TPanel;
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbgRotasTitleClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInsRotaClick(Sender: TObject);
    procedure btnGeraAutoClick(Sender: TObject);
    procedure dbgRotasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnRelatorioClick(Sender: TObject);
    procedure dbgRotasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryConsulta  : TUniQuery;
    lflLastField : TLastField;

    procedure pProximaOrdenacao;
    procedure pPegaProximaColuna;
    procedure pAbrePesquisa;
    procedure pLimpaPesquisa;
    procedure pMostraPedidosVinculados;
    procedure pAlteraDataEntrega;
    procedure pAlteraStatus;
    procedure pDeletaEntrega;

    function fAbreConsulta(blnLike: Boolean): Boolean;
    function fAsDate(strCampo, strValor: String): String;
    function fRetOperador(ftyTipCam : TFieldType): String;
    function fDeletouAEntrega: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untCadNovaEntregaRegiao, untCadNovaEntregaRegiaoAuto,untPedidosRotasRegiao,
  untConsultas, untTypesSistema, untFuncoesSimples, untAltDataEntregaRota,
  untValidacoesRotasRegiao;

{$R *.dfm}

Const
  SET_OF_TYPES : Set of TFieldType = [ftString,ftWideString,ftDate,ftDateTime,ftInteger,ftLargeInt,ftWord,ftFloat];

procedure TfrmControleRotasRegiao.btnGeraAutoClick(Sender: TObject);
var
  blnConfirma: Boolean;
  frmCadNovaEntregaRegiaoAuto: TfrmCadNovaEntregaRegiaoAuto;
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadNovaEntregaRegiaoAuto,frmCadNovaEntregaRegiaoAuto);
    frmCadNovaEntregaRegiaoAuto.ShowModal;
    blnConfirma := frmCadNovaEntregaRegiaoAuto.blnConfirma;
  Finally
    pFreeAndNil(frmCadNovaEntregaRegiaoAuto);
  End;

  If blnConfirma Then
    fAbreConsulta(False);
end;

procedure TfrmControleRotasRegiao.btnInsRotaClick(Sender: TObject);
var
  blnConfirma: Boolean;
  frmCadNovaEntregaRegiao: TfrmCadNovaEntregaRegiao;
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadNovaEntregaRegiao,frmCadNovaEntregaRegiao);
    frmCadNovaEntregaRegiao.ShowModal;
    blnConfirma := frmCadNovaEntregaRegiao.blnConfirma;
  Finally
    pFreeAndNil(frmCadNovaEntregaRegiao);
  End;

  If blnConfirma Then
    fAbreConsulta(False);
end;

procedure TfrmControleRotasRegiao.btnMudaOrdemClick(Sender: TObject);
begin
  inherited;
  pProximaOrdenacao;
end;

procedure TfrmControleRotasRegiao.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  pAbrePesquisa;
end;

procedure TfrmControleRotasRegiao.btnRelatorioClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(59,
                        4959,
                        [],
                        ['DTAINI','DTAFIN','CODREG','STATUS'],
                        [mskDtaIni.Text,mskDtaFin.Text,edtCodReg.Text,IfThen(cbStatus.Text = 'ABERTO','Abertos',IfThen(cbStatus.Text = 'BAIXADO','Baixados','Todos'))],
                        Sender,
                        nil,
                        True);

end;

procedure TfrmControleRotasRegiao.dbgRotasDrawColumnCell(Sender    : TObject;
                                                         const Rect: TRect;
                                                         DataCol   : Integer;
                                                         Column    : TColumn;
                                                         State     : TGridDrawState);
begin
  inherited;
  If Column.Index = lflLastField.intIndCol then
  Begin
    dbgRotas.Canvas.Brush.Color := clInfoBk;
    dbgRotas.Canvas.Font.Color  := clWindowText;
    dbgRotas.Canvas.FillRect(Rect);
    dbgRotas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

  If Column.Field.DataSet.FieldByName('ENT_STATUS').AsString = 'ABERTO' Then
  Begin
    dbgRotas.Canvas.Font.Color := clGreen;

    If gdFocused in State Then
    Begin
      dbgRotas.Canvas.Brush.Color := clWindow;
      dbgRotas.Canvas.Font.Color  := clWindowText;
    End;

    dbgRotas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

  If Column.Field.DataSet.FieldByName('ENT_STATUS').AsString = 'BAIXADO' Then
  Begin
    dbgRotas.Canvas.Font.Color := clRed;

    If gdFocused in State Then
    Begin
      dbgRotas.Canvas.Brush.Color := clWindow;
      dbgRotas.Canvas.Font.Color  := clWindowText;
    End;

    dbgRotas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TfrmControleRotasRegiao.dbgRotasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN : pMostraPedidosVinculados;
    VK_F4     : pAlteraDataEntrega;
    VK_F6     : pAlteraStatus;
    VK_DELETE : pDeletaEntrega;
  End;
end;

procedure TfrmControleRotasRegiao.dbgRotasTitleClick(Column: TColumn);
begin
  inherited;
  pnlPesquisa.Visible := False;

  If Not cdsConsulta.IsEmpty Then
  With lflLastField Do
  Begin
    intIndCol := Column.Index;
    ftyTipCam := Column.Field.DataType;
    strNomCam := Column.Field.FieldName;
    strNomCol := Column.Title.Caption;
  End;
  fAbreConsulta(False);
end;

procedure TfrmControleRotasRegiao.edtCodRegKeyPress(Sender: TObject; var Key: Char);
Var
  arrRegiao : TConsultasArray;
begin
  inherited;
  If fPesqRotasRegiao(Self, edtCodReg, Nil, Nil, Key, arrRegiao) Then
		fValidaCampos(edtCodReg, False);
end;

function TfrmControleRotasRegiao.fAbreConsulta(blnLike: Boolean): Boolean;

  function fSQLPeso: String;
  begin
    Result := ' (SELECT IFNULL(SUM(EXTDOR.FDO_PESBRU),0) ' +
              '    FROM FATGOR '+
              '  INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
              '  INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ' +
              '  INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ' +
              '  WHERE EXTGOR.FGO_CODROT = ENT_CODIGO '+
              '    AND ((IFNULL(FGO_MOTBAI, "") = "") OR ((FGO_MOTBAI <> "") AND (FDO_NUMFAT <> "")))) AS FGO_PESBRU, ';
  end;

  function fSQLValor: String;
  begin
    Result := ' (SELECT IFNULL(SUM(FATDOR.FDO_VLRCON),0) ' +
              '    FROM FATGOR '+
              '  INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
              '  INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ' +
              '  INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ' +
              '  WHERE EXTGOR.FGO_CODROT = ENT_CODIGO '+
              '    AND ((IFNULL(FGO_MOTBAI, "") = "") OR ((FGO_MOTBAI <> "") AND (FDO_NUMFAT <> "")))) AS FGO_VLRCON, ';
  end;

Begin
  Try
    With qryConsulta, Sql Do
    Begin
      Close;
      cdsConsulta.Close;
      Clear;

      Add('SELECT DISTINCT ENT_CODIGO, ');
      Add('       ENT_CODEMP, ');
      Add('       ENT_DTAENT, ');
      Add('       ENT_CODREG, ');
      Add('       REG_DESREG, ');
      Add('       CONCAT( VEI_PLAVEI, "-",  IFNULL(MAR_DESMAR, " ")," ",  IFNULL(MOD_DESMOD, " ")," ", ');
      Add('                                 IFNULL(COR_DESCOR, " ")," ", IFNULL(VEI_ANOVEI, " ") ) AS VEICULO, ');
      Add('       VEI_DESVEI, ');
      Add('       VEI_CAPCAR, ');
      Add('       ROT_VLRMIN, ');
      Add('       CASE WHEN ENT_STATUS = "A" THEN  "ABERTO" ');
      Add('            WHEN ENT_STATUS = "B" THEN "BAIXADO" ');
      Add('       ELSE "TODOS"                              ');
      Add('       END AS ENT_STATUS,                        ');
      Add(fSQLPeso);
      Add(fSQLValor);
      Add('(IFNULL(VEI_CAPCAR,0) - (SELECT IFNULL(SUM(EXTDOR.FDO_PESBRU),0) ' +
          '                          FROM FATGOR '+
          '                        INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
          '                        INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ' +
          '                        INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ' +
          '                        WHERE EXTGOR.FGO_CODROT = ENT_CODIGO '+
          '                          AND ((IFNULL(FGO_MOTBAI, "") = "") OR ((FGO_MOTBAI <> "") AND (FDO_NUMFAT <> ""))))) AS DISPON,     ');
      Add('       ENTREG.AUTOINCREM                      ');
      Add(' FROM ENTREG                                  ');
      Add(' INNER JOIN CADREG ON REG_CODREG = ENT_CODREG ');
      Add(' INNER JOIN ROTREG ON ROT_CODREG = ENT_CODREG ');
      Add(' LEFT  JOIN ROTREV ON REV_CODIGO = ENT_ROTVEI ');
      Add(' LEFT  JOIN CADVEI ON VEI_PLAVEI = REV_PLAVEI ');
      Add(' LEFT  JOIN MODVEI ON VEI_CODMOD = MOD_CODMOD ');
      Add(' LEFT  JOIN MARVEI ON VEI_CODMAR = MAR_CODMAR ');
      Add(' LEFT  JOIN CORVEI ON VEI_CODCOR = COR_CODCOR ');
      Add(' WHERE ENT_DTAENT BETWEEN :DTAINI AND :DTAFIN  ');
//      Add('   AND ENT_CODEMP = :CODEMP                    ');

      If cbStatus.ItemIndex > 0 Then
        Add('   AND ENT_STATUS = :STATUS                  ');

      If Not fEmptyStr(edtCodReg.Text) Then
        Add('   AND ENT_CODREG = :CODREG                  ');

      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
//      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If cbStatus.ItemIndex > 0 Then
        ParamByName('STATUS').AsString := IIF(cbStatus.Text = 'ABERTO', 'A', 'B');

      If Not fEmptyStr(edtCodReg.Text) Then
        ParamByName('CODREG').AsString := edtCodReg.Text;

      If lflLastField.intIndCol <> -1 Then
      Begin
        If blnLike Then
        Begin
          Case lflLastField.ftyTipCam Of
            ftDate,
            ftDateTime : Add(' AND ' + fAsDate(lflLastField.strNomCam,edtData.Text));

            ftString,
            ftWideString: If not fEmptyStr(Trim(edtString.Text)) Then
                            Add(' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ');

            ftInteger,
            ftLargeInt,
            ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                            Add(' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ');

            ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                            Add(' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ');
          End;
        End;

        Add(' ORDER BY ');

        Add('  ENT_DTAENT, REG_DESREG');
      End;

      If blnLike Then
      Begin
        Case lflLastField.ftyTipCam Of
          ftString,
          ftWideString: If not fEmptyStr(Trim(edtString.Text)) Then
                          ParamByName('CODPES').AsString  := edtString.Text + '%';

          ftInteger,
          ftLargeInt,
          ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                          ParamByName('CODPES').AsInteger := StrToIntDef(Trim(edtNumero.Text),0);

          ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                          ParamByName('CODPES').AsFloat := fStrToFloat(Trim(edtValor.Text));

        End;
      End;

      Open;

      cdsConsulta.Open;

      TFloatField(cdsConsulta.FieldByName('FGO_PESBRU')).DisplayFormat := '#,##0.00';
      TFloatField(cdsConsulta.FieldByName('FGO_VLRCON')).DisplayFormat := '#,##0.00';

      If lflLastField.intIndCol <> -1 Then
        dbgRotas.SelectedField := fieldbyname(lflLastField.strNomCam);
{
      For intIndex := 0 to dbgRotas.Columns.Count - 1 do
      Begin
        if SameText(dbgRotas.Columns[intIndex].FieldName,'CLI_FONE01') Then
         dbgRotas.Columns[intIndex].Field.EditMask := fRetMascaraFonePais;
      End;
}
      Result := True;
    End;

  Except
    Result := False;
  End;
end;

function TfrmControleRotasRegiao.fAsDate(strCampo, strValor: String): String;
  Var
    dtaTemp: TDateTime;
begin
  {*****************************************}
  {* "1 = 1" -> PEQUENO HACK PARA QUE,     *}
  {* QUANDO A DATA DIGITADA NAO FOR VALIDA,*}
  {* EX: '12/0' NÃO APRESENTE ERRO E IGNORE*}
  {* O FILTRO DE DATA                      *}
  {**************************************MV*}
  strValor := AnsiReplaceStr(strValor, '/', FormatSettings.DateSeparator);
  strValor := AnsiReplaceStr(strValor, '-', FormatSettings.DateSeparator);
  Try
    dtaTemp  := StrToDate(strValor);
    strValor := FormatDateTime('yyyy-mm-dd', dtaTemp);

    Result := strCampo + ' = ' + QuotedStr(strValor);
  Except
    Result := ' 1 = 1 ';
  End;
end;

function TfrmControleRotasRegiao.fDeletouAEntrega: Boolean;
var
  qryCons: TUniQuery;
begin
  Result := True;
  Try
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ENTREG WHERE ENT_CODIGO = :CODROT');
        ParamByName('CODROT').AsString := cdsConsulta.FieldByName('ENT_CODIGO').AsString;
        ExecSQL;
      End;

      fMensagem('INFORMAÇÃO','Rota de entrega excluída com sucesso !',['&Ok']);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmControleRotasRegiao.fDeletouAEntrega]');
      End;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmControleRotasRegiao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsConsulta.Close;
end;

procedure TfrmControleRotasRegiao.FormCreate(Sender: TObject);
begin
  inherited;
  lflLastField.intIndCol := 1;
  lflLastField.ftyTipCam := ftString;
  lflLastField.strNomCam := 'REG_DESREG';
  lflLastField.strNomCol := 'Região';

  qryConsulta         := fCriaQuery;
  dspConsulta.Dataset := qryConsulta;
end;

procedure TfrmControleRotasRegiao.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(qryConsulta) Then
    FreeAndNil(qryConsulta);
end;

procedure TfrmControleRotasRegiao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3    : pProximaOrdenacao;
    VK_F5    : pAbrePesquisa;
    VK_F9    : btnRelatorio.Click;
    VK_F10   : btnGeraAuto.Click;

    VK_RETURN: Begin
                 If pnlPesquisa.Visible And
                  ((edtdata.Focused)   Or (edtNumero.Focused) Or
                   (edtString.Focused) Or (edtValor.Focused)) Then
                 Begin
                   fAbreConsulta(True);
                   pSetFocus(pnlPesquisa);
                 End;
               End;

    VK_ESCAPE: Begin
                 If pnlPesquisa.Visible Then
                 Begin
                   pLimpaPesquisa;
                   pSetFocus(dbgRotas);
                   Abort;
                 End

                 Else inherited;
               End;

    VK_INSERT: btnInsRota.Click;
    Else       inherited;
  End;
end;

procedure TfrmControleRotasRegiao.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  pSetFocus(mskDtaIni);
end;

function TfrmControleRotasRegiao.fRetOperador(ftyTipCam: TFieldType): String;
begin
  Case ftyTipCam Of
    ftString,
    ftWideString : Result := 'LIKE';
    ftDate,
    ftDateTime   : Result := 'DATE';
    Else           Result := '=';
  End;
end;

function TfrmControleRotasRegiao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If ((fEmptyStr(mskDtaIni.Text)) OR (mskDtaIni.Text = '  /  /    ')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If ((Not fEmptyStr(mskDtaIni.Text)) And (mskDtaIni.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaFin.Text)) And (mskDtaFin.Text <> '  /  /    ')) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If ((fEmptyStr(mskDtaIni.Text)) OR (mskDtaIni.Text = '  /  /    ')) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodReg) Then
    Begin

      If (fEmptyStr(edtCodReg.Text)) Then
      Begin
        edtDesReg.Text := 'TODAS';
      End
      Else
      Begin
        edtDesReg.Text := fRetNomRotasRegiao(edtCodReg.Text);
        If (fEmptyStr(edtDesReg.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa região não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;

      If Result Then
        fAbreConsulta(TRUE);

    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);  
end;

procedure TfrmControleRotasRegiao.pAbrePesquisa;
begin
  If lflLastField.intIndCol = -1 Then
    pPegaProximaColuna;

  If (lflLastField.intIndCol > -1) Then
  Begin
    If lflLastField.ftyTipCam in SET_OF_TYPES Then
    Begin

      lblNomeCampo.Caption := lflLastField.strNomCol + ':';

      pnlPesquisa.Visible  := True;

      Case lflLastField.ftyTipCam Of
        ftString,
        ftWideString: Begin
                       edtString.Left           := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtData.Visible          := False;
                       edtString.Visible        := True;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := False;
                       pSetFocus(edtString);
                       lblPesquisa.FocusControl := edtString;
                     End;
        ftDate,
        ftDateTime : Begin
                       edtData.Left             := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtData.Visible          := True;
                       edtString.Visible        := False;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := False;
                       pSetFocus(edtData);
                       lblPesquisa.FocusControl := edtData;
                     End;
        ftInteger,
        ftLargeInt,
        ftWord     : Begin
                       edtNumero.Left    := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtData.Visible   := False;
                       edtString.Visible := False;
                       edtNumero.Visible := True;
                       edtValor.Visible  := False;
                       pSetFocus(edtNumero);
                       lblPesquisa.FocusControl := edtNumero;
                     End;
        ftFloat     : Begin
                       edtValor.Left            := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtData.Visible          := False;
                       edtString.Visible        := False;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := True;
                       pSetFocus(edtValor);
                       lblPesquisa.FocusControl := edtValor;
                     End;
      End;
    End
    Else
      fMensagem('', 'Somente campos do tipo data, texto, numérico ou valor podem ser pesquisados.', ['&O k']);
  End
  Else
    fMensagem('', 'Escolha um campo de ordenação clicando no título de uma coluna.', ['&O k']);
end;

procedure TfrmControleRotasRegiao.pAlteraDataEntrega;
  Var
    frmAltDataEntregaRota: TfrmAltDataEntregaRota;
begin
  If Not cdsConsulta.IsEmpty Then
  Begin
    Try
      pCriarFormularios(TfrmAltDataEntregaRota,frmAltDataEntregaRota);
      frmAltDataEntregaRota.strCodRot := cdsConsulta.FieldByName('ENT_CODIGO').AsString;
      frmAltDataEntregaRota.strCodReg := cdsConsulta.FieldByName('ENT_CODREG').AsString;
      frmAltDataEntregaRota.ShowModal;
      If frmAltDataEntregaRota.blnAlterou Then
        fValidaCampos(edtCodReg);
    Finally
      pFreeAndNil(frmAltDataEntregaRota);
    End;
  End;
end;

procedure TfrmControleRotasRegiao.pAlteraStatus;
var
  objRotReg : TRotReg;
begin
  objRotReg := nil;
  Try
    objRotReg := TRotReg.Create(Self);
    objRotReg.strCodRot := cdsConsulta.FieldByName('ENT_CODIGO').AsString;

    If objRotReg.fAlteraStatusRota Then
      fAbreConsulta(False);
  Finally
    objRotReg.Free;
  End;
end;

procedure TfrmControleRotasRegiao.pDeletaEntrega;
  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' SELECT FGO_CODROT ';
    Result := Result + '   FROM ENTREG     ';
    Result := Result + '  INNER JOIN ROTREG ON ROT_CODREG = ENT_CODREG ';
    Result := Result + '  INNER JOIN EXTGOR ON FGO_CODROT = ENT_CODIGO ';
    Result := Result + '  WHERE FGO_CODROT = :CODROT LIMIT 1           ';
  End;
var
  qryCons: TUniQuery;
begin
  If Not cdsConsulta.IsEmpty Then
  Begin
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL);
        ParamByName('CODROT').AsString := cdsConsulta.FieldByName('ENT_CODIGO').AsString;
        Open;

        If IsEmpty Then
        Begin
          If fDeletouAEntrega Then
            fValidaCampos(edtCodReg);
        End
        Else
          fMensagem('ATENÇÃO','Existem pedidos vinculados a essa rota de entrega.' + #13#10 +
                              'Para excluir essa rota de entrega você precisa desvincular' + #13#10 +
                              'os pedidos dessa rota!',['&Ok']);
      End;
    Finally
      FreeAndNil(qryCons);
    End;
  End;
end;

procedure TfrmControleRotasRegiao.pLimpaPesquisa;
begin
  pnlPesquisa.Visible := False;
  edtData.Clear;
  edtNumero.Clear;
  edtString.Clear;
  edtValor.Clear;
end;

procedure TfrmControleRotasRegiao.pMostraPedidosVinculados;
  Var
    frmPedidosRotasRegiao: TfrmPedidosRotasRegiao;
begin
  If Not cdsConsulta.IsEmpty Then
  Begin
    Try
      pCriarFormularios(TfrmPedidosRotasRegiao,frmPedidosRotasRegiao);
      frmPedidosRotasRegiao.strCodRot := cdsConsulta.FieldByName('ENT_CODIGO').AsString;
      frmPedidosRotasRegiao.fAbreConsulta(False);
      frmPedidosRotasRegiao.ShowModal;
    Finally
      pFreeAndNil(frmPedidosRotasRegiao);
      fAbreConsulta(True);
    End;
  End;
end;

procedure TfrmControleRotasRegiao.pPegaProximaColuna;
  Var
    intIndex: integer;
    intCount: integer;
Begin
  intCount := 0;
  intIndex := lflLastField.intIndCol;

    If cdsConsulta.Active Then
    Repeat
      inc(intIndex);
      If intIndex > dbgRotas.Columns.Count - 1 Then
        intIndex := 0;
      inc(intCount);

      If dbgRotas.Columns.Items[intIndex].Visible And
        (dbgRotas.Columns.Items[intIndex].Field.DataType In SET_OF_TYPES) Then
      With lflLastField Do
      Begin
        intIndCol := intIndex;
        ftyTipCam := dbgRotas.Columns.Items[intIndex].Field.DataType;
        strNomCam := dbgRotas.Columns.Items[intIndex].Field.FieldName;
        strNomCol := dbgRotas.Columns.Items[intIndex].Title.Caption;

        exit;
      End;
    Until (intCount > dbgRotas.Columns.Count);
end;

procedure TfrmControleRotasRegiao.pProximaOrdenacao;
begin
  pnlPesquisa.Visible := False;

  If Not cdsConsulta.Active Then
    lflLastField.intIndCol := -1
  Else
    pPegaProximaColuna;

  fAbreConsulta(False);
end;

end.
