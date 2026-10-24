{*****************************************************************************}
{* "AGORA, POIS, Ó ISRAEL, QUE É QUE O SENHOR TEU DEUS REQUER DE TI,         *}
{*  SENÃO QUE TEMAS O SENHOR TEU DEUS, QUE ANDES EM TODOS OS SEUS CAMINHOS,  *}
{*  E O AMES, E SIRVAS AO SENHOR TEU DEUS DE TODO O TEU CORAÇÃO E DE TODA A  *}
{*  TUA ALMA, QUE GUARDES OS MANDAMENTOS DO SENHOR, E OS SEUS ESTATUTOS,     *}
{*  QUE EU HOJE TE ORDENO PARA O TEU BEM?"                                   *}
{*                                                   (DEUTERENÔMIO 10:12-13) *}
{**************************************************************************JC*}

unit untBalancoEstoqueZera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, StdCtrls,
  EditFocus, AppEvnts, Menus, Buttons, ExtCtrls, untFuncoesSimples, DB,
  Uni, StrUtils, BitBtnLockedIncrem, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxProgressBar, Vcl.ComCtrls, untConstantes, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TfrmBalancoEstoqueZera = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    pnlProduto: TPanel;
    Label1: TLabel;
    edtLocIni: TEditFocus;
    edtLocFin: TEditFocus;
    Label6: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label8: TLabel;
    shpMultSel: TShape;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label3: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label4: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    cxgDados: TcxGridCitel;
    cxgDadosDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgDadosDBTableViewCitelITE_CODGRU: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_CODITE: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_DESITE: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_NUMLOT: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_SALCON: TcxGridDBColumn;
    cxgDadosDBTableViewCitelUNI_SIGUNI: TcxGridDBColumn;
    cxgDadosDBTableViewCitelITE_LOCFIS: TcxGridDBColumn;
    cxgDadosLevel1: TcxGridLevel;
    btnZerarContagem: TBitBtnLocked;
    Label5: TLabel;
    edtCodUni: TEditFocus;
    edtDesUni: TEditFocus;
    edtDescricao: TEditFocus;
    Label7: TLabel;
    lblDepartamento: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lblGrupo: TLabel;
    edtCodGrupo: TEditFocus;
    EdtDesGru: TEditFocus;
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnZerarContagemClick(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtDesUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtDesUniExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGrupoExit(Sender: TObject);
  private

    arrProduto   : TConsultasArray;
    arrLinhaGrupo: TConsultasArray;
    arrFornecedor: TConsultasArray;
    arrUnidade: TConsultasArray;
    arrMarca : TConsultasArray;
    arrDepto: TConsultasArray;
    arrGrupo: TConsultasArray;
    qryGen   : TUniQuery;
    dtsItens : TDataSource;
    qryConsulta: TUniQuery;
    qryUpdade: TUniQuery;
    function  fZerarItens(pgbProgresso: TcxProgressBar): Boolean;
    function  fCarregar(pgbProgresso: TcxProgressBar): Boolean;
    function fGetSQLFiltrosDigCon(blnCadLot: Boolean): string;

    procedure pLimpaTela;
    procedure pHabilitaTela;
    procedure pSetaParametros(qryConsulta: TUniQuery);

    Function fZeraLote: Boolean;
    Function fSQLFiltros(blnCadLot : Boolean = False; blnNotBalger: Boolean = False): String;

    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmBalancoEstoqueZera: TfrmBalancoEstoqueZera;

implementation

uses untFuncoesConsulta, untBalancoEstoqueZerarSaldo, untCadLote, untPai,
  untConsultas, untConDet, untGravando, untHistoricoBalanco,
  untControleContagemBalancoEstoque;

{$R *.dfm}

procedure TfrmBalancoEstoqueZera.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    fvalidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueZera.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

Function TfrmBalancoEstoqueZera.fZeraLote: Boolean;
  Var
    objCadLot: TCadLot;
Begin
  Try
    objCadLot := TCadLot.Create(Self);
    With qryGen Do
    Begin
      DisableControls;

      Filter   := 'ITE_NUMLOT <> ' + QuotedStr('          ');
      Filtered := True;

      frmGravando.lblGravando.Caption := 'Aguarde, atualizando contagem dos lotes...';
      frmGravando.pgbStatus.Properties.Max := qryGen.RecordCount;
      frmGravando.pgbStatus.Position := 0;
      Application.ProcessMessages;

      First;

      Result := objCadLot.fZeraContagemLote(True,  fSQLFiltros(True) + fGetSQLFiltrosDigCon(True), pSetaParametros);

      Filtered := False;

      EnableControls;
    End;
    FreeAndNil(objCadLot);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro('', E.Message + '[fZeraLote] ');
    End;
  End;

End;

function TfrmBalancoEstoqueZera.fZerarItens(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSql: String;
    blnControleContagem: Boolean;

begin
  blnControleContagem := TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco;
  Result := True;
  qryConsulta := Nil;
  strSql := strSql + ' UPDATE                                                  ';
  strSql := strSql + ' 	 ITEGER G                                              ';
  strSql := strSql + ' 	 INNER JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE    ';
  If blnControleContagem Then
  Begin
    strSql := strSql + ' 	 LEFT JOIN BALDET ON BALDET.BLD_CODITE = G.ITE_CODITE  ';
    strSql := strSql + ' 	 LEFT JOIN BALGER ON BALGER.AUTOINCREM = BALDET.BLD_SEQGER AND BLG_CODEMP = G.ITE_CODEMP ';
  End;


  strSql := strSql + ' SET                                                     ';
  strSql := strSql + ' 	 G.ITE_ORDCON = 0,     ';
  strSql := strSql + ' 	 G.ITE_SALCON = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_GMLCON = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_DIFSAL = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_DIF_ML = 0,                                     ';
  strSql := strSql + ' 	 G.ITE_DIGCON = "N"                                    ';
  strSql := strSql + ' WHERE                                                   ';
  strSql := strSql + ' 	 G.ITE_CODITE = I.ITE_CODITE AND                       ';
  strSql := strSql + '   G.ITE_CODEMP = :CODEMP                                ';

  strSql := strSql +   fSQLFiltros();

  frmGravando.lblGravando.Caption := 'Aguarde, gravando log de contagem...';


  Application.ProcessMessages;

  If fLock_Unlock(STR_TRAVA_CONDET, True, False) Then
  Begin
    If Not TConDet.fGravaConDetItens(Self, fSQLFiltros, VS_strCodEmp, 'N', pSetaParametros, '', blnControleContagem) Then
    Begin
      fLock_Unlock(STR_TRAVA_CONDET, False, False);
      Result := False;
      Exit;
    End;
  End Else
  Begin
    pMensagemOk('Uma tarefa de balanço está sendo feita em outra estação: ' + fGetHostLock(STR_TRAVA_CONDET) + '. Tente novamente!');
    Exit;
  End;

  qryUpdade   := fCriaQuery;
  qryConsulta := qryUpdade;

  With qryConsulta Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSql);

    pSetaParametros(qryConsulta);

    Try
      fStartTransaction;

      ExecSQL;
      If blnControleContagem Then
        TControleContagemBalancoEstoque.pLimpaBalgerSaldoProduto(fSQLFiltros, pSetaParametros);

      THistoricoBalanco.pLimpaHistoricoSaldoProduto(fSQLFiltros, '', pSetaParametros);

      if fCfgSis('CONDET', varBoolean) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' DELETE L                                             ');
        SQL.Add(' FROM LOCCON L                                        ');
        SQL.Add('   INNER JOIN CADITE I ON I.ITE_CODITE = L.ITE_CODITE ');
        SQL.Add('   INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
        SQL.Add('                      AND G.ITE_CODEMP = :CODEMP      ');
        SQL.Add(' WHERE TRUE ');
        SQL.Add( fSQLFiltros  );
        pSetaParametros(qryConsulta);
        ExecSQL;
      End;

      If fZeraLote Then
      Begin
        fCommit;
        fMensagem('', 'Contagem de estoque zerada para os itens !',['&O K']);
      End
      Else
      Begin
        fRollBack;
        fMensagem('', 'Não foi possível zerar os dados!',['&O K']);
      End;

      Close;
      FreeAndNil(qryUpdade);
      pLimpaTela;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro('', E.Message + '[pBuscaZeraItens] ');
      End;
    End;
  End;
  fLock_Unlock(STR_TRAVA_CONDET, False, False);
End;

Function TfrmBalancoEstoqueZera.fSQLFiltros(blnCadLot : Boolean = False; blnNotBalger: Boolean = False): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(edtLocIni.Text) Then
  Begin
    If Not blnCadLot then
    Begin
      If (TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco) Then
      Begin
        If (Not fEmptyStr(edtLocFin.Text)) Then
        Begin
          strSQL := strSQL + ' AND '+IIF(blnNotBalger, ' NOT ', '') +' ((LEFT(BALGER.BLG_LOCFIS, LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN ))';
//           strSQL := strSQL + ' OR (LEFT(G.ITE_LOCFIS, LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN ))';
        End
        Else
        Begin
          strSQL := strSQL + '  AND '+IIF(blnNotBalger, ' NOT ', '') +' ((BALGER.BLG_LOCFIS LIKE :LOCINI)) ';
//          strSQL := strSQL + '  OR   (AND G.ITE_LOCFIS LIKE :LOCINI)) ';
        End
      End
      Else
      Begin
        If (Not fEmptyStr(edtLocFin.Text)) Then
          strSQL := strSQL + ' AND LEFT(G.ITE_LOCFIS, LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN '
        Else
          strSQL := strSQL + '  AND G.ITE_LOCFIS LIKE :LOCINI ';
      End;
    End
    Else
    Begin
      If (Not fEmptyStr(edtLocFin.Text)) Then
        strSQL := strSQL + ' AND LEFT(LOT_LOCFIS, LENGTH(:MAIOR)) BETWEEN :LOCINI AND :LOCFIN '
      Else
        strSQL := strSQL + '  AND LOT_LOCFIS LIKE :LOCINI ';
    End;
  End;

  If Not fEmptyStr(edtCodUni.Text) Then
  Begin
    {******************************************}
    {* BUSCA AS UNIDADES SELECIONADAS         *}
    {***************************************MV*}
    If Length(arrUnidade) > 1 Then
      strSQL := strSQL + '  AND LOCATE(I.ITE_CODUNI,:CODUNI) > 0 '
    Else
      strSQL := strSQL + '  AND I.ITE_CODUNI = :CODUNI ';
  End;

  If Not fEmptyStr(edtCodMar.Text) Then
  Begin
    If Length(arrMarca) > 1 Then
      strSQL     := strSQL     + '  AND LOCATE(I.ITE_CODMAR,:CODMAR) > 0 '
    Else
      strSQL := strSQL + ' AND I.ITE_CODMAR = :CODMAR ';
  End;

  If Not fEmptyStr(edtCodDep.Text) Then
  Begin
    If Length(arrDepto) > 1 Then
      strSQL     := strSQL     + '  AND LOCATE(I.ITE_CODDEP,:CODDEP) > 0 '
    Else
      strSQL := strSQL + ' AND I.ITE_CODDEP = :CODDEP ';
  End;

  strSQL := strSQL + fStrLocate(edtCodFor, arrFornecedor, 'I.ITE_CODFOR', 'CODFOR');

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin

    {******************************************}
    {BUSCA OS GRUPOS ESCOLHIDOS                }
    {***************************************JC*}
    If Length(arrLinhaGrupo) > 1 Then
      strSQL     := strSQL     + '  AND LOCATE(I.ITE_CODGRU,:CODGRU) > 0 '
    Else
    Begin
     If RightStr(mskLinhaGrupo.Text,3) = '000' Then
       strSQL     := strSQL     + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
     Else
       strSQL     := strSQL     + '  AND I.ITE_CODGRU = :CODGRU ';
    End;

  End;

  If Not fEmptyStr(edtDesIte.Text) Then
    strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin
    If Length(arrProduto) > 1 Then
      strSQL := strSQL + '  AND LOCATE(G.ITE_CODITE,:CODITE) > 0 '
    Else
    Begin
      strSQL := strSQL + '  AND G.ITE_CODITE = :CODITE ';
    End;
  End;

  If Not fEmptyStr(edtCodGrupo.Text) Then
  Begin
    If Length(arrGrupo) > 1 Then
      strSQL := strSQL + '  AND LOCATE(I.ITE_PRDGRU,:PRDGRU) > 0 '
    Else
    Begin
      strSQL := strSQL + '  AND I.ITE_PRDGRU = :PRDGRU ';
    End;
  End;

  If blnCadLot Then
    strSql := strSql + ' AND LOT_NUMLOT <> "A DEFINIR" ';
  Result := strSQL;
End;

procedure TfrmBalancoEstoqueZera.FormCreate(Sender: TObject);
begin
  inherited;

  dtsItens := TDataSource.Create(Self);
  cxgDadosDBTableViewCitel.DataController.DataSource := dtsItens;
  qryGen := fCriaQuery(Self);

  If TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
  Begin
    btnZerarContagem.Caption := '[ F9 ] &Iniciar Contagem';
    pnlCabecalho.Height := 45;
    Label2.Visible := False;
    edtCodIte.Visible := False;
    edtDesIte.Visible := False;
    Label8.Visible := False;
    mskLinhaGrupo.Visible := False;
    edtDesGrupo.Visible := False;
    Label4.Visible := False;
    edtCodFor.Visible := False;
    edtNomFor.Visible := False;
    Label3.Visible := False;
    edtCodMar.Visible := False;
    edtDesMar.Visible := False;
    Label1.Top := 7;
    Label6.Top := 7;
    edtLocIni.Top := 21;
    edtLocFin.Top := 21;
    edtLocFin.Tag := 99;
  End;

end;

procedure TfrmBalancoEstoqueZera.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If btnConfirma.Enabled Then
  begin
    try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fZerarItens;
      frmGravando.lblGravando.Caption := 'Aguarde, limpando a contagem...';
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando);
    End;
  end;
end;

procedure TfrmBalancoEstoqueZera.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10 : btnConfirma.Click;
    VK_F9  : btnZerarContagem.Click;
  End;

end;

procedure TfrmBalancoEstoqueZera.pLimpaTela;
begin
  dtsItens.DataSet     := Nil;
  cxgDados.Enabled     := False;
  btnConfirma.Enabled  := False;
  edtLocIni.Enabled    := True;
  edtLocFin.Enabled    := True;
  edtDescricao.Enabled := True;

  edtCodIte.Clear;
  edtDesIte.Clear;
  edtDescricao.Clear;
  mskLinhaGrupo.Clear;
  edtDesGrupo.Clear;
  edtLocIni.Clear;
  edtLocFin.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;

  Self.SelectFirst;
end;

procedure TfrmBalancoEstoqueZera.pHabilitaTela;
begin
  cxgDados.Enabled    := True;
  btnConfirma.Enabled := True;
  edtLocIni.Enabled   := False;
  edtLocFin.Enabled   := False;
end;

procedure TfrmBalancoEstoqueZera.FormShow(Sender: TObject);
  Var
    strCodAmz: String;
    intNumAmz: Integer;

begin
  inherited;
  If (fCfgSis('CTLEST') = '2') And TCadLot.fTemContagemArmazem(strCodAmz, intNumAmz) Then
    If intNumAmz > 1 Then
      Caption := Caption + ' - Armazéns ' + strCodAmz
    Else
      Caption := Caption + ' - Armazém ' + strCodAmz + '-' + fRetNomeArmazem(strCodAmz);

  pSetFocus(edtCodIte);

  pSetaCodIte( edtCodIte );

end;

procedure TfrmBalancoEstoqueZera.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  pLimpaTela;
end;

procedure TfrmBalancoEstoqueZera.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrProduto,Nil,fRetNomProduto,'do produto',fTamCodIte);
end;

procedure TfrmBalancoEstoqueZera.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtCodIte, True);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueZera.btnZerarContagemClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmBalancoEstoqueZerarSaldo, frmBalancoEstoqueZerarSaldo);
end;

procedure TfrmBalancoEstoqueZera.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomeMarca, nil, 'da Marca');
end;

procedure TfrmBalancoEstoqueZera.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueZera.edtCodUniExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodUni,edtDesUni,arrUnidade,fRetNomUnidade,Nil,'da unidade');
end;

procedure TfrmBalancoEstoqueZera.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, edtDesUni, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtCodUni,True);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueZera.edtDesUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni,edtDesUni,arrUnidade,fRetNomUnidade,Nil,'da unidade',3);
end;

procedure TfrmBalancoEstoqueZera.edtDesUniKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, edtDesUni, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtCodUni,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueZera.pSetaParametros(qryConsulta: TUniQuery);
  Var
    strIte: String;
    strLin: String;
    strFor: String;
    strUni: String;
    strGrupo: String;
Begin
  With qryConsulta Do
  Begin
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Not fEmptyStr(edtLocIni.Text) Then
    Begin

      If (Not fEmptyStr(edtLocFin.Text)) Then
      Begin
        ParamByName('LOCINI').AsString := edtLocIni.Text;
        ParamByName('LOCFIN').AsString := edtLocFin.Text;

        If Length(edtLocIni.Text) > Length(edtLocFin.Text) Then
          ParamByName('MAIOR').AsString := edtLocIni.Text
        Else
          ParamByName('MAIOR').AsString := edtLocFin.Text;

      End
      Else
        ParamByName('LOCINI').AsString := edtLocIni.Text + '%';

    End;

    If Not fEmptyStr(edtCodMar.Text) Then
    Begin
      pSetaParam(edtCodMar.Text,arrMarca,strLin,'CODMAR',qryConsulta);
    End;

    If Not fEmptyStr(edtCodDep.Text) Then
    Begin
      pSetaParam(edtCodDep.Text,arrDepto,strLin,'CODDEP',qryConsulta);
    End;

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLin,'CODGRU',qryConsulta);
    End;

    If Not fEmptyStr(edtCodIte.Text) Then
    Begin
      pSetaParam(edtCodIte.Text,arrProduto,strIte,'CODITE',qryConsulta);
    End;

    If Not fEmptyStr(edtCodUni.Text) Then
    Begin
      pSetaParam(edtCodUni.Text, arrUnidade, strUni, 'CODUNI', qryConsulta);
    End;

    If Not fEmptyStr(edtCodGrupo.Text) Then
    Begin
      pSetaParam(edtCodGrupo.Text, arrGrupo, strGrupo, 'PRDGRU', qryConsulta);
    End;

    pSetaParam(edtCodFor.Text, arrFornecedor, strFor, 'CODFOR', qryConsulta);

    If Not fEmptyStr(edtDesIte.Text) Then
      ParamByName('DESITE').AsString := '%' + edtDescricao.Text + '%';
  End;
End;

{********************************************************************}

function TfrmBalancoEstoqueZera.fCarregar(pgbProgresso: TcxProgressBar): Boolean;
var strSql: string;
begin
  Result := True;
  qryConsulta := Nil;
  strSql := '';
  strSql := strSql + ' SELECT                                                  ';
  strSql := strSql + ' 	 SQL_NO_CACHE                                          ';
  strSql := strSql + ' 	 "          " AS ITE_NUMLOT,                           ';
  strSql := strSql + ' 	 G.ITE_CODEMP AS ITE_CODEMP,                           ';
  strSql := strSql + ' 	 I.ITE_CODGRU AS ITE_CODGRU,                           ';
  strSql := strSql + ' 	 G.ITE_CODITE AS ITE_CODITE,                           ';
  strSql := strSql + ' 	 I.ITE_DESITE AS ITE_DESITE,                           ';
  strSql := strSql + ' 	 U.UNI_SIGUNI AS UNI_SIGUNI,                           ';
  strSql := strSql + ' 	 G.ITE_SALCON AS ITE_SALCON,                           ';
  If TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
    strSql := strSql + '  IFNULL(BALGER.BLG_LOCFIS, G.ITE_LOCFIS) AS ITE_LOCFIS '
  Else
    strSql := strSql + ' 	 G.ITE_LOCFIS AS ITE_LOCFIS                          ';
  strSql := strSql + ' FROM                                                    ';
  strSql := strSql + ' 	 ITEGER G                                              ';
  strSql := strSql + ' 	 JOIN CADITE      I ON  G.ITE_CODITE = I.ITE_CODITE    ';
  strSql := strSql + ' 	 LEFT JOIN CADUNI U ON (I.ITE_CODUNI = U.UNI_CODUNI)   ';
  If TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
  Begin
    strSql := strSql + '   LEFT JOIN BALDET ON BALDET.BLD_CODITE = G.ITE_CODITE ';
    strSql := strSql + ' 	 LEFT JOIN BALGER ON BALGER.AUTOINCREM = BALDET.BLD_SEQGER AND BLG_CODEMP = G.ITE_CODEMP AND BALGER.BLG_STATUS = "F"';
  End;

  strSql := strSql + ' WHERE                                                   ';
  strSql := strSql + ' 	 G.ITE_DIGCON = "S" AND                                ';
  strSql := strSql + '   G.ITE_CODEMP = :CODEMP                                ';

  strSql := strSql +   fSQLFiltros;

  If TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
    strSql := strSql + ' GROUP BY BALGER.BLG_LOCFIS , G.ITE_CODITE ';


  If Not TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
  Begin
    strSql := strSql + ' UNION ALL                                               ';

    strSql := strSql + ' SELECT                                                  ';
    strSql := strSql + ' 	 SQL_NO_CACHE                                          ';
    strSql := strSql + ' 	 LOT_NUMLOT   AS ITE_NUMLOT,                           ';
    strSql := strSql + ' 	 LOT_CODEMP   AS ITE_CODEMP,                           ';
    strSql := strSql + ' 	 I.ITE_CODGRU AS ITE_CODGRU,                           ';
    strSql := strSql + ' 	   LOT_CODITE AS ITE_CODITE,                           ';
    strSql := strSql + ' 	 I.ITE_DESITE AS ITE_DESITE,                           ';
    strSql := strSql + ' 	 U.UNI_SIGUNI AS UNI_SIGUNI,                           ';
    strSql := strSql + ' 	   LOT_SALCON AS ITE_SALCON,                           ';
    strSql := strSql + ' 	   LOT_LOCFIS AS ITE_LOCFIS                            ';
    strSql := strSql + ' FROM                                                    ';
    strSql := strSql + ' 	 CADLOT                                                ';

    strSql := strSql + ' INNER JOIN ITEGER G ON LOT_CODITE = G.ITE_CODITE AND    ';
    strSql := strSql + '                	      G.ITE_CODEMP = LOT_CODEMP        ';

    strSql := strSql + ' INNER JOIN CADITE I ON LOT_CODITE = I.ITE_CODITE        ';

    strSql := strSql + ' LEFT  JOIN CADUNI U ON (I.ITE_CODUNI = U.UNI_CODUNI)    ';

    strSql := strSql + ' WHERE                                                   ';
    strSql := strSql + ' 	 LOT_DIGCON = "S" AND                                  ';
    strSql := strSql + '   G.ITE_CODEMP = :CODEMP                                ';

    strSql := strSql +   fSQLFiltros(True);
  End;

  strSql := strSql + ' 	ORDER BY                                               ';
  strSql := strSql + ' 	  ITE_CODGRU,                                          ';
  strSql := strSql + ' 	  ITE_CODITE,                                          ';
  strSql := strSql + ' 	  ITE_NUMLOT                                           ';

  qryConsulta := qryGen;

  With qryConsulta Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSql);

    pSetaParametros(qryConsulta);

    Open;

    If Not IsEmpty Then
    Begin
      dtsItens.DataSet := qryConsulta;
      cxgDadosDBTableViewCitel.ApplyBestFit();
      TFloatField(qryConsulta.FieldByName('ITE_SALCON')).DisplayFormat := '#,##0.000';
      pHabilitaTela;
      pSetFocus(cxgDados);
    End
    Else
    Begin
      pLimpaTela;
      fMensagem('', 'Nenhum registro encontrado !',['&O K']);
    End;
  End;
end;

function TfrmBalancoEstoqueZera.fGetSQLFiltrosDigCon(blnCadLot: Boolean): string;
  var
    strSQL: String;
begin
  If Not blnCadLot then
    strSql := strSql + ' 	AND G.ITE_DIGCON = "S" '
  Else
    strSql := strSql + ' 	AND LOT_DIGCON = "S"      ';
  Result := strSql;
end;

function TfrmBalancoEstoqueZera.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
Begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskLinhaGrupo) Then
    Begin
      pDesmarcaLista(mskLinhaGrupo, arrLinhaGrupo, '', 6);
    End

    Else If (Sender = edtCodIte) Then
    Begin
      pDesmarcaLista(edtCodIte,arrProduto);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor,arrFornecedor);
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar,arrMarca);
    End

    Else If (Sender = edtCodDep) Then
    Begin
      pDesmarcaLista(edtCodDep, arrDepto, '', 3);
    End

    Else If (Sender = edtCodGrupo) Then
    Begin

      pDesmarcaLista(edtCodGrupo, arrGrupo);

      If Result And blnValidaIndividual Then
      Begin
        try
          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.fExecutarAcao := fCarregar;
          frmGravando.lblGravando.Caption := 'Aguarde, carregando os itens...';
          frmGravando.PgbStatus.Visible := False;
          frmGravando.ShowModal;
        Finally
          FreeAndNil(frmGravando);
        End;
        blnMudarFoco := False;
      End;
    End

    Else If Result And (Sender = edtLocFin) And  (TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco) Then
    Begin
      try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.fExecutarAcao := fCarregar;
        frmGravando.PgbStatus.Visible := False;
        frmGravando.ShowModal;
      Finally
        FreeAndNil(frmGravando);
      End;
      blnMudarFoco := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

procedure TfrmBalancoEstoqueZera.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, nil, Key, arrFornecedor, False) Then
  Begin
    fvalidaCampos(edtCodFor,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueZera.edtCodGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGrupo,edtDesGru,arrGrupo,fRetNomGrupoProdutos,Nil,'do grupo');
end;

procedure TfrmBalancoEstoqueZera.edtCodGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupo: TConsultasArray;
begin
  inherited;
  If fPesqGrupoProduto(Self, edtCodGrupo, edtDesGru, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(edtCodGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueZera.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDep,edtDesDep,arrDepto,fRetNomDep,Nil,'do departamento');
end;

procedure TfrmBalancoEstoqueZera.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  {**********************************}
  {* NOVA CONSULTA DE DEPARTAMENTOS *}
  {*******************************TS*}
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepto, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueZera.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornecedor,fRetNomFornecedor,Nil,'do fornecedor',8);

end;

end.

