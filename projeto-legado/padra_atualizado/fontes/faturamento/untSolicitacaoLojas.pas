unit untSolicitacaoLojas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB, Grids,
  DBGridCitel, DBGrids, UniClientDataSet, Uni, untSolicitacaoTE, untCadLote, untTypesSistema,
  BitBtnLockedIncrem, StrUtils, frxClass, frxExportCSVTestabilidade, untLiberacao,
  untMsgLiberacao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TRecAnterior = Record
    intRecNo : Integer;
    strCodIte,
    strCodEmp,
    strNumLot: String;
    fltQtdIte: Double;
  End;

  TfrmSolicitacaoLojas = class(TfrmPai)
    dtsItens: TDataSource;
    btnConfirma: TBitBtnLocked;
    dtsUsado: TDataSource;
    pnlIteSld: TPanel;
    chkIteSld: TCheckBox;
    shpSemSaldo: TShape;
    lblSemSaldo: TLabel;
    shpComSaldo: TShape;
    lblComSaldo: TLabel;
    btnAltEmp: TBitBtnLocked;
    dtsEstoque: TDataSource;
    dbgItensLojaDBTableViewCitel: TcxGridDBTableViewCitel;
    dbgItensLojaLevel1: TcxGridLevel;
    dbgItensLoja: TcxGridCitel;
    CODITE: TcxGridDBColumn;
    CODGRU: TcxGridDBColumn;
    DESCRI: TcxGridDBColumn;
    NUMLOT: TcxGridDBColumn;
    QTDITE: TcxGridDBColumn;
    CODEMP: TcxGridDBColumn;
    LOTABA: TcxGridDBColumn;
    SALLOC: TcxGridDBColumn;
    SALOUT: TcxGridDBColumn;
    dbgEstoqueDBTableViewCitel: TcxGridDBTableViewCitel;
    dbgEstoqueLevel1: TcxGridLevel;
    dbgEstoque: TcxGridCitel;
    EMP_NOMEMP: TcxGridDBColumn;
    ITE_SALDOS: TcxGridDBColumn;
    ITE_SAL_ML: TcxGridDBColumn;
    ITE_SALRES: TcxGridDBColumn;
    ITE_SALREG: TcxGridDBColumn;
    ITE_SALEXT: TcxGridDBColumn;
    ITE_SALDIS: TcxGridDBColumn;
    ITE_ENTFUT: TcxGridDBColumn;
    TEMSLD: TcxGridDBColumn;
    lblEmNegritoSubProdutos: TLabel;
    lblEmNegrito: TLabel;
    ITESUB: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkIteSldClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAltEmpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgItensLojaDBTableViewCitelEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure dbgItensLojaDBTableViewCitelCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    recAnteri: TRecAnterior;
    objCadLot: TCadLot;
    blnSaiTsl: Boolean;
    strNTrava: String;
    blnSenha: Boolean;
    strOpcTra: String;
    blnTravaSemPedirSenha: Boolean;
    qryEstoque: TUniQuery;
    objLiberacao : TLiberacao;

    Function fVerificaLojas: Boolean;

    Function fFaltaSaldoLoja(    strCodIte,
                                 strCodEmp,
                                 strNumLot: String;
                                 fltQtdAnt,
                                 fltQtdIte: Double;
                             Var fltSaldos,
                                 fltQtdUsa: Double;
                                 blnValidaQtdUsa : Boolean = True): Boolean;

    Function fGetSaldoLoja(strCodIte, strCodEmp, strNumLot: String): Double;

    procedure pCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    function fTravar(blnTemSld: Boolean): Boolean;
    function fRetornaEmpresaItens: String;
    function fSenhaLiberaProdutosAbastecimento: Boolean;
    function fRetCodItens(): String;
    function fRetSqlEstoque(): String;
    procedure pProcessaEstoque();
    procedure pCarregaSaldosEmpresas();
  public
    { Public declarations }
    objSoliTE: TSolicitacaoTE;

    procedure pItensLojaBeforePost(DataSet: TDataSet);
    procedure pItensLojaBeforeEdit(DataSet: TDataSet);
    procedure pItensLojaAfterInsert(DataSet: TDataSet);
    procedure pItensLojaAfterScroll(DataSet: TDataSet);
  end;

implementation

uses untFuncFat, untFuncoesSimples, untConsultas, untSelecionaEmpresaTE,
     untConsultaLoteEmp, untIFatReservaSaldo, untTFatReservaSaldo,
     untIFatEntregaFutura, untTFatEntregaFutura;

{$R *.dfm}

procedure TfrmSolicitacaoLojas.pCarregaSaldosEmpresas;
begin
  qryEstoque.SQL.Text := fRetSqlEstoque();
  qryEstoque.Open;

  (qryEstoque.FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
  (qryEstoque.FieldByName('ITE_SAL_ML') As TFloatField).DisplayFormat := '#,###0.000';
  (qryEstoque.FieldByName('ITE_SALRES') As TFloatField).DisplayFormat := '#,##0.000';
  (qryEstoque.FieldByName('ITE_SALREG') As TFloatField).DisplayFormat := '#,##0.000';
  (qryEstoque.FieldByName('ITE_SALEXT') As TFloatField).DisplayFormat := '#,##0.000';
  (qryEstoque.FieldByName('ITE_SALDIS') As TFloatField).DisplayFormat := '#,##0.000';
  (qryEstoque.FieldByName('ITE_ENTFUT') As TFloatField).DisplayFormat := '#,##0.000';

  pSetaClient(qryEstoque);
  pProcessaEstoque();
end;

procedure TfrmSolicitacaoLojas.pCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  Try
    Key := #0;

    frmConsultaLoteEmp := TfrmConsultaLoteEmp.Create(Nil);
    frmConsultaLoteEmp.strCodIte := dtsItens.DataSet.FieldByName('CODITE').AsString;
    If (dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex = LOTABA.Index) Then
      frmConsultaLoteEmp.strEmpLoct := dtsItens.DataSet.FieldByName('CODEMP').AsString;
    frmConsultaLoteEmp.blnUtiEmpAce := True;
    frmConsultaLoteEmp.cxgConsultaView.Bands[1].Visible := fExisteLote(dtsItens.DataSet.FieldByName('CODITE').AsString,
                                                                       dtsItens.DataSet.FieldByName('CODEMP').AsString);
    frmConsultaLoteEmp.ShowModal;

    If (dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex <> CODEMP.Index) And
       (fEmptyStr(dtsItens.DataSet.FieldByName('CODEMP').AsString)) Then
    Begin
      dbgItensLojaDBTableViewCitel.Columns[CODEMP.Index].Focused := True;
      dbgItensLojaDBTableViewCitel.Controller.EditingController.ShowEdit();
    End;

    If (Not fEmptyStr(frmConsultaLoteEmp.strCodEmp + frmConsultaLoteEmp.strLotAba)) Then
    Begin
      If Not (dtsItens.DataSet.State = dsEdit) Then
        dtsItens.DataSet.Edit;

      If Not fEmptyStr(frmConsultaLoteEmp.strCodEmp) Then
        dtsItens.DataSet.FieldByName('CODEMP').AsString := frmConsultaLoteEmp.strCodEmp;

      If Not fEmptyStr(frmConsultaLoteEmp.strLotAba) Then
        dtsItens.DataSet.FieldByName('LOTABA').AsString := frmConsultaLoteEmp.strLotAba;

      dtsItens.DataSet.Post;
    End;
  Except
    On E: Exception Do
	    pMensagensErro(E.Message,'[TfrmSolicitacaoLojas.pCodEmpresaKeyPress]');
  End;

  pFreeAndNil(frmConsultaLoteEmp);
end;

procedure TfrmSolicitacaoLojas.chkIteSldClick(Sender: TObject);
begin
  inherited;
  try
    dtsEstoque.DataSet.DisableControls;

    If TCheckBox(Sender).Checked Then
    Begin
      dtsItens.DataSet.Filter := 'TEMSLD = FALSE';
      dtsItens.DataSet.Filtered := True;
    End
    Else
    Begin
      dtsItens.DataSet.Filter := '';
      dtsItens.DataSet.Filtered := False;
    End;
  finally
    dtsEstoque.DataSet.EnableControls;
  end;
end;

Function TfrmSolicitacaoLojas.fGetSaldoLoja(strCodIte, strCodEmp, strNumLot: String): Double;
  Var
    qryGen: TUniQuery;
Begin

  Try
    If Not fEmptyStr(strNumLot) Then
    Begin
      Result := objCadLot.fSaldoLote(strCodIte, strCodEmp, strNumLot);
    End
    Else
    Begin
      qryGen := fCriaQuery;

      With qryGen, SQL Do
      Begin

        Clear;
        Add('SELECT ITE_SALDOS FROM ITEGER');
        Add('WHERE ITE_CODITE = :CODITE AND');
        Add('      ITE_CODEMP = :CODEMP');

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        If IsEmpty Then
          Result := 0
        Else
          Result := FieldByName('ITE_SALDOS').AsFloat;
      End;

      FreeAndNil(qryGen);
    End;

    If fUsaQtdPendenteEntregaFutura Then
      Result := Result + TEntregaFutura.New(
                           TParamEF.New()
                             .CodIte(strCodIte)
                             .CodEmp(strCodEmp)
                             .Lote(strNumLot)
                             .Faturamento(True)
                           ).Total();

    Result := Result - TSaldoReservado.New(
                         TReservaParametros.New()
                           .EmpresaItem(strCodEmp)
                           .CodigoItem(strCodIte)
                           .CodEmpresa(strCodEmp)
                           .NumeroLote(strNumLot)
                         ).fGetQuantidade();
  Except

    On E: Exception Do
    Begin
      Result := 0;
			pMensagensErro(E.Message,'[TfrmSolicitacaoLojas.fGetSaldoLoja]');
    End;

  End;

End;

Function TfrmSolicitacaoLojas.fFaltaSaldoLoja(    strCodIte,
                                                  strCodEmp,
                                                  strNumLot: String;
                                                  fltQtdAnt,
                                                  fltQtdIte: Double;
                                              Var fltSaldos,
                                                  fltQtdUsa: Double;
                                                  blnValidaQtdUsa : Boolean = True): Boolean;
Begin

  If (blnValidaQtdUsa) Then
    fltQtdUsa := objSoliTE.fJaUtilizado(strCodIte, strCodEmp, strNumLot)
  Else
    fltQtdUsa := 0;

  fltSaldos := fGetSaldoLoja(strCodIte, strCodEmp, strNumLot);
  Result := (fltSaldos - fltQtdUsa) < (fltQtdIte - fltQtdAnt);

End;

procedure TfrmSolicitacaoLojas.pItensLojaAfterInsert(DataSet: TDataSet);
Begin
  DataSet.Cancel;
End;

procedure TfrmSolicitacaoLojas.pItensLojaAfterScroll(DataSet: TDataSet);
begin

  qryEstoque.DisableControls;
  try
    qryEstoque.Filtered := False;
    qryEstoque.Filter := 'ITE_CODITE = ' + QuotedStr(DataSet.FieldByName('CODITE').AsString);
    qryEstoque.Filtered := True;
  finally
    qryEstoque.EnableControls;
  end;

  If qryEstoque.Active Then
  Begin
    If qryEstoque.FieldByName('ITE_CNV_ML').AsFloat <= 0 Then
    Begin
      dbgEstoqueDBTableViewCitel.Columns[2].Visible := False;
      dbgEstoqueDBTableViewCitel.Columns[1].Width := 90;
      dbgEstoqueDBTableViewCitel.Columns[5].Width := 120;
      dbgEstoqueDBTableViewCitel.Columns[6].Width := 120;
    End
    Else
    Begin
      dbgEstoqueDBTableViewCitel.Columns[2].Visible := True;
      dbgEstoqueDBTableViewCitel.Columns[1].Width := 60;
      dbgEstoqueDBTableViewCitel.Columns[5].Width := 90;
      dbgEstoqueDBTableViewCitel.Columns[6].Width := 90;
    End;
  End;
end;

procedure TfrmSolicitacaoLojas.pItensLojaBeforeEdit(DataSet: TDataSet);
Begin
  With DataSet, recAnteri Do
  Begin
    intRecNo  := RecNo;
    strCodIte := FieldByName('CODITE').AsString;
    strCodEmp := FieldByName('CODEMP').AsString;
    strNumLot := FieldByName('LOTABA').AsString;
    fltQtdIte := FieldByName('QTDITE').AsFloat;
  End;
End;

procedure TfrmSolicitacaoLojas.pItensLojaBeforePost(DataSet: TDataSet);
  Var
    fltSaldos,
    fltQtdAnt,
    fltQtdUsa: Double;
    strMensag: String;
    strLotUti: String;
    intColEmp,
    intColLot: Integer;
    blnRealizaValidacao: Boolean;
    blnSomaAndSubt: Boolean;
    blnLoteIgual: Boolean;

    procedure pEnabledControls;
    Begin
      While DataSet.ControlsDisabled Do
        DataSet.EnableControls;
    End;
begin
  inherited;

  With DataSet Do
  Begin
    intColLot := LOTABA.Index;
    intColEmp := CODEMP.Index;

    If fEmptyStr(FieldByName('CODEMP').AsString) Then
      FieldByName('CODEMP').Clear;

    If (fEmptyStr(FieldByName('CODEMP').AsString) And
       fEmptyStr(FieldByName('LOTABA').AsString)) Or
       ((State = dsEdit) And (ModalResult <> mrOK)) Then
      FieldByName('INFLOT').AsString := 'N';

    If (Not fEmptyStr(FieldByName('CODEMP').AsString)) Then
      FieldByName('CODEMP').AsString := fStrZero(FieldByName('CODEMP').AsString,3);

    If (Not fExisteLote(FieldByName('CODITE').AsString,
                        FieldByName('CODEMP').AsString)) Then
      FieldByName('LOTABA').Clear;

    If (Not fEmptyStr(FieldByName('CODEMP').AsString)) And
       fEmptyStr(fRetNomeEmpresa(FieldByName('CODEMP').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa não cadastrada.', ['&Ok']);
      pSetFocus(dbgItensLoja);
      dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intColEmp;
      pEnabledControls;
      Cancel;
      Abort;
      Exit;
    End

    Else If (Not fEmptyStr(FieldByName('CODEMP').AsString)) And
       (Pos(FieldByName('CODEMP').AsString, strEmpAcessoUsuarioLogado) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Operador não possui acesso à empresa informada.', ['&Ok']);
      pSetFocus(dbgItensLoja);
      dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intColEmp;
      pEnabledControls;
      Cancel;
      Abort;
      Exit;
    End

    Else If fEmptyStr(FieldByName('CODEMP').AsString) And (fTravar(FieldByName('TEMSLD').AsBoolean)) Then
    Begin
      fMensagem('ATENÇÃO!', Format('Informe a Loja que fornecerá o item [%s].', [FieldByName('CODITE').AsString]), ['&OK']);
      pSetFocus(dbgItensLoja);
      dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intColEmp;
      pEnabledControls;
      Cancel;
      Abort;
      Exit;
    End

    Else If (Not fEmptyStr(FieldByName('CODEMP').AsString)) And
            (Not fEmptyStr(FieldByName('NUMLOT').AsString)) And
            (Not fEmptyStr(FieldByName('LOTABA').AsString)) And
            (Not fExisteLote(FieldByName('LOTABA').AsString,
                             FieldByName('CODITE').AsString,
                             FieldByName('CODEMP').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', IIF(fCfgSis('CTLEST', VarString, FieldByName('CODEMP').AsString) = '1', 'Lote', 'Armazém') + ' não cadastrado.', ['&Ok']);
      pSetFocus(dbgItensLoja);
      dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intColLot;
      pEnabledControls;
      Cancel;
      Abort;
      Exit;
    End

    Else If (Not fEmptyStr(FieldByName('CODEMP').AsString)) And
            (fExisteLote(FieldByName('CODITE').AsString,
                         FieldByName('CODEMP').AsString))   And
             fEmptyStr(FieldByName('LOTABA').AsString)      And
             (FieldByName('INFLOT').AsString = 'S')         And
            (fTravar(FieldByName('TEMSLD').AsBoolean))      Then
    Begin
      fMensagem('ATENÇÃO!', Format('Informe o ' + IIF(fCfgSis('CTLEST', VarString, FieldByName('CODEMP').AsString) = '1', 'Lote', 'Armazém') + ' que fornecerá o item [%s].', [FieldByName('CODITE').AsString]), ['&OK']);
      pSetFocus(dbgItensLoja);
      dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intColLot;
      pEnabledControls;
      Cancel;
      Abort;
      Exit;
    End

    Else If (Not fEmptyStr(FieldByName('CODEMP').AsString)) And
            (Not fPermiteTransfEntreEmps(FieldByName('CODEMP').AsString, VS_strCodEmp)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A empresa '+FieldByName('CODEMP').AsString+' não permite transferência de estoque.'+#13+
                            'Verificar nas configurações de "Transferência de Estoque" no "Cadastro de Empresa"', ['&Ok']);
      pSetFocus(dbgItensLoja);
      dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intColEmp;
      pEnabledControls;
      Cancel;
      Abort;
      Exit;
    End

{    Else If FieldByName('CODEMP').AsString = VS_strCodEmp Then
    Begin
      fMensagem('ATENÇÃO!', 'A Loja que fornecerá o item não pode ser a loja corrente.', ['&Ok']);
      pSetFocus(dbgItensLoja);
      Cancel;
      Abort;
      Exit;
    End}

    Else
    Begin
      With recAnteri Do
      Begin
        blnLoteIgual := IIF(fEmptyStr(FieldByName('NUMLOT').AsString), True,
                        IIF((strNumLot = FieldByName('LOTABA').AsString), True, False));

        If (intRecNo = RecNo) And (strCodEmp = FieldByName('CODEMP').AsString) And blnLoteIgual Then
          fltQtdAnt := fltQtdIte
        Else
          fltQtdAnt := 0;
      End;

      strLotUti := IIF(Not fEmptyStr(FieldByName('LOTABA').AsString), FieldByName('LOTABA').AsString, '');

      blnRealizaValidacao := (Not fEmptyStr(FieldByName('CODEMP').AsString)) And
                             (IIF(fEmptyStr(FieldByName('NUMLOT').AsString), True, Not fEmptyStr(strLotUti)));

      blnSomaAndSubt := IIF(fEmptyStr(FieldByName('NUMLOT').AsString), True,
                        IIF(Not fEmptyStr(FieldByName('LOTABA').AsString), True, False));

      If blnRealizaValidacao And
        fFaltaSaldoLoja(FieldByName('CODITE').AsString,
                        FieldByName('CODEMP').AsString,
                        strLotUti,
                        fltQtdAnt,
                        FieldByName('QTDITE').AsFloat + IIF((FieldByName('CODEMP').AsString = VS_strCodEmp) And (FieldByName('SALLOC').AsFloat > 0), FieldByName('SALLOC').AsFloat, 0),
                        fltSaldos,
                        fltQtdUsa) Then
      Begin
        If (Pos(strOpcTra, 'T_A_') > 0) And (blnTravaSemPedirSenha) Then
        Begin
          strMensag := 'Saldo de estoque do item ' +
                       FieldByName('CODITE').AsString + '-' + FieldByName('DESCRI').AsString + ', na Loja ' +
                       FieldByName('CODEMP').AsString + ' = ' + FloatToStrF(fltSaldos, ffFixed, 12, 2);

          If Not fEmptyStr(strLotUti) Then
            strMensag := strMensag + #13#10 + objCadLot.strTitLab + ': ' + strLotUti;

          If fltQtdUsa > 0 Then
            strMensag := strMensag + #13#10 + 'Saldo já utilizado: ' + FloatToStrF(fltQtdUsa, ffFixed, 12, 2);

          If blnTravaSemPedirSenha Then
            fMensagem('', strMensag, ['&Ok']);

          pSetFocus(dbgItensLoja);
          dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intColEmp;
          pEnabledControls;

          Cancel;
          Abort;
          Exit;
        End
        Else If (Pos(strOpcTra, 'T_A_') > 0) And (Not blnTravaSemPedirSenha) Then
        Begin
          If blnRealizaValidacao Then
          Begin
            With recAnteri Do
              objSoliTE.pSubtUtilizado(strCodIte,
                                       strCodEmp,
                                       strNumLot,
                                       fltQtdIte,
                                       blnSomaAndSubt);

            objSoliTE.pSomaUtilizado(FieldByName('CODITE').AsString,
                                     FieldByName('CODEMP').AsString,
                                     strLotUti,
                                     FieldByName('QTDITE').AsFloat,
                                     blnSomaAndSubt);
          End;
        End;
      End
      Else
      Begin
        If blnRealizaValidacao Then
        Begin
          With recAnteri Do
            objSoliTE.pSubtUtilizado(strCodIte,
                                     strCodEmp,
                                     strNumLot,
                                     fltQtdIte,
                                     blnSomaAndSubt);

          objSoliTE.pSomaUtilizado(FieldByName('CODITE').AsString,
                                   FieldByName('CODEMP').AsString,
                                   strLotUti,
                                   FieldByName('QTDITE').AsFloat,
                                   blnSomaAndSubt);
        End;
      End;
    End;

    FieldByName('INFLOT').AsString := 'S';
  End;

end;

function TfrmSolicitacaoLojas.fRetCodItens: String;
var
  intRecNo: Integer;
begin
  With dtsItens.DataSet Do
  Begin
    Result := '';
    DisableControls;
    intRecNo := RecNo;
    First;
    Try
      While Not Eof Do
      Begin
        If Not fEmptyStr(Result) then
          Result := Result + ',';

        Result := Result + QuotedStr(FieldByName('CODITE').AsString);

        Next;
      End;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;

end;

function TfrmSolicitacaoLojas.fRetornaEmpresaItens: String;
begin
  Result := '';
  Try
    pCriarFormularios(TfrmSelecionaEmpresaTE, frmSelecionaEmpresaTE);
    frmSelecionaEmpresaTE.Caption := 'Selecione a Empresa dos Itens (Geral)';
    frmSelecionaEmpresaTE.blnEmpLog := True;
    frmSelecionaEmpresaTE.ShowModal;
    If (frmSelecionaEmpresaTE.ModalResult = mrOk) Then
      Result := frmSelecionaEmpresaTE.strEmp_TE;
  Except
    On E: Exception Do
    Begin
      Result := '';
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmSelecionaEmpresaTE);
end;

function TfrmSolicitacaoLojas.fRetSqlEstoque: String;
begin
  Result := '';
  Result := Result + 'SELECT                           ';
  Result := Result + '  E.EMP_CODEMP,                  ';
  Result := Result + '  G.ITE_CODITE,                  ';
  Result := Result + '  C.ITE_CNV_ML,                  ';
  Result := Result + '  CONCAT(                        ';
  Result := Result + '    E.EMP_CODEMP,                ';
  Result := Result + '    "-",                         ';
  Result := Result + '    E.EMP_NOMFAN                 ';
  Result := Result + '  ) AS EMP_NOMEMP,               ';
  Result := Result + '  G.ITE_SALDOS,                  ';
  Result := Result + '  G.ITE_SAL_ML,                  ';
  Result := Result + '  0.00 AS ITE_SALRES,            ';
  Result := Result + '  0.00 AS ITE_SALREG,            ';
  Result := Result + '  0.00 AS ITE_SALEXT,            ';
  Result := Result + '  0.00 AS ITE_SALDIS,            ';
  Result := Result + '  0.00 AS ITE_ENTFUT             ';
  Result := Result + 'FROM                             ';
  Result := Result + '  ITEGER G                       ';
  Result := Result + 'INNER JOIN CADITE C              ';
  Result := Result + '  ON C.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + 'INNER JOIN CADEMP E              ';
  Result := Result + '  ON E.EMP_CODEMP = G.ITE_CODEMP ';
  Result := Result + 'WHERE G.ITE_CODITE IN (' + fRetCodItens() + ')';
  Result := Result + ' AND LOCATE(E.EMP_CODEMP, '+QuotedStr(strEmpAcessoUsuarioLogado)+') > 0 ';
end;

function TfrmSolicitacaoLojas.fSenhaLiberaProdutosAbastecimento: Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    intRecNo: Integer;
    intTamCodIte: Integer;
Begin
  If Not fCfgSis('LIBABS', varBoolean) Then
  Begin
    Result := True;
    Exit
  End;

  intTamCodIte := fTamCodIte+1;
   
  With dtsItens.DataSet Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    First;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Itens que foram solicitados as lojas para realizar o abastecimento');
    objLiberacao.objMsgLibera.pAddQuebra;

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Código'                           , intTamCodIte , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Grupo'                            , 6  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Descrição'                        , 32 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , objCadLot.strTitLab + ' do Produto', 30 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'Quantidade'                       , 10 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Loja Transf.'                     , 11 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , objCadLot.strTitLab + ' Transf.'   , 30 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    While Not Eof Do
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Código'                           , FieldByName('CODITE').AsString                             , intTamCodIte , alEsquerda );
      objLinha.pAddColuna('Grupo'                            , FieldByName('CODGRU').AsString                             , 6  , alEsquerda );
      objLinha.pAddColuna('Descrição'                        , FieldByName('DESCRI').AsString                             , 32 , alEsquerda );
      objLinha.pAddColuna(objCadLot.strTitLab + ' do Produto', FieldByName('NUMLOT').AsString                             , 30 , alCentro   );
      objLinha.pAddColuna('Quantidade'                       , FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 10, 2) , 10 , alDireita  );
      objLinha.pAddColuna('Loja Transf.'                     , FieldByName('CODEMP').AsString                             , 11 , alDireita  );
      objLinha.pAddColuna(objCadLot.strTitLab + ' Transf.'   , FieldByName('LOTABA').AsString                             , 30 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'SENABA';
    objLiberacao.strSenLib := fCfgSis('SENABA');
    objLiberacao.strMsgSen := 'Liberação de abastecimento';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result :=  objLiberacao.fLibera;
  End;
end;

function TfrmSolicitacaoLojas.fTravar(blnTemSld: Boolean): Boolean;
begin
  Result := Not blnTemSld;
end;

Function TfrmSolicitacaoLojas.fVerificaLojas: Boolean;
Var
  fltSaldos,
  fltQtdUsa  : Double;
  strLotUti  : String;
  objTabela  : TRegistroMsgLiberaTabela;
  objLinha   : TLinhaMsgLibera;
  intAgrupador : Integer;
  intTamCodIte: Integer;
Begin
  Result := TRUE;

  With dtsItens.DataSet Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('TRAVOU').AsBoolean:=False;
      Post;

      If fEmptyStr(FieldByName('CODEMP').AsString) And (fTravar(FieldByName('TEMSLD').AsBoolean)) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Informe a Loja que fornecerá o item [%s].', [FieldByName('CODITE').AsString]), ['&OK']);
        Result := FALSE;
        Break;
      End;
      Next;
    End;
    First;
    EnableControls;
  End;

  intTamCodIte := fTamCodIte+1;

  If (Result) And (Not blnTravaSemPedirSenha) Then
  Begin

    With dtsItens.DataSet Do
    Begin
      DisableControls;
      First;


      objLiberacao.Clear;
      objTabela := TRegistroMsgLiberaTabela.Create;
      intAgrupador := -1;
      While Not Eof Do
      Begin
        If fTravar(FieldByName('TEMSLD').AsBoolean) Then
        Begin

          strLotUti := IIF(Not fEmptyStr(FieldByName('LOTABA').AsString), FieldByName('LOTABA').AsString, '');

          If fFaltaSaldoLoja(FieldByName('CODITE').AsString,
                             FieldByName('CODEMP').AsString,
                             strLotUti,
                             0,
                             FieldByName('QTDITE').AsFloat + IIF((FieldByName('CODEMP').AsString = VS_strCodEmp) And (FieldByName('SALLOC').AsFloat > 0), FieldByName('SALLOC').AsFloat, 0),
                             fltSaldos,
                             fltQtdUsa,
                             False) Then
          Begin
            If objTabela.isEmpty Then
            Begin
              objLiberacao.objMsgLibera.pAddTexto('ITENS SEM SALDO NA SOLICITAÇÃO ENTRE LOJAS');
              objLiberacao.objMsgLibera.pAddTextoCaption('EMP. SOLICITANTE', Copy(VS_strCodEmp+' - '+fRetNomeEmpresaSelec(VS_strCodEmp),1,50));
              objLiberacao.objMsgLibera.pAddQuebra;

              objLinha  := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlCabecalho;
              objLinha.pAddColuna(''  , 'CÓD.'                 , intTamCodIte    , alEsquerda , teAutcom);
              objLinha.pAddColuna(''  , 'DESCRIÇÃO'            , 35 , alEsquerda , teAutcom);
              objLinha.pAddColuna(''  , 'QTDE. À LIBE.'        , 15 , alDireita  , teAutcom);
              objLinha.pAddColuna(''  , 'EMPRESA ABASTECEDORA' , 25 , alEsquerda , teAutcom);
              objLinha.pAddColuna(''  , 'SALDO EMP. ABAST.'    , 17 , alDireita  , teAutcom);
              objTabela.lstLinhas.Add(objLinha);

            End;

            inc(intAgrupador);

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.intAgrupador := intAgrupador;
            objLinha.pAddColuna('CÓD.'                 , FieldByName('CODITE').AsString                                                            , intTamCodIte  , alEsquerda );
            objLinha.pAddColuna('DESCRIÇÃO'            , FieldByName('DESCRI').AsString                                                            , 35 , alEsquerda );
            objLinha.pAddColuna('QTDE. À LIBE.'        , FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2)                                , 15 , alDireita  );
            objLinha.pAddColuna('EMPRESA ABASTECEDORA' , FieldByName('CODEMP').AsString+' - '+fRetNomeEmpresaSelec(FieldByName('CODEMP').AsString) , 25 , alEsquerda );
            objLinha.pAddColuna('SALDO EMP. ABAST.'    , FloatToStrF(fltSaldos, ffFixed, 12, 2)                                                    , 17 , alDireita  );
            objTabela.lstLinhas.Add(objLinha);


            If Not fEmptyStr(strLotUti) Then
            begin
              objLinha  := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.intAgrupador := intAgrupador;
              objLinha.pAddColuna(objCadLot.strTitLab, strLotUti,  105  , alCentro);
              objTabela.lstLinhas.Add(objLinha);
            end;

            Edit;
            FieldByName('TRAVOU').AsBoolean:=True;
            Post;
          End;
        End;

        Next;
      End;

      If objTabela.isEmpty Then
        FreeAndNil(objTabela)
      else
      Begin

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        objLiberacao.strDirAce := 'LBSDVN';
        objLiberacao.blnTraTel := (strOpcTra = 'T');
        objLiberacao.strSenLib := fCfgSisL('SESDVN');
        objLiberacao.strMsgSen := 'Liberação de produto sem saldo - Venda Normal';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;

        If Result Then
        Begin
          First;

          While Not Eof Do
          Begin
            If (FieldByName('TRAVOU').AsBoolean) Then
            Begin
               objSoliTE.pSomaUtilizado(FieldByName('CODITE').AsString,
                                        FieldByName('CODEMP').AsString,
                                        strLotUti,
                                        FieldByName('QTDITE').AsFloat,
                                        True);
            End;

            Next;

          End;

        End
        Else
        Begin
          pSetFocus(dbgItensLoja);
          dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := CODEMP.Index;
        End;
      End;

      First;
      EnableControls;
    End;
  End;

End;

procedure TfrmSolicitacaoLojas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItensLoja);
end;

procedure TfrmSolicitacaoLojas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If dtsItens.DataSet.State = dsEDit Then
      dtsItens.DataSet.Post;

    If Not fVerificaLojas Then
      Action := caNone
    Else If Not fSenhaLiberaProdutosAbastecimento Then
      Action := caNone;
  End;

end;

procedure TfrmSolicitacaoLojas.dbgItensLojaDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (blnSaiTsl) Then
  Begin
    if not dbgItensLojaDBTableViewCitel.DataController.DataSource.DataSet.Active then
      Exit;

    if dbgItensLojaDBTableViewCitel.DataController.Values[AViewInfo.GridRecord.RecordIndex, TEMSLD.Index] then
      ACanvas.Font.Color := clBlue
    else
      ACanvas.Font.Color := clRed;

  End;

  If dbgItensLojaDBTableViewCitel.DataController.Values[AViewInfo.GridRecord.RecordIndex, ITESUB.Index] = 'S' Then
    ACanvas.Font.Style := [fsBold];

end;

procedure TfrmSolicitacaoLojas.dbgItensLojaDBTableViewCitelEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  strKey: string;
begin
  If fCheckParent(ActiveControl, dbgItensLoja) Then 
  Begin
    inherited;

    If fEntraCons(Key) Then
    Begin
      dbgItensLojaDBTableViewCitel.GetColumnByFieldName(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name).Focused := True;
      dbgItensLojaDBTableViewCitel.Controller.EditingController.ShowEdit();

      pCodEmpresaKeyPress(Sender, Key);

      dbgItensLojaDBTableViewCitel.GetColumnByFieldName(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name).Focused := True;
      dbgItensLojaDBTableViewCitel.Controller.EditingController.ShowEdit();
    End
    Else
    Begin
      If (dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex = LOTABA.Index) And
         (fEmptyStr(dbgItensLojaDBTableViewCitel.DataController.DataSource.DataSet.FieldByName('NUMLOT').AsString)) Then
        Key := #0
      Else
      Begin
        strKey := Key;
        strKey := AnsiUpperCase(strKey);
        Key    := strKey[1];
      End;
    End;
  End;
end;

procedure TfrmSolicitacaoLojas.FormShow(Sender: TObject);
begin
  inherited;
  dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := CODEMP.Index;

  strNTrava := 'NNNNNNNNNNNNNNNNNNNN';
  blnSenha  := fCfgSisL('SOLSTE', varBoolean);
  strOpcTra := fCfgSisL('TRASTE', VarString );

  blnTravaSemPedirSenha := (Not blnSenha) And (strOpcTra = 'T');
  pCarregaSaldosEmpresas();
  pItensLojaAfterScroll(dtsItens.DataSet);
end;

procedure TfrmSolicitacaoLojas.FormCreate(Sender: TObject);
begin
  inherited;

  blnSaiTsl := (fCfgSis('SAITSL') = '2');

  With recAnteri Do
  Begin
    intRecNo  := -1;
    strCodIte := '';
    strCodEmp := '';
    strNumLot := '';
    fltQtdIte := 0;
  End;

  objCadLot := TCadLot.Create(Self);
  objLiberacao := TLiberacao.Create;

  NUMLOT.Caption := objCadLot.strTitLab + ' do Produto';
  LOTABA.Caption := objCadLot.strTitLab + ' Abast.';
  btnAltEmp.Visible := blnSaiTsl;

  chkIteSld.Visible   := blnSaiTsl;
  shpSemSaldo.Visible := blnSaiTsl;
  lblSemSaldo.Visible := blnSaiTsl;
  shpComSaldo.Visible := blnSaiTsl;
  lblComSaldo.Visible := blnSaiTsl;

  qryEstoque := fCriaQuery(Self);
  dtsEstoque.DataSet := qryEstoque;

  dbgEstoqueDBTableViewCitel.Columns[5].Visible := fCfgSis('ESTEXT', varBoolean);
end;

procedure TfrmSolicitacaoLojas.FormDestroy(Sender: TObject);
begin
  If Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;

end;

procedure TfrmSolicitacaoLojas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: If dtsItens.DataSet.State = dsEdit Then
                 dtsItens.DataSet.Cancel
               Else
                 Close;
    VK_RETURN: Begin
                 If Not (dtsItens.DataSet.State = dsEdit) Then
                   dtsItens.DataSet.Edit
                 Else
                 Begin
                   If dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex = CODEMP.Index Then
                   Begin
                     If (dtsItens.DataSet.State = dsEdit) Then
                     Begin
                       dtsItens.DataSet.Post;
                     End;

                     If Not fEmptyStr(dtsItens.DataSet.FieldByName('NUMLOT').AsString) Then
                       dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := LOTABA.Index
                     Else
                       dtsItens.DataSet.Next;
                   End
                   Else
                   Begin
                     If (dtsItens.DataSet.State = dsEdit) Then
                       dtsItens.DataSet.Post;

                     dtsItens.DataSet.Next;
                     dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := CODEMP.Index;
                   End;

                   If dtsItens.DataSet.Eof And btnConfirma.CanFocus Then
                     pSetFocus(btnConfirma);
                 End;
               End;
    VK_F10   : btnConfirma.Click;
    VK_F7    : btnAltEmp.Click;
  End;
  If ((Shift= [ssCtrl]) or (Shift = [ssAlt]) or (Shift = [ssAlt, ssShift]) or (Shift = [ssAlt, ssCtrl]) or (Shift= [ssShift,ssCtrl]) or (Shift= [ssAlt,ssShift,ssCtrl])) and (Key = VK_Delete) Then
    Key := 0;
end;

procedure TfrmSolicitacaoLojas.pProcessaEstoque;
Var
  fltCNV_ML: Double;
begin
  qryEstoque.DisableControls;
  try
    With qryEstoque Do
    Begin
      Filtered := False;
      Try
        First;
        While Not Eof Do
        Begin
          Edit;
          fltCNV_ML := IIF(FieldByName('ITE_CNV_ML').AsFloat <= 0, 1, FieldByName('ITE_CNV_ML').AsFloat);

          FieldByName('ITE_SALRES').AsFloat := TSaldoReservado.New(
                                                 TReservaParametros.New()
                                                   .EmpresaItem(FieldByName('EMP_CODEMP').AsString)
                                                   .CodigoItem(FieldByName('ITE_CODITE').AsString)
                                                   .CodEmpresa(FieldByName('EMP_CODEMP').AsString)
                                                   .TipoReserva(trsPedidoVenda)
                                                   .ConverterML(True)
                                                 ).fGetQuantidade();

          FieldByName('ITE_SALREG').AsFloat := TSaldoReservado.New(
                                                 TReservaParametros.New()
                                                   .EmpresaItem(FieldByName('EMP_CODEMP').AsString)
                                                   .CodigoItem(FieldByName('ITE_CODITE').AsString)
                                                   .CodEmpresa(FieldByName('EMP_CODEMP').AsString)
                                                   .TipoReserva(trsGarantia)
                                                   .ConverterML(True)
                                                 ).fGetQuantidade();

          FieldByName('ITE_SALEXT').AsFloat := TSaldoReservado.New(
                                                 TReservaParametros.New()
                                                   .EmpresaItem(FieldByName('EMP_CODEMP').AsString)
                                                   .CodigoItem(FieldByName('ITE_CODITE').AsString)
                                                   .CodEmpresa(FieldByName('EMP_CODEMP').AsString)
                                                   .TipoReserva(trsExterno)
                                                   .ConverterML(True)
                                                 ).fGetQuantidade();

          If FieldByName('ITE_SALEXT').AsFloat < 0 Then
            FieldByName('ITE_SALEXT').AsFloat := 0;

          FieldByName('ITE_SALDIS').AsFloat := ((FieldByName('ITE_SALDOS').AsFloat * fltCNV_ML) + FieldByName('ITE_SAL_ML').AsFloat) -
                                               FieldByName('ITE_SALRES').AsFloat -
                                               FieldByName('ITE_SALREG').AsFloat - IIF(FieldByName('ITE_SALEXT').AsFloat < 0, 0, FieldByName('ITE_SALEXT').AsFloat);

          FieldByName('ITE_ENTFUT').AsFloat := TEntregaFutura.New(
                                                 TParamEF.New()
                                                   .CodIte(FieldByName('ITE_CODITE').AsString)
                                                   .CodEmp(FieldByName('EMP_CODEMP').AsString)
                                                   .ConverteML(True)
                                                   .TipoTE(tteTodas)
                                                 ).Total();
          Post;

          Next;
        End;
      Finally
        Filtered := True;
      End;
    End;
  finally
    qryEstoque.EnableControls;
  end;
end;

procedure TfrmSolicitacaoLojas.btnAltEmpClick(Sender: TObject);
  Var
    strEmpSel : String;
begin
  inherited;
  If (btnAltEmp.Visible) Then
  Begin
    strEmpSel := fRetornaEmpresaItens;

    If Not fEmptyStr(strEmpSel) Then
    Begin

      With dtsItens.DataSet Do
      Begin
        First;
        While Not Eof Do
        Begin

          Try
            Edit;
            FieldByName('CODEMP').AsString := strEmpSel;
            Post;
          Except
            On E: EAbort Do
            Begin
              If State = dsEdit Then
                Cancel;
            End;
            On E: Exception Do
              Raise Exception.Create('Erro ao alterar empresa dos itens.');
          End;

          Next;
        End;
      End;

    End;
  End;
end;

end.
