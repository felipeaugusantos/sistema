unit untCtrNegociacaoParcelamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, UITypes,
  QColorLabel, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  Vcl.Mask, MaskEditFocus, Data.DB, Vcl.Grids, Vcl.DBGrids, clipbrd,
  Datasnap.DBClient, untParcelamento, DBGridCitel, UniClientDataSet, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxClasses, cxTextEdit,Math,untLiberacao,untMsgLiberacao,
  cxCalendar, cxProgressBar, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxMaskEdit, cxDropDownEdit,untQckAcertoConta,untTypesSistema, Uni, untPesqAux,
  untTEnvioEmail, strUtils;

type
  TfrmCtrNegociacaoParcelamento = class(TfrmPai)
    pnlDados: TPanel;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    edtValorCorrigido: TEditFocus;
    edtParcelas: TEditFocus;
    edtIntervalo: TEditFocus;
    edtTaxa: TEditFocus;
    edtDiaFixo: TEditFocus;
    Label8: TLabel;
    chkIntervalo: TCheckBox;
    chkDiaFixo: TCheckBox;
    lblCarencia: TLabel;
    edtCarencia: TEditFocus;
    lblPreVis: TLabel;
    Label7: TLabel;
    edtAmortizacao: TEditFocus;
    Label9: TLabel;
    edtJuros: TEditFocus;
    Label10: TLabel;
    edtValorFinal: TEditFocus;
    Panel1: TPanel;
    btnCalcular: TBitBtnLocked;
    pnlGrid: TPanel;
    cdsParcelas: TUniClientDataSet;
    cdsParcelasparcela: TStringField;
    cdsParcelasvencimento: TDateField;
    cdsParcelassaldo_devedor: TFloatField;
    cdsParcelasamortizacao: TFloatField;
    cdsParcelasjuros: TFloatField;
    cdsParcelasprestacao: TFloatField;
    dtsParcelas: TDataSource;
    btnCopiar: TBitBtnLocked;
    chkPrimeiraParc: TCheckBox;
    mskDataPrimeiraParc: TMaskEditFocus;
    Label11: TLabel;
    Label6: TLabel;
    edtValorDesejado: TEditFocus;
    edtValorBase: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtDesconto: TEditFocus;
    pnlTotais: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    edtValPag: TEditFocus;
    edtValPre: TEditFocus;
    cdsParcelasprestacao_a_pagar: TFloatField;
    cxStyleRepository: TcxStyleRepository;
    cxStyleZebra: TcxStyle;
    cxGridParcelas: TcxGrid;
    cxvGridParcelas: TcxGridDBTableView;
    cxvGridParcelasColumn1: TcxGridDBColumn;
    cxvGridParcelasVENCIMENTO: TcxGridDBColumn;
    cxvGridParcelasColumn3: TcxGridDBColumn;
    cxvGridParcelasColumn4: TcxGridDBColumn;
    cxvGridParcelasColumn5: TcxGridDBColumn;
    cxvGridParcelasColumn6: TcxGridDBColumn;
    cxvGridParcelasColumn7: TcxGridDBColumn;
    cxGridParcelasLevel1: TcxGridLevel;
    btnAlterarVencimento: TBitBtnLocked;
    btnRegraAlteracoes: TBitBtnLocked;
    mskDataBase: TcxDateEdit;
    btnPrevia: TBitBtnLocked;
    btnHelpPrevia: TBitBtnLocked;
    rdgOperacao: TRadioGroup;
    chkDiferencaUltParcela: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure chkIntervaloClick(Sender: TObject);
    procedure chkDiaFixoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCarenciaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure edtValorDesejadoChange(Sender: TObject);
    procedure chkPrimeiraParcClick(Sender: TObject);
    procedure cdsParcelasprestacao_a_pagarChange(Sender: TField);
    procedure cxvGridParcelasCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvGridParcelasEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure cxvGridParcelasEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarVencimentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsParcelasvencimentoChange(Sender: TField);
    procedure btnRegraAlteracoesClick(Sender: TObject);
    procedure btnPreviaClick(Sender: TObject);
    procedure btnHelpPreviaClick(Sender: TObject);
    procedure rdgOperacaoClick(Sender: TObject);
  private
    { Private declarations }
    blnEfetuandoRateio : Boolean;
    objLiberacao : TLiberacao;

    FCopiaParcelas: TUniClientDataset;

    FRecalculando: Boolean;

    procedure pCalcularParcelas;
    procedure pHabilitarIntervaloDiaFixo;
    procedure pCalculaTotais;
    procedure pRateiaValorDigitado;

    function fSomaTotalAcima: Double;
    function fSomaTotalAbaixo: Double;
    function fLiberacaoDesconto: Boolean;
    function fChamaSenhaVariavel(strMsg : String = ''; strDirAce : String = ''; strCfgSis : String = '';
                                 strMsgSen : String = ''; strOperador : String = ''; strNTrava : String = '';
                                 strDirAceNv2: String = ''; strSenLibNv2: String = ''; blnNivel2: Boolean = False): Boolean;

    procedure AtualizaVencimentosNoArray();
    procedure ReclaculaJurosDuplicatasSeelcionadas;

    function RecalcularVencimentos(pgbProgresso: TcxProgressBar): Boolean;
    function ValidarVencimentoDigitado(AVencimento: TDateTime;
                                       AParcela: String): Boolean;
    function GetCodigoClientes: String;
    procedure GetInfClientes(Var AEmail,AContato : String);

    procedure PreviaNegociacao;
    procedure AtualizaDuplicatas;
    procedure pCalculaTotalDuplicatas;
    function fGetDataPagamento(cdsDup: TDataSet): Double;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    objParcelamento: TParcelamento;
  end;

implementation

uses untfuncoesSimples, untConstantes, untFuncoes, untGravando, untDigEmail, untDigCondicaoPgtoNegociacaoParc;

{$R *.dfm}

{ TfrmCtrNegociacaoParcelamento }

function TfrmCtrNegociacaoParcelamento.fSomaTotalAbaixo: Double;
var
  intBase: Integer;
  intCont: Integer;
Begin
  intBase := cdsParcelas.RecNo;

  Result := 0.0;
  For intCont := intBase To Length(objParcelamento.arrParcelas)-1 Do
  Begin
    Result := Result + objParcelamento.arrParcelas[intCont].fltValorParcela;
  End;
end;

function TfrmCtrNegociacaoParcelamento.fSomaTotalAcima: Double;
var
  intBase: Integer;
  intCont: Integer;
Begin
  intBase := cdsParcelas.RecNo-1;

  Result := 0.0;
  For intCont := 0 To intBase-1 Do
  Begin
    Result := Result + objParcelamento.arrParcelas[intCont].fltValorParcela;
  End;
End;

function TfrmCtrNegociacaoParcelamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
     Dateb : Tdatetime;
begin
  Result := True;

  Try
    objParcelamento.fltValorCorrigido := fStrToFloat(edtValorCorrigido.Text);

    If (Sender = edtDesconto) Then
      objParcelamento.fltDesconto := fStrToFloat(edtDesconto.Text);

    If (Sender = edtValorDesejado) Then
      objParcelamento.fltValorDesejado := fStrToFloat(edtValorDesejado.Text);

    If (Sender = edtParcelas) Then
      objParcelamento.intQuantidadeParcelas := StrToIntDef(edtParcelas.Text, 0);

    If (Sender = mskDataBase) Then
    Begin

      If fCfgSis('DIALRV', varString) <> '' Then
      Begin
         Dateb := Date + fCfgSis('DIALRV', varInteger);
         If StrToDate(mskDataBase.Text) > Dateb Then
         Begin
            pMensagemOk('A data base informada está excedendo a data limite configurada para inclusão da primeira parcela. Data limite: "' + DatetoStr(Dateb) + '"');
            Result := False;
            exit;
         End;
      End;

      objParcelamento.dtaDataBase := StrToDateDef(mskDataBase.Text, 0);

      If Result And (objParcelamento.cdsCadRec.FieldByName('CTR_DTAPAG').AsDateTime <>  StrToDateDef(mskDataBase.Text, 0)) Then
      Begin
        TfrmGravando.fExecutarModalA(AtualizaDuplicatas, 'Aguarde, Atualizando Duplicatas...', '');
      End;

    End;

    If (Sender = mskDataPrimeiraParc) Then
      objParcelamento.dataPrimeiraParcela := StrToDateDef(mskDataPrimeiraParc.Text, 0);

    If (Sender = edtIntervalo) Then
      objParcelamento.intIntervaloDias := StrToIntDef(edtIntervalo.Text, 0);

    If (Sender = edtDiaFixo) Then
      objParcelamento.intDiaFixo := StrToIntDef(edtDiaFixo.Text, 0);

    If (Sender = edtTaxa) And (Not edtTaxa.ReadOnly) Then
      objParcelamento.fltTaxaJuros := fStrToFloat(edtTaxa.Text);

    If (Sender = edtCarencia) Then
      objParcelamento.intCarencia := StrToIntDef(edtCarencia.Text, 0);

  Except

    On E: ExceptionAutcom Do
    Begin
      Result := False;
      pMensagemOk(E.Message);
      pSetFocus(Sender);
    End;

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;

  End;

  edtValorBase.Text := FormatFloat('#,##0.00', objParcelamento.fltValorBase);

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCtrNegociacaoParcelamento.GetCodigoClientes: String;
begin
  objParcelamento.cdsCadRec.First;
  Result := '';
  While Not objParcelamento.cdsCadRec.Eof Do
  Begin
    If (Pos(objParcelamento.cdsCadRec.FieldByName('CTR_CODCLI').AsString,Result) <= 0) Then
    Begin
      If fEmptyStr(Result)Then
        Result := objParcelamento.cdsCadRec.FieldByName('CTR_CODCLI').AsString
      Else
        Result := Result + '_' + objParcelamento.cdsCadRec.FieldByName('CTR_CODCLI').AsString;
    End;
    objParcelamento.cdsCadRec.Next;
  End;
end;

procedure TfrmCtrNegociacaoParcelamento.GetInfClientes(Var AEmail,AContato : String);
  Var
    LCadCli : TUniQuery;
    LSql: String;
begin
  Try
    LSql := '';
    LSql := LSql + 'SELECT          ' ;
    LSql := LSql + '  CLI_CONTAT,   ' ;
    LSql := LSql + '  CLI_EMAIL_    ' ;
    LSql := LSql + 'FROM            ' ;
    LSql := LSql + '  CADCLI        ' ;
    LSql := LSql + 'WHERE           ' ;
    LSql := LSql + 'CLI_CODCLI IN (' + fRetStrToSQLIn(GetCodigoClientes) + ') ';

    Try
      LCadCli := fCriaQuery(Nil);
      LCadCli.Close;
      LCadCli.Sql.Clear;
      LCadCli.Sql.Add(LSql);
      LCadCli.Open;

      LCadCli.First;
      If Not LCadCli.IsEmpty Then
      Begin
        While Not LCadCli.Eof Do
        Begin

          If fEmptyStr(AEmail) Then
            AEmail := LCadCli.FieldByName('CLI_EMAIL_').AsString
          Else If  Not fEmptyStr(LCadCli.FieldByName('CLI_EMAIL_').AsString) Then
            AEmail := AEmail + ';' + LCadCli.FieldByName('CLI_EMAIL_').AsString;

          If fEmptyStr(AContato) Then
            AContato := LCadCli.FieldByName('CLI_CONTAT').AsString
          Else If  Not fEmptyStr(LCadCli.FieldByName('CLI_CONTAT').AsString) Then
            AContato := AContato + ';' + LCadCli.FieldByName('CLI_CONTAT').AsString;

          LCadCli.Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCtrNegociacaoParcelamento.GetEmailClientes]');
      End;
    End;
  Finally
    FreeAndNil(LCadCli);
  End;
end;

function TfrmCtrNegociacaoParcelamento.fGetDataPagamento(cdsDup: TDataSet): Double;
Begin
  If (cdsDup.FieldByName('CTR_DTAPAG').IsNull) Or (cdsDup.FieldByName('CTR_DTAPAG').AsDateTime = 0) Then
    Result := VS_Date
  Else
    Result := cdsDup.FieldByName('CTR_DTAPAG').AsDateTime;
End;

procedure TfrmCtrNegociacaoParcelamento.AtualizaDuplicatas;
  Var
    fltAtraso: Double;
    fltValDup: Double;
    recMulJur: TRecMultaJuros;
    LDtaBase : String;
    documento: TDocAgrupamento;
begin

  If Not Assigned(objParcelamento.cdsCadRec) Or
         objParcelamento.cdsCadRec.IsEmpty Then
    Exit;

  Try
    objParcelamento.cdsCadRec.First;
    LDtaBase := mskDataBase.Text;
    objParcelamento.ClearArrayDocumentos;

    While Not objParcelamento.cdsCadRec.Eof Do
    Begin
      fltValDup := objParcelamento.cdsCadRec.FieldByName('CTR_VALDUP').AsFloat;

      objParcelamento.cdsCadRec.Edit;

      objParcelamento.cdsCadRec.FieldByName('CTR_DTAPAG').AsDateTime := StrToDateTime(LDtaBase);
      fltAtraso := StrToDateTime(LDtaBase) - objParcelamento.cdsCadRec.FieldByName('CTR_DTAVEN').AsDateTime;


      recMulJur := fCalculaMultaJuros(objParcelamento.cdsCadRec.FieldByName('CTR_DTAVEN').AsDateTime,
                                      fGetDataPagamento(objParcelamento.cdsCadRec),
                                      objParcelamento.cdsCadRec.FieldByName('CTR_VALDUP').AsFloat,
                                      fCfgSis('JURATR', varDouble),
                                      fCfgSis('MULATR', varDouble));

      objParcelamento.cdsCadRec.FieldByName('CTR_VALDES').AsFloat  := 0.0;
      objParcelamento.cdsCadRec.FieldByName('CTR_VALMUL').AsFloat  := recMulJur.fltValorMulta;
      objParcelamento.cdsCadRec.FieldByName('CTR_VALJUR').AsFloat  := recMulJur.fltValorJuros;
      objParcelamento.cdsCadRec.FieldByName('CTR_ATRASO').AsFloat  := IIF(fltAtraso < 0, 0, fltAtraso);
      objParcelamento.cdsCadRec.FieldByName('CTR_VALCAL').AsFloat  := fltValDup +
                                            recMulJur.fltValorMulta +
                                            recMulJur.fltValorJuros +
                                            objParcelamento.cdsCadRec.FieldByName('CTR_DESPCO').AsFloat;
      objParcelamento.cdsCadRec.Post;

      documento.strNumDoc := objParcelamento.cdsCadRec.FieldByName('NRODUP').AsString;
      documento.strParcel := objParcelamento.cdsCadRec.FieldByName('PARDUP').AsString;
      documento.strEspDoc := objParcelamento.cdsCadRec.FieldByName('CTR_ESPDOC').AsString;
      documento.strCodEmp := objParcelamento.cdsCadRec.FieldByName('CTR_CODEMP').AsString;
      documento.strCodCli := objParcelamento.cdsCadRec.FieldByName('CTR_CODCLI').AsString;
      documento.dtaDtaVen := objParcelamento.cdsCadRec.FieldByName('CTR_DTAVEN').AsDateTime;
      documento.dtaDtaPag := objParcelamento.cdsCadRec.FieldByName('CTR_DTAPAG').AsDateTime;
      documento.fltValOri := objParcelamento.cdsCadRec.FieldByName('CTR_VALDUP').AsFloat;
      documento.fltValMul := objParcelamento.cdsCadRec.FieldByName('CTR_VALMUL').AsFloat;
      documento.fltValJur := objParcelamento.cdsCadRec.FieldByName('CTR_VALJUR').AsFloat;
      documento.fltDesCob := objParcelamento.cdsCadRec.FieldByName('CTR_DESPCO').AsFloat;
      documento.fltValCor := objParcelamento.cdsCadRec.FieldByName('CTR_VALCAL').AsFloat;
      documento.intDiaAtr := objParcelamento.cdsCadRec.FieldByName('CTR_ATRASO').AsInteger;

      objParcelamento.pAdicionarDocumentoAgrupamento(documento);

      objParcelamento.cdsCadRec.Next;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCtrNegociacaoParcelamento.AtualizaDuplicata');
    End;
  End;

  pCalculaTotalDuplicatas;

end;

procedure TfrmCtrNegociacaoParcelamento.AtualizaVencimentosNoArray;
  Var
    LContador: Integer;
begin
  Try
    cdsParcelas.DisableControls;
    cdsParcelas.Filtered := True;

    For LContador := 0 To Length(objParcelamento.arrParcelas) - 1 Do
    Begin
      If Not fEmptyStr(objParcelamento.arrParcelas[LContador].strNumeroParcela)Then
      Begin
        cdsParcelas.Filter := 'PARCELA=' + objParcelamento.arrParcelas[LContador].strNumeroParcela;

        If (cdsParcelas.RecordCount > 0) Then
          objParcelamento.arrParcelas[LContador].dtaVencimento := cdsParcelas.FieldByName('vencimento').AsDateTime;
      End;
    End;
  Finally
    cdsParcelas.Filter := '';
    cdsParcelas.Filtered := False;

    cdsParcelas.EnableControls;
  End;
end;

procedure TfrmCtrNegociacaoParcelamento.btnAlterarVencimentoClick(
  Sender: TObject);
begin
  inherited;
  If Not btnAlterarVencimento.Enabled Then
    Exit;

  FCopiaParcelas := fCriaClientDatSet(cdsParcelas);

  cxvGridParcelasVENCIMENTO.Properties.ReadOnly := False;
  cxvGridParcelasVENCIMENTO.Options.Editing := True;

  cxvGridParcelasColumn7.Options.Editing := False;

  FRecalculando := False;

  btnAlterarVencimento.Enabled := False;

  pSetFocus(cxGridParcelas);
end;

procedure TfrmCtrNegociacaoParcelamento.btnCalcularClick(Sender: TObject);
begin

  If Not fValidaCampos(mskDataBase) Then
    Exit;

  TfrmGravando.fExecutarModalA(pCalcularParcelas, 'Aguarde, calculando parcelas ...', '');
end;

procedure TfrmCtrNegociacaoParcelamento.pCalculaTotalDuplicatas;
  Var
    fldValCor: TAggregateField;
    cdsGen : TUniClientDataSet;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldValCor := TAggregateField.Create(Self);

  With fldValCor Do
  Begin
    FieldName := 'FLDVALCOR';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTR_VALCAL)';
    Active := True;
  End;

  cdsGen.Data := objParcelamento.cdsCadRec.Data;
  cdsGen.Filtered := False;
  cdsGen.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
  cdsGen.Filtered := True;

  cdsGen.AggregatesActive := True;

  edtValorCorrigido.Text := FormatFloat('#,##0.00', IIF(fldValCor.Value = Null, 0.00, fldValCor.Value));
  objParcelamento.fltValorCorrigido := IIF(fldValCor.Value = Null, 0.00, fldValCor.Value);
  objParcelamento.fltDesconto := fStrToFloat(edtDesconto.Text); // para recalcular o total com desconto ;)

  FreeAndNil(fldValCor);
  FreeAndNil(cdsGen);
end;

procedure TfrmCtrNegociacaoParcelamento.pCalcularParcelas;
  Var
    parcela: untParcelamento.TParcela;
begin
  inherited;

  Try
    objParcelamento.fltValorCorrigido     := fStrToFloat(edtValorCorrigido.Text);
    objParcelamento.fltDesconto           := fStrToFloat(edtDesconto.Text);
    objParcelamento.fltValorDesejado      := fStrToFloat(edtValorDesejado.Text);
    objParcelamento.intQuantidadeParcelas := StrToIntDef(edtParcelas.Text, 0);
    objParcelamento.dtaDataBase           := StrToDateDef(mskDataBase.Text, 0);
    objParcelamento.intIntervaloDias      := StrToIntDef(edtIntervalo.Text, 0);
    objParcelamento.intDiaFixo            := StrToIntDef(edtDiaFixo.Text, 0);
    objParcelamento.intCarencia           := StrToIntDef(edtCarencia.Text, 0);
    objParcelamento.dataPrimeiraParcela   := StrToDateDef(mskDataPrimeiraParc.Text, 0);

    If objParcelamento.fltValorDesejado = 0.00 Then
    Begin
      objParcelamento.fltTaxaJuros := fStrToFloat(edtTaxa.Text);
      objParcelamento.pCalcularParcelas;
    End
    Else
    Begin
      objParcelamento.pCalcularParcelasValorDesejado;
    End;

    cdsParcelas.EmptyDataSet;

    If chkDiferencaUltParcela.Checked Then
      objParcelamento.pAjustaValoresParcelas;

    For parcela In objParcelamento.arrParcelas Do
    Begin
      cdsParcelas.Append;
      cdsParcelas.FieldByName('parcela').AsString      := parcela.strNumeroParcela;
      cdsParcelas.FieldByName('vencimento').AsDateTime := parcela.dtaVencimento;
      cdsParcelas.FieldByName('amortizacao').AsFloat   := parcela.fltAmortizacao;
      cdsParcelas.FieldByName('Juros').AsFloat         := parcela.fltJuros;
      cdsParcelas.FieldByName('prestacao').AsFloat     := parcela.fltValorParcela;

      If chkDiferencaUltParcela.Checked Then
        cdsParcelas.FieldByName('prestacao').AsFloat     := parcela.fltValorParcelaOriginal;

      cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat := parcela.fltValorParcela;
      cdsParcelas.FieldByName('saldo_devedor').AsFloat := parcela.fltSaldo;
      cdsParcelas.Post;
    End;

    cdsParcelas.First;

    If objParcelamento.fltValorDesejado <> 0.00 Then
      edtTaxa.Text := FormatFloat(edtTaxa.EditFormat, objParcelamento.fltTaxaJuros);

    edtAmortizacao.Text := FormatFloat('#,##0.00', objParcelamento.fltTotalAmortizacao);
    edtJuros.Text       := FormatFloat('#,##0.00', objParcelamento.fltTotalJuros);
    edtValorFinal.Text  := FormatFloat('#,##0.00', objParcelamento.fltTotalParcelas);

    pCalculaTotais;

    pnlGrid.Enabled  := True;
    pnlDados.Enabled := False;

    pSetFocus(cxGridParcelas);

    btnAlterarVencimento.Enabled := True;

    cxvGridParcelasColumn7.Options.Editing := True;

  Except

    On E: ExceptionAutcom Do
    Begin
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;

  End;

end;

procedure TfrmCtrNegociacaoParcelamento.pCalculaTotais;
Var
  cdsGen: TUniClientDataSet;
  fldValPre,
  fldValPag: TAggregateField;
  fltValPre,
  fltValPag: Double;
begin
  cdsGen    := TUniClientDataSet.Create(Self);
  fldValPre := fCriaAggregateField(cdsGen, 'FLDTOTPRE', 'SUM(prestacao)', '#,##0.00');
  fldValPag := fCriaAggregateField(cdsGen, 'FLDTOTPAG', 'SUM(prestacao_a_pagar)', '#,##0.00');

  With cdsGen Do
  Begin
    Data := cdsParcelas.Data;
    AggregatesActive := True;
    fltValPre        := IIF(fldValPre.Value = Null, 0.00, fldValPre.Value);
    fltValPag        := IIF(fldValPag.Value = Null, 0.00, fldValPag.Value);
    edtValPre.Text   := FormatFloat('#,##0.00', fltValPre);
    edtValPag.Text   := FormatFloat('#,##0.00', fltValPag);
  End;

  FreeAndNil(fldValPre);
  FreeAndNil(fldValPag);
  FreeAndNil(cdsGen);
end;

procedure TfrmCtrNegociacaoParcelamento.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fStrToFloat(edtValPre.Text) <> fStrToFloat(edtValPag.Text) Then
  Begin
    pMensagemOk('O Total Prestação não pode ser diferente do Total a Pagar!');
    Exit;
  End;

  If Not cdsParcelas.IsEmpty Then
  Begin
    If Not fLiberacaoDesconto Then
      Exit;

    AtualizaVencimentosNoArray;
    ReclaculaJurosDuplicatasSeelcionadas;

    blnConfirma := True;
    Close;
  End
  Else
    pMensagemOk('Favor calcular as parcelas antes de prosseguir!');
end;

procedure TfrmCtrNegociacaoParcelamento.btnCopiarClick(Sender: TObject);
begin
  inherited;
  If Not cdsParcelas.IsEmpty Then
  Begin
    ClipBoard.AsText := objParcelamento.ToString;
    pMensagemOk('Copiado para área de transferência com sucesso!');
  End;
end;

procedure TfrmCtrNegociacaoParcelamento.btnHelpPreviaClick(Sender: TObject);
  Var
    LMsg: String;
begin
  LMsg := '* Duplicatas com boletos emitidos e/ou enviados ao banco somente poderão ser selecionados para "simulação" de negociação de vencimentos [F11]. '+#13#10 +
          '* Duplicatas selecionadas de clientes diferentes e ou rede de lojas somente poderão ser selecionadas para "simulação" de negociação de vencimentos [F11]';

  fMensagem('Ajuda', LMsg , ['&Ok']);
end;

procedure TfrmCtrNegociacaoParcelamento.btnPreviaClick(Sender: TObject);
begin
  inherited;

  If cdsParcelas.IsEmpty Then
  Begin
    pMensagemOk('Favor calcular as parcelas antes de prosseguir!');
    Exit;
  End;

  TfrmGravando.fExecutarModalA(PreviaNegociacao, 'Aguarde, Gerando Prévia da Negociação...', '');
end;

procedure TfrmCtrNegociacaoParcelamento.btnRegraAlteracoesClick(
  Sender: TObject);
  var
    LMensagem: String;
begin
  inherited;
  LMensagem := 'Para a alteração da data de vecimento das duplicatas:        ' + #13#10 +
               ' -A nova data não pode ser menor que a data atual.           ' + #13#10 +
               ' -A nova data deve ser maior que a data da parcela anterior. ' + #13#10 +
               ' -A nova data deve ser menor que a data da próxima parcela.  ' + #13#10 + #13#10 +

               '*Ao alterar a data de uma parcela, o sistema recalculará as  ' + #13#10 +
               ' próximas, conforme os parâmetros escolhidos.                ' + #13#10 +
               '*Não é possível alterar o vencimento das carências.          ' + #13#10 +
               '*A validação das datas de vencimento é feita sobre as datas  ' + #13#10 +
               ' geradas inicialmente, sem as alterações.                    ' + #13#10 +
               '*A alteração do vencimento só poderá ser feita se não foi    ' + #13#10 +
               ' alterado o valor de alguma duplicata.                       ' + #13#10 +
               '*Ao selecionar a opção F2, a alteração de valor da duplicata ' + #13#10 +
               ' é bloqueada.                                                ';

  fMensagem('REGRAS', LMensagem, ['&Ok'], 1, False, 2, 0, False, 0, False, False, False, 350);
end;

procedure TfrmCtrNegociacaoParcelamento.cdsParcelasprestacao_a_pagarChange(
  Sender: TField);
begin
  inherited;
  If (cdsParcelas.State = dsEdit) And
     (cxvGridParcelasColumn7.Index = cxvGridParcelas.Controller.FocusedColumnIndex) Then
    pRateiaValorDigitado;
end;

procedure TfrmCtrNegociacaoParcelamento.cdsParcelasvencimentoChange(
  Sender: TField);
  Var
    LRegistroAtual: Integer;
begin
  If FRecalculando Then
    Exit;

  If cdsParcelas.State <> dsEdit Then
    Exit;

  If cxvGridParcelasVENCIMENTO.Index <> cxvGridParcelas.Controller.FocusedColumnIndex Then
    Exit;

  If Not ValidarVencimentoDigitado(cdsParcelas.FieldByName('VENCIMENTO').AsDateTime,
                                   cdsParcelas.FieldByName('PARCELA').AsString) Then
  Begin
    cdsParcelas.Cancel;

    Abort;
  End;

  LRegistroAtual := cdsParcelas.RecNo;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := RecalcularVencimentos;
    frmGravando.lblGravando.Caption := 'Aguarde... Reclaculando vencimentos.';
    frmGravando.ShowModal;

    FRecalculando := False;
  Finally
    pFreeAndNil(frmGravando);

    cdsParcelas.RecNo := LRegistroAtual;
  End;
end;

procedure TfrmCtrNegociacaoParcelamento.chkDiaFixoClick(Sender: TObject);
begin
  inherited;
  chkIntervalo.Checked := Not chkDiaFixo.Checked;
  pHabilitarIntervaloDiaFixo;
  pSetFocus(edtDiaFixo);
end;

procedure TfrmCtrNegociacaoParcelamento.chkIntervaloClick(Sender: TObject);
begin
  inherited;
  chkDiaFixo.Checked := Not chkIntervalo.Checked;
  pHabilitarIntervaloDiaFixo;
  pSetFocus(edtIntervalo);
end;

procedure TfrmCtrNegociacaoParcelamento.chkPrimeiraParcClick(Sender: TObject);
begin
  inherited;
  mskDataPrimeiraParc.Enabled            := chkPrimeiraParc.Checked = true;
  mskDataPrimeiraParc.Text               := IIF(chkPrimeiraParc.Checked, DateToStr(date), '');
  objParcelamento.blnUsarPrimeiraParcela := chkPrimeiraParc.Checked;
end;

procedure TfrmCtrNegociacaoParcelamento.cxvGridParcelasCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If cdsParcelas.IsEmpty Then
    Exit;

  If fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvGridParcelasColumn1.Index])) Then
  Begin
    If ACanvas.Font.Color <> clHighLightText Then
      ACanvas.Font.Color := lblCarencia.Font.Color;
  End;
end;

procedure TfrmCtrNegociacaoParcelamento.cxvGridParcelasEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := (cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat > 0);
end;

procedure TfrmCtrNegociacaoParcelamento.cxvGridParcelasEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
var
  fltValor: Double;
begin
  inherited;
  fltValor := fStrToFloat(StringReplace(Sender.Controller.EditingController.Edit.EditingValue,'.','',[rfReplaceAll]));

  If (cxvGridParcelasColumn7.Index = cxvGridParcelas.Controller.FocusedColumnIndex) Then
  Begin
    If (fltValor > 0) Then
      TcxTextEdit(Sender.Controller.EditingController.Edit).Text := StringReplace(Sender.Controller.EditingController.Edit.EditingValue,'.','',[rfReplaceAll])
    Else
      TcxTextEdit(Sender.Controller.EditingController.Edit).Text :=  StringReplace(AItem.EditValue,'.','',[rfReplaceAll]);
  End;
end;

procedure TfrmCtrNegociacaoParcelamento.edtCarenciaChange(Sender: TObject);
begin
  inherited;
  lblCarencia.Font.Color := clBlack;
  If fStrToFloat(edtCarencia.Text) > 0 Then
    lblCarencia.Font.Color := clBlue;

end;

procedure TfrmCtrNegociacaoParcelamento.edtValorDesejadoChange(Sender: TObject);
begin
  inherited;
  edtTaxa.TabStop     := True;
  edtTaxa.ReadOnly    := False;
  edtTaxa.NormalColor := clWhite;
  edtTaxa.EditFormat  := '#,##0.0000';

  If fStrToFloat(edtValorDesejado.Text) <> 0.00 Then
  Begin
    edtTaxa.TabStop     := False;
    edtTaxa.ReadOnly    := True;
    edtTaxa.NormalColor := $00FFDFB8;
    edtTaxa.Text        := '0,0000000000';
    edtTaxa.EditFormat  := '#,##0.0000000000';//Aumenta a precisao para 10
  End;
end;

function TfrmCtrNegociacaoParcelamento.fLiberacaoDesconto: Boolean;
  Var
    fltCtrDes: Double;
    fltCtrDe2: Double;
    fltDesPer: Double;
    fltDesPe2: Double;
    strSCtrDe: String;
begin
  Result := True;
  fltCtrDes := (fCfgSis('CTRDES', varDouble) / 100);
  fltDesPer := (RoundTo(fStrToFloat(edtValorCorrigido.Text), -2) * RoundTo(fltCtrDes, -2));

  strSCtrDe := fCfgSis('SCTRDE', varString);
  fltCtrDe2 := (fCfgSis('CTRDE2', varDouble) / 100);
  fltDesPe2 := (RoundTo(fStrToFloat(edtValorCorrigido.Text), -2) * RoundTo(fltCtrDe2, -2));

  If (RoundTo(fStrToFloat(edtDesconto.Text), -2) > RoundTo(fltDesPer, -2))  Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor do desconto é maior que o permitido. ', ['&Ok']);
    If (Not fChamaSenhaVariavel( '',
                        'CTRDESMAX',
                           'SCTRDE',
                  'Desconto Máximo',
              strLoginUsuarioLogado,
                                 '',
                        'CTRDESMA2',
                  fCfgSis('SCTRD2'),
                 (RoundTo(fStrToFloat(edtDesconto.Text), -2) > fltDesPe2))) Then
    Begin
      Result := False;
    End;

  End;
end;

procedure TfrmCtrNegociacaoParcelamento.pHabilitarIntervaloDiaFixo;
begin
  If chkIntervalo.Checked Then
  Begin
    edtIntervalo.Enabled := True;
    edtIntervalo.Text    := '30';
    edtDiaFixo.Enabled   := False;
  End
  Else
  Begin
    edtIntervalo.Enabled := False;
    edtIntervalo.Text    := '30';
    edtDiaFixo.Enabled   := True;
  End;

  objParcelamento.blnUsarDiaFixo := chkDiaFixo.Checked;
end;

procedure TfrmCtrNegociacaoParcelamento.pRateiaValorDigitado();
  Var
    fltTotalAcima: Double;
    fltTotalAbaixo: Double;
    fltValorRestante: Double;
    fltValorParcela: Double;
    fltValorADescontar: Double;
    intBase: Integer;
    intContador: Integer;
    intDivisor: Integer;
    intQtdPar: Integer;
    parcela: untParcelamento.TParcela;
begin
  If blnEfetuandoRateio Then
    Exit;

  blnEfetuandoRateio := True;

  btnAlterarVencimento.Enabled := False;

  intBase   := cdsParcelas.RecNo;
  intQtdPar := Length(objParcelamento.arrParcelas);
  fltTotalAcima  := fSomaTotalAcima;

  intDivisor := intQtdPar - intBase;
    If (intDivisor <= 0) Then
      intDivisor := 1;

  fltValorRestante   := fStrToFloat(FloatToStrF((objParcelamento.fltTotalParcelas - fltTotalAcima -
                                                 cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat), ffFixed,12,2));
  fltValorParcela    := fStrToFloat(FloatToStrF((fltValorRestante / intDivisor), ffFixed,12,2));
  fltValorADescontar := fStrToFloat(FloatToStrF(((fltValorParcela * intDivisor) - fltValorRestante), ffFixed,12,2));

  If ((cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat + fltTotalAcima) > objParcelamento.fltTotalParcelas) Or
     (fltValorParcela = 0) Or
     ((fltValorRestante / intDivisor) < 0.01) Or
     (fltValorADescontar >= fltValorParcela) Or
     (fStrToFloat(FloatToStrF((cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat), ffFixed,12,2)) = 0) Then
  Begin
    cdsParcelas.Edit;
    cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat := objParcelamento.arrParcelas[intBase-1].fltValorParcela;
    cdsParcelas.Post;
  End;

  fltValorRestante := fStrToFloat(FloatToStrF((objParcelamento.fltTotalParcelas - fltTotalAcima -
                                               cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat), ffFixed,12,2));
  If fltValorRestante < 0 Then
    Abort;

  fltValorParcela := fStrToFloat(FloatToStrF((fltValorRestante / intDivisor), ffFixed,12,2));

  For intContador := intBase To intQtdPar-1 Do
  Begin
     objParcelamento.arrParcelas[intContador].fltValorParcela := fltValorParcela;
  End;

  If intQtdPar <> intBase Then
     objParcelamento.arrParcelas[intBase-1].fltValorParcela := cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat;

  fltTotalAbaixo := fFormataFloat(fSomaTotalAbaixo, 2);

  If intQtdPar = intBase Then
  Begin
    objParcelamento.arrParcelas[intBase-1].fltValorParcela := objParcelamento.fltTotalParcelas - fltTotalAcima;
  End
  Else
  If (fltTotalAbaixo < fltValorRestante) Then
  Begin

    If intQtdPar < intBase Then
      Inc(intBase,-1);

    objParcelamento.arrParcelas[intBase].fltValorParcela := objParcelamento.arrParcelas[intBase].fltValorParcela + fltValorRestante - fltTotalAbaixo;

  End
  Else If (fltTotalAbaixo > fltValorRestante) Then
  Begin
    objParcelamento.arrParcelas[intBase].fltValorParcela := objParcelamento.arrParcelas[intBase].fltValorParcela - (fltTotalAbaixo - fltValorRestante);
  End;

  intBase := cdsParcelas.RecNo;
  cdsParcelas.DisableControls;
  cdsParcelas.First;

  For parcela In objParcelamento.arrParcelas Do
  Begin
    cdsParcelas.Edit;
    cdsParcelas.FieldByName('prestacao_a_pagar').AsFloat := parcela.fltValorParcela;
    cdsParcelas.Post;
    cdsParcelas.Next;
  End;

  cdsParcelas.RecNo := intBase;
  cdsParcelas.EnableControls;

  pCalculaTotais;

  blnEfetuandoRateio := False;
end;

procedure TfrmCtrNegociacaoParcelamento.PreviaNegociacao;
  Var
    LViaEmail : Boolean;
    LQckAcertoConta: TfrmQckAcertoConta;
    LCaminhoPDF : String;
    arrArquivos,
    arrDestinatarios : TStringArray;
    blnConfirma: Boolean;
    LContato: String;
    LEmail : String;
begin

  Try
    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Acerto de Conta') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'Acerto de Conta');

    LViaEmail := (fMensagem('','Saída',['&Gerar PDF','&E-mail']) = 2);

    pCriarFormularios(TfrmQckAcertoConta,LQckAcertoConta);

    objParcelamento.cdsCadRec.IndexFieldNames := 'CTR_CODCLI;CTR_DTAVEN;CTR_NUMDUP;CTR_CODEMP';
    objParcelamento.cdsCadRec.Filtered := False;
    objParcelamento.cdsCadRec.Filter := 'CTR_MARDES = ' + QuotedStr('M');
    objParcelamento.cdsCadRec.Filtered := True;

    LQckAcertoConta.dtsCtaRec.DataSet   := objParcelamento.cdsCadRec;
    LQckAcertoConta.dtsParcelas.DataSet := cdsParcelas;

    LQckAcertoConta.frxPreviaNeg.Script.Variables['TOTGERCOR']   := FormatFloat('#,##0.00',objParcelamento.fltValorCorrigido);
    LQckAcertoConta.frxPreviaNeg.Script.Variables['VALDES']      := FormatFloat('#,##0.00',objParcelamento.fltDesconto);
    LQckAcertoConta.frxPreviaNeg.Script.Variables['TOTCOMDES']   := FormatFloat('#,##0.00',objParcelamento.fltValorBase);
    LQckAcertoConta.frxPreviaNeg.Script.Variables['QTDPAR']      := objParcelamento.intQuantidadeParcelas.ToString;
    LQckAcertoConta.frxPreviaNeg.Script.Variables['VALFINDES']   := FormatFloat('#,##0.00',objParcelamento.fltValorDesejado);
    LQckAcertoConta.frxPreviaNeg.Script.Variables['TAXJUR']      := FormatFloat('#,##0.00',objParcelamento.fltTaxaJuros);
    LQckAcertoConta.frxPreviaNeg.Script.Variables['INTERDIAS']   := objParcelamento.intIntervaloDias.ToString;
    LQckAcertoConta.frxPreviaNeg.Script.Variables['VENCDIAFIXO'] := objParcelamento.intDiaFixo.ToString;
    LQckAcertoConta.frxPreviaNeg.Script.Variables['CARENCIA']    := objParcelamento.intCarencia.ToString;
    LQckAcertoConta.frxPreviaNeg.Script.Variables['DTABASE']     := FormatDateTime('dd/MM/yyyy',objParcelamento.dtaDataBase);
    LQckAcertoConta.frxPreviaNeg.Script.Variables['AMORTI']      := FormatFloat('#,##0.00',objParcelamento.fltTotalAmortizacao);
    LQckAcertoConta.frxPreviaNeg.Script.Variables['JUROS']       := FormatFloat('#,##0.00',objParcelamento.fltTotalJuros);
    LQckAcertoConta.frxPreviaNeg.Script.Variables['VALFIN']      := FormatFloat('#,##0.00',objParcelamento.fltTotalParcelas);

    TfrxMemoView(LQckAcertoConta.frxPreviaNeg.FindObject('memoInterDias')).Memo.Text :='(' + IIF(objParcelamento.blnUsarDiaFixo, ' ', 'X') + ') Invervalo em Dias';
    TfrxMemoView(LQckAcertoConta.frxPreviaNeg.FindObject('memoVencFixo')).Memo.Text  :='(' + IIF(objParcelamento.blnUsarDiaFixo, 'X', ' ') + ') Vencimento Dia Fixo';

    LCaminhoPDF := GetCodigoClientes +'-'+FormatDateTime('yyyymmdd', Date) + '.pdf';

    If LQckAcertoConta.frxPreviaNeg.PrepareReport Then
    Begin
      LQckAcertoConta.frxPDFExport.FileName    := LCaminhoPDF;
      LQckAcertoConta.frxPDFExport.DefaultPath := ExtractFilePath(Application.ExeName) + 'Acerto de Conta';
      LQckAcertoConta.frxPDFExport.ShowDialog  := False;
      LQckAcertoConta.frxPreviaNeg.Export(LQckAcertoConta.frxPDFExport);

      LCaminhoPDF := ExtractFilePath(Application.ExeName) + 'Acerto de Conta' + '\' + LCaminhoPDF;

      If Not LViaEmail Then
      Begin
        pPreviewReport(Self.Name, 'Acerto de Conta - Prévia de Negociação', LQckAcertoConta.frxPreviaNeg);
      End
      Else
      Begin
        Try
          pCriarFormularios(TfrmDigEmail, frmDigEmail);
          GetInfClientes(LEmail,LContato);
          frmDigEmail.edtEmail.Text   := LEmail;
          frmDigEmail.edtContato.Text := LContato;
          frmDigEmail.edtContato.Visible := False;
          frmDigEmail.Label2.Visible := False;
          blnConfirma := (frmDigEmail.ShowModal = mrOk);

          If (blnConfirma) Then
          Begin
            LContato := frmDigEmail.edtContato.Text;
            LEmail   := frmDigEmail.edtEmail.Text;
          End;
        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[TfrmCtrNegociacaoParcelamento.PreviaNegociacao]');
          End;
        End;
        pFreeAndNil(frmDigEmail);

        If blnConfirma Then
        Begin
          pCriarArrayAnexosEDestinatarios(LCaminhoPDF, LEmail, arrDestinatarios, arrArquivos);
          TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, 'Acerto de Conta', arrDestinatarios, [], [], ['Segue arquivo em anexo.'], arrArquivos);
        End;

        SetForegroundWindow(VS_APPLICATION_HANDLE);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCtrNegociacaoParcelamento.PreviaNegociacao]');
    End;
  End;

  FreeAndNil(LQckAcertoConta);
end;

procedure TfrmCtrNegociacaoParcelamento.rdgOperacaoClick(Sender: TObject);
 Var
     frmDigCondicaoPgtoNegociacaoParc : TfrmDigCondicaoPgtoNegociacaoParc;
     iQtdParcelasCondPgto : Integer;
     fltTaxaCndPgto : Double;
     blnConfirma : Boolean;
begin
  inherited;

  If RdgOperacao.ItemIndex = 1 Then
  Begin
    pCriarFormularios(TfrmDigCondicaoPgtoNegociacaoParc, frmDigCondicaoPgtoNegociacaoParc);
    frmDigCondicaoPgtoNegociacaoParc.ShowModal;

    blnConfirma := frmDigCondicaoPgtoNegociacaoParc.blnConfirma;

    If blnConfirma Then
    Begin

       If Not fEmptyStr(frmDigCondicaoPgtoNegociacaoParc.strQtdParcelasCondPgto) Then
          iQtdParcelasCondPgto := StrToint(frmDigCondicaoPgtoNegociacaoParc.strQtdParcelasCondPgto)
       Else
          iQtdParcelasCondPgto := 1;

       fltTaxaCndPgto   := frmDigCondicaoPgtoNegociacaoParc.fltTaxaCnd;
       edtparcelas.text := IntToStr(iQtdParcelasCondPgto);
       edtTaxa.Text     := FormatFloat(edtTaxa.EditFormat, fltTaxaCndPgto);

       edtparcelas.enabled := False;

       If fltTaxaCndPgto <> 0.00 Then
          edtTaxa.enabled := False
       Else
          edtTaxa.enabled := True;

    End
    Else
    Begin
      rdgOperacao.itemindex := 0;
      edtparcelas.enabled   := True;
      edtTaxa.enabled       := True;
    End;

  End
  Else
  Begin
     edtparcelas.enabled := True;
     edtTaxa.enabled     := True;
     edtparcelas.text    := '1';
     edtTaxa.Text        := FormatFloat(edtTaxa.EditFormat, 0);
  End;

end;

function TfrmCtrNegociacaoParcelamento.RecalcularVencimentos(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LParcela: Integer;
begin
  FRecalculando := True;

  Result := FRecalculando;

  pgbProgresso.Visible := False;

  cdsParcelas.Post;

  objParcelamento.pCalcularParcelas(cdsParcelas.FieldByName('VENCIMENTO').AsDateTime,
                                    cdsParcelas.RecNo - 1);

  cdsParcelas.DisableControls;
  cdsParcelas.First;
  For LParcela := 0 To Length(objParcelamento.arrParcelas) - 1 Do
  Begin
    cdsParcelas.Edit;
    cdsParcelas.FieldByName('VENCIMENTO').AsDateTime := objParcelamento.arrParcelas[LParcela].dtaVencimento;
    cdsParcelas.FieldByName('SALDO_DEVEDOR').AsFloat := objParcelamento.arrParcelas[LParcela].fltSaldo;
    cdsParcelas.FieldByName('AMORTIZACAO').AsFloat := objParcelamento.arrParcelas[LParcela].fltAmortizacao;
    cdsParcelas.FieldByName('JUROS').AsFloat := objParcelamento.arrParcelas[LParcela].fltJuros;
    cdsParcelas.FieldByName('PRESTACAO').AsFloat := objParcelamento.arrParcelas[LParcela].fltValorParcela;
    cdsParcelas.FieldByName('PRESTACAO_A_PAGAR').AsFloat := objParcelamento.arrParcelas[LParcela].fltValorParcela;
    cdsParcelas.Post;

    cdsParcelas.Next;
  End;

  edtAmortizacao.Text := FormatFloat('#,##0.00', objParcelamento.fltTotalAmortizacao);
  edtJuros.Text       := FormatFloat('#,##0.00', objParcelamento.fltTotalJuros);
  edtValorFinal.Text  := FormatFloat('#,##0.00', objParcelamento.fltTotalParcelas);
  edtValorDesejado.Text := '0,00';

  pCalculaTotais;

  FRecalculando := False;
  cdsParcelas.EnableControls;
end;

procedure TfrmCtrNegociacaoParcelamento.ReclaculaJurosDuplicatasSeelcionadas;
  Var
    LValorSobra,
    LPercentualDuplicata,
    LCreditos: Double;

    LContador,
    LTotalDuplicatas: Integer;
begin
  If fFormataFloat(objParcelamento.fltTotalParcelas, 2) = fFormataFloat(objParcelamento.fltValorCorrigido, 2) Then
    Exit;

  LTotalDuplicatas := Length(objParcelamento.ArrayDocsAgrupar);

  LCreditos := 0;
  For LContador := 0 To LTotalDuplicatas - 1 Do
  Begin
    If objParcelamento.ArrayDocsAgrupar[LContador].fltValCor < 0 Then
      LCreditos := LCreditos + objParcelamento.ArrayDocsAgrupar[LContador].fltValCor;
  End;

  LValorSobra := objParcelamento.fltTotalJuros;
  For LContador := 0 To LTotalDuplicatas - 1 Do
  Begin
    If objParcelamento.ArrayDocsAgrupar[LContador].fltValCor < 0 Then
      Continue;

    LPercentualDuplicata := objParcelamento.ArrayDocsAgrupar[LContador].fltValCor / (objParcelamento.fltValorCorrigido + LCreditos);

    objParcelamento.ArrayDocsAgrupar[LContador].fltValCor := objParcelamento.ArrayDocsAgrupar[LContador].fltValCor -
                                                             objParcelamento.ArrayDocsAgrupar[LContador].fltValJur;

    objParcelamento.ArrayDocsAgrupar[LContador].fltValJur := objParcelamento.ArrayDocsAgrupar[LContador].fltValJur +
                                                             fFormataFloat(objParcelamento.fltTotalJuros * LPercentualDuplicata, 2);
    LValorSobra := LValorSobra - fFormataFloat(objParcelamento.fltTotalJuros * LPercentualDuplicata, 2);

    objParcelamento.ArrayDocsAgrupar[LContador].fltValCor := objParcelamento.ArrayDocsAgrupar[LContador].fltValCor +
                                                             objParcelamento.ArrayDocsAgrupar[LContador].fltValJur;
  End;

  If fFormataFloat(LValorSobra, 2) <> 0 Then
  Begin
    objParcelamento.ArrayDocsAgrupar[LTotalDuplicatas - 1].fltValJur := objParcelamento.ArrayDocsAgrupar[LTotalDuplicatas - 1].fltValJur +
                                                                        LValorSobra;

    objParcelamento.ArrayDocsAgrupar[LTotalDuplicatas - 1].fltValCor := objParcelamento.ArrayDocsAgrupar[LTotalDuplicatas - 1].fltValCor +
                                                                        LValorSobra;
  End;
end;

function TfrmCtrNegociacaoParcelamento.ValidarVencimentoDigitado(AVencimento: TDateTime;
  AParcela: String): Boolean;
  Var
    LParcelaAnterior,
    LProximaParcela: Integer;
    Dateb : TDatetime;
begin
  If AVencimento < VS_Date Then
  Begin
    fMensagem('ATENÇÃO', 'A data de vencimento não pode ser menor que a data atual!', ['&Ok']);
    Exit(False);
  End;

  If (AParcela = '001') Then
  Begin
     If fCfgSis('DIALRV', varString) <> '' Then
     Begin
         Dateb := Date + fCfgSis('DIALRV', varInteger);
         If AVencimento > Dateb Then
         Begin
            pMensagemOk('A data informada está excedendo a data limite configurada para inclusão da primeira parcela. Data limite: "' + DatetoStr(Dateb) + '"');
            exit(False);
         End;
     End;
  End;

  FCopiaParcelas.Filtered := True;

  LParcelaAnterior := StrToInt(AParcela) - 1;
  If LParcelaAnterior > 0 Then
  Begin
    FCopiaParcelas.Filter := 'PARCELA=' + fStrZero(LParcelaAnterior.ToString(), 3).QuotedString();
    Result := AVencimento > FCopiaParcelas.FieldByName('VENCIMENTO').AsDateTime;
  End
  Else
  Begin
    FCopiaParcelas.Filter := 'PARCELA='''' OR PARCELA IS NULL';

    Result := FCopiaParcelas.IsEmpty;

    If Not Result Then
    Begin
      FCopiaParcelas.Last;
      Result := AVencimento > FCopiaParcelas.FieldByName('VENCIMENTO').AsDateTime;
    End;
  End;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'A data de vencimento dessa parcela deve ser maior que ' +
                         FormatDateTime('dd/mm/yyyy', FCopiaParcelas.FieldByName('VENCIMENTO').AsDateTime) + '.', ['&Ok']);
    Exit;
  End;

  LProximaParcela := StrToInt(AParcela) + 1;
  FCopiaParcelas.Filter := 'PARCELA=' + fStrZero(LProximaParcela.ToString(), 3).QuotedString();

  If Not FCopiaParcelas.IsEmpty Then
  Begin
    Result := AVencimento < FCopiaParcelas.FieldByName('VENCIMENTO').AsDateTime;

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'A data de vencimento dessa parcela deve ser menor que ' +
                           FormatDateTime('dd/mm/yyyy', FCopiaParcelas.FieldByName('VENCIMENTO').AsDateTime) + '.', ['&Ok']);
      Exit;
    End;
  End;
end;

procedure TfrmCtrNegociacaoParcelamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(FCopiaParcelas) Then
    FreeAndNil(FCopiaParcelas);
end;

procedure TfrmCtrNegociacaoParcelamento.FormCreate(Sender: TObject);
begin
  inherited;
  cdsParcelas.CreateDataSet;
  blnEfetuandoRateio := False;
  objLiberacao := TLiberacao.Create;

  FRecalculando := False;
end;

procedure TfrmCtrNegociacaoParcelamento.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;

procedure TfrmCtrNegociacaoParcelamento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3    : btnCopiar.Click;

    VK_F4    : btnPrevia.Click;

    VK_F2    : btnAlterarVencimento.Click;

    VK_F10   : Begin
                 If btnConfirma.Enabled Then
                 Begin
                   btnConfirma.Click;
                   Key := 0;
                 End;
               End;

    VK_DELETE: If cxGridParcelas.Focused Then
                 Key := 0;

    VK_ESCAPE: If pnlGrid.Enabled Then
               Begin
                 If cdsParcelas.State In [dsEdit] Then
                 Begin
                   If fMensagem('ATENÇÃO', 'Deseja Cancelar a alteração do vencimento?', ['&Sim', '&Não']) = 1 Then
                     cdsParcelas.Cancel;

                   Exit;
                 End;

                 cdsParcelas.EmptyDataSet;

                 edtAmortizacao.Text := '0,00';
                 edtJuros.Text       := '0,00';
                 edtValorFinal.Text  := '0,00';
                 edtValPre.Text      := '0,00';
                 edtValPag.Text      := '0,00';
                 pnlGrid.Enabled     := False;
                 pnlDados.Enabled    := True;
                 btnAlterarVencimento.Enabled := False;

                 cxvGridParcelasVENCIMENTO.Properties.ReadOnly := True;
                 cxvGridParcelasVENCIMENTO.Options.Editing := False;

                 pSetFocus(edtParcelas);
               End
               Else
                 btnSair.Click;
  end;
end;

procedure TfrmCtrNegociacaoParcelamento.FormShow(Sender: TObject);
begin
  inherited;
  mskDataBase.Text       := DateToStr(objParcelamento.dtaDataBase);
  edtValorCorrigido.Text := FormatFloat('#,##0.00', objParcelamento.fltValorCorrigido);
  edtDesconto.Text       := FormatFloat('#,##0.00', objParcelamento.fltDesconto);
  edtValorDesejado.Text  := FormatFloat('#,##0.00', objParcelamento.fltValorDesejado);
  edtValorBase.Text      := FormatFloat('#,##0.00', objParcelamento.fltValorBase);

  chkIntervalo.Checked := True;

  blnConfirma      := False;
  pnlGrid.Enabled  := False;
  pnlDados.Enabled := True;

  btnConfirma.Enabled := (Not objParcelamento.blnSimulacao);
  btnHelpPrevia.Visible :=  objParcelamento.blnSimulacao;
  //pSetFocus(rdgOperacao);
  pSetFocus(TRadioGroup(rdgOperacao.Controls[0]));
end;

function TfrmCtrNegociacaoParcelamento.fChamaSenhaVariavel(strMsg : String = ''; strDirAce : String = ''; strCfgSis : String = '';
                                                           strMsgSen : String = ''; strOperador : String = ''; strNTrava : String = '';
                                                           strDirAceNv2: String = ''; strSenLibNv2: String = ''; blnNivel2: Boolean = False): Boolean;
  Var
    objMsg : TMensagemLiberacao;
begin
  objMsg := objParcelamento.GetMensagemLiberacao;
  Result := True;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.fGetObjectFromJson(objMsg.fGetJsonObject.ToJSON);

    objLiberacao.strDirAce := strDirAce;
    objLiberacao.strSenLib := fCfgSis(strCfgSis);
    objLiberacao.strMsgSen := strMsgSen;
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strOperador;
    objLiberacao.strCodDig := strOperador;
    objLiberacao.strDirAceNv2 := strDirAceNv2;
    objLiberacao.strSenLibNv2 := strSenLibNv2;
    objLiberacao.blnNivel2 := blnNivel2;
    objLiberacao.objMsgLibera.strTitulo := strMsg;
    objLiberacao.blnMosMen := False;

    While (True) Do
    Begin
      If objLiberacao.fLibera Then

        Break

      else
        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
        Begin
          Result := False;
          Exit;
        end;
    End;
  Finally
    objLiberacao.Clear;
  End;

end;

end.

