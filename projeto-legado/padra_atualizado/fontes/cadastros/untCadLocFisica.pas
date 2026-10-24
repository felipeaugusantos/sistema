unit untCadLocFisica;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB, Uni, untCadLote, EditFocus,
  BitBtnLockedIncrem, QColorLabel, DBMemoFocus, frxClass,
  untCfgLocFis, frxExportCSVTestabilidade, MaskUtils, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox,
  System.StrUtils, untTypesSistema, untTPickingCheckOut;

type
  TfrmCadLocFisica = class(TfrmPaiCad)
    dtsCadLoc: TDataSource;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    pnlOpcoes: TPanel;
    dbckbAtivo: TDBCheckBox;
    dbckbCritico: TDBCheckBox;
    dbCkbTransitoria: TDBCheckBox;
    dbCkbBalcao: TDBCheckBox;
    dbeCodLoc: TDBEditFocus;
    grpInformacoes: TcxGroupBox;
    dbeDescri: TDBEditFocus;
    Label2: TLabel;
    grpCaracteristicas: TcxGroupBox;
    grpEndereco: TcxGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    dbeRua: TDBEditFocus;
    dbePredio: TDBEditFocus;
    dbeAndar: TDBEditFocus;
    dbeApartamento: TDBEditFocus;
    grpProduto: TcxGroupBox;
    pnlArmazem: TPanel;
    lblArmazem: TLabel;
    dbeCodAmz: TDBEditFocus;
    edtDesAmz: TEditFocus;
    pnlLocSep: TPanel;
    Label13: TLabel;
    dbeCodLse: TDBEditFocus;
    edtDesLse: TEditFocus;
    dbeCodEmp: TDBEditFocus;
    pnlObservacao: TPanel;
    dbeObserv: TDBMemoFocus;
    Label59: TLabel;
    pnlCapMaxRepo: TPanel;
    Label8: TLabel;
    dbeCapaci: TDBEditFocus;
    Label7: TLabel;
    dbePonRep: TDBEditFocus;
    pnlPesoLocDim: TPanel;
    grpDimensoes: TGroupBox;
    Label72: TLabel;
    lblPesLiq: TLabel;
    Label3: TLabel;
    dbeLargur: TDBEditFocus;
    dbeAltura: TDBEditFocus;
    dbeProfun: TDBEditFocus;
    Label16: TLabel;
    dbePesMax: TDBEditFocus;
    Label14: TLabel;
    dbeItePic: TDBEditFocus;
    Label15: TLabel;
    edtDesIte: TEditFocus;
    pnlPrdDif: TPanel;
    dbckbPdeRpd: TDBCheckBox;
    Label4: TLabel;
    dbeTaxaOcpMax: TDBEditFocus;
    grpPicking: TGroupBox;
    rbPicking: TRadioButton;
    rbBuffer: TRadioButton;
    rbExcesso: TRadioButton;
    rbPickingCheckOut: TRadioButton;
    rbPickingLabor: TRadioButton;
    btnImportarPlanilha: TBitBtnLocked;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodAmzKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeObservKeyPress(Sender: TObject; var Key: Char);
    procedure dbeItePicKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodLseKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure grpPickingExit(Sender: TObject);
    procedure dbckbPdeRpdClick(Sender: TObject);
    procedure btnImportarPlanilhaClick(Sender: TObject);
  private
    { Private declarations }
    objCfgLocFis : TCamposCfgLocFis;
    objCadLot: TCadLot;
    blnAtuAmz: Boolean;
    blnLotPic: Boolean;
    strCodAmzAnt: String;
    strCodLocAnt: String;
    strLocPickinBkp: String;
    blnUsaMascaraCodigo : boolean;
    blnAlterouTipoLocalizacao: boolean;
    blnUsaRotinaWMS: boolean;
    FTransitorio: Boolean;
    FCodLocal: String;
    FDescLocal: String;
    strLocCrit: String;

    procedure pAfterScroll(DataSet: TDataSet);
    procedure pSetaCamposWms;
    function fRetCodigoWMS: String;
    function fJaTemLoteNaPicking: Boolean;
    function fVerificaChavePrimaria: Boolean;
    procedure pAjustarTela;
    function fValidaLocIte: Boolean;
    function fAlterouLocCrit():Boolean;
    function fValidaPickingLaboratorioItemBase(out strMensagem: String): Boolean;
    function fGetTipoLocalizacao: String;
    procedure pSetTipoLocalizacao;
    function fLocFisLotGarantia(ALocFis: String): Boolean;
    function fValidaCodigoLocalizacaoFisicaEmBranco(strDescricaoLocalizacao: String): Boolean;
  public
    property blnTransitorio: Boolean Read FTransitorio  Write FTransitorio;
    property strCodLocal   : String Read FCodLocal  Write FCodLocal;
    property strDescLocal  : String Read FDescLocal Write FDescLocal;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pOnStateChange;override;
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples, untConsultas, untMemo,
  untMensagemExplicativa, untImportarPlanilhaLocFisica;

{$R *.dfm}

procedure TfrmCadLocFisica.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodLoc, dbeDescri, False);

  dbckbCritico.Enabled := Not fLocFisLotGarantia(dbeCodLoc.Text);

  strCodAmzAnt := dbeCodAmz.Field.AsString;
  strCodLocAnt := dbeCodLoc.Field.AsString;
  strLocPickinBkp := fGetTipoLocalizacao;

  strLocCrit := dbckbCritico.Field.AsString;

  pAfterScroll(qryTabela);

  dbckbPdeRpd.OnClick := dbckbPdeRpdClick;
end;

procedure TfrmCadLocFisica.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pAfterScroll(qryTabela);
end;

procedure TfrmCadLocFisica.btnExcluirClick(Sender: TObject);
  Var
    strItem, strLote: String;
    fltSalLot, fltSalLotML: Double;
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If objCadLot.fTemProdutoComLocFisica(dbeCodLoc.Text, strItem, fltSalLot, fltSalLotML) Then
    pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) + ' está cadastrado com essa Localização Física, não pode ser excluída!')

  Else If objCadLot.fTemLoteComLocFisica(dbeCodLoc.Text, strItem, strLote, fltSalLot, fltSalLotML) Then
    pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
    ' ( ' + objCadLot.strTitLab + strLote +
    ') está cadastrado com essa Localização Física, não pode ser excluída!')

  Else
  Begin
    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadLocFisica.btnExcluirClick]');
      End;
    End;

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;
  End;
end;

procedure TfrmCadLocFisica.btnGravarClick(Sender: TObject);
  Var
    strMensagemAux: String;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If grpPicking.Visible Then
  Begin
    qryTabela.FieldByName('LOC_PICKIN').AsString := fGetTipoLocalizacao;

    If fEmptyStr(qryTabela.FieldByName('LOC_PICKIN').AsString) Then
    Begin
      pMensagemOk('Informe o Tipo de Localização!');
      Exit;
    End;

    If (qryTabela.State = dsEdit) And rbPickingLabor.Visible And rbPickingLabor.Checked Then
    Begin
      If Not fValidaPickingLaboratorioItemBase(strMensagemAux) Then
      Begin
        TfrmMemo.pShowMessage('A localização física só pode ser do tipo "Picking Laboratório" se ela estiver vinculada apenas a produtos que são bases '+
          'de tintas imobiliárias. Antes de continuar, faça primeiro o ajuste no(s) cadastro(s) relacionado(s) abaixo (aba "Complementos" campo "Produto Base") '+
          'e depois faça novamente essa alteração.' + sLineBreak + sLineBreak + strMensagemAux.Trim, 9);
        Exit;
      End;
    End;

    qryTabela.FieldByName('LOC_PRILAB').AsString := IIF(rbPickingLabor.Visible And rbPickingLabor.Checked, 'S', 'N');
  End;

  If blnAtuAmz And
     (strCodAmzAnt <> dbeCodAmz.Field.AsString) And
     objCadLot.fTemMovimentacaoLocFisica(strCodAmzAnt, dbeCodLoc.Field.AsString) Then
  Begin
    pMensagemOk('Já exite movimentação para os Lotes desse Armazém, alteração não permitida!');
    Exit;
  End;

  if dbckbCritico.Checked and objCadLot.fLocalizacaoTemSeparacaoEmAberto(dbeCodLoc.Text) then
  begin
    pMensagemOk('Não é possível alterar essa localização para crítico pois existem pedidos separados e não expedidos com lotes dessa localização!');
    Exit;
  end;

  if ((blnAlterouTipoLocalizacao) And (Pos(qryTabela.FieldByName('LOC_PICKIN').AsString, 'N_S') > 0)) And (fJaTemLoteNaPicking) Then
  begin
    pMensagemOk('Não é possível alterar essa localização para buffer ou picking pois já existem itens com saldos definidos para esta localização!');
    Exit;
  end;

  Try

    If ( not fVerificaChavePrimaria ) Then
    Begin
      If fUsaRotinaWMS Then
        fMensagem('', 'Essa Localização já esta cadastrada, verifique os dados da Rua, Predio, Andar e Apartamento!', ['&OK'])
      Else
        fMensagem('', 'Essa Localização já esta cadastrada!', ['&OK']);

      Exit;
    End;

    If (fLocFisLotGarantia(qryTabela.FieldByName('LOC_CODLOC').AsString)) And (dbckbCritico.Checked) Then
    Begin
      pMensagemOk('Essa Localização Física está associada a um lote GARANTIA, portanto não permite marcar a localização como Crítica.');
      dbckbCritico.Enabled := True;
      Exit;
    End;

    If fUsaRotinaWMS and (blnUsaMascaraCodigo) And (qryTabela.State in [dsInsert]) Then
    Begin
      dbeCodLoc.Text := fRetCodigoWMS;
      dbeCodLoc.Field.AsString := dbeCodLoc.Text;
      If fEmptyStr(dbeCodLoc.Field.AsString) Then
      Begin
        pMensagemOk('Não foi possível determinar o código da localização física, refaça o processo de cadastro, caso essa mensagem volte a ocorrer entre em contato com a Citel.');
        Exit;
      End;
    end;

    inherited;

    If blnGravou Then
    Begin
      If fAlterouLocCrit() Then
        ReprocessarItensLocFisica(dbeCodLoc.Field.AsString);

      If fValidaCodigoLocalizacaoFisicaEmBranco(dbeDescri.Text) Then
        fRollBack;

      If blnAtuAmz And (strCodAmzAnt <> dbeCodAmz.Field.AsString) Then
      Begin
        If objCadLot.fAtualizaLocFisica(strCodAmzAnt, dbeCodAmz.Field.AsString,
                                        dbeCodLoc.Field.AsString) Then
          fCommit
        Else
          fRollBack;
      End
      else if (strCodLocAnt <> '') and (strCodLocAnt <> dbeCodLoc.Field.AsString) then
      begin
        If objCadLot.fAtualizaLocFisicaLotes(strCodLocAnt, dbeCodLoc.Field.AsString, VS_strCodEmp) Then
          fCommit
        Else
          fRollBack;
      end
      else
      Begin
       fCommit;

       If blnTransitorio Then
       Begin
         strCodLocal := dbeCodLoc.Field.AsString;
         strDescLocal:= dbeDescri.Field.AsString;
         Close;
       End;

      End;

    End

    Else fRollBack;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadLocFisica.btnGravarClick]');
    End;

  End;

  pAfterScroll(qryTabela);

end;

procedure TfrmCadLocFisica.btnImportarPlanilhaClick(Sender: TObject);
var
  frmImportarPlanilha : TfrmImportarPlanilhaLocFisica;
begin
  inherited;

  pCriarFormularios(TfrmImportarPlanilhaLocFisica, frmImportarPlanilha);

  Try
    frmImportarPlanilha.blnUsaMascaraCodigo := blnUsaMascaraCodigo;
    frmImportarPlanilha.ShowModal;
  Finally
    pFreeAndNil(frmImportarPlanilha);
  End;
end;

procedure TfrmCadLocFisica.btnIncluirClick(Sender: TObject);
begin
  inherited;

  dbckbCritico.Field.AsString := 'N';

  If blnUsaRotinaWMS Then
  Begin

    dbeCodEmp.Field.AsString := VS_strCodEmp;
    rbBuffer.Checked := True;
    dbckbAtivo.Field.AsString := 'S';
    dbckbBalcao.Field.AsString := 'N';
    dbckbPdeRpd.FIeld.AsString := 'S';
    dbckbTransitoria.Field.AsString := IIF(blnTransitorio, 'S', 'N');
    dbeLargur.Field.AsFloat  := 0.00;
    dbeAltura.Field.AsFloat  := 0.00;
    dbeProfun.Field.AsFloat  := 0.00;
    dbeCapaci.Field.AsFloat  := 0.00;
    dbePonRep.Field.AsFloat  := 0.00;
    dbeTaxaOcpMax.Field.AsInteger  := 100;

    if blnUsaMascaraCodigo then
    begin
      pHabilitaCodigo(dbeCodLoc, dbeCodLoc, False);
      pSetFocus(dbeDescri);
    end
    else
      pHabilitaCodigo(dbeCodLoc, dbeCodLoc, True);

  End
  Else
  Begin
    pHabilitaCodigo(dbeCodLoc, dbeCodLoc, True);
  End;
  strCodLocAnt := '';
  strLocCrit := '';
end;

procedure TfrmCadLocFisica.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAtiv: TConsultasArray;
begin
  chrKey := '/';
  If fPesqLocFisica(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
  Begin
    pSetFocus(btnAlterar);
    pSetaCamposWms;
  End;

end;

procedure TfrmCadLocFisica.dbckbPdeRpdClick(Sender: TObject);
begin
  inherited;
  If Not dbckbPdeRpd.Checked Then
    dbckbPdeRpd.Checked := Not fValidaLocIte;
end;

function TfrmCadLocFisica.fValidaLocIte:Boolean;
var
  qryAux: TUniQuery;
  strItem: String;
CONST
    LINHA = '------------------------------------------------------------------------------------';
begin
  Result := False;
  If qryTabela.State in [dsEdit] Then
  Begin
    qryAux := fCriaQuery;
    strItem := '';
    If Not fEmptyStr(qryTabela.FieldByName('LOC_ITEPIC').AsString) Then
      strItem := qryTabela.FieldByName('LOC_ITEPIC').AsString + '-' + edtDesIte.Text;
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT         ');
      qryAux.SQL.Add('   LCI_CODITE,  ');
      qryAux.SQL.Add('   ITE_DESITE,  ');
      qryAux.SQL.Add('   LOC_DESCRI,  ');
      qryAux.SQL.Add('   CONCAT("PRODUTO: ",LCI_CODITE, "-", ITE_DESITE, " | LOCALIZAÇÃO FÍSICA: ", LOC_DESCRI) AS DESCRI   ');
      qryAux.SQL.Add(' FROM           ');
      qryAux.SQL.Add('  LOCITE        ');
      qryAux.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = LCI_CODITE ');
      qryAux.SQL.Add(' INNER JOIN CADLOC ON CADLOC.AUTOINCREM = LCI_LOCFIS ');

      qryAux.SQL.Add(' WHERE                  ');
      qryAux.SQL.Add('  LCI_LOCFIS = :LOCFIS  ');
      qryAux.SQL.Add(' AND                    ');
      qryAux.SQL.Add('  LCI_CODITE <> :CODITE ');
      qryAux.SQL.Add(' LIMIT 1                ');
      qryAux.ParamByName('CODITE').AsString := qryTabela.FieldByName('LOC_ITEPIC').AsString;
      qryAux.ParamByName('LOCFIS').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryAux.Open;

      Result := qryAux.IsEmpty;

      If Not Result Then
      Begin
        pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
        frmMensagemExplicativa.Caption := 'Localização física';
        frmMensagemExplicativa.Width   := 800;
        frmMensagemExplicativa.Height  := 550;
        frmMensagemExplicativa.RitchObservacao.Visible:= True;
        frmMensagemExplicativa.RitchObservacao.BringToFront;
        frmMensagemExplicativa.RitchObservacao.Lines.Add(LINHA);
        frmMensagemExplicativa.RitchObservacao.Lines.Add('Não é possível desmarcar essa opção pois já existe mapeamento para esta localização física');
        If Not fEmptyStr(strItem) Then
          frmMensagemExplicativa.RitchObservacao.Lines.Add('para um item diferente do ' + strItem );
        frmMensagemExplicativa.RitchObservacao.Lines.Add(LINHA);

        qryAux.First;
        While Not qryAux.Eof do
        Begin
          frmMensagemExplicativa.RitchObservacao.Lines.Add(qryAux.FieldByName('DESCRI').AsString);
          qryAux.Next
        End;
        frmMensagemExplicativa.RitchObservacao.ScrollBars:= ssVertical;
        frmMensagemExplicativa.ShowModal;
      End;

    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

function TfrmCadLocFisica.fValidaPickingLaboratorioItemBase(out strMensagem: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    strMensagem := '';

    qryAux.SQL.Add('SELECT ITE_CODITE, ITE_DESITE, LOT_NUMLOT');
    qryAux.SQL.Add('FROM CADLOT');
    qryAux.SQL.Add('JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP');
    qryAux.SQL.Add('JOIN CADITE ON LOT_CODITE = ITE_CODITE');
    qryAux.SQL.Add('WHERE LOT_STATUS = "S"');
    qryAux.SQL.Add('  AND IFNULL(ITE_ITEBAS,"N") <> "S"');
    qryAux.SQL.Add('  AND LOC_CODLOC = :CODLOC');

    qryAux.ParamByName('CODLOC').AsString := qryTabela.FieldByName('LOC_CODLOC').AsString;
    qryAux.Open;

    Result := qryAux.IsEmpty;

    If Not Result Then
    Begin
      strMensagem := 'Produto | Descrição                                                             | Lote' + sLineBreak;

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        strMensagem := strMensagem +
          qryAux.FieldByName('ITE_CODITE').AsString.PadRight(8)  +'| '+
          qryAux.FieldByName('ITE_DESITE').AsString.PadRight(70) +'| '+
          qryAux.FieldByName('LOT_NUMLOT').AsString.PadRight(20) + sLineBreak;

        qryAux.Next;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadLocFisica.dbeCodAmzKeyPress(Sender: TObject; var Key: Char);
  Var
    arrAmz: TConsultasArray;
begin
  inherited;
  If fPesqArmazem(Self, dbeCodAmz, edtDesAmz, nil, Key, arrAmz) Then
  Begin
    If fValidaCampos(dbeCodAmz, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLocFisica.dbeCodLseKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  If fPesqLocSep(Self, dbeCodLse, edtDesLse, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(dbeCodLse, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLocFisica.dbeItePicKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqItem(conIteSimples, Self, dbeItePic, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(dbeItePic, True) Then
      SelectNext(ActiveControl, True, True);
  End
end;

procedure TfrmCadLocFisica.dbeObservKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) And fEmptyStr(dbeObserv.Text) Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadLocFisica.fAlterouLocCrit: Boolean;
begin
  Result := (strLocCrit <> dbckbCritico.Field.AsString);
end;

function TfrmCadLocFisica.fJaTemLoteNaPicking: Boolean;
var
  qrySaldos: TUniQuery;
  blnTemPicking,
  blnBufferJaTemItem: Boolean;
begin
  If Not blnLotPic Then
    Exit(False);

  Try
    qrySaldos := fCriaQuery;

    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add('    SELECT                              ');
    qrySaldos.SQL.Add('      LOT_CODITE                        ');
    qrySaldos.SQL.Add('    FROM                                ');
    qrySaldos.SQL.Add('      CADLOT A                          ');
    qrySaldos.SQL.Add('      LEFT JOIN CADLOC C                ');
    qrySaldos.SQL.Add('        ON A.LOT_LOCFIS = C.LOC_CODLOC  ');
    qrySaldos.SQL.Add('        AND A.LOT_CODEMP = C.LOC_CODEMP ');
    qrySaldos.SQL.Add('        AND C.LOC_PICKIN = "S"          ');
    qrySaldos.SQL.Add('      INNER JOIN CADITE I               ');
    qrySaldos.SQL.Add('        ON I.ITE_CODITE = A.LOT_CODITE  ');
    qrySaldos.SQL.Add('    WHERE C.LOC_CODEMP = :CODEMP        ');
    qrySaldos.SQL.Add('      AND C.LOC_CODLOC = :CODLOC        ');
    qrySaldos.SQL.Add('      AND A.LOT_SALDOS > 0              ');
    qrySaldos.SQL.Add('      AND LOT_STATUS = "S"              ');
    If grpProduto.Visible Then
      qrySaldos.SQL.Add('      AND LOT_CODITE = :CODITE        ');

    qrySaldos.Params[0].AsString := qryTabela.FieldByName('LOC_CODEMP').AsString;
    qrySaldos.Params[1].AsString := qryTabela.FieldByName('LOC_CODLOC').AsString;
    If grpProduto.Visible Then
      qrySaldos.Params[2].AsString := qryTabela.FieldByName('LOC_ITEPIC').AsString;


    qrySaldos.Open;

    blnTemPicking := Not qrySaldos.isEmpty;

    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add('    SELECT                                   ');
    qrySaldos.SQL.Add('     LOT_CODITE                              ');
    qrySaldos.SQL.Add('   FROM                                      ');
    qrySaldos.SQL.Add('     CADLOT                                  ');
    qrySaldos.SQL.Add('     INNER JOIN CADLOC                       ');
    qrySaldos.SQL.Add('       ON LOT_LOCFIS = LOC_CODLOC            ');
    qrySaldos.SQL.Add('       AND LOT_CODEMP = LOC_CODEMP           ');
    qrySaldos.SQL.Add('       AND LOC_PICKIN = "N"                  ');
    qrySaldos.SQL.Add('   WHERE LOT_LOCFIS = :CODLOC                ');
    qrySaldos.SQL.Add('     AND LOT_CODEMP = :CODEMP                ');
    qrySaldos.SQL.Add('     AND LOT_SALDOS > 0                      ');
    qrySaldos.SQL.Add('     AND LOT_STATUS = "S"                    ');
    If grpProduto.Visible Then
      qrySaldos.SQL.Add('     AND LOT_CODITE = :CODITE                ');

    qrySaldos.Params[0].AsString := qryTabela.FieldByName('LOC_CODLOC').AsString;
    qrySaldos.Params[1].AsString := qryTabela.FieldByName('LOC_CODEMP').AsString;
    If grpProduto.Visible Then
      qrySaldos.Params[2].AsString := qryTabela.FieldByName('LOC_ITEPIC').AsString;

    qrySaldos.Open;

    blnBufferJaTemItem := Not qrySaldos.isEmpty;

    Try
      Result := blnTemPicking Or blnBufferJaTemItem;
    Except On
      E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadLocFisica.fJaTemLoteNaPicking]');
      End;
    End;
  Finally
    FreeAndNil(qrySaldos);
  End;
end;

procedure TfrmCadLocFisica.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodLse(dbeCodLse);
  blnUsaRotinaWMS       := fUsaRotinaWMS;
  strNomeTabela         := 'CADLOC';
  strNomeCampo          := 'LOC_CODLOC';

  qryTabela             := fCriaQuery(Self);
  qryTabela.AfterScroll := pAfterScroll;
  dtsCadLoc.DataSet     := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0]     := dbeCodLoc;
  arrCamposChave[1]     := dbeCodEmp;

  objCadLot := TCadLot.Create(Self);

  dbckbTransitoria.visible := fCfgSis('ESTTRA', varBoolean);
  dbckbBalcao.visible := fCfgSis('UTCSEA', varString) = 'C';

  pnlArmazem.Visible := fCfgSis('CTLEST') = '2';

  blnUsaMascaraCodigo := (Trim(fCfgSis('LOCFIS', varString)) <> '');

  If Not pnlArmazem.Visible Then
    Self.Height := Self.Height - pnlArmazem.Height + 3;

  dbckbAtivo.Visible := blnUsaRotinaWMS;

  grpDimensoes.Visible := blnUsaRotinaWMS;

  pnlPrdDif.Visible := blnUsaRotinaWMS;

  grpPicking.Visible := blnUsaRotinaWMS;

  pAjustarTela;

  objCfgLocFis := TCamposCfgLocFis.Create;

  rbPickingCheckOut.Visible := TPickingCheckOut.fWMSUtilizaPickingCheckOut;
  rbPickingLabor.Visible    := fUsaPickingLaboratorioWms;
end;

procedure TfrmCadLocFisica.pAjustarTela;
begin
  If Not pnlArmazem.Visible Then
    grpCaracteristicas.Height := grpCaracteristicas.Height - pnlArmazem.Height;

  If Not grpDimensoes.Visible Then
  Begin
    grpCaracteristicas.Height := grpCaracteristicas.Height - grpPicking.Height;
    pnlPesoLocDim.Height := pnlPesoLocDim.Height - grpPicking.Height;
  End;

  pnlLocSep.Visible := blnUsaRotinaWMS or fCfgSis('UTLSLF', varBoolean);
  If Not blnUsaRotinaWMS Then
  Begin
    pnlLocSep.Parent := pnlCabecalho;
    pnlCabecalho.Height := pnlCabecalho.Height + pnlLocSep.Height;
    pnlLocSep.Align  := alBottom;
  End;

  If Not pnlLocSep.Visible Then
    grpCaracteristicas.Height := grpCaracteristicas.Height - pnlLocSep.Height;

  grpProduto.Visible := Not (blnUsaRotinaWMS And fCfgSis('LOTPIC', varBoolean));
  If grpProduto.Visible Then
    grpInformacoes.Height := grpCaracteristicas.Height +
                                    grpEndereco.Height +
                                     grpProduto.Height + 40
  Else
    grpInformacoes.Height := grpCaracteristicas.Height +
                                    grpEndereco.Height + 40;

  If Not blnUsaRotinaWMS Then
  Begin
    pnlArmazem.Parent := pnlCabecalho;
    pnlCabecalho.Height := pnlCabecalho.Height + pnlArmazem.Height;

    pnlArmazem.Align := alBottom;
    pnlCapMaxRepo.Parent := pnlCabecalho;
    pnlCabecalho.Height := pnlCabecalho.Height + pnlCapMaxRepo.Height;

    pnlCapMaxRepo.Align := alBottom;
    grpInformacoes.Visible := False;

    pnlObservacao.Visible := False;
    dbeCodLoc.TabOrder := 1;
    dbeDescri.TabOrder := 2;
    pnlCapMaxRepo.TabOrder := 3;
    pnlArmazem.TabOrder := 4;
  End
  Else
  Begin
    pnlCapMaxRepo.Visible := False;
    grpCaracteristicas.Height := grpCaracteristicas.Height - pnlCapMaxRepo.Height;
  End;

  Self.Height := 70;
  If pnlCabecalho.Visible Then
    Self.Height := Self.Height + pnlCabecalho.Height;

  If pnlStatus.Visible Then
    Self.Height := Self.Height + pnlStatus.Height;

  If pnlObservacao.Visible Then
    Self.Height := Self.Height + pnlObservacao.Height;

  If grpInformacoes.Visible Then
    Self.Height := Self.Height + grpInformacoes.Height;

end;

procedure TfrmCadLocFisica.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objCfgLocFis);
  inherited;
end;

procedure TfrmCadLocFisica.pSetaCamposWms;
  Var
    objCampo     : TCfgLocFis;
Begin
  //Se Utiliza WMS Carrega configuraçoes que vai formar o endereço
  // CFG_LOCFIS.
  If fUsaRotinaWMS Then
  Begin

    For objCampo in objCfgLocFis Do
    Begin

      If objCampo.strNomCam = 'LOC_CODLSE' Then
        Continue;

      With objCampo Do
      Begin
        If strNomCam = dbeRua.Field.FieldName Then
        Begin
          pSetaConfiguracoes(dbeRua);
        End

        Else
        If strNomCam = dbePredio.Field.FieldName Then
        Begin
          pSetaConfiguracoes(dbePredio);
        End

        Else
        If strNomCam = dbeAndar.Field.FieldName Then
        Begin
          pSetaConfiguracoes(dbeAndar);
        End

        Else
        If strNomCam = dbeApartamento.Field.FieldName Then
        Begin
          pSetaConfiguracoes(dbeApartamento);
        End;
      End;
    End;


  End;

End;

procedure TfrmCadLocFisica.grpPickingExit(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Then
    blnAlterouTipoLocalizacao := False
  Else
    blnAlterouTipoLocalizacao := strLocPickinBkp <> fGetTipoLocalizacao;
end;

procedure TfrmCadLocFisica.pSetTipoLocalizacao;
  Var
    intCont: Integer;
begin
  For intCont := 0 To grpPicking.ControlCount -1 Do
    If grpPicking.Controls[intCont] Is TRadioButton Then
      TRadioButton(grpPicking.Controls[intCont]).Checked := False;

  If fEmptyStr(qryTabela.FieldByName('LOC_PICKIN').AsString) Then
    Exit;

  Case qryTabela.FieldByName('LOC_PICKIN').AsString[1] Of
    'S': Begin
           If qryTabela.FieldByName('LOC_PRILAB').AsString = 'S' Then
             rbPickingLabor.Checked := True
           Else
             rbPicking.Checked := True;
         End;
    'N': rbBuffer.Checked          := True;
    'E': rbExcesso.Checked         := True;
    'C': rbPickingCheckOut.Checked := True;
  End;
end;

function TfrmCadLocFisica.fGetTipoLocalizacao: String;
begin
  Result := '';

  If rbPicking.Checked Or (rbPickingLabor.Visible And rbPickingLabor.Checked) Then
    Exit('S');

  If rbBuffer.Checked Then
    Exit('N');

  If rbExcesso.Checked Then
    Exit('E');

  If rbPickingCheckOut.Visible And rbPickingCheckOut.Checked Then
    Exit('C');
end;

procedure TfrmCadLocFisica.FormShow(Sender: TObject);
begin
  inherited;
  blnAtuAmz := (fCfgSis('CTLEST') = '2') And fCfgSis('CADLOC', varBoolean);
  pSetaCamposWms;
  blnLotPic := fCfgSis('LOTPIC', varBoolean);
  pSetFocus(btnIncluir);

  If blnTransitorio Then
    btnIncluir.onClick(Nil);
end;

procedure TfrmCadLocFisica.pAfterScroll(DataSet: TDataSet);
begin
  If DataSet.Active Then
  Begin
    edtDesAmz.Text := fRetNomeArmazem(DataSet.FieldByName('LOC_CODAMZ').AsString);
    edtDesIte.Text := fRetNomProduto (DataSet.FieldByName('LOC_ITEPIC').AsString);
    edtDesLse.Text := fCampoTabela('LSE_DESCRI','CADLSE',['LSE_CODIGO'],[DataSet.FieldByName('LOC_CODLSE').AsString]);

    TFloatField(dbeLargur.Field).DisplayFormat := fMskDigitos(3);
    TFloatField(dbeAltura.Field).DisplayFormat := fMskDigitos(3);
    TFloatField(dbeProfun.Field).DisplayFormat := fMskDigitos(3);
    TFloatField(dbeCapaci.Field).DisplayFormat := fMskDigitos(3);
    TFloatField(dbePonRep.Field).DisplayFormat := fMskDigitos(3);

    pSetTipoLocalizacao;
  End;
end;

procedure TfrmCadLocFisica.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('LOC_CODLOC');
  stlCampos.Add('LOC_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('LOC_DESCRI');
  stlCamInd.Add('LOC_CODLOC');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadLocFisica.pOnStateChange;
  Var
    intCont: Integer;
begin
  inherited;
  grpPicking.Enabled := (qryTabela.State in [dsInsert, dsEdit]);

  For intCont := 0 To grpPicking.ControlCount -1 Do
    grpPicking.Controls[intCont].Enabled := grpPicking.Enabled;
end;

function TfrmCadLocFisica.fLocFisLotGarantia(ALocFis: String): Boolean;
Var
  LSQL: String;
  LQry: TUniQuery;
begin
  LSQL := '';
  LSQL := LSQL + ' SELECT COUNT(1) AS TOTAL ';
  LSQL := LSQL + ' FROM CADLOT ';
  LSQL := LSQL + '  WHERE LOT_LOCFIS = :LOCFIS ';
  LSQL := LSQL + '    AND LOT_NUMLOT = "GARANTIA"';

  LQry := fCriaQuery;

  Try
    LQry.SQL.Add(LSQL);
    LQry.ParamByName('LOCFIS').AsString := ALocFis;
    LQry.Open;

    Result := LQry.FieldByName('TOTAL').AsInteger > 0;

    LQry.Close;
  Finally
    FreeAndNil(LQry);
  End;
end;

function TfrmCadLocFisica.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strItem: String;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodLoc) Then
    Begin
      if not fEmptyStr(dbeCodLoc.text) then
      begin
        dbeCodLoc.text := Trim(dbeCodLoc.text);
        dbeCodLoc.field.AsString := dbeCodLoc.text;
      end;


      If (fEmptyStr(dbeCodLoc.Text)) And (dbeCodLoc.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da localização física deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da localização física deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodAmz) And pnlArmazem.Visible Then
    Begin
      If Not fEmptyStr(dbeCodAmz.Text) Then
      Begin
        edtDesAmz.Text := fRetNomeArmazem(dbeCodAmz.Text);
        If fEmptyStr(edtDesAmz.Text) Then
        Begin
          pMensagemOk('Nenhum armazém encontrado com este código para a empresa logada!');
          Result := False;
        End;
      End
      Else
      Begin
        pMensagemOk('Código do armazém deve ser informado!');
        Result := False;
      End;
    End

    Else If (Sender = dbeLargur) And grpDimensoes.Visible Then
    Begin
      If fStrToFloat(dbeLargur.Text) < 0 Then
      Begin
        pMensagemOk('A Largura deve ser informada corretamente!');
        Result := False;
      End;
    End

    Else If (Sender = dbeAltura) And grpDimensoes.Visible Then
    Begin
      If fStrToFloat(dbeAltura.Text) < 0 Then
      Begin
        pMensagemOk('A Altura deve ser informada corretamente!');
        Result := False;
      End;
    End

    Else If (Sender = dbeProfun) And grpDimensoes.Visible Then
    Begin
      If fStrToFloat(dbeProfun.Text) < 0 Then
      Begin
        pMensagemOk('A Profundidade deve ser informada corretamente!');
        Result := False;
      End;
    End

    Else If (Sender = dbeCodLse) Then
    Begin
      If (fEmptyStr(dbeCodLse.Text)) Then
      Begin
        edtDesLse.Clear;
        dbeCodLse.Field.Clear;

        If fCfgSis('LSEWMS', varBoolean) Then
        Begin
          Result := False;
          pMensagemOK('É Obrigatório a digitação do Local de Separaçao da Localização Física!');
        End;

      End
      Else
      Begin
        edtDesLse.Text := fCampoTabela('LSE_DESCRI','CADLSE',['LSE_CODIGO'],[dbeCodLse.Text]);

        If fEmptyStr(edtDesLse.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse local de separação não está cadastrado!',['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeCapaci) And blnUsaRotinaWMS Then
    Begin
      If fStrToFloat(dbeCapaci.Text) < 0 Then
      Begin
        pMensagemOk('A capacidade máxima deve ser informada corretamente!');
        Result := False;
      End;
    End

    Else If (Sender = dbeItePic) And blnUsaRotinaWMS And dbeItePic.Enabled Then
    Begin
      edtDesIte.Text := fRetNomProduto(dbeItePic.Text);

      If fEmptyStr(dbeItePic.Text) Then
        dbeItePic.Field.Clear

      Else If fEmptyStr(edtDesIte.Text) Then        
      Begin
        pMensagemOk('Produto picking informado não encontrado no sistema!');
        Result := False;
      End

      Else If (qryTabela.State <> dsInsert) And objCadLot.fTemLoteComLocFisica(dbeCodLoc.Text, strItem, True) And (strItem <> dbeItePic.Text) Then
      Begin
        Result := False;
        pMensagemOk('Não é possível definir este item como produto picking. ' +
                    'A localização física está sendo utilizada por outros produtos!' +
                    #13#10 + '(' + strItem + ')');

      End;

    End
    Else If (Sender = dbeTaxaOcpMax) And (pnlPrdDif.Visible) Then
    Begin
      If Not ((StrToIntDef(dbeTaxaOcpMax.Text, 0) > 0) And (StrToIntDef(dbeTaxaOcpMax.Text, 0) <= 100)) Then
      Begin
        Result := False;
        pMensagemOk('A taxa de ocupação máxima deve ser maior que 0 e menor ou igual a 100!');
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadLocFisica.fValidaCodigoLocalizacaoFisicaEmBranco(strDescricaoLocalizacao: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT COUNT(1) AS QTD FROM CADLOC WHERE IFNULL(LOC_CODLOC,"") = "" AND LOC_DESCRI = ' + QuotedStr(strDescricaoLocalizacao) );
    qryAux.Open;
    Result := qryAux.FieldByName('QTD').AsInteger > 0;
  finally
    FreeAndNil(qryAux);
  end;
end;

Function TfrmCadLocFisica.fRetCodigoWMS : String;
  Var
    objCampo : TCfgLocFis;
    strValor : String;
begin
  Result := '';
  For objCampo in objCfgLocFis Do
  Begin
    strValor := qryTabela.FieldByName(objCampo.strNomCam).AsString;
    If not fEmptyStr(strValor) then
      Result := Result + strValor + '-';
  End;

  Result := Copy(Result, 1, Length(Result)-1);
End;

function TfrmCadLocFisica.fVerificaChavePrimaria : Boolean;
  Var
    qryCadLoc : TUniQuery;
Begin
  qryCadLoc := fCriaQuery;
  Try
    With qryCadLoc, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT COUNT(0) AS QTD      ');
      Add(' FROM CADLOC                 ');
      Add(' WHERE LOC_CODEMP = :CODEMP  ');
      Add('   AND LOC_CODLOC = :CODLOC  ');
      Add('   AND AUTOINCREM <> :AUTINC ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      if fUsaRotinaWMS And blnUsaMascaraCodigo And (qryTabela.State in [dsInsert]) then
        ParamByName('CODLOC').AsString := fRetCodigoWms
      else
        ParamByName('CODLOC').AsString := dbeCodLoc.Text;

      ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;

      Result := FieldByName('QTD').AsInteger = 0;

      Close;

    End;

  Finally
    FreeAndNil(qryCadLoc);
  End;

End;

end.

