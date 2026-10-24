unit untFatConfirmacaoAjustes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  untFuncFat, untFuncFatTypes, StrUtils, MaskUtils,
  BitBtnLockedIncrem, Gauges, untZClient, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untTLock;

type
  TfrmFatConfirmacaoAjustes = class(TfrmPaiOrdena)
    btnConfirmacao: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    btnDesmarcar: TBitBtnLocked;
    pnlProgressoDetalhes: TPanel;
    pgbProgressoDetalhes: TGauge;
    lblProgressoDetalhes: TLabel;
    pnlProgressoGeral: TPanel;
    pgbProgressoGeral: TGauge;
    lblProgressoGeral: TLabel;
    lblTotImp: TLabel;
    edtTotEntSel: TEditFocus;
    lbl1: TLabel;
    edtTotSaiSel: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmacaoClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure edtCodCliEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryCadCli: TUniQuery;
    fatVenda : TfatVenda;

    cdsItensAju: TZClient;

    strMesAno: String;
    strInfoProcessamento: String;

    stlListaFaturados: TStringList;

    blnMarcandoTodos: Boolean;
    objLock: TLock;

    procedure pCarregaCliente;
    Procedure pCriaTemporariaVenda(Var fatVenda : TFatVenda);

    Function fConfirmar: Boolean;
    Function fConfirmaDocumento(strEntSai: String): Boolean;
    procedure pIncluiItens(fatVenda: TFatVenda; strEntSai: String);

    Function fSetarParametros(qryDados: TUniQuery): Boolean;
    procedure pRegistrarProgresso(strTexto: String; lblInformacao: TLabel; pgbProgresso: Tgauge; intInicio, intAtual, intFinal: Integer);

    function fFaturarAjustes: Boolean;
    function fTravaConfirmacao: Boolean;
    function fValidaDados: Boolean;

    procedure pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
    procedure pAtualizaTotalSelecionado;
    function fValidaCompetencia(strMesAno: String): Boolean;
    function fRetornaMesAno: String;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fGetSQLItens(blnAgrupar: Boolean = False): String;
    function fSetParametros: Boolean; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    procedure pAcaoAdd; Override;
    procedure pAcaoDel; Override;
  end;


implementation

uses Math, untFuncoes, untConsultas, untTypesSistema,
     untPesqAux, untPai, untFuncoesSimples, untGravando, untFatDigMensagemEP, 
     untDuplicatas, untFatDadosFiscais, untMaskInputDialog;
{$R *.dfm}

procedure TfrmFatConfirmacaoAjustes.pAcaoAdd;
begin
  inherited;
  If Not blnMarcandoTodos Then
    pAtualizaTotalSelecionado;
end;

procedure TfrmFatConfirmacaoAjustes.pAcaoDel;
begin
  inherited;
  pAtualizaTotalSelecionado;
end;

procedure TfrmFatConfirmacaoAjustes.pAtualizaTotalSelecionado;
  Var
    intContad: Integer;
    blnFilter: Boolean;
    strFilter: String;
    strSeqGer: String;
    fltTotEnt: Double;
    fltTotSai: Double;
begin
  With cdsConsulta Do
  Begin
    fltTotEnt := 0.00;
    fltTotSai := 0.00;

    blnFilter := False;

    If Active Then
    Begin
      Try
        DisableControls;

        strSeqGer := FieldByName('AUTOINCREM').AsString;
        blnFilter := Filtered;
        strFilter := Filter;

        Filter   := '';
        Filtered := False;

        For intContad := 0 to stlListSelecao.Count -1 Do
        Begin
          If Locate('AUTOINCREM', stlListSelecao[intContad], []) Then
          Begin
            fltTotEnt := fltTotEnt + FieldByName('DET_TOTENT').AsFloat;
            fltTotSai := fltTotSai + FieldByName('DET_TOTSAI').AsFloat;
          End;
        End;

      Finally
        Filter := strFilter;
        Filtered := blnFilter;
        Locate('AUTOINCREM', strSeqGer, []);
        EnableControls;
      End;
    End;

    edtTotEntSel.Text := FormatFloat('#,##0.00', fltTotEnt);
    edtTotSaiSel.Text := FormatFloat('#,##0.00', fltTotSai);
  End;
end;

procedure TfrmFatConfirmacaoAjustes.pCarregaCliente;
begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
  If Not (fEmptyStr(edtCodCli.Text)) Then
    edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtNomCli.Text := '';
end;

function TfrmFatConfirmacaoAjustes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        objLock.pDestravarTodos;
        fMensagem('', 'Informe o código do cliente!', ['&Ok']);
        Result := FALSE;
      End

      Else
      Begin
        pCarregaCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          objLock.pDestravarTodos;
          fMensagem('', 'Cliente não cadastrado!', ['&Ok']);
          Result := FALSE;
        End
        Else
        Begin
          If fTravaConfirmacao Then
          Begin
            pLimpaPesquisa;
            fAbreConsulta(FALSE);
          End
          Else
            Result := False;
        End;

      End
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatConfirmacaoAjustes.fGetSql(blnLike: Boolean): String;
Begin
  Result := fGetSQLItens(True);
End;

function TfrmFatConfirmacaoAjustes.fGetSQLItens(blnAgrupar: Boolean = False): String;
  Const
    STR_ITE_PRECUS = ' IF((LOT_NUMLOT IS NOT NULL) AND (LOT_PRECUS > 0), LOT_PRECUS, G.ITE_PRECUS) ';

  Var
    strSQL: String;

  function fGetSQLQtdIte: String;
  begin
    Result := 'ROUND(IF(D.DET_ESPDOC = "ML" AND I.ITE_CNV_ML > 0, D.DET_QTDITE / I.ITE_CNV_ML, D.DET_QTDITE), 4)';
  end;

  function fGetSQLUnitar(strEntSai: String): String;
    Var
      strPRCAJ : String;
  begin
    strPRCAJ := fCfgSis('PRCAJ' + strEntSai);

    If strPRCAJ = 'PRECUS' Then
      Result := 'ROUND(IF(DET_PROACA = "S", DET_UNITAR, ' + STR_ITE_PRECUS + ' ), ' + fCfgSis('DECUNI') + ')'

    Else If (strPRCAJ = 'PREMED') Then
      Result := 'ROUND(IF(DET_PROACA = "S", DET_UNITAR, IF(IFNULL(ITE_PREMED,0) = 0, ' + STR_ITE_PRECUS + ', ITE_PREMED)), ' + fCfgSis('DECUNI') + ')'

    Else
      Result := 'ROUND(IF(DET_PROACA = "S", DET_UNITAR, ITE_' + strPRCAJ + '), ' + fCfgSis('DECUNI') + ')';
  end;

Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE  ';
  strSQL := strSQL + '   D.DET_CLAFIS, ';
  strSQL := strSQL + '   D.DET_ESPDOC, ';
  strSQL := strSQL + '   D.DET_NUMDOC, ';
  strSQL := strSQL + '   D.DET_CODEMP, ';
  strSQL := strSQL + '   D.DET_DTAENT, ';
  strSQL := strSQL + '   D.DET_HORENT, ';
  strSQL := strSQL + '   D.DET_CODVEN, ';
  strSQL := strSQL + '   D.DET_IDEPRO, ';
  strSQL := strSQL + '   D.DET_CODITE, ';
  strSQL := strSQL + '   D.DET_DESCRI, ';
  strSQL := strSQL + '   IF(IFNULL(D.DET_UNIDAD, "") = "", I.ITE_CODUNI, D.DET_UNIDAD) AS DET_UNIDAD, ';
  strSQL := strSQL + '   (T.DET_IMPULT / D.DET_QTDITE) AS IMPULT, ';
  strSQL := strSQL + '   D.DET_TOTCUS, ';
  strSQL := strSQL + '   D.DET_TOTCU2, ';
  strSQL := strSQL + '   D.DET_QTDEMB, ';
  strSQL := strSQL + '   D.DET_PREEMB, ';
  strSQL := strSQL + '   D.DET_CODMAR, ';
  strSQL := strSQL + '   D.DET_REFERE, ';
  strSQL := strSQL + '   D.DET_INCPIS, ';
  strSQL := strSQL + '   D.DET_ITECHA, ';
  strSQL := strSQL + '   D.DET_ITETIN, ';
  strSQL := strSQL + '   D.DET_LINLIN, ';
  strSQL := strSQL + '   D.DET_DESCOR, ';
  strSQL := strSQL + '   D.DET_TIPPRE, ';
  strSQL := strSQL + '   D.DET_LAZQUA, ';
  strSQL := strSQL + '   D.DET_TIPEMB, ';
  strSQL := strSQL + '   D.DET_PRCTIN, ';
  strSQL := strSQL + '   D.DET_FATTIN, ';
  strSQL := strSQL + '   D.DET_PROMOC, ';
  strSQL := strSQL + '   D.DET_SEQTIN, ';
  strSQL := strSQL + '   D.DET_VOLPRO, ';
  strSQL := strSQL + '   D.DET_CODACA, ';
  strSQL := strSQL + '   D.DET_EMPACA, ';
  strSQL := strSQL + '   D.DET_PROACA, ';
  strSQL := strSQL + '   D.DET_TABPRE, ';
  strSQL := strSQL + '   D.DET_PRVTIN, ';
  strSQL := strSQL + '   I.ITE_CODGRU, ';
  strSQL := strSQL + '   I.ITE_CODFOR, ';
  strSQL := strSQL + '   I.ITE_CODMAR, ';
  strSQL := strSQL + '   I.ITE_INCPIS, ';
  strSQL := strSQL + '   D.DET_TOTITE, ';
  strSQL := strSQL + STR_ITE_PRECUS + ' AS ITE_PRECUS, ';
  strSQL := strSQL + '   G.ITE_ICMSAI, ';
  strSQL := strSQL + '   G.ITE_IMPFED, ';
  strSQL := strSQL + '   G.ITE_DESOPE, ';
  strSQL := strSQL + '   G.ITE_PREMED, ';
  strSQL := strSQL + '   I.ITE_PESOIT, ';
  strSQL := strSQL + '   I.ITE_PESLIQ, ';
  strSQL := strSQL + '   I.ITE_DESITE, ';
  strSQL := strSQL + '   I.ITE_DESFAB, ';
  strSQL := strSQL + '   I.ITE_COMLUB, ';
  strSQL := strSQL + '   I.ITE_CLAIPI, ';
  strSQL := strSQL + '   I.ITE_EXCIPI, ';
  strSQL := strSQL + '   I.ITE_CODFAB, ';
  strSQL := strSQL + '   G.ITE_PRECOM, ';
  strSQL := strSQL + '   G.ITE_PREVE1, ';
  strSQL := strSQL + '   G.ITE_PREVE2, ';
  strSQL := strSQL + '   G.ITE_PREVE3, ';
  strSQL := strSQL + '   G.ITE_PREVE4, ';
  strSQL := strSQL + '   G.ITE_PREVE5, ';
  strSQL := strSQL + '   G.ITE_PREVE6, ';
  strSQL := strSQL + '   G.ITE_PREVE7, ';
  strSQL := strSQL + '   G.ITE_PREULT, ';
  strSQL := strSQL + '   G.ITE_IMPULT, ';
  strSQL := strSQL + '   G.ITE_QTDUCO, ';
  strSQL := strSQL + '   G.ITE_IPISAI, ';
  strSQL := strSQL + '   G.ITE_DESMAX, ';
  strSQL := strSQL + '   G.ITE_SALDOS, ';
  strSQL := strSQL + '   G.ITE_PREMED, ';
  strSQL := strSQL + '   G.ITE_COMVAR, ';
  strSQL := strSQL + '   G.ITE_COMATA, ';
  strSQL := strSQL + '   G.ITE_COMDIS, ';
  strSQL := strSQL + '   G.ITE_MARMIN, ';
  strSQL := strSQL + '   G.ITE_MARMSG, ';
  strSQL := strSQL + '   G.ITE_MARMGE, ';

  strSQL := strSQL + '   G.ITE_DESMVM, ';
  strSQL := strSQL + '   G.ITE_DESMSM, ';
  strSQL := strSQL + '   G.ITE_DESMGM, ';

  strSQL := strSQL + '   G.ITE_MARMMV, ';
  strSQL := strSQL + '   G.ITE_MARMMS, ';
  strSQL := strSQL + '   G.ITE_MARMMG, ';

  strSQL := strSQL + '   G.ITE_IPIENT, ';
  strSQL := strSQL + '   G.ITE_FREENT, ';
  strSQL := strSQL + '   G.ITE_QTPPRO, ';
  strSQL := strSQL + '   A.ABF_CODABF, ';
  strSQL := strSQL + '   M.MAR_DESMAR, ';
  strSQL := strSQL + '   I.ITE_OBRCPF, ';
  strSQL := strSQL + '   D.DET_NUMLOT, ';

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '   I.ITE_IMPDIR, '
  Else
    strSQL := strSQL + '   G.ITE_IMPDIR, ';

  If blnAgrupar Then
  Begin
    strSQL := strSQL + '   SUM(IF(DET_CLAFIS < 5000, ' + fGetSQLQtdIte + ', 0)) AS DET_QTDENT, ';
    strSQL := strSQL + '   SUM(IF(DET_CLAFIS > 5000, ' + fGetSQLQtdIte + ', 0)) AS DET_QTDSAI, ';
    strSQL := strSQL + '   SUM(IF(DET_CLAFIS < 5000, ROUND(' + fGetSQLQtdIte + ' * ' + fGetSQLUnitar('E') + ', 2), 0)) AS DET_TOTENT, ';
    strSQL := strSQL + '   SUM(IF(DET_CLAFIS > 5000, ROUND(' + fGetSQLQtdIte + ' * ' + fGetSQLUnitar('S') + ', 2), 0)) AS DET_TOTSAI, ';
  End
  Else
  Begin
    strSQL := strSQL + '   ' + fGetSQLUnitar('E') + ' AS DET_UNIENT, ';
    strSQL := strSQL + '   ' + fGetSQLUnitar('S') + ' AS DET_UNISAI, ';
    strSQL := strSQL + '   ' + fGetSQLQtdIte + ' AS DET_QTDITE, ';
  End;

  strSQL := strSQL + '   D.DET_SEQGER, ';
  strSQL := strSQL + '   D.DET_SEQGER AS AUTOINCREM, ';
  strSQL := strSQL + '   D.AUTOINCREM AS AUTINC ';

  strSQL := strSQL + ' FROM            ';
  strSQL := strSQL + '   MOVDET D     ';
  strSQL := strSQL + '   INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE      ';
  strSQL := strSQL + '   INNER JOIN ITEGER G ON G.ITE_CODITE = D.DET_CODITE AND  ';
  strSQL := strSQL + '                          G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + '   LEFT JOIN CADLOT  ON  G.ITE_CODITE = LOT_CODITE AND  ';
  strSQL := strSQL + '                         G.ITE_CODEMP = LOT_CODEMP AND  ';
  strSQL := strSQL + '                         D.DET_NUMLOT = LOT_NUMLOT       ';

  strSQL := strSQL + '   INNER JOIN CADMAR  M ON I.ITE_CODMAR = M.MAR_CODMAR ';
  strSQL := strSQL + '   INNER JOIN ABFICM  A ON A.ABF_ESTADO = :ESTADO AND  ';

  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + ' I.ITE_CODABF = A.ABF_CODABF '
  Else
    strSQL := strSQL + ' G.ITE_CODABF = A.ABF_CODABF ';

  strSQL := strSQL + '   LEFT  JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   D.DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  (D.DET_ESPDOC = "AJ" OR D.DET_TIPFAT = "AJ") AND    ';
  strSQL := strSQL + '   D.DET_ESPDOC <> "TM"   AND ';
  strSQL := strSQL + '   D.DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '   T.DET_DOCCAJ IS NULL   AND ';
  strSQL := strSQL + '   D.DET_PROEMB <> "S"        ';

  If Not fEmptyDate(mskDtaIni.Text) Then
    strSQL := strSQL + ' AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If blnAgrupar Then
  Begin
    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '   D.DET_SEQGER ';
  End;

  Result := strSQL;
End;

function TfrmFatConfirmacaoAjustes.fSetParametros: Boolean;
Begin
  Result := fSetarParametros(qryConsulta);
End;

function TfrmFatConfirmacaoAjustes.fSetarParametros(qryDados: TUniQuery): Boolean;
Begin
  With qryDados, Sql Do
  Begin
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    ParamByName('ESTADO').AsString  := fCadEmp('ESTADO');

    If Not fEmptyDate(mskDtaIni.Text) Then
    Begin
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;
  End;

  Result := True;
End;

procedure TfrmFatConfirmacaoAjustes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F6    : If btnMarcar.Visible Then btnMarcar.Click;
    VK_F7    : If btnDesmarcar.Visible Then btnDesmarcar.Click;
    VK_F10   : If btnConfirmacao.Visible Then btnConfirmacao.Click;
    VK_ESCAPE: If fCheckParent(ActiveControl, pnlHeader) Then
               Begin
                 Close;
               End  
               Else If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1 Then
               Begin
                 pSetFocus(mskDtaIni);
               End;

    Else       inherited;
  End;

end;

procedure TfrmFatConfirmacaoAjustes.FormShow(Sender: TObject);
begin
  inherited;

  blnSempreRelerBanco  := FALSE;
  blnQuoteLista        := FALSE;
  blnSelecionaComEnter := TRUE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftDate;
end;

function TfrmFatConfirmacaoAjustes.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Result := inherited fAbreConsulta(blnLike);

  If Result Then
  Begin
    (cdsConsulta.FieldByName('DET_QTDENT') As TFloatField).DisplayFormat := fMskDigitos(4);
    (cdsConsulta.FieldByName('DET_QTDSAI') As TFloatField).DisplayFormat := fMskDigitos(4);
    (cdsConsulta.FieldByName('DET_TOTENT') As TFloatField).DisplayFormat := fMskDigitos(2);
    (cdsConsulta.FieldByName('DET_TOTSAI') As TFloatField).DisplayFormat := fMskDigitos(2);
  End;

  Result := Result And Not cdsConsulta.IsEmpty;

  If Result Then
  Begin
    With cdsItensAju, qryQuery, SQL Do
    Begin
      cdsItensAju.Close;

      Close;
      Clear;
      Add(fGetSQLItens);
      fSetarParametros(qryQuery);
      Open;
      pSetaClient(qryQuery);
      pSetProvider;

      cdsItensAju.Open;
    End;
  End;

End;

procedure TfrmFatConfirmacaoAjustes.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.Active Then
    pDesmarcaTodos;

  pAtualizaTotalSelecionado;
end;

procedure TfrmFatConfirmacaoAjustes.btnMarcarClick(Sender: TObject);
begin
  inherited;
  Try
    blnMarcandoTodos := True;  
    If cdsConsulta.Active Then
      pMarcaTodos;
  Finally
    blnMarcandoTodos := False;
  End;
  pAtualizaTotalSelecionado;
end;

procedure TfrmFatConfirmacaoAjustes.btnMudaOrdemClick(Sender: TObject);
begin
  If cdsConsulta.Active Then
    inherited;
end;

procedure TfrmFatConfirmacaoAjustes.btnPesquisarClick(Sender: TObject);
begin
  If cdsConsulta.Active Then
    inherited;
end;

procedure TfrmFatConfirmacaoAjustes.edtCodCliEnter(Sender: TObject);
begin
  inherited;
  stlListSelecao.Clear;

  If cdsConsulta.Active Then
    cdsConsulta.EmptyDataSet;

  If cdsItensAju.Active Then
    cdsItensAju.EmptyDataSet;

  objLock.pDestravarTodos;

  pAtualizaTotalSelecionado;    
end;

procedure TfrmFatConfirmacaoAjustes.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConfirmacaoAjustes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmFatConfirmacaoAjustes.FormCreate(Sender: TObject);
begin
  inherited;
  blnMarcandoTodos := False;
  qryCadCli := fCriaQuery(Self);
  cdsItensAju := TZClient.Create(Self);
  stlListaFaturados := TStringList.Create;
  objLock := TLock.Create;
end;

procedure TfrmFatConfirmacaoAjustes.FormDestroy(Sender: TObject);
begin
  stlListaFaturados.Destroy;
  FreeAndNil(objLock);
  inherited;
end;

function TfrmFatConfirmacaoAjustes.fValidaDados: Boolean;
Var
  intContad: Integer;
begin
  Result := True;

  strMesAno := '';

  cdsConsulta.DisableControls;

  Try
    For intContad := 0 to stlListSelecao.Count -1 Do
    Begin
      If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intContad], []) Then
      Begin
        If (not fEmptyStr(strMesAno)) And (strMesAno <> FormatDateTime('MM/yyyy', cdsConsulta.FieldByName('DET_DTAENT').AsDateTime)) Then
        Begin
          Result := False;
          Break;
        End;

        strMesAno := FormatDateTime('MM/yyyy', cdsConsulta.FieldByName('DET_DTAENT').AsDateTime);
      End;
    End;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  End;

end;

procedure TfrmFatConfirmacaoAjustes.btnConfirmacaoClick(Sender: TObject);
begin
  inherited;

  If Not cdsConsulta.Active Then
    Exit;

  pLimpaPesquisa;    

  If cdsConsulta.IsEmpty Then
    Exit;

  If stlListSelecao.Count = 0 Then
  Begin
    fMensagem('', 'Selecione pelo menos um documento para confirmar!', ['&Ok']);
    Exit;
  End;

  If not fValidaDados Then
  Begin
    fMensagem('', 'Não é permitido selecionar documentos com Mês/Ano diferentes!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('', 'Confirma emissão da nota fiscal?', ['&Sim', '&Não']) = 1) Then
  Begin
    Try
      If fConfirmar Then
        fMensagem('', 'Confirmação realizada com sucesso!', [' &Ok '])
      Else
        fMensagem('', 'Não foi possível confirmar o(s) documento(s)!', ['&Ok']);
    Finally
      stlListSelecao.Clear;
      If fTravaConfirmacao Then
      Begin
        fAbreConsulta(FALSE);
        pAtualizaTotalSelecionado;
      End
      Else
        pSetFocus(mskDtaIni);
    End;
  End;

end;

Procedure TfrmFatConfirmacaoAjustes.pCriaTemporariaVenda(Var fatVenda : TFatVenda);
Begin
  pCriarCdsVenda(Self);
  fatVenda := TFatVenda.CreateInstance('CA');
  fatVenda.strOpcDocTrue:= 'CA';
  fatVenda.strNomeForm  := 'frmFatVendas';
  fatVenda.strCodTra    := fCfgSis('TRASUG');
  fatVenda.blnNotEsp    := True;
  fatVenda.strEspDoc    := 'NF';
  fatVenda.strTipFat    := 'Nota Fiscal';
  fatVenda.fFaturarAjustes := fFaturarAjustes;
End;

procedure TfrmFatConfirmacaoAjustes.pOnProcessaItem(const item: TDadosFechamento;
  index, count: Integer; AInfo: String = '');
begin
  If AInfo.IsEmpty Then
    AInfo := strInfoProcessamento;
  pRegistrarProgresso(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 35)]),
    lblProgressoDetalhes, pgbProgressoDetalhes, 0, Succ(index), count);
end;

function TfrmFatConfirmacaoAjustes.fValidaCompetencia(strMesAno: String): Boolean;
Begin
  Result := True;

  Try

    If fEmptyStr(AnsiReplaceStr(strMesAno,'/','')) Then
    Begin
      Result := False;
      Exit;
    End;

    If not (StrToDateDef('01/' + strMesAno, 0) > 0) Then
    Begin
      Result := False;
      Exit;
    End;

  Except
    Result := False;
  End;

End;

function TfrmFatConfirmacaoAjustes.fRetornaMesAno: String;
begin
  Result := fMaskInputDialog('Confirme a competência do ajuste', 'Confirme o Mês/Ano:', AnsiReplaceStr(Self.strMesAno,'/',''), 255, 450, ecNormal, '99/9999;1;_');

  If not fValidaCompetencia(Result) Then
  Begin
    Result := '';
    fMensagem('','Competência inválida!', ['&Ok']);
  End;
end;

Function TfrmFatConfirmacaoAjustes.fConfirmar: Boolean;
begin
  Result := True;

  Try
    pCriaTemporariaVenda(fatVenda);

    Try
      fatVenda.pCarregaDadosClienteBaixa(edtCodCli.Text);

      fatVenda.strCodVen := fatVenda.strCodOpe;
      fatVenda.strCodDig := fatVenda.strCodOpe;
      fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
      fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);
      fatVenda.strMesAno := fRetornaMesAno;

      If fEmptyStr(fatVenda.strMesAno) Then
      Begin
        Result := False;
        Exit;
      End;

      If (fatVenda.blnCliFil) And
         (fRetornaClienteFilial(VS_strCodEmp) <> fatVenda.strCodCli) Then
      Begin
        fatVenda.pAtualizaClassTransferencias;
      End;

      If not fCfgSis('DFSEST', varBoolean) Then
      Begin
        pCriarFormularios(TfrmFatDigMensagemEP, frmFatDigMensagemEP);
        Try
          frmFatDigMensagemEP.Caption := 'Mensagem da Confirmação de Ajuste';
          frmFatDigMensagemEP.fatVenda := fatVenda;
          Result := (frmFatDigMensagemEP.ShowModal = MrOk);
        Finally
          pFreeAndNil(frmFatDigMensagemEP);
        End;
      End;

      If (Result) Then
        Result := fConfirmaDocumento('E') And
                  fConfirmaDocumento('S');
    Finally
      FreeAndNil(fatVenda);
      pFreeCdsVenda;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmFatConfirmacaoAjustes.fConfirmar]');
    End;
  End;
end;

Function TfrmFatConfirmacaoAjustes.fConfirmaDocumento(strEntSai: String): Boolean;
  Var
    strInformacao: String;
Begin
  Try
    Result := False;
    Screen.Cursor := crHourGlass;
    cdsConsulta.DisableControls;
    pnlProgressoDetalhes.Visible := True;
    pnlProgressoGeral.Visible    := True;

    Try
      cdsVenda.EmptyDataSet;
      stlListaFaturados.Clear;

      pIncluiItens(fatVenda, strEntSai);

      FillChar(fatVenda.recInconsistenciaEFD, SizeOf(fatVenda.recInconsistenciaEFD), #0);

      If (cdsVenda.RecordCount > 0) And (Not fEmptyStr(fCfgSis('CLAICA'))) Then
        fatVenda.pPedeDadosTratamentoInconsistenciaEFD;

      fatVenda.pCarregaAliquotasRetencao;

      strInfoProcessamento := 'Aguarde, Processando produto %s ...';

      fatVenda.pPreencheMatrizFechamento('', pOnProcessaItem);

      fatVenda.strEntSaiConfAjuEst := strEntSai;

      If fatVenda.fUltrapassouLimiteItensNFe(Length(fatVenda.arrMatItens), '', strInformacao) Then
      Begin
        pMensagemSonora(strInformacao);
      End
      Else If Length(fatVenda.arrMatItens) > 0 Then
      Begin
        fatVenda.pCalculaPesBruLiq;

        strInfoProcessamento := 'Aguarde, Calculando valor do produto %s ...';

        fatVenda.pDestacaRetencoes;
        fatVenda.pRetemImpostosNoDescontoEspecial;

        fatVenda.pCalculaTotGer(False, True, pOnProcessaItem);

        fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

        If fCfgSis('DFSEST', varBoolean) Then
        Begin
          pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
          Try
            frmFatDadosFiscais.Caption := Self.Caption;
            frmFatDadosFiscais.fatVenda := fatVenda;
            frmFatDadosFiscais.ShowModal;

            If not frmFatDadosFiscais.blnConfirma Then
              Exit;
          Finally
            pFreeAndNil(frmFatDadosFiscais);
          End;
        End;

        fatVenda.pCalculaTotalParaCadRec;

        fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotCadRec,
                                                 FAlse, False, False, VS_Date, False);
        fatVenda.pRateiaValores;

        fatVenda.pVerificaModalidadeFreteConfirmacaoAjuste();

        fatVenda.blnGerouNotaConfAjuEst := True;

        Try
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.strChave := 'FATVENDAS';
          frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
          frmGravando.ShowModal;

          Result := frmGravando.blnConfirma;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message,'[btnGerPedClick - frmGravando]');
            Result := False;
          End;
        End;

        pFreeAndNil(frmGravando);
      End
      Else
      Begin
        fatVenda.blnGerouNotaConfAjuEst := False;
        Result := fFaturarAjustes();
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        FreeAndNil(fatVenda);
        pMensagensErro(E.Message, '[TfrmFatConfirmacaoAjustes.fConfirmaDocumento]');
      End;
    End;

  Finally
    Screen.Cursor := crDefault;
    cdsConsulta.EnableControls;
    pnlProgressoDetalhes.Visible := False;
    pnlProgressoGeral.Visible    := False;
  End;
End;

procedure TfrmFatConfirmacaoAjustes.pIncluiItens(fatVenda: TFatVenda; strEntSai: String);
Var
  cdsSint: TUniClientDataSet;
  stlSint: TStringList;
  stlNor: TStringList;
  intIndex: Integer;
  recMadeira : TDadosMadeira;
  recForTin  : TForTin;

  function fGetEntradaSaidaSint():String;
  begin
    If (cdsSint.FieldByName('QTDITE').AsFloat > 0) Then
      Result := 'E'
    Else If (cdsSint.FieldByName('QTDITE').AsFloat < 0) Then
      Result := 'S'
    Else
      Result := 'N';
  end;

  function fGetEntradaSaida():String;
  begin
    Result := IIF((cdsItensAju.FieldByName('DET_CLAFIS').AsInteger < 5000), 'E', 'S');
  end;

  function fGetUnitario: Double;
  begin
    Result := IIF((fGetEntradaSaida() = 'E'), cdsItensAju.FieldByName('DET_UNIENT').AsFloat, cdsItensAju.FieldByName('DET_UNISAI').AsFloat);
  end;

  procedure pAddItemTemp(fltQtdIte: Double);
  begin
    fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                         Nil,
                                         cdsItensAju.FieldByName('DET_IDEPRO').AsString,
                                         cdsItensAju.FieldByName('ITE_CODGRU').AsString,
                                         cdsItensAju.FieldByName('DET_CODITE').AsString,
                                         cdsItensAju.FieldByName('ITE_DESITE').AsString,
                                         cdsItensAju.FieldByName('DET_DESCRI').AsString,
                                         cdsItensAju.FieldByName('ITE_DESFAB').AsString,
                                         cdsItensAju.FieldByName('DET_UNIDAD').AsString,
                                         cdsItensAju.FieldByName('DET_UNIDAD').AsString,
                                         cdsItensAju.FieldByName('DET_CODMAR').AsString,
                                         cdsItensAju.FieldByName('ITE_CODFOR').AsString,
                                         cdsItensAju.FieldByName('DET_REFERE').AsString,
                                         fGetUnitario,
                                         fGetUnitario,
                                         fGetUnitario,
                                         fGetUnitario,
                                         0.00,
                                         fltQtdIte,
                                         fltQtdIte * fGetUnitario,
                                         strEntSai,
                                         cdsItensAju.FieldByName('ITE_PRECUS').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PRECUS').AsFloat * fltQtdIte,
                                         cdsItensAju.FieldByName('ITE_COMLUB').AsString,
                                         cdsItensAju.FieldByName('ITE_IPISAI').AsFloat,
                                         cdsItensAju.FieldByName('ITE_DESMAX').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREVE1').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREVE2').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREVE3').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREVE4').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREVE5').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREVE6').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREVE7').AsFloat,
                                         fCalculaPrecoVenda(2, cdsItensAju.FieldByName('ITE_PRECUS').AsFloat, fGetUnitario, 0, 0, 0, 0, 0),
                                         cdsItensAju.FieldByName('ITE_SALDOS').AsFloat,
                                         cdsItensAju.FieldByName('DET_INCPIS').AsString,
                                         cdsItensAju.FieldByName('ITE_COMVAR').AsFloat,
                                         cdsItensAju.FieldByName('ITE_COMATA').AsFloat,
                                         cdsItensAju.FieldByName('ITE_COMDIS').AsFloat,
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         cdsItensAju.FieldByName('ITE_PREULT').AsFloat * fltQtdIte,
                                         cdsItensAju.FieldByName('ITE_IMPULT').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREULT').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PREMED').AsFloat,
                                         cdsItensAju.FieldByName('ITE_CLAIPI').AsString,
                                         cdsItensAju.FieldByName('DET_ITECHA').AsString,
                                         cdsItensAju.FieldByName('DET_ITETIN').AsString,
                                         cdsItensAju.FieldByName('DET_DESCOR').AsString,
                                         cdsItensAju.FieldByName('DET_TIPPRE').AsString,
                                         cdsItensAju.FieldByName('DET_LAZQUA').AsInteger,
                                         cdsItensAju.FieldByName('DET_TIPEMB').AsString,
                                         0,
                                         0,
                                         cdsItensAju.FieldByName('DET_PRVTIN').AsFloat,
                                         cdsItensAju.FieldByName('DET_PRCTIN').AsFloat,
                                         cdsItensAju.FieldByName('DET_FATTIN').AsFloat,
                                         'N',
                                         '',
                                         0,
                                         0,
                                         cdsItensAju.FieldByName('ABF_CODABF').AsString,
                                         cdsItensAju.FieldByName('ITE_PESOIT').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PESLIQ').AsFloat,
                                         cdsItensAju.FieldByName('DET_PROMOC').AsString,
                                         0,
                                         0,
                                         0,
                                         0,
                                         IIF(fEmptyStr(cdsItensAju.FieldByName('DET_SEQTIN').AsString), '', '2'),
                                         fatVenda.fRetPerComGrupo(cdsItensAju.FieldByName('ITE_CODGRU').AsString),
                                         cdsItensAju.FieldByName('ITE_CODFAB').AsString,
                                         -1,
                                         0,
                                         '',
                                         '',
                                         '',
                                         cdsItensAju.FieldByName('ITE_MARMIN').AsFloat,
                                         cdsItensAju.FieldByName('ITE_MARMSG').AsFloat,
                                         cdsItensAju.FieldByName('ITE_MARMGE').AsFloat,
                                         fRetNomMarca(cdsItensAju.FieldByName('DET_CODMAR').AsString),
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         cdsItensAju.FieldByName('DET_LINLIN').AsString,
                                         0,
                                         '',
                                         '',
                                         '',
                                         cdsItensAju.FieldByName('ITE_PRECOM').AsFloat,
                                         fGetUnitario,
                                         cdsItensAju.FieldByName('ITE_QTPPRO').AsFloat,
                                         '',
                                         '',
                                         cdsItensAju.FieldByName('ITE_OBRCPF').AsString,
                                         '',
                                         '',
                                         fRetSiglaUnidade(cdsItensAju.FieldByName('DET_UNIDAD').AsString),
                                         cdsItensAju.FieldByName('DET_VOLPRO').AsFloat,
                                         Succ(cdsVenda.RecordCount),
                                         '',
                                         cdsItensAju.FieldByName('DET_CODACA').AsString,
                                         cdsItensAju.FieldByName('DET_EMPACA').AsString,
                                         cdsItensAju.FieldByName('DET_PROACA').AsString = 'S',
                                         cdsItensAju.FieldByName('DET_ESPDOC').AsString,
                                         cdsItensAju.FieldByName('DET_NUMDOC').AsString,
                                         cdsItensAju.FieldByName('DET_CODEMP').AsString,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         cdsItensAju.FieldByName('DET_TABPRE').AsString,
                                         cdsItensAju.FieldByName('ITE_IPIENT').AsFloat,
                                         cdsItensAju.FieldByName('ITE_FREENT').AsFloat,
                                         '',
                                         0.0,
                                         '',
                                         0.0,
                                         '',
                                         '',
                                         'N',
                                         '',
                                         0,
                                         fltQtdIte,
                                         0.0,
                                         0,
                                         cdsItensAju.FieldByName('ITE_IMPDIR').AsString,
                                         '',
                                         cdsItensAju.FieldByName('ITE_PRECUS').AsFloat,
                                         cdsItensAju.FieldByName('ITE_PRECUS').AsFloat * fltQtdIte,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         recForTin,
                                         '',
                                         '',
                                         IIF(fCfgSis('SINAJU', VarBoolean), '', cdsItensAju.FieldByName('DET_NUMLOT').AsString),
                                         '',
                                         '',
                                         False,
                                         'N',
                                         'NOR',
                                         0,
                                         '',
                                         'N',
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         True,
                                         '',
                                         '',
                                         '',
                                         0,
                                         cdsItensAju.FieldByName('ITE_PRECUS').AsFloat,
                                         '',
                                         '',
                                         recMadeira,
                                         cdsItensAju.FieldByName('ITE_IMPULT').AsFloat * fltQtdIte,
                                         0,
                                         0,
                                         '',
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         '',
                                         'N',
                                         0,
                                         0,
                                         0,
                                         False,
                                         False,
                                         'N',
                                         '',
                                         0,
                                         0,
                                         '',
                                         'N',
                                         0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         cdsItensAju.FieldByName('ITE_EXCIPI').AsString,
                                         0.00,
                                         '',
                                         '',
                                         '',
                                         'S',
                                         'N',
                                         '',
                                         '',
                                         '',
                                         '',
                                         False,
                                         -1,
                                         -1,
                                         'N',
                                         '',
                                         'N',
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         False,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         'N',
                                         'N',
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         cdsItensAju.FieldByName('ITE_MARMMV').AsFloat,
                                         cdsItensAju.FieldByName('ITE_MARMMS').AsFloat,
                                         cdsItensAju.FieldByName('ITE_MARMMG').AsFloat);
  end;

  procedure pAddItemSintTemp(fltQtdIte: Double);
  begin
    If fatVenda.fLocalizaItem(cdsItensAju.FieldByName('DET_CODITE').AsString,
                              cdsItensAju.FieldByName('DET_DESCRI').AsString,
                              fGetUnitario,
                              fltQtdIte,
                              '',
                              recMadeira) Then
    Begin
      fatVenda.fSomaNaTemporaria(cdsItensAju.FieldByName('DET_CODITE').AsString,
                                 cdsItensAju.FieldByName('DET_DESCRI').AsString,
                                 IIF(fCfgSis('SINAJU', VarBoolean), '', cdsItensAju.FieldByName('DET_NUMLOT').AsString),
                                 fGetUnitario,
                                 fltQtdIte,
                                 cdsItensAju.FieldByName('DET_TOTITE').AsFloat,
                                 cdsItensAju.FieldByName('DET_TOTCUS').AsFloat,
                                 cdsItensAju.FieldByName('DET_TOTCU2').AsFloat,
                                 cdsItensAju.FieldByName('DET_QTDEMB').AsFloat,
                                 cdsItensAju.FieldByName('DET_PREEMB').AsFloat,
                                 cdsItensAju.FieldByName('ITE_IPISAI').AsFloat,
                                 recMadeira,
                                 cdsItensAju.FieldByName('DET_CODVEN').AsString,
                                 '',
                                 cdsItensAju.FieldByName('ITE_IMPULT').AsFloat * fltQtdIte,
                                 cdsItensAju.FieldByName('DET_NUMDOC').AsString,
                                 cdsItensAju.FieldByName('DET_ESPDOC').AsString,
                                 cdsItensAju.FieldByName('DET_CODEMP').AsString,
                                 cdsItensAju.FieldByName('AUTOINCREM').AsString);
    End
    Else
      pAddItemTemp(fltQtdIte);
  end;

  procedure pCriarCDSSint();
  begin
    cdsSint.FieldDefs.Add('CODITE', ftString, 5);
    cdsSint.FieldDefs.Add('DESCRI', ftString, 87);
    cdsSint.FieldDefs.Add('UNITAR', ftFloat, 0);
    cdsSint.FieldDefs.Add('QTDITE', ftFloat, 0);
    cdsSint.CreateDataSet();
  end;

begin
  cdsSint := TUniClientDataSet.Create(Self);
  stlSint := TStringList.Create;
  stlNor  := TStringList.Create;

  Try
    pCriarCDSSint();

    For intIndex := 0 To PRed(stlListSelecao.Count) Do
    Begin
      If (Not cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndex], [])) Then
        Continue;

      cdsItensAju.Filter := 'DET_SEQGER = ' + QuotedStr(stlListSelecao[intIndex]);
      cdsItensAju.Filtered := True;

      pRegistrarProgresso('Aguarde, Processando documentos de ' + IIF(strEntSai = 'E', 'Entrada', 'Saída') + '...', lblProgressoGeral, pgbProgressoGeral, 0, intIndex + 1, stlListSelecao.Count);
      pRegistrarProgresso('Aguarde, Inserindo produto(s) do documento ' + cdsConsulta.FieldByName('DET_NUMDOC').AsString + '-' + cdsConsulta.FieldByName('DET_ESPDOC').AsString + ' ...', lblProgressoDetalhes, pgbProgressoDetalhes, 0, 0, 0);

      stlListaFaturados.Add(stlListSelecao[intIndex]);

      cdsItensAju.First;
      While (Not cdsItensAju.Eof) Do
      Begin
        If (Not fatVenda.blnMeiaNota) And
           (fCfgSis('SINAJU', VarBoolean)) And
           (cdsItensAju.FieldByName('DET_IDEPRO').AsString = 'NOR') And
           (Pos('ITEM ESPECIAL', cdsItensAju.FieldByName('ITE_DESITE').AsString) <= 0) Then
        Begin
          stlSint.Add(cdsItensAju.FieldByName('AUTINC').AsString);

          If (Not cdsSint.Locate('CODITE;DESCRI;UNITAR',
                                 VarArrayOf([cdsItensAju.FieldByName('DET_CODITE').AsString,
                                             cdsItensAju.FieldByName('DET_DESCRI').AsString,
                                             FloatToStr(fGetUnitario)]), [])) Then
          Begin
            cdsSint.Append;
            cdsSint.FieldByName('CODITE').AsString := cdsItensAju.FieldByName('DET_CODITE').AsString;
            cdsSint.FieldByName('DESCRI').AsString := cdsItensAju.FieldByName('DET_DESCRI').AsString;
            cdsSint.FieldByName('UNITAR').AsFloat := fGetUnitario();
            cdsSint.FieldByName('QTDITE').AsFloat := 0;

            If (fGetEntradaSaida() = 'E') Then
              cdsSint.FieldByName('QTDITE').AsFloat := cdsSint.FieldByName('QTDITE').AsFloat + cdsItensAju.FieldByName('DET_QTDITE').AsFloat
            Else
              cdsSint.FieldByName('QTDITE').AsFloat := cdsSint.FieldByName('QTDITE').AsFloat - cdsItensAju.FieldByName('DET_QTDITE').AsFloat;

            cdsSint.Post;
          End
          Else
          Begin
            cdsSint.Edit;

            If (fGetEntradaSaida() = 'E') Then
              cdsSint.FieldByName('QTDITE').AsFloat := cdsSint.FieldByName('QTDITE').AsFloat + cdsItensAju.FieldByName('DET_QTDITE').AsFloat
            Else
              cdsSint.FieldByName('QTDITE').AsFloat := cdsSint.FieldByName('QTDITE').AsFloat - cdsItensAju.FieldByName('DET_QTDITE').AsFloat;

            cdsSint.Post;
          End;
        End
        Else
        Begin
          stlNor.Add(cdsItensAju.FieldByName('AUTINC').AsString);
        End;


        cdsItensAju.Next;
      End;
    End;

    For intIndex := 0 To PRed(stlNor.Count) Do
    Begin
      cdsItensAju.Filter := 'AUTINC = ' + QuotedStr(stlNor[intIndex]);
      cdsItensAju.Filtered := True;

      If (Not cdsItensAju.IsEmpty) And (fGetEntradaSaida() = strEntSai) Then
        pAddItemTemp(cdsItensAju.FieldByName('DET_QTDITE').AsFloat);
    End;

    For intIndex := 0 To PRed(stlSint.Count) Do
    Begin
      cdsItensAju.Filter := 'AUTINC = ' + QuotedStr(stlSint[intIndex]);
      cdsItensAju.Filtered := True;

      If cdsSint.Locate('CODITE;DESCRI;UNITAR',
                         VarArrayOf([cdsItensAju.FieldByName('DET_CODITE').AsString,
                                     cdsItensAju.FieldByName('DET_DESCRI').AsString,
                                     FloatToStr(fGetUnitario)]), []) Then
      Begin
        If (cdsSint.FieldByName('QTDITE').AsFloat = 0) Then
          Continue;

        If fGetEntradaSaidaSint() <> strEntSai Then
          Continue;

        If fGetEntradaSaidaSint() <> fGetEntradaSaida() Then
          Continue;

        pAddItemSintTemp(Abs(cdsSint.FieldByName('QTDITE').AsFloat));

        cdsSint.Edit;
        cdsSint.FieldByName('QTDITE').AsFloat := 0;
        cdsSint.Post;
      End;
    End;
  Finally
    FreeAndNil(cdsSint);
    FreeAndNil(stlSint);
    FreeAndNil(stlNor);

    cdsItensAju.Filter := '';
    cdsItensAju.Filtered := False;
  End;
end;

procedure TfrmFatConfirmacaoAjustes.pRegistrarProgresso(strTexto: String;
  lblInformacao: TLabel; pgbProgresso: Tgauge; intInicio, intAtual, intFinal: Integer);
begin
  pgbProgresso.MaxValue := intFinal;
  pgbProgresso.MinValue := intInicio;
  pgbProgresso.Progress := intAtual;
  lblInformacao.Caption := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  pProcessMessages;
end;

function TfrmFatConfirmacaoAjustes.fFaturarAjustes: Boolean;
  Var
    qryGen: TUniQuery;
    intIndice: Integer;
    strDoc,
    strSeq,
    strSQL: string;

  function fUpdateMov(strPrefixo: String): String;
  begin
    Result := ' UPDATE MOV' + strPrefixo +
              '   SET '+ strPrefixo + '_TIPFAT = :TIPFAT, '+
              '       '+ strPrefixo + '_JAFATU = :JAFATU, '+
              '       '+ strPrefixo + '_NUMFAT = :NUMFAT, '+
              '       '+ strPrefixo + '_EMPFAT = :EMPFAT, '+
              '       '+ strPrefixo + '_CLIFAT = :CLIFAT, '+
              '       '+ strPrefixo + '_VENFAT = :VENFAT, '+
              '       '+ strPrefixo + '_DTAFAT = :DTAFAT '+
              ' WHERE '+
              '   ' + strPrefixo + '_ESPDOC' + ' = "AJ" AND ';

    If strPrefixo = 'GER' Then
    Begin
      If (Not fatVenda.blnGerouNotaConfAjuEst) Then
        Result := Result + strPrefixo + '_JAFATU' + ' = 0 AND  ';

      Result := Result + ' AUTOINCREM = :SEQGER ';
    End
    Else
    Begin
      Result := Result + strPrefixo + '_SEQGER = :SEQGER AND ';
      Result := Result + strPrefixo + '_JAFATU' + ' = 0 AND  ';

      If strToIntDef(fatVenda.strClaFis, 0) < 5000 Then
        Result := Result + strPrefixo + '_CLAFIS < 5000 '
      Else
        Result := Result + strPrefixo + '_CLAFIS > 5000 ';
    End;
  end;

  procedure pTrocaSQL(strSQL: String);
  begin
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
  end;

  procedure pInsereParamsUpdateMov();
  begin
    qryGen.ParamByName('SEQGER').AsString   := strSeq;
    qryGen.ParamByName('JAFATU').AsString   := '1';
    qryGen.ParamByName('TIPFAT').AsString   := fatVenda.strEspDoc;
    qryGen.ParamByName('NUMFAT').AsString   := fatVenda.strNumDoc;
    qryGen.ParamByName('EMPFAT').AsString   := fatVenda.strEmpDoc;
    qryGen.ParamByName('CLIFAT').AsString   := fatVenda.strCodCli;
    qryGen.ParamByName('VENFAT').AsString   := fatVenda.strCodVen;
    qryGen.ParamByName('DTAFAT').AsDateTime := VS_Date;
  end;

  procedure pInsereParamsDocAJ();
  begin
    qryGen.ParamByName('DOCCAJ').AsString := strDoc;
    qryGen.ParamByName('SEQGER').AsString := strSeq;
  end;

begin
  Result := True;

  qryGen := fCriaQuery;

  Try
    For intIndice := 0 To stlListaFaturados.Count - 1 Do
    Begin
      strDoc:=Concat(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strEmpDoc);

      If (Not fatVenda.blnGerouNotaConfAjuEst) Then
      Begin
        If (cdsConsulta.Locate('AUTOINCREM', stlListaFaturados[intIndice], [])) Then
        Begin
          strDoc := Concat(cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                           cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                           cdsConsulta.FieldByName('DET_CODEMP').AsString);
        End;
      End;

      strSeq:=stlListaFaturados[intIndice];

      strSQL:=' UPDATE MOVDET, '+
              '        MOVTRI  '+
              '   SET DET_DOCCAJ = :DOCCAJ '+
              ' WHERE '+
              '   MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER '+
              '   AND MOVDET.DET_ESPDOC = "AJ" '+
              '   AND MOVDET.DET_SEQGER = :SEQGER '+
              '   AND (IFNULL(MOVTRI.DET_DOCCAJ, "") = "")';

      If (fatVenda.strEntSaiConfAjuEst = 'E') Then
        strSQL:=strSQL+' AND MOVDET.DET_CLAFIS < 5000 '
      Else If (fatVenda.strEntSaiConfAjuEst = 'S') Then
        strSQL:=strSQL+' AND MOVDET.DET_CLAFIS > 5000 ';

      pTrocaSQL(strSQL);
      pInsereParamsDocAJ();
      qryGen.ExecSQL;

      pTrocaSQL(AnsiReplaceStr(strSQL, 'DET_ESPDOC', 'DET_TIPFAT'));
      pInsereParamsDocAJ();
      qryGen.ExecSQL;

      pTrocaSQL(fUpdateMov('DET'));
      pInsereParamsUpdateMov();
      qryGen.ExecSQL;

      pTrocaSQL(fUpdateMov('GER'));
      pInsereParamsUpdateMov();
      qryGen.ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

Function TfrmFatConfirmacaoAjustes.fTravaConfirmacao: Boolean;
Begin
  // DESTRAVA ANTERIOR SE HOUVER
  objLock.pDestravarTodos;

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    Result := objLock.fLock_Unlock('CONF_AJUSTE_' + edtCodCli.Text, True, False);
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Este cliente já está sendo baixado por outra estação: ' +
                 fGetHostLock('CONF_AJUSTE_' + edtCodCli.Text), ['&Ok']);
    End;
  End

  Else Result := True;
End;

end.
