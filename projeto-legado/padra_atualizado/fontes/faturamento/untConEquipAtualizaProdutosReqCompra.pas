unit untConEquipAtualizaProdutosReqCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Uni, UniClientDataSet, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxTextEdit, untLogGor;

type
  TStringValueRecord = Record
    strOldValue: String;
    strValue: String;
    class operator implicit(Value: String): TStringValueRecord;
  end;

  TRecStringValue = TStringValueRecord;


type
  TLogGorAlt = class(TLogGor)
  private
    class var strSeqGorAnt: String;
    class function fGravarLogGor(pstrSeqGor: String): Boolean;overload;
  public
    class function fGravarLogGor(pstrNumDoc, pstrEspDoc, pstrCodEmp: String): Boolean;overload;
    class function fGravarLogDor(recCodIte, recDesIte: TRecStringValue): Boolean;
  end;

type
  TRequisicaoRecord = Record
    strCodReq: String;
    strCodCli: String;
    strNomCli: String;
    strCodEqu: String;
    strDesEqu: String;
    strCodVen: String;
    strNomVen: String;
    strCodTec: String;
    strNomTec: String;
    strNumOSe: String;
    strEmpOSe: String;
    strNumDoc: String;
    strEspDoc: String;
    strEmpDoc: String;
    constructor Create(pstrCodReq: String);
  end;
  TrecRequisicao = TRequisicaoRecord;
type
  TfrmConEquipAtualizaProdutosReqCompra = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlButtons: TPanel;
    FlwPnlButtons: TFlowPanel;
    btnFechar: TBitBtnLocked;
    pnlTop: TPanel;
    pnlDadosOS: TPanel;
    pnlBottom: TPanel;
    lblInfo: TLabel;
    lblCodReq: TLabel;
    lnlNumOSe: TLabel;
    lnlPedido: TLabel;
    lblCliente: TLabel;
    lblEquip: TLabel;
    lblVend: TLabel;
    lblTecnico: TLabel;
    edtNumOse: TEditFocus;
    edtEmpOSe: TEditFocus;
    edtNumDoc: TEditFocus;
    edtEmpDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodTec: TEditFocus;
    edtNomTec: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodEqu: TEditFocus;
    edtDesEqu: TEditFocus;
    edtCodReq: TEditFocus;
    dtsGrid: TDataSource;
    cxGridTBV: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGridCitel;
    cxGridTBVCODITE: TcxGridDBColumn;
    cxGridTBVDESITE: TcxGridDBColumn;
    cxGridTBVQTDITE: TcxGridDBColumn;
    cxGridTBVVLRUNI: TcxGridDBColumn;
    cxGridTBVCODNOV: TcxGridDBColumn;
    cxGridTBVDESNOV: TcxGridDBColumn;
    cxGridTBVDESMAR: TcxGridDBColumn;
    cxGridTBVREFERE: TcxGridDBColumn;
    cxGridTBVCODFAB: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    procedure edtCodReqKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridTBVEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxGridTBVCODNOVPropertiesEditValueChanged(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridTBVKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strCodReq: String;
    qryMovRcg: TUniQuery;
    qryConEqu: TUniQuery;
    qryItens: TUniQuery;
    qryCadIte: TUniQuery;
    cdsGrid: TUniClientDataSet;
    FblnSomenteItensSemOS: Boolean;
    procedure pLimparTela;
    procedure pCriaCdsGrid;
    procedure pAtualizaRequisicao;
    function fCarregarTela: Boolean;
    function fCarregaRequisicao: Boolean;
    function fCarregaOrdemServico: Boolean;
    function fCarregaItensOS: Boolean;
    function fCarregaItensSemOs: Boolean;
    procedure pAdicionarItemGrid(pstrCodIte, pstrDesIte: String; pfltQtdIte, pfltVlrUni: Double; pstrNumDoc, pstrEspDoc, pstrEmpDoc, pstrSeqRcd: String);
    function fAdicionarItemEspecialGrid(pstrCodIte, pstrDesIte: String; pfltQtdIte, pfltVlrUni: Double; pstrNumDoc, pstrEspDoc, pstrEmpDoc, pstrSeqRcd: String): Boolean;
    function fCarregaItem(strCodIte: String): Boolean;
    function fVerificaPDFaturado(strNumPed, strEmpPed: String): Boolean;
    function fValidaItem: Boolean;
    function fVerificaTemItensAlterar: Boolean;

    function fObterDadosRequisicao: TRecRequisicao;

    procedure pExibirDadosReq(recRequisicao: TrecRequisicao);
    procedure btnConfirmaItensSemOsClick(Sender: TObject);
    procedure pSetblnSomenteItensSemOS(const Value: boolean);
    procedure pConfigurarTelaItemSemOS;
    procedure pPosicionarObj(aControl, aControlRef: TControl; intDistancia: Byte = 2; blnPosDireita: Boolean = True);
    function fRequisicaoVinculadaRequisicaoVenda: Boolean;
    procedure pPesquisar(Var Key: Char);


  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    { Public declarations }
    strCodEmp: String;
    property blnSomenteItensSemOS: Boolean Read FblnSomenteItensSemOS Write pSetblnSomenteItensSemOS;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untConsertoEquipamento, untFuncFat, System.StrUtils;

{$R *.dfm}

{ TfrmConEquipAtualizaProdutosReqCompra }

procedure TfrmConEquipAtualizaProdutosReqCompra.btnConfirmaItensSemOsClick(
  Sender: TObject);
  Var
    blnTemDocVnd,
    blnTemLogGor: boolean;

    recCodIte,
    recDesIte: TRecStringValue;
    sltProdAtualizados: TStringList;
    strAux: String;
begin
  sltProdAtualizados := Nil;
  if cdsGrid.IsEmpty then
    Exit;

  if (not fVerificaTemItensAlterar) then
    Exit;

  blnTemLogGor := False;
  blnTemDocVnd := fRequisicaoVinculadaRequisicaoVenda;

  Try
    sltProdAtualizados := TStringList.Create;
    try
      fStartTransaction;

      cdsGrid.First;
      {$Region 'Percorrendo cada item para verificar se deve registrar alteração'}
      while not cdsGrid.Eof do
      begin
        if (not fEmptyStr(cdsGrid.FieldByName('CODNOV').AsString)) and (not fEmptyStr(cdsGrid.FieldByName('DESNOV').AsString)) then
        begin
          {$Region 'Obtendo alterações'}
          recCodIte := cdsGrid.FieldByName('CODITE').AsString;
          recCodIte := cdsGrid.FieldByName('CODNOV').AsString;

          recDesIte := cdsGrid.FieldByName('DESITE').AsString;
          recDesIte := cdsGrid.FieldByName('DESNOV').AsString;

          strAux := Format('%s=%s',[recCodIte.strOldVAlue,
                                    recDesIte.strOldVAlue]);
          {$EndRegion 'Obtendo alterações'}

          {$Region 'Verificar se já foi feita alteração para o item especial'}
          if sltProdAtualizados.IndexOf(strAux) >= 0 then
          begin
            //passando para o próximo item porque elemento atual já foi registrado
            cdsGrid.Next;
            Continue;
          end;
          {$EndRegion 'Verificar se já foi feita alteração para o item especial'}

          {$Region 'Se tiver documento de venda, gravar a LOGGOR e LOGDOR'}
          if blnTemDocVnd then
          begin
            if (Not blnTemLogGor) then
            begin
              if Not TLogGorAlt.fGravarLogGor(cdsGrid.FieldByName('NUMDOC').AsString,
                                              cdsGrid.FieldByName('ESPDOC').AsString,
                                              cdsGrid.FieldByName('EMPDOC').AsString) then
              begin
                raise exception.Create('Ocorreu uma falha ao criar LgoGor da alteração.');
              end
              else
                blnTemLogGor := True;
            end;

            if blnTemLogGor then
            begin
              if Not TLogGorAlt.fGravarLogDor(recCodIte, recDesIte) then
                raise exception.Create('Ocorreu uma falha ao criar LgoGor da alteração.');
            end;
          end;
          {$EndRegion 'Se tiver documento de venda deve ser gravada a LOGGOR'}
          pAtualizaRequisicao;

          {$Region 'marcando item como alterado'}
          sltProdAtualizados.Add(strAux);
          {$EndRegion 'marcando item como alterado'}
        end;

        cdsGrid.Next;
      end;
      {$EndRegion 'Percorrendo os itens para verificar se deve registrar alteração'}
      fCommit;
      fMensagem('Aviso', 'Processo concluído!' , ['&Ok']);
      pLimparTela;
      ModalResult := mrOk;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(E.Message, 'btnConfirmaItensSemOsClick - untConEquipAtualizaProdutosReqCompra');
      end;
    end;
  Finally
    if assigned(sltProdAtualizados) then
      FreeAndNil(sltProdAtualizados);
  End;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.btnConfirmarClick(
  Sender: TObject);
var
  objConEqu: TConEqu;
begin
  inherited;

  if cdsGrid.IsEmpty then
    Exit;

  if (not fVerificaTemItensAlterar) then
    Exit;

  objConEqu := TConEqu.Create(Nil);

  try
    try
      if objConEqu.fVerificaOrdServExiste(edtNumOSe.Text, edtEmpOSe.Text, False) then
      begin
        fStartTransaction;

        objConEqu.strOperac := 'A';

        cdsGrid.First;

        while not cdsGrid.Eof do
        begin
          if (not fEmptyStr(cdsGrid.FieldByName('CODNOV').AsString)) and (not fEmptyStr(cdsGrid.FieldByName('DESNOV').AsString)) and
            (objConEqu.cdsIteEqu.Locate('CODITE;DESITE', VarArrayOf([cdsGrid.FieldByName('CODITE').AsString, cdsGrid.FieldByName('DESITE').AsString]), [])) then
          begin
            objConEqu.cdsIteEqu.Edit;
            objConEqu.cdsIteEqu.FieldByName('CODITE').AsString := cdsGrid.FieldByName('CODNOV').AsString;
            objConEqu.cdsIteEqu.FieldByName('DESITE').AsString := cdsGrid.FieldByName('DESNOV').AsString;
            objConEqu.cdsIteEqu.FieldByName('REFERE').AsString := cdsGrid.FieldByName('REFERE').AsString;
            objConEqu.cdsIteEqu.FieldByName('UNIDAD').AsString := cdsGrid.FieldByName('UNIDAD').AsString;
            objConEqu.cdsIteEqu.FieldByName('CODUNI').AsString := cdsGrid.FieldByName('CODUNI').AsString;
            objConEqu.cdsIteEqu.Post;

            pAtualizaRequisicao;
          end;

          cdsGrid.Next;
        end;

         objConEqu.fGravaEquGer;

        objConEqu.pAlteraStatusDados(objConEqu.strStatus,
                                         objConEqu.strSubSta,
                                         '',
                                         True,
                                         objConEqu.strRetPor,
                                         objConEqu.strOsPdCl,
                                         objConEqu.strReaPor,
                                         objConEqu.strReaTel);

        fCommit;
        fMensagem('Aviso', 'Processo concluído!' , ['&Ok']);
        pLimparTela;
        ModalResult := mrOk;
      end;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(E.Message, 'btnConfirmarClick - untConEquipAtualizaProdutosReqCompra');
      end;
    end;
  finally
    FreeAndNil(objConEqu);
  end;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.cxGridTBVCODNOVPropertiesEditValueChanged(
  Sender: TObject);
var
  strCodIte: String;
  blnResult: boolean;
begin
  inherited;
  blnResult := False;
  strCodIte := TcxTextEdit(Sender).Text;

   if (fEmptyStr(strCodIte)) then
  begin
    fMensagem('Aviso', 'Informe um item!' , ['&Ok']);
    cdsGrid.Cancel;
    Exit;
  end;

  strCodIte := fStrZero(strCodIte, fTamCodIte);

  if fCarregaItem(strCodIte)   then
  begin
    if fValidaItem then
    begin
      blnResult := True;
      cdsGrid.FieldByName('CODNOV').AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;
      cdsGrid.FieldByName('DESNOV').AsString := qryCadIte.FieldByName('ITE_DESITE').AsString;
      cdsGrid.FieldByName('DESMAR').AsString := qryCadIte.FieldByName('MAR_DESMAR').AsString;
      cdsGrid.FieldByName('REFERE').AsString := qryCadIte.FieldByName('ITE_REFERE').AsString;
      cdsGrid.FieldByName('CODFAB').AsString := qryCadIte.FieldByName('ITE_CODFAB').AsString;
      cdsGrid.FieldByName('CODUNI').AsString := qryCadIte.FieldByName('ITE_CODUNI').AsString;
      cdsGrid.FieldByName('UNIDAD').AsString := qryCadIte.FieldByName('UNI_SIGUNI').AsString;
    end;
  end
  else
    fMensagem('Aviso', 'Item ' + strCodIte + ' não encontrado!' , ['&Ok']);

  if Not blnResult then
  begin
    cdsGrid.FieldByName('CODNOV').Clear;
    cdsGrid.FieldByName('DESNOV').Clear;
    cdsGrid.FieldByName('DESMAR').Clear;
    cdsGrid.FieldByName('REFERE').Clear;
    cdsGrid.FieldByName('CODFAB').Clear;
    cdsGrid.FieldByName('CODUNI').Clear;
    cdsGrid.FieldByName('UNIDAD').Clear;
  end;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.cxGridTBVEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);

begin
  inherited;

  pPesquisar(Key);

end;

procedure TfrmConEquipAtualizaProdutosReqCompra.cxGridTBVKeyPress(
  Sender: TObject; var Key: Char);

begin
  pPesquisar(Key);
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.edtCodReqKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  if fPesqRequisicaoCompra(Self, edtCodReq, Key) then
    fValidaCampos(edtCodReq, True);
end;

function TfrmConEquipAtualizaProdutosReqCompra.fCarregaItem(strCodIte: String): Boolean;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ITE_CODITE, ITE_DESITE, ITE_REFERE, ITE_CODFAB, ITE_CODUNI, ITE_ITEATI, ';
  strSQL := strSQL + '    (SELECT UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = ITE_CODUNI) UNI_SIGUNI, ';
  strSQL := strSQL + '    (SELECT MAR_DESMAR FROM CADMAR WHERE MAR_CODMAR = ITE_CODMAR) MAR_DESMAR ';
  strSQL := strSQL + 'FROM CADITE ';
  strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';

  qryCadIte.Close;
  qryCadIte.SQL.Text := strSQL;
  qryCadIte.ParamByName('CODITE').AsString := strCodIte;
  qryCadIte.Open;

  Result := not qryCadIte.IsEmpty;
end;

function TfrmConEquipAtualizaProdutosReqCompra.fCarregaItensOS: Boolean;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT EQU_CODITE, EQU_DESCRI, EQU_QTDITE, EQU_UNITAR ';
  strSQL := strSQL + 'FROM EQUDET ';
  strSQL := strSQL + 'WHERE EQU_SEQGER = :SEQEQU AND ';
  strSQL := strSQL + '      EQU_CODITE = :CODITE AND ';
  strSQL := strSQL + '      EQU_DESCRI = :DESITE AND ';
  strSQL := strSQL + '      EQU_EMPITE = :EMPITE ';

  qryItens.Close;
  qryItens.SQL.Text := strSQL;
  qryItens.ParamByName('SEQEQU').AsString := qryConEqu.FieldByName('SEQEQU').AsString;
  qryItens.ParamByName('CODITE').AsString := qryMovRcg.FieldByName('RCD_CODITE').AsString;
  qryItens.ParamByName('DESITE').AsString := qryMovRcg.FieldByName('RCD_DESITE').AsString;
  qryItens.ParamByName('EMPITE').AsString := IIF(qryConEqu.FieldByName('MULLOJ').AsString = 'S', qryMovRcg.FieldByName('RCD_EMPPDV').AsString,
    qryConEqu.FieldByName('EQU_CODEMP').AsString);

  qryItens.Open;

  if QryItens.IsEmpty then
    Exit(False)
  else
    Result := fAdicionarItemEspecialGrid(qryItens.FieldByName('EQU_CODITE').AsString,
                                         qryItens.FieldByName('EQU_DESCRI').AsString,
                                         qryItens.FieldByName('EQU_QTDITE').AsFloat,
                                         qryItens.FieldByName('EQU_UNITAR').AsFloat,
                                         qryMovRcg.FieldByName('RCD_DOCPDV').AsString,
                                         qryMovRcg.FieldByName('RCD_ESPPDV').AsString,
                                         qryMovRcg.FieldByName('RCD_EMPPDV').AsString,
                                         qryMovRcg.FieldByName('SEQRCD').AsString);
end;

function TfrmConEquipAtualizaProdutosReqCompra.fCarregaItensSemOs: Boolean;
var
  strSQL: String;
  intContador: Integer;
begin
  intContador := 0;
  Result := False;


  strSQL := '';

  strSQL := strSQL + ' SELECT G.RCG_CODIGO, G.RCG_CODEMP, D.RCD_DOCPDV, D.RCD_ESPPDV, D.RCD_EMPPDV, D.RCD_CODITE, D.RCD_DESITE, D.RCD_QTDITE, D.AUTOINCREM AS SEQRCD, 0 AS "UNITAR" ';
  strSQL := strSQL + ' FROM MOVRCG G ';
  strSQL := strSQL + ' INNER JOIN MOVRCD D ON G.RCG_CODIGO = D.RCD_CODIGO AND G.RCG_CODEMP = D.RCD_CODEMP ';
  strSQL := strSQL + ' WHERE RCG_CODEMP = :CODEMP AND RCG_CODIGO = :CODIGO ';
  strSQL := strSQL + '       AND NOT EXISTS (SELECT 1 FROM EQUGER ';
  strSQL := strSQL + '                       WHERE     EQU_NUMPED = D.RCD_DOCPDV ';
  strSQL := strSQL + '                             AND EQU_TIPPED = D.RCD_ESPPDV  ';
  strSQL := strSQL + '                             AND EQU_EMPPED = D.RCD_EMPPDV)  ';

  qryItens.Close;
  qryItens.SQL.Text := strSQL;

  qryItens.ParamByName('CODIGO').AsString := edtCodReq.Text;
  qryItens.ParamByName('CODEMP').AsString := strCodEmp;

  qryItens.Open;

  if QryItens.IsEmpty then
    Exit;


  QryItens.First;
  While Not QryItens.Eof do
  begin
    if  fAdicionarItemEspecialGrid(qryItens.FieldByName('RCD_CODITE').AsString,
                                   qryItens.FieldByName('RCD_DESITE').AsString,
                                   qryItens.FieldByName('RCD_QTDITE').AsFloat,
                                   qryItens.FieldByName('UNITAR').AsFloat,
                                   qryItens.FieldByName('RCD_DOCPDV').AsString,
                                   qryItens.FieldByName('RCD_ESPPDV').AsString,
                                   qryItens.FieldByName('RCD_EMPPDV').AsString,
                                   qryItens.FieldByName('SEQRCD').AsString) then
      inc(intContador);

    QryItens.Next;
  end;

  Result := intContador > 0;

  Result := Result and (Not fVerificaPDFaturado(qryItens.FieldByName('RCD_DOCPDV').AsString,
                               qryItens.FieldByName('RCD_EMPPDV').AsString));

end;

function TfrmConEquipAtualizaProdutosReqCompra.fCarregaOrdemServico: Boolean;
var
  strSQL: String;
  blnOrigemOrdServico: Boolean;
begin
  Result := True;

  blnOrigemOrdServico := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT EQUGER.AUTOINCREM SEQEQU, EQU_NUMOSE, EQUGER.EQU_CODEMP, EQU_CODCLI, CLI_NOMCLI, EQU_CODEQU, ';
  strSQL := strSQL + '       CADEQU.EQU_DESCRI, EQU_CODVEN, (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = EQU_CODVEN) NOMVEN, ';
  strSQL := strSQL + '       EQU_CODTEC, (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = EQU_CODTEC) NOMTEC, EQU_NUMPED, EQU_TIPPED, EQU_EMPPED, IFNULL(FGO_MULLOJ, "N") MULLOJ ';
  strSQL := strSQL + 'FROM EQUGER ';
  strSQL := strSQL + 'INNER JOIN CADCLI ON EQU_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + 'INNER JOIN CADEQU ON EQU_CODEQU = EQU_CODIGO ';
  strSQL := strSQL + 'LEFT JOIN EQUGOR ON EQUGER.AUTOINCREM = FGO_SEQEQU ';
  strSQL := strSQL + 'WHERE EQU_NUMPED = :NUMDOC AND  ';
  strSQL := strSQL + '      EQU_TIPPED = :ESPDOC AND ';
  strSQL := strSQL + '      EQU_EMPPED = :CODEMP ';
  strSQL := strSQL + 'UNION ';
  strSQL := strSQL + 'SELECT EQUGER.AUTOINCREM SEQEQU, EQU_NUMOSE, EQUGER.EQU_CODEMP, EQU_CODCLI, CLI_NOMCLI, EQU_CODEQU, ';
  strSQL := strSQL + '       CADEQU.EQU_DESCRI, EQU_CODVEN, (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = EQU_CODVEN) NOMVEN, ';
  strSQL := strSQL + '       EQU_CODTEC, (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = EQU_CODTEC) NOMTEC, EQU_NUMPED, EQU_TIPPED, EQU_EMPPED, FGO_MULLOJ MULLOJ ';
  strSQL := strSQL + 'FROM EQUGER ';
  strSQL := strSQL + 'INNER JOIN CADCLI ON EQU_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + 'INNER JOIN CADEQU ON EQU_CODEQU = EQU_CODIGO ';
  strSQL := strSQL + 'INNER JOIN EQUGOR ON EQUGER.AUTOINCREM = FGO_SEQEQU ';
  strSQL := strSQL + 'INNER JOIN FATGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + 'WHERE FGO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '      FGO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '      FGO_CODEMP = :CODEMP ';

  qryConEqu.SQL.Text := strSQL;

  qryMovRcg.First;

  while not qryMovRcg.Eof do
  begin
    if fEmptyStr(qryMovRcg.FieldByName('RCD_DOCPDV').AsString) then
    begin
      qryMovRcg.Next;
      Continue;
    end;

    if (not blnOrigemOrdServico) then
    begin
      qryConEqu.Close;
      qryConEqu.ParamByName('NUMDOC').AsString := qryMovRcg.FieldByName('RCD_DOCPDV').AsString;
      qryConEqu.ParamByName('ESPDOC').AsString := qryMovRcg.FieldByName('RCD_ESPPDV').AsString;
      qryConEqu.ParamByName('CODEMP').AsString := qryMovRcg.FieldByName('RCD_EMPPDV').AsString;
      qryConEqu.Open;

      blnOrigemOrdServico := not qryConEqu.IsEmpty;
    end;

    if blnOrigemOrdServico then
      fCarregaItensOS;

    qryMovRcg.Next;
  end;

  if (not blnOrigemOrdServico) then
  begin
    Result := False;
    fMensagem('Aviso', 'Requisição de compra não se originou de uma ordem de serviço!' , ['&Ok']);
  end
  else if (fVerificaPDFaturado(qryConEqu.FieldByName('EQU_NUMPED').AsString,
                               qryConEqu.FieldByName('EQU_EMPPED').AsString)) then
    Exit(False);
end;

function TfrmConEquipAtualizaProdutosReqCompra.fCarregaRequisicao: Boolean;
var
  strSQL: String;
begin
  Result := True;
  
  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + ' SELECT RCG_CODIGO, RCG_CODEMP, RCD_DOCPDV, RCD_ESPPDV, RCD_EMPPDV, RCD_CODITE, RCD_DESITE, MOVRCD.AUTOINCREM SEQRCD ';
  strSQL := strSQL + ' FROM MOVRCG ';
  strSQL := strSQL + ' INNER JOIN MOVRCD ON RCG_CODIGO = RCD_CODIGO AND RCG_CODEMP = RCD_CODEMP ';
  strSQL := strSQL + ' WHERE RCG_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND RCG_CODIGO = :CODIGO ';

  qryMovRcg.Close;
  qryMovRcg.SQL.Clear;
  qryMovRcg.SQL.Add(strSQL);
  qryMovRcg.ParamByName('CODEMP').AsString := strCodEmp;
  qryMovRcg.ParamByName('CODIGO').AsString := edtCodReq.Text;
  qryMovRcg.Open;

  if (qryMovRcg.IsEmpty) then
  begin
    Result := False;
    fMensagem('Aviso', 'Requisição não encontrada!' , ['&Ok']);
  end;
end;

function TfrmConEquipAtualizaProdutosReqCompra.fCarregarTela: Boolean;
  Var
    recRequisicao: TrecRequisicao;
begin
  Result := True;

  if (fEmptyStr(edtCodReq.Text)) then
    Exit;

  if (not fEmptyStr(strCodReq)) and (strCodReq <> edtCodReq.Text) then
  begin
    if fMensagem('AVISO', 'Deseja carregar a requisição ' + edtCodReq.Text + '?', ['&Sim', '&Não']) = 2 then
    begin
      edtCodReq.Text := strCodReq;
      Exit;
    end;
  end;

  dtsGrid.DataSet := Nil;
  cdsGrid.EmptyDataSet;

  try
    if (not fCarregaRequisicao) then
      Exit(False);

    if FblnSomenteItensSemOS then
    begin
      if Not fCarregaItensSemOs then
      begin
        fMensagem('Aviso', 'Requisição não possui Item Especial ou, se possuir, ele deve estar associado a uma ordem de serviço. '
                           +slinebreak + ' Verifiquei através do botão [ALT F6 ATUALIZAR PRODTUOS OS]' , ['&Ok']);
        Exit(False);
      end;
    end
    else begin
      if (not fCarregaOrdemServico) then
        Exit(False);

      if cdsGrid.IsEmpty then
      begin
        fMensagem('Aviso', 'Ordem de serviço ' + qryConEqu.FieldByName('EQU_NUMOSE').AsString +
          ' não possui Item Especial com requisição de compra!' , ['&Ok']);
        Exit(False);
      end;
    end;


    strCodReq := qryMovRcg.FieldByName('RCG_CODIGO').AsString;
    recRequisicao := fObterDadosRequisicao;
    pExibirDadosReq(recRequisicao);

    cdsGrid.First;

    cxGridTBVCODNOV.Focused := True;
  finally
    dtsGrid.DataSet := cdsGrid;
  end;
end;

function TfrmConEquipAtualizaProdutosReqCompra.fObterDadosRequisicao: TRecRequisicao;
  Var
    Qry: TUniquery;
    strSql: String;
begin
  Result.Create(strCodReq);
  if FblnSomenteItensSemOS then
  begin
    Qry := nil;
    Try
      strSql :=          ' 	SELECT G.RCG_CODIGO, D.RCD_DOCPDV, D.RCD_ESPPDV, D.RCD_EMPPDV, G.RCG_CODEMP, G.RCG_CODCLI, C.CLI_NOMCLI, G.RCG_CODVEN, O.OPE_NOMOPE ';
      strSql := strSql + ' 	FROM MOVRCG G ';
      strSql := strSql + ' 	JOIN MOVRCD D ON G.RCG_CODIGO = D.RCD_CODIGO AND G.RCG_CODEMP = D.RCD_CODEMP ';
      strSql := strSql + ' 	JOIN CADCLI C ON C.CLI_CODCLI = G.RCG_CODCLI ';
      strSql := strSql + ' 	JOIN CADOPE O ON O.OPE_CODOPE = G.RCG_CODVEN ';
      strSql := strSql + ' 	WHERE G.RCG_CODIGO = :CODIGO AND G.RCG_CODEMP = :CODEMP ';

      Qry := fCriaQuery;
      Qry.close;
      Qry.Sql.Clear;
      Qry.Sql.Add(strSql);
      Qry.ParamByName('CODIGO').AsString := Result.strCodReq;
      Qry.ParamByName('CODEMP').AsString := strCodEmp;
      Qry.Open;

      if Not Qry.IsEmpty then
      begin
        Qry.First;
        Result.strCodCli := Qry.fieldByName('RCG_CODCLI').AsString;
        Result.strNomCli := Qry.fieldByName('CLI_NOMCLI').AsString;
        Result.strCodVen := Qry.fieldByName('RCG_CODVEN').AsString;
        Result.strNomVen := Qry.fieldByName('OPE_NOMOPE').AsString;
        Result.strNumDoc := Qry.FieldByName('RCD_DOCPDV').AsString;
        Result.strEspDoc := Qry.FieldByName('RCD_ESPPDV').AsString;
        Result.strEmpDoc := Qry.FieldByName('RCD_EMPPDV').AsString;

      end;

    Finally
      If Assigned(Qry) Then
        FreeAndNil(Qry);
    End;
  end
  else begin
     Result.strNumOSe := qryConEqu.FieldByName('EQU_NUMOSE').AsString;
     Result.strEmpOSe := qryConEqu.FieldByName('EQU_CODEMP').AsString;
     Result.strNumDoc := qryConEqu.FieldByName('EQU_NUMPED').AsString;
     Result.strEspDoc := qryConEqu.FieldByName('EQU_TIPPED').AsString;
     Result.strEmpDoc := qryConEqu.FieldByName('EQU_EMPPED').AsString;
     Result.strCodCli := qryConEqu.FieldByName('EQU_CODCLI').AsString;
     Result.strNomCli := qryConEqu.FieldByName('CLI_NOMCLI').AsString;
     Result.strCodEqu := qryConEqu.FieldByName('EQU_CODEQU').AsString;
     Result.strDesEqu := qryConEqu.FieldByName('EQU_DESCRI').AsString;
     Result.strCodVen := qryConEqu.FieldByName('EQU_CODVEN').AsString;
     Result.strNomVen := qryConEqu.FieldByName('NOMVEN').AsString;
     Result.strCodTec := qryConEqu.FieldByName('EQU_CODTEC').AsString;
     Result.strNomTec := qryConEqu.FieldByName('NOMTEC').AsString;
  end;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pLimparTela;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.FormCreate(Sender: TObject);
begin
  inherited;
  FblnSomenteItensSemOS := False;
  strCodEmp := '';
  qryMovRcg := fCriaQuery(Self);
  qryConEqu := fCriaQuery(Self);
  qryItens := fCriaQuery(Self);
  qryCadIte := fCriaQuery(Self);

  pCriaCdsGrid;

  pSetFocus(edtCodReq);

end;

procedure TfrmConEquipAtualizaProdutosReqCompra.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryMovRcg);
  FreeAndNil(qryConEqu);
  FreeAndNil(qryItens);
  FreeAndNil(qryCadIte);
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F10 then
    btnConfirmar.Click;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.FormShow(Sender: TObject);
begin
  inherited;

  if (not fEmptyStr(edtCodReq.Text)) then
    blnFecharFormPai := Not fCarregarTela;

  if blnFecharFormPai then
    Exit;
end;

function TfrmConEquipAtualizaProdutosReqCompra.fRequisicaoVinculadaRequisicaoVenda: Boolean;
begin
  Result := Not fEmptyStr(cdsGrid.FieldByName('NUMDOC').AsString);
  Result := Result and (Not fEmptyStr(cdsGrid.FieldByName('ESPDOC').AsString));
  Result := Result and (Not fEmptyStr(cdsGrid.FieldByName('EMPDOC').AsString));
end;

function TfrmConEquipAtualizaProdutosReqCompra.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtCodReq) then
  begin
    if (not fEmptyStr(edtCodReq.Text)) then
      Result := fCarregarTela
    else
    begin
      edtCodReq.Text := strCodReq;
      Result := (not fEmptyStr(strCodReq));
    end;

    if (not Result) then
      pLimparTela;
  end;
end;

function TfrmConEquipAtualizaProdutosReqCompra.fValidaItem: Boolean;
begin
  Result := False;

  if fIsItemEspecial(qryCadIte.FieldByName('ITE_CODITE').AsString) then
  begin
    fMensagem('Aviso', 'Não é permitido informar item especial!' , ['&Ok']);
    Exit;
  end;

  if (qryCadIte.FieldByName('ITE_ITEATI').AsString <> 'S') then
  begin
    fMensagem('Aviso', 'Esse item está Inativo!', ['&OK']);
    Exit;
  end;
  
  if (fEhItemServico(qryCadIte.FieldByName('ITE_CODITE').AsString)) then
  begin
    fMensagem('', 'Não é permitido selecionar um item de Serviço!', ['&OK']);
    Exit;
  end;

  Result := True;
end;

function TfrmConEquipAtualizaProdutosReqCompra.fVerificaPDFaturado(strNumPed, strEmpPed: String): Boolean;
var
  blnJaFatu,
  blnJaBaix,
  blnImp,
  blnSepImp: Boolean;
  strCodVen: String;
  qryFatgor: TUniQuery;
begin
  qryFatgor := fCriaQuery(Self);

  try
    fDocumentoFatExiste(qryFatgor,
                        strNumPed,
                        'PD',
                        strEmpPed,
                        blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

    Result := blnJaFatu;
  finally
    FreeAndNil(qryFatGor);
  end;
end;

function TfrmConEquipAtualizaProdutosReqCompra.fVerificaTemItensAlterar: Boolean;
var
  cdsDados: TUniClientDataSet;
begin
  Result := False;
  
  cdsDados := TUniClientDataSet.Create(nil);

  try
    pCloneDataSet(cdsDados, cdsGrid);

    cdsDados.First;
    
    while not cdsDados.Eof do
    begin
      if (not fEmptyStr(cdsDados.FieldByName('CODNOV').AsString)) and
        (not fEmptyStr(cdsDados.FieldByName('DESNOV').AsString)) then
        Exit(True);
        
      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.pAtualizaRequisicao;
var
  strSQL : String;
  qryAux: TUniQuery;

begin
  qryAux := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + 'UPDATE MOVRCD ';
    strSQL := strSQL + 'SET RCD_CODITE = :CODITE, ';
    strSQL := strSQL + '    RCD_DESITE = :DESITE ';
    strSQL := strSQL + 'WHERE AUTOINCREM = :SEQRCD ';

    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('CODITE').AsString := cdsGrid.FieldByName('CODNOV').AsString;
    qryAux.ParamByName('DESITE').AsString := cdsGrid.FieldByName('DESNOV').AsString;
    qryAux.ParamByName('SEQRCD').AsString := cdsGrid.FieldByName('SEQRCD').AsString;
    qryAux.ExecSQL;


    qryAux.SQL.Clear;

    if Not FblnSomenteItensSemOS then
      Exit;

    strSQL := '';
    strSQL := strSQL + 'UPDATE FATDOR ';
    strSQL := strSQL + 'SET FDO_CODITE = :CODNOV, ';
    strSQL := strSQL + '    FDO_DESCRI = :DESNOV ';
    strSQL := strSQL + 'WHERE FDO_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '      AND FDO_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '      AND FDO_CODEMP = :CODEMP ';
    strSQL := strSQL + '      AND FDO_CODITE = :CODITE ';
    strSQL := strSQL + '      AND FDO_DESCRI = :DESITE ';

    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('CODNOV').AsString := cdsGrid.FieldByName('CODNOV').AsString;
    qryAux.ParamByName('DESNOV').AsString := cdsGrid.FieldByName('DESNOV').AsString;
    qryAux.ParamByName('NUMDOC').AsString := cdsGrid.FieldByName('NUMDOC').AsString;
    qryAux.ParamByName('ESPDOC').AsString := cdsGrid.FieldByName('ESPDOC').AsString;
    qryAux.ParamByName('CODEMP').AsString := cdsGrid.FieldByName('EMPDOC').AsString;
    qryAux.ParamByName('CODITE').AsString := cdsGrid.FieldByName('CODITE').AsString;
    qryAux.ParamByName('DESITE').AsString := cdsGrid.FieldByName('DESITE').AsString;
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmConEquipAtualizaProdutosReqCompra.fAdicionarItemEspecialGrid(
  pstrCodIte, pstrDesIte: String; pfltQtdIte, pfltVlrUni: Double; pstrNumDoc,
  pstrEspDoc, pstrEmpDoc, pstrSeqRcd: String): Boolean;
begin
  if fIsItemEspecial(pstrCodIte) then
  begin
    Result := True;
    pAdicionarItemGrid(pstrCodIte,
                       pstrDesIte,
                       pfltQtdIte,
                       pfltVlrUni,
                       pstrNumDoc,
                       pstrEspDoc,
                       pstrEmpDoc,
                       pstrSeqRcd);
  end
  else
    Result := False;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.pAdicionarItemGrid(pstrCodIte, pstrDesIte: String; pfltQtdIte, pfltVlrUni: Double;
  pstrNumDoc, pstrEspDoc, pstrEmpDoc, pstrSeqRcd: String);
begin
  cdsGrid.Insert;
  cdsGrid.FieldByName('CODITE').AsString := pstrCodIte;
  cdsGrid.FieldByName('DESITE').AsString := pstrDesIte;
  cdsGrid.FieldByName('QTDITE').AsFloat  := pfltQtdIte;
  cdsGrid.FieldByName('VLRUNI').AsFloat  := pfltVlrUni;
  cdsGrid.FieldByName('NUMDOC').AsString := pstrNumDoc;
  cdsGrid.FieldByName('ESPDOC').AsString := pstrEspDoc;
  cdsGrid.FieldByName('EMPDOC').AsString := pstrEmpDoc;
  cdsGrid.FieldByName('SEQRCD').AsString := pstrSeqRcd;
  cdsGrid.Post;
end;


procedure TfrmConEquipAtualizaProdutosReqCompra.pConfigurarTelaItemSemOS;
  CONST
    TOP_LINHA1: Integer = 9;
    TOP_LINHA2: integer = 34;
    TOP_LINHA3: Integer = 59;
begin
  {$Region 'ocultando controles desnecessários'}
  lnlNumOSe.Visible := False;
  edtNumOse.Visible := False;
  edtEmpOSe.Visible := False;
  lblTecnico.Visible := False;
  edtNomTec.Visible := False;
  edtCodTec.Visible := False;
  lblEquip.Visible := False;
  edtCodEqu.Visible := False;
  edtDesEqu.Visible := False;
  cxGridTBVVLRUNI.Visible := False;
  {$EndRegion 'ocultando controles desnecessários'}
  edtNumDoc.Left := edtNumOse.left;
  edtNumDoc.Top := TOP_LINHA1;
  pPosicionarObj(edtEspDoc, edtNumDoc);
  pPosicionarObj(edtEmpDoc, edtEspDoc);

  pPosicionarObj(lnlPedido, edtNumDoc, 2, False);
  lnlPedido.Top := lnlPedido.Top + 3;


  lblCliente.Top := TOP_LINHA2 + 3;
  edtCodCli.Top := TOP_LINHA2;
  edtNomCli.Top := TOP_LINHA2;

  lblVend.Top := TOP_LINHA3 + 3;
  edtCodVen.Top := TOP_LINHA3;
  edtNomVen.Top := TOP_LINHA3;

  pnlDadosOS.Height := 88;
  btnConfirmar.OnClick := btnConfirmaItensSemOsClick;

  Self.Caption := 'Atualizar Itens Especiais da Requisição de Compra';
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.pCriaCdsGrid;
begin
  cdsGrid := TUniClientDataSet.Create(Self);

  cdsGrid.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  cdsGrid.FieldDefs.Add('DESITE', ftString, 57);
  cdsGrid.FieldDefs.Add('QTDITE', ftFloat);
  cdsGrid.FieldDefs.Add('VLRUNI', ftFloat);
  cdsGrid.FieldDefs.Add('CODNOV', ftString, fTamCodIte);
  cdsGrid.FieldDefs.Add('DESNOV', ftString, 57);
  cdsGrid.FieldDefs.Add('DESMAR', ftString, 57);
  cdsGrid.FieldDefs.Add('REFERE', ftString, 16);
  cdsGrid.FieldDefs.Add('CODFAB', ftString, 25);
  cdsGrid.FieldDefs.Add('UNIDAD', ftString,  2);
  cdsGrid.FieldDefs.Add('CODUNI', ftString,  2);
  cdsGrid.FieldDefs.Add('NUMDOC', ftString, 12);
  cdsGrid.FieldDefs.Add('ESPDOC', ftString,  2);
  cdsGrid.FieldDefs.Add('EMPDOC', ftString,  3);
  cdsGrid.FieldDefs.Add('SEQRCD', ftString, 20);
  cdsGrid.CreateDataSet;

  (cdsGrid.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsGrid.FieldByName('QTDITE') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsGrid.FieldByName('VLRUNI') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (cdsGrid.FieldByName('VLRUNI') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.pExibirDadosReq(
  recRequisicao: TrecRequisicao);
begin
  edtCodReq.Text := recRequisicao.strCodReq;
  edtNumOSe.Text := recRequisicao.strNumOSe;
  edtEmpOSe.Text := recRequisicao.strEmpOSe;
  edtNumDoc.Text := recRequisicao.strNumDoc;
  edtEspDoc.Text := recRequisicao.strEspDoc;
  edtEmpDoc.Text := recRequisicao.strEmpDoc;
  edtCodCli.Text := recRequisicao.strCodCli;
  edtNomCli.Text := recRequisicao.strNomCli;
  edtCodEqu.Text := recRequisicao.strCodEqu;
  edtDesEqu.Text := recRequisicao.strDesEqu;
  edtCodVen.Text := recRequisicao.strCodVen;
  edtNomVen.Text := recRequisicao.strNomVen;
  edtCodTec.Text := recRequisicao.strCodTec;
  edtNomTec.Text := recRequisicao.strNomTec;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.pLimparTela;
begin
  strCodReq := '';

  edtCodReq.Clear;
  edtNumOSe.Clear;
  edtEmpOSe.Clear;
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtEmpDoc.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodEqu.Clear;
  edtDesEqu.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtCodTec.Clear;
  edtNomTec.Clear;
  cdsGrid.EmptyDataSet;

  qryMovRcg.Close;
  qryConEqu.Close;
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.pPesquisar(var Key: Char);
  var
    arrSel: TConsultasArray;
    strDesMar,
    strSigUni: String;
begin
  if cdsGrid.IsEmpty then
    Exit;

  if (not(CharInSet(Key, ['0'..'9', #13, #8, #47]))) then
    Key := #0;

  if Not fEntraCons(Key) then
    Exit;

  if Not cxGridTBVCODNOV.Focused then
    Exit;

  qryCadIte.Close;
  qryCadIte.SQL.Clear;

  if fPesqItem(conIteSimples, Self, nil, nil, qryCadIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
  begin
    if (not fValidaItem) then
      Exit;

    strDesMar := fCampoTabela('MAR_DESMAR', 'CADMAR', ['MAR_CODMAR'], [qryCadIte.FieldByName('ITE_CODMAR').AsString]);
    strSigUni := fCampoTabela('UNI_SIGUNI', 'CADUNI', ['UNI_SIGUNI'], [qryCadIte.FieldByName('ITE_CODUNI').AsString]);

    cdsGrid.Edit;
    cdsGrid.FieldByName('CODNOV').AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;
    cdsGrid.FieldByName('DESNOV').AsString := qryCadIte.FieldByName('ITE_DESITE').AsString;
    cdsGrid.FieldByName('DESMAR').AsString := strDesMar;
    cdsGrid.FieldByName('REFERE').AsString := qryCadIte.FieldByName('ITE_REFERE').AsString;
    cdsGrid.FieldByName('CODFAB').AsString := qryCadIte.FieldByName('ITE_CODFAB').AsString;
    cdsGrid.FieldByName('CODUNI').AsString := qryCadIte.FieldByName('ITE_CODUNI').AsString;
    cdsGrid.FieldByName('UNIDAD').AsString := strSigUni;
    cdsGrid.Post;
  end;

end;

procedure TfrmConEquipAtualizaProdutosReqCompra.pPosicionarObj(aControl,
  aControlRef: TControl; intDistancia: Byte = 2; blnPosDireita: Boolean = True);
begin
  aControl.top := aControlRef.Top;
  if blnPosDireita then
    aControl.left := aControlRef.left + aControlRef.Width + intDistancia +1
  else
    aControl.left := aControlRef.left - ( aControl.Width + intDistancia +1);
end;

procedure TfrmConEquipAtualizaProdutosReqCompra.pSetblnSomenteItensSemOS(
  const Value: boolean);
begin
  FblnSomenteItensSemOS := Value;
  if FblnSomenteItensSemOS then
   pConfigurarTelaItemSemOS;
end;

{ TRequisicaoRecord }

constructor TRequisicaoRecord.Create(pstrCodReq: String);
begin
  Self.strCodReq := pstrCodReq;
  Self.strCodCli := EmptyStr;
  Self.strNomCli := EmptyStr;
  Self.strCodEqu := EmptyStr;
  Self.strDesEqu := EmptyStr;
  Self.strCodVen := EmptyStr;
  Self.strNomVen := EmptyStr;
  Self.strCodTec := EmptyStr;
  Self.strNomTec := EmptyStr;
  Self.strNumOSe := EmptyStr;
  Self.strEmpOSe := EmptyStr;
  Self.strNumDoc := EmptyStr;
  Self.strEspDoc := EmptyStr;
  Self.strEmpDoc := EmptyStr;
end;

{ TLogGorAlt }

class function TLogGorAlt.fGravarLogGor(pstrSeqGor: String): Boolean;
  Var
    strSql: String;
    Qry: TUniQuery;

begin
  Result := True;
  TLogGorAlt.strSeqGor := fRetAutoIncrem('LOGGOR', VS_strCodEmp);

  strSQL := strSQL + ' INSERT INTO LOGGOR (';
  strSQL := strSQL + '         AUTOINCREM, ';
  strSQL := strSQL + '         DTALOG, ';
  strSQL := strSQL + '         HORLOG, ';
  strSQL := strSQL + '         FRMLOG, ';
  strSQL := strSQL + '         FGO_NUMDOC, ';
  strSQL := strSQL + '         FGO_ESPDOC, ';
  strSQL := strSQL + '         FGO_CODEMP, ';
  strSQL := strSQL + '         FGO_CODCLI, ';
  strSQL := strSQL + '         FGO_TIPFRE, ';
  strSQL := strSQL + '         FGO_CODTRA, ';
  strSQL := strSQL + '         FGO_TOTFRE, ';
  strSQL := strSQL + '         FGO_CODCND, ';
  strSQL := strSQL + '         FGO_CONPAG, ';
  strSQL := strSQL + '         FGO_CODFPG, ';
  strSQL := strSQL + '         FGO_TOTPRO, ';
  strSQL := strSQL + '         FGO_DESESP, ';
  strSQL := strSQL + '         FGO_TOTSER, ';
  strSQL := strSQL + '         FGO_DESACE, ';
  strSQL := strSQL + '         FGO_TOTIPI, ';
  strSQL := strSQL + '         FGO_TOTRET, ';
  strSQL := strSQL + '         FGO_VLRCON, ';
  strSQL := strSQL + '         FGO_ENT_CD, ';
  strSQL := strSQL + '         FGO_OPRFLJ, ';
  strSQL := strSQL + '         OPELOG, ';
  strSQL := strSQL + '         FGO_DTAENT, ';
  strSQL := strSQL + '         FGO_SITUAC, ';
  strSQL := strSQL + '         FGO_CODPOR, ';
  strSQL := strSQL + '         FGO_CODVEN, ';
  strSQL := strSQL + '         WTSMAQ, ';
  strSQL := strSQL + '         WTS_IP) ';
  //values
  strSQL := strSQL + ' SELECT :AUTINC AS "AUTOINCREM", ';
  strSQL := strSQL + '         :DTALOG AS "DTALOG", ';
  strSQL := strSQL + '         :HORLOG AS "HORLOG", ';
  strSQL := strSQL + '         :FRMLOG AS "FRMLOG", ';
  strSQL := strSQL + '         L.FGO_NUMDOC, ';
  strSQL := strSQL + '         L.FGO_ESPDOC, ';
  strSQL := strSQL + '         L.FGO_CODEMP, ';
  strSQL := strSQL + '         L.FGO_CODCLI, ';
  strSQL := strSQL + '         L.FGO_TIPFRE, ';
  strSQL := strSQL + '         L.FGO_CODTRA, ';
  strSQL := strSQL + '         L.FGO_TOTFRE, ';
  strSQL := strSQL + '         L.FGO_CODCND, ';
  strSQL := strSQL + '         L.FGO_CONPAG, ';
  strSQL := strSQL + '         L.FGO_CODFPG, ';
  strSQL := strSQL + '         L.FGO_TOTPRO, ';
  strSQL := strSQL + '         L.FGO_DESESP, ';
  strSQL := strSQL + '         L.FGO_TOTSER, ';
  strSQL := strSQL + '         L.FGO_DESACE, ';
  strSQL := strSQL + '         L.FGO_TOTIPI, ';
  strSQL := strSQL + '         L.FGO_TOTRET, ';
  strSQL := strSQL + '         L.FGO_VLRCON, ';
  strSQL := strSQL + '         L.FGO_ENT_CD, ';
  strSQL := strSQL + '         L.FGO_OPRFLJ, ';
  strSQL := strSQL + '         :OPELOG AS OPELOG, ';
  strSQL := strSQL + '         L.FGO_DTAENT, ';
  strSQL := strSQL + '         "A" AS  FGO_SITUAC, ';
  strSQL := strSQL + '         NULL AS "FGO_CODPOR", ';
  strSQL := strSQL + '         L.FGO_CODVEN, ';
  strSQL := strSQL + '         :WTSMAQ AS WTSMAQ, ';
  strSQL := strSQL + '         :WTS_IP AS WTS_IP ';
  strSQL := strSQL + ' FROM LOGGOR L ';
  strSQL := strSQL + ' WHERE L.AUTOINCREM = :SEQGOR ';

  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSQL);

    Qry.ParamByName('AUTINC').AsString := TLogGorAlt.strSeqGor;
    Qry.ParamByName('SEQGOR').AsString := pstrSeqGor;
    Qry.ParamByName('HORLOG').AsDateTime := fTime();
    Qry.ParamByName('DTALOG').AsDateTime := VS_Date;
    Qry.ParamByName('OPELOG').AsString := strLoginUsuarioLogado;

    Qry.ParamByName('WTSMAQ').AsString := VS_WorkstationID;
    Qry.ParamByName('WTS_IP').AsString := VS_WorkStationIP;
    Try
      Qry.ExecSQL;

    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(e.message, 'untConEquipAtualizaProdutosReqCompra.'+'TLogGorAlt.fGravarLogGor');
      end;
    end;
  Finally
    If Assigned(Qry) Then
      FreeAndNil(Qry);
  End;
end;

class function TLogGorAlt.fGravarLogDor(recCodIte,
  recDesIte: TRecStringValue): Boolean;
  Type
    TEnuSituacao = (Excluisao, Inclusao);

  var
    strSQL: String;
    enuSituacao: TEnuSituacao;
    Qry: TUniQuery;
begin
  Result := True;

  strSQL := 'INSERT INTO LOGDOR (AUTOINCREM, ';
  strSQL := strSQL + '           FDO_SEQGOR, ';
  strSQL := strSQL + '           FDO_SITUAC, ';
  strSQL := strSQL + '           FDO_CODVEN, ';
  strSQL := strSQL + '           FDO_CODITE, ';
  strSQL := strSQL + '           FDO_DESCRI, ';
  strSQL := strSQL + '           FDO_UNIDAD, ';
  strSQL := strSQL + '           FDO_NUMLOT, ';
  strSQL := strSQL + '           FDO_IDEPRO, ';
  strSQL := strSQL + '           FDO_CODACA, ';
  strSQL := strSQL + '           FDO_EMPACA, ';
  strSQL := strSQL + '           FDO_PROACA, ';
  strSQL := strSQL + '           FDO_QTDITE, ';
  strSQL := strSQL + '           FDO_UNIORI, ';
  strSQL := strSQL + '           FDO_UNITAR, ';
  strSQL := strSQL + '           FDO_DESESP, ';
  strSQL := strSQL + '           FDO_VALIPI, ';
  strSQL := strSQL + '           FDO_VALRET, ';
  strSQL := strSQL + '           FDO_VLRCON, ';
  strSQL := strSQL + '           FDO_PROMOC, ';
  strSQL := strSQL + '           FDO_TABPRE, ';
  strSQL := strSQL + '           FDO_EMPITE, ';
  strSQL := strSQL + '           FDO_ENTRET, ';
  strSQL := strSQL + '           FDO_EMPCAR) ';
  //values
  strSQL := strSQL + ' SELECT  :AUTINC AS "AUTOINCREM", ';
  strSQL := strSQL + '         :SEQGOR AS "FDO_SEQGOR", ';
  strSQL := strSQL + '         :SITUAC AS "FDO_SITUAC", ';
  strSQL := strSQL + '         D.FDO_CODVEN, ';
  strSQL := strSQL + '         :CODITE AS "FDO_CODITE", ';
  strSQL := strSQL + '         :DESITE AS "FDO_DESCRI", ';
  strSQL := strSQL + '         D.FDO_UNIDAD, ';
  strSQL := strSQL + '         D.FDO_NUMLOT, ';
  strSQL := strSQL + '         D.FDO_IDEPRO, ';
  strSQL := strSQL + '         D.FDO_CODACA, ';
  strSQL := strSQL + '         D.FDO_EMPACA, ';
  strSQL := strSQL + '         D.FDO_PROACA, ';
  strSQL := strSQL + '         D.FDO_QTDITE, ';
  strSQL := strSQL + '         D.FDO_UNIORI, ';
  strSQL := strSQL + '         D.FDO_UNITAR, ';
  strSQL := strSQL + '         D.FDO_DESESP, ';
  strSQL := strSQL + '         D.FDO_VALIPI, ';
  strSQL := strSQL + '         D.FDO_VALRET, ';
  strSQL := strSQL + '         D.FDO_VLRCON, ';
  strSQL := strSQL + '         D.FDO_PROMOC, ';
  strSQL := strSQL + '         D.FDO_TABPRE, ';
  strSQL := strSQL + '         D.FDO_EMPITE, ';
  strSQL := strSQL + '         E.FDO_ENTRET, ';
  strSQL := strSQL + '         E.FDO_EMPCAR ';
  strSQL := strSQL + ' FROM FATDOR D ';

  strSQL := strSQL + ' JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM ';

  strSQL := strSQL + ' WHERE D.FDO_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '       AND D.FDO_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '       AND D.FDO_CODEMP = :CODEMP ';
  strSQL := strSQL + '       AND D.FDO_CODITE = :CODITEANT ';
  strSQL := strSQL + '       AND D.FDO_DESCRI = :DESITEANT ';
  strSQL := strSQL + ' LIMIT 1 ';

  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSQL);

    Qry.ParamByName('NUMDOC').AsString := TLogGorAlt.strNumDoc;
    Qry.ParamByName('CODEMP').AsString := TLogGorAlt.strCodEmp;
    Qry.ParamByName('ESPDOC').AsString := TLogGorAlt.strEspDoc;

    Qry.ParamByName('CODITEANT').AsString := recCodIte.strOldValue;
    Qry.ParamByName('DESITEANT').AsString := recDesIte.strOldValue;

    Qry.ParamByName('SEQGOR').AsString := TLogGorAlt.strSeqGor;
    Try
      for enuSituacao in [Excluisao.. Inclusao] do
      begin
        Qry.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGDOR', VS_strCodEmp);
        Qry.ParamByName('SITUAC').AsString := ifthen(enuSituacao = Excluisao, 'E','I');
        Qry.ParamByName('CODITE').AsString := ifthen(enuSituacao = Excluisao, recCodIte.strOldValue, recCodIte.strValue);
        Qry.ParamByName('DESITE').AsString := ifthen(enuSituacao = Excluisao, recDesIte.strOldValue, recDesIte.strValue);
        Qry.ExecSQL;
      end;
    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(e.message, 'untConEquipAtualizaProdutosReqCompra.'+'TLogGorAlt.fGravarLogDor');
        Exit;
      end;
    End;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

class function TLogGorAlt.fGravarLogGor(pstrNumDoc, pstrEspDoc,
  pstrCodEmp: String): Boolean;
  Var
    strSql: String;
    Qry: TUniQuery;
begin
  Result := False;
  TLogGorAlt.strNumDoc := pstrNumDoc;
  TLogGorAlt.strEspDoc := pstrEspDoc;
  TLogGorAlt.strCodEmp := pstrCodEmp;


  strSQL := strSQL + ' SELECT G.AUTOINCREM, ';
  strSQL := strSQL + '        (CAST(CONCAT(DTALOG," ",HORLOG) AS DATETIME)) AS TMP_DTAHRA ';
  strSQL := strSQL + ' FROM LOGGOR G ';
  strSQL := strSQL + ' WHERE FGO_NUMDOC = :NUMDOC AND FGO_ESPDOC = :ESPDOC AND FGO_CODEMP = :CODEMP AND FGO_SITUAC IN ("A","I") ';
  strSQL := strSQL + ' ORDER BY  TMP_DTAHRA DESC LIMIT 1 ';

  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSQL);
    Qry.ParamByName('NUMDOC').AsString := Self.strNumDoc;
    Qry.ParamByName('ESPDOC').AsString := Self.strEspDoc;
    Qry.ParamByName('CODEMP').AsString := Self.strCodEmp;
    Qry.Open;

    if Qry.IsEmpty then
      Exit
    else
      Qry.First;

    TLogGorAlt.strSeqGorAnt := Qry.FieldByName('AUTOINCREM').AsString;
    Result := TLogGorAlt.fGravarLogGor(TLogGorAlt.strSeqGorAnt);

  Finally
    if Not Result then
    begin
      TLogGorAlt.strSeqGorAnt :=  EmptyStr;
      TLogGorAlt.strSeqGor := EmptyStr;
    end;
    If Assigned(Qry) Then
      FreeAndNil(Qry);
  End;

end;


{ TStringValueRecord }

class operator TStringValueRecord.implicit(Value: String): TStringValueRecord;
begin
  Result.strOldValue := Result.strValue;
  Result.strValue := Value;
end;

end.

