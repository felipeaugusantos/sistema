unit untOrdProdGeracaoAutomaticaEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxContainer, EditFocus,
  Vcl.Mask, MaskEditFocus, cxGroupBox, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, cxRadioGroup, untConsultas, untTypesSistema, untZClient, cxLabel,
  System.Generics.Collections, cxTextEdit, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmOrdProdGeracaoAutomaticaEstoque = class(TfrmPaiEdit)
    cxgItensLvl: TcxGridLevel;
    cxgItensTbv: TcxGridDBTableViewCitel;
    cxgItens: TcxGridCitel;
    gpbGranel: TcxGroupBox;
    Label1: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label3: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    gpbExibicao: TcxGroupBox;
    chkSemNecessidade: TCheckBox;
    chkOpsPen: TCheckBox;
    chkEstMax: TCheckBox;
    btnCalcular: TBitBtnLocked;
    btnGerarOP: TBitBtnLocked;
    rdgEstoque: TcxRadioGroup;
    rdgCalculo: TcxRadioGroup;
    cxgItensTbvCODITE: TcxGridDBColumn;
    cxgItensTbvDESITE: TcxGridDBColumn;
    cxgItensTbvSIGUNI: TcxGridDBColumn;
    cxgItensTbvSALDOS: TcxGridDBColumn;
    cxgItensTbvSALDIS: TcxGridDBColumn;
    cxgItensTbvESTMIN: TcxGridDBColumn;
    cxgItensTbvESTMAX: TcxGridDBColumn;
    cxgItensTbvOPSPEN: TcxGridDBColumn;
    cxgItensTbvSUGEST: TcxGridDBColumn;
    chkValidaSaldosSubItens: TCheckBox;
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGerarOPClick(Sender: TObject);
    procedure cxgItensTbvEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensTbvSUGESTPropertiesEditValueChanged(Sender: TObject);
  private
    arrLinGru  : TConsultasArray;
    arrMarca   : TConsultasArray;
    arrProduto : TConsultasArray;

    strLinGru  : String;
    strMarca   : String;
    strProduto : String;

    cdsItens: TZClient;
    function fSQLItens: String;
    function fGeraOP(pgbProgresso: TcxProgressBar): Boolean;
    function fCalcula(pgbProgresso: TcxProgressBar): Boolean;
    procedure pVerificaSaldoSubItens;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untFuncoesConsulta, untOrdPro, untGravando;



procedure TfrmOrdProdGeracaoAutomaticaEstoque.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmOrdProdGeracaoAutomaticaEstoque.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmOrdProdGeracaoAutomaticaEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  cdsItens := TZClient.Create(Self);
  cxgItensTbv.DataController.DataSource := cdsItens.dtsSource;

  chkValidaSaldosSubItens.Visible := (fCfgSis('SLD_OI') <> 'N');
  if (not chkValidaSaldosSubItens.Visible) Then
      chkValidaSaldosSubItens.Checked := False;

end;

procedure TfrmOrdProdGeracaoAutomaticaEstoque.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_F1  : if btnCalcular.Enabled then
               btnCalcular.Click;
    VK_F10 : if btnGerarOP.Enabled then
               btnGerarOP.Click;
  end;
end;

procedure TfrmOrdProdGeracaoAutomaticaEstoque.btnCalcularClick(
  Sender: TObject);
begin
  inherited;
  try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCalcula;
    frmGravando.ShowModal;
  finally
    pFreeAndNil(frmGravando);
  end;

end;

procedure TfrmOrdProdGeracaoAutomaticaEstoque.btnGerarOPClick(Sender: TObject);
begin
  inherited;

  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
    Exit;

  If fMensagem('', 'Confirma Geração de Ordem de Produção ?', ['Sim', 'Não']) = 2 Then
    Exit;

  Self.Enabled        := False;
  btnCalcular.Enabled := False;

  try
    cdsItens.DisableControls;
    cdsItens.Filtered := False;
    cdsItens.Filter   := 'SUGEST > 0';
    cdsItens.Filtered := True;
    cdsItens.First;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGeraOP;
    frmGravando.ShowModal;

    if frmGravando.blnConfirma then
      btnCalcularClick(btnCalcular);


  finally
    pFreeAndNil(frmGravando);

    cdsItens.Filtered := False;
    cdsItens.First;
    cdsItens.EnableControls;

    Self.Enabled := True;
    btnCalcular.Enabled := True;
  end;



end;



procedure TfrmOrdProdGeracaoAutomaticaEstoque.cxgItensTbvEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (not cdsItens.Active) or  cdsItens.IsEmpty then
    exit;

  Case Key of
    VK_RETURN: if cxgItensTbvSUGEST.Focused then
               begin
                 Sender.Controller.FocusNextRecord(Sender.Controller.FocusedRecordIndex, not (ssShift in Shift), true, false, false);
                 Key := 0;
               end;
  end;
end;

procedure TfrmOrdProdGeracaoAutomaticaEstoque.cxgItensTbvSUGESTPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if fStrTofloat(TcxTextEdit(Sender).Text) < 0 then
  begin
    pMensagemOk('A quantidade deve ser maior ou igual a 0!');
    cdsItens.Cancel;
  end;
end;

function TfrmOrdProdGeracaoAutomaticaEstoque.fGeraOP(pgbProgresso: TcxProgressBar): Boolean;
Var
  lstOrdPro : TObjectList<TOrdPro>;
  objOrdPro : TOrdPro;
  intUltimaLinha : Integer;

begin
  inherited;

  lstOrdPro := TObjectList<TOrdPro>.Create;
  try
    pgbProgresso.Properties.Max := cdsItens.RecordCount;
    pInformacao('Aguarde, iniciando a gravação das OPs...', pgbProgresso);

    fStartTransaction;
    While Not cdsItens.Eof Do
    Begin
      Try
        pgbProgresso.Position := cdsItens.RecNo;
        pInformacao('Aguarde, gerando ordem de produção do produto ' + cdsItens.FieldByName('CODITE').AsString + '...', pgbProgresso);

        objOrdPro := TOrdPro.Create(Nil, False);

        objOrdPro.blnTransacao := False;
        objOrdPro.strCodEmp    := VS_strCodEmp;
        objOrdPro.strCodIte    := cdsItens.FieldByName('CODITE').AsString;
        objOrdPro.strQtdApr    := cdsItens.FieldByName('SUGEST').AsString;
        objOrdPro.strQtdPro    := '0.0';
        objOrdPro.strConfer    := fRetNomVendRep(strLoginUsuarioLogado);
        objOrdPro.strDtaPro    := DateToStr(VS_Date);
        objOrdPro.strDtaCad    := DateToStr(VS_Date);

        If objOrdPro.fInsereOrdemProducao Then
          lstOrdPro.Add(objOrdPro)
        else
        Begin
          result := false;
          pMensagemOk('Operação cancelada pois não foi possível gerar a ordem de produção do item ' +
                       cdsItens.FieldByName('CODITE').AsString + ' - ' + cdsItens.fieldByName('DESITE').AsString + '!');
          fRollBack;
          exit;
        End;


      Except

        On E: Exception Do
        Begin
          result := false;
          fRollBack;
          pMensagensErro(E.Message, '[btnGerarOPClick]');
          exit;
        End;

      End;

      cdsItens.Next;
    End;

    Result := fCommit;

    if Result then
    begin
      If fMensagem('','Geração concluída com sucesso!. Imprime as ordens de Produção?', ['&Sim', '&Não']) = 1 Then
      begin
        For objOrdPro in lstOrdPro Do
        begin
          pInformacao('Aguarde, imprimindo ordem de produção ' + objOrdPro.strCodPro + '...', pgbProgresso);
          intUltimaLinha := 0;
          objOrdPro.pImprimeOrdPro(objOrdPro.strCodPro, intUltimaLinha, False, objOrdPro.strCodEmp);
        end;
      end;
    end;

  finally
    FreeAndNil(lstOrdPro);
  end;

end;


function TfrmOrdProdGeracaoAutomaticaEstoque.fCalcula(pgbProgresso: TcxProgressBar): Boolean;
  var
    fltSugestao     : real;
    blnExibeEstoque : boolean;
begin
  try
    pgbProgresso.Visible := False;
    pInformacao('Aguarde, buscando produtos...', pgbProgresso);

    cdsItens.DisableControls;
    cdsItens.Filtered := False;
    cdsItens.qryQuery.SQL.Text := fSQLItens;

    pSetaParam(mskLinGru.Text, arrLinGru,  strLinGru,  'CODGRU', cdsItens.qryQuery);
    pSetaParam(edtCodMar.Text, arrMarca,   strMarca,   'CODMAR', cdsItens.qryQuery);
    pSetaParam(edtCodIte.Text, arrProduto, strProduto, 'CODITE', cdsItens.qryQuery);

    cdsItens.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

    cdsItens.fAbreClient(True, 'TfrmOrdProdGeracaoAutomaticaEstoque.btnCalcularClick');


    cdsItens.pFormataDecimal('SALDOS', 3);
    cdsItens.pFormataDecimal('SALDIS', 3);
    cdsItens.pFormataDecimal('ESTMIN', 3);
    cdsItens.pFormataDecimal('ESTMAX', 3);
    cdsItens.pFormataDecimal('OPSPEN', 3);
    cdsItens.pFormataDecimal('SUGEST', 3);

    cdsItens.First;

    pgbProgresso.Visible  := True;
    pgbProgresso.Properties.Max := cdsItens.RecordCount;
    pgbProgresso.Position := 0;

    while not cdsItens.Eof do
    begin
      pgbProgresso.Position := pgbProgresso.Position +1;
      pInformacao('Aguarde, calculando sugestão de produção do produto ' + cdsItens.FieldByName('CODITE').AsString + '...', pgbProgresso);

      cdsItens.Edit;
      cdsItens.FieldByName('SALDIS').AsFloat := fRetornaSaldoDisponivel(cdsItens.FieldByName('CODITE').AsString, True);


      if chkEstMax.Checked then
        fltSugestao := cdsItens.FieldByName('ESTMAX').AsFloat
      else
        fltSugestao := cdsItens.FieldByName('ESTMIN').AsFloat;

      case rdgCalculo.ItemIndex of
        0 : fltSugestao := fltSugestao - cdsItens.FieldByName('SALDOS').AsFloat;
        1 : fltSugestao := fltSugestao - cdsItens.FieldByName('SALDIS').AsFloat;
      end;

      if chkOpsPen.Checked then
        fltSugestao := fltSugestao - cdsItens.FieldByName('OPSPEN').AsFloat;

      if fltSugestao > 0 then
        cdsItens.FieldByName('SUGEST').AsFloat := fltSugestao;

      cdsItens.Post;

      Case rdgEstoque.ItemIndex Of
        1: begin
             case rdgCalculo.ItemIndex of
               0: blnExibeEstoque := (cdsItens.FieldByName('SALDOS').AsFloat < cdsItens.FieldByName('ESTMIN').AsFloat);
               1: blnExibeEstoque := (cdsItens.FieldByName('SALDIS').AsFloat < cdsItens.FieldByName('ESTMIN').AsFloat);
               else blnExibeEstoque := False;
             end;
           end;
        2: begin
             case rdgCalculo.ItemIndex of
               0: blnExibeEstoque := (cdsItens.FieldByName('SALDOS').AsFloat < 0);
               1: blnExibeEstoque := (cdsItens.FieldByName('SALDIS').AsFloat < 0);
               else blnExibeEstoque := False;
             end;
           end;
        else blnExibeEstoque      := True;
      End;

      if blnExibeEstoque and (chkSemNecessidade.Checked or (fltSugestao > 0)) then
        cdsItens.Next
      else
        cdsItens.Delete;

    end;

    {Verifica Saldo dos subitens req.: 221807 }
    if chkValidaSaldosSubItens.Checked Then
      pVerificaSaldoSubItens;

    cdsItens.First;

    If cdsItens.RecordCount = 0 Then
      pMensagemOk('Nenhum registro encontrado!');

    Result := True;
  finally
    cdsItens.EnableControls;
  end;

end;


procedure TfrmOrdProdGeracaoAutomaticaEstoque.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrProduto, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmOrdProdGeracaoAutomaticaEstoque.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples,
               Self,
               edtCodIte,
               edtDesIte,
               nil,
               Key,
               arrProduto,
               False,
               nil,
               'Consulta de Itens') Then
  Begin
    If fValidaCampos(edtCodIte, True) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmOrdProdGeracaoAutomaticaEstoque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru,arrLinGru,'',6);
    End
    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarca);
    End
    Else If (Sender = edtCodIte) Then
    Begin
      pDesmarcaLista(edtCodIte, arrProduto);
    End;

  end;

  If Not Result Then
    pSetFocus(Sender);

end;

{$R *.dfm}

procedure TfrmOrdProdGeracaoAutomaticaEstoque.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmOrdProdGeracaoAutomaticaEstoque.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmOrdProdGeracaoAutomaticaEstoque.pVerificaSaldoSubItens;
var
 objOrdPro : TOrdPro;
 blnNaoTemSaldoSubItem: Boolean;
begin

  cdsItens.first;
  While Not cdsItens.Eof Do
  Begin
    objOrdPro := TOrdPro.Create(Nil, False);

    objOrdPro.blnTransacao := False;
    objOrdPro.strCodEmp    := VS_strCodEmp;
    objOrdPro.strCodIte    := cdsItens.FieldByName('CODITE').AsString;
    objOrdPro.strQtdApr    := cdsItens.FieldByName('SUGEST').AsString;
    objOrdPro.strQtdPro    := '0.0';
    objOrdPro.strConfer    := fRetNomVendRep(strLoginUsuarioLogado);
    objOrdPro.strDtaPro    := DateToStr(VS_Date);
    objOrdPro.strDtaCad    := DateToStr(VS_Date);

    objOrdPro.pCriaTemporaria(False, cdsItens.FieldByName('CODITE').AsString);

    blnNaoTemSaldoSubItem := False;
    objOrdPro.cdsIteEst.First;
    While Not objOrdPro.cdsIteEst.Eof Do
    Begin
      objOrdPro.cdsIteEst.Edit;
      If objOrdPro.cdsIteEst.FieldByName('METRAG').AsFloat > 0 Then
        objOrdPro.cdsIteEst.FieldByName('QTDTOT').AsFloat := cdsItens.FieldByName('SUGEST').AsFloat * objOrdPro.cdsIteEst.FieldByName('QTDITE').AsFloat * objOrdPro.cdsIteEst.FieldByName('METRAG').AsFloat
      Else
        objOrdPro.cdsIteEst.FieldByName('QTDTOT').AsFloat := cdsItens.FieldByName('SUGEST').AsFloat * objOrdPro.cdsIteEst.FieldByName('QTDITE').AsFloat;
      objOrdPro.cdsIteEst.Post;

      If (Not blnNaoTemSaldoSubItem) And (objOrdPro.cdsIteEst.FieldByName('QTDTOT').AsFloat > objOrdPro.cdsIteEst.FieldByName('SALDOS').AsFloat)  Then
        blnNaoTemSaldoSubItem := True;

      objOrdPro.cdsIteEst.Next;
    End;

    {se algum dos subitens não tiver saldo é exclui o item.}
    If blnNaoTemSaldoSubItem Then
      cdsItens.Delete
    Else
      cdsItens.Next;

    objOrdPro.pLimpaDados;
    objOrdPro.cdsIteEst.EmptyDataSet;

    if objOrdPro <> Nil Then
      FreeAndNil(objOrdPro);

  End;

end;

function TfrmOrdProdGeracaoAutomaticaEstoque.fSQLItens: String;
Var
  strSQL: String;
Begin
  strSQL := ' /* untAnaliseProducao.fSQLItens */                                           ';
  strSQL := strSQL + '  SELECT SQL_NO_CACHE DISTINCT                                       ';
  strSQL := strSQL + '    I.ITE_CODITE  AS CODITE,                                         ';
  strSQL := strSQL + '    I.ITE_DESITE  AS DESITE,                                         ';
  strSQL := strSQL + '    UNI_SIGUNI    AS SIGUNI,                                         ';
  strSQL := strSQL + '    ITE_SALDOS    AS SALDOS,                                         ';
  strSQL := strSQL + '    0.000         AS SALDIS,                                         ';
  strSQL := strSQL + '    ITE_ESTMIN    AS ESTMIN,                                         ';
  strSQL := strSQL + '    ITE_ESTMAX    AS ESTMAX,                                         ';

  strSQL := strSQL + '    IFNULL((SELECT                                                   ';
  strSQL := strSQL + '              SUM(IF(PRO_QTDAPR < PRO_QTDPRO                         ';
  strSQL := strSQL + '                     , 0                                             ';
  strSQL := strSQL + '                     , IFNULL(PRO_QTDAPR,0) - IFNULL(PRO_QTDPRO,0))) ';
  strSQL := strSQL + '            FROM                                                     ';
  strSQL := strSQL + '              MOVPRO                                                 ';
  strSQL := strSQL + '            WHERE                                                    ';
  strSQL := strSQL + '                  PRO_DTABAI IS NULL                                 ';
  strSQL := strSQL + '              AND PRO_CODITE = G.ITE_CODITE                          ';
  strSQL := strSQL + '              AND PRO_CODEMP = G.ITE_CODEMP)                         ';
  strSQL := strSQL + '          ,0)     AS OPSPEN,                                         ';

  strSQL := strSQL + '    0.000         AS SUGEST                                          ';
  strSQL := strSQL + '  FROM                                                               ';
  strSQL := strSQL + '    ITEGER G                                                         ';
  strSQL := strSQL + '  INNER JOIN CADITE I  ON G.ITE_CODITE = I.ITE_CODITE                ';
  strSQL := strSQL + '  INNER JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI                     ';
  strSQL := strSQL + '  WHERE                                                              ';
  strSQL := strSQL + '        G.ITE_CODEMP = :CODEMP                                       ';
  strSQL := strSQL + '    AND G.ITE_CODITE IN (SELECT GMT_CODITE FROM GERMAT)              ';

  strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGru , 'I.ITE_CODGRU', 'CODGRU');
  strSQL := strSQL + fStrLocate(      edtCodMar, arrMarca  , 'I.ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(      edtCodIte, arrProduto, 'G.ITE_CODITE', 'CODITE');

  Case rdgEstoque.ItemIndex Of
    1: strSQL := strSQL + ' AND ITE_SALDOS < ITE_ESTMIN ';
    2: strSQL := strSQL + ' AND ITE_SALDOS < 0          ';
  End;

  Result := strSQL;
End;


end.
