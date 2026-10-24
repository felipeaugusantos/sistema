{***************************}
{* qryConCar -> CADCAR     *}
{************************RP*}
unit untCadMovCartoesParcelas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  System.Generics.Collections, System.DateUtils, Uni,
  UniClientDataSet, untFramePlanoDeContasDBEditFocus, cxDBEdit, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, untFramePlanoDeContasMaskEdit, untTypesSistema, untConsultas,
  untFechamentoFinanceiro, System.StrUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadMovCartoesParcelas = class(TfrmPai)
    pnlFundo: TPanel;
    pnlDados: TPanel;
    Label6: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtDtaCup: TcxDateEdit;
    Label9: TLabel;
    edtNumCCD: TEditFocus;
    edtNumNSU: TEditFocus;
    lblConNsu: TLabel;
    edtConNsu: TEditFocus;
    edtValSta: TEditFocus;
    pnlTotal: TPanel;
    grdDuplic: TcxGridCitel;
    grdDuplicDados: TcxGridDBTableViewCitel;
    grdDuplicDadosMCA_NUMCCD: TcxGridDBColumn;
    grdDuplicDadosMCA_NUMNSU: TcxGridDBColumn;
    grdDuplicDadosMCA_DTACUP: TcxGridDBColumn;
    grdDuplicDadosMCA_VALSTA: TcxGridDBColumn;
    grdDuplicDadosPARDUP: TcxGridDBColumn;
    grdDuplicNivel: TcxGridLevel;
    grdDuplicDadosMCA_NUMNOT: TcxGridDBColumn;
    Label23: TLabel;
    edtValTot: TEditFocus;
    Label1: TLabel;
    edtQtdPar: TEditFocus;
    dtsMovCar: TDataSource;
    btnGravar: TBitBtnLocked;
    grdDuplicDadosMCA_DTAVEN: TcxGridDBColumn;
    Label4: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label29: TLabel;
    grbMovBan: TGroupBox;
    Label25: TLabel;
    edtDesPorCar: TEditFocus;
    edtCodCar: TEditFocus;
    edtDesCar: TEditFocus;
    edtPerCar: TEditFocus;
    edtValTax: TEditFocus;
    edtPorCar: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    edtDtaCad: TcxDateEdit;
    grdDuplicDadosMCA_CODCAR: TcxGridDBColumn;
    grdDuplicDadosMCA_DTACAD: TcxGridDBColumn;
    grdDuplicDadosMCA_PERCAR: TcxGridDBColumn;
    grdDuplicDadosMCA_VALTAX: TcxGridDBColumn;
    grdDuplicDadosMCA_CODCTA: TcxGridDBColumn;
    grdDuplicDadosMCA_CODPOR: TcxGridDBColumn;
    grpFrete: TGroupBox;
    chkDesmembrarFrete: TCheckBox;
    lblValorFrete: TLabel;
    edtValorFrete: TEditFocus;
    pnlConfirma: TPanel;
    rdgAltVal: TRadioGroup;
    btnIncluirParcela: TBitBtnLocked;
    btnExcluirParcela: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnVincularCredito: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnIncluirParcelaClick(Sender: TObject);
    procedure btnExcluirParcelaClick(Sender: TObject);
    procedure edtNumNSUKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCarExit(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorCarKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtValTaxExit(Sender: TObject);
    procedure grdDuplicDadosMCA_CODCARGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure grdDuplicDadosMCA_CODCTAGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure grdDuplicDadosMCA_CODPORGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure edtPerCarExit(Sender: TObject);
    procedure edtValStaExit(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnVincularCreditoClick(Sender: TObject);
  private
    { Private declarations }
    FblnAltPar,
    blnAltera : Boolean;
    FCodigoCartaoAtual:String;

    FstrNumDup,
    FstrCodEmp,
    FstrCodCli: String;
    FdtaDtaCad: TDate;

    FCodEmpresa : String;

    lstMovCarDelete: TStringList;

    cdsMovCar,
    FCloneMovCar: TUniClientDataset;

    fltTotVen : Double;

    qryConCartao: TUniQuery;
    qryConCta: TUniQuery;

    LCdsCartao: TUniClientDataSet;

    FRotina: String;

    FCodigoEmp : String;

    objFechamento: TFechamentoFinanceiro;

    blnUsaParBanDebContabil : boolean;
    blnCfg_UtiCon : boolean;

    sCodigoCartaoInicial : string;
    dDataCadInicial : TDate;
    dDataTraInicial : TDate;

    blnExitCodCar,
    FRecalculaComFrete: boolean;

    FMudouQuantidadeParcelas,
    FAlterarCartaoCaixaVinculado: Boolean;

    FAutoIncremCreditoSelecionado,
    FChaveCreditoSelecionado: String;

    FValorCreditoSelecionado,
    FPercentualAbatimento: Double;

    FRecalclaComPercentual: Boolean;

    FUsouVinculoCC : Boolean;

    procedure pExibeTotal;
    procedure pAlteraValoresParc(fltValor, LValorFrete: Double);
    procedure pRecalculaParcelas;
    function fValidaValores: Boolean;
    function CriaClientControleCartao(ANumDup, ACodEmp, ACodCli: String; ADtaCad: TDate) : TUniClientDataSet;
    procedure pCarregaCartao;
    procedure pCarregaCentroCusto;
    procedure CalculaValores(blnCalcPerc, ACalculaComFrete: Boolean);
    procedure ReCenter;

    function DeveAlterarOVencimento: Boolean;
    function RetonaNovoVencimento(ADataCalculo: TDateTime): TDateTime;
    Function fVerificaParametroContabilBandeira: Boolean;
    Function fConfiguracaoExiste(strCodCfg: string; strCodEmp: string = ''): boolean;
    Function fCfgConEmp: string;

    procedure ValorDoFreteApenasNaPrimeiraParcela;
    procedure VinculaCreditoParcelas;
    procedure VincularChaveCartaoCC;
    function RetornaValorRecalculo(AValorNormal, APorPercentual: Double): Double;

    function RetornaChaveCredito: String;
    function AdicionarCreditoHistorico(const AHistorico, AChaveCredito: string): string;
    function PermiteAlterarDados : Boolean;
    function ExistemMovimentosJaBaixados : Boolean;
    procedure pBaixarParcelasZeradasVinculo(const AChaveCredito: String);
 protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strCodEmpCar : String;
    { Public declarations }
    property blnAltPar: Boolean read FblnAltPar;
    property Rotina: String read FRotina write FRotina;
    property MudouQuantidadeParcelas: Boolean read FMudouQuantidadeParcelas;
    property AlterarCartaoCaixaVinculado: Boolean read FAlterarCartaoCaixaVinculado write FAlterarCartaoCaixaVinculado;

    procedure pCarregaParcelas(strNumDup, strCodEmp, strCodCli: String; dtaDtaCad: TDate);
  end;

var
  frmCadMovCartoesParcelas: TfrmCadMovCartoesParcelas;

implementation

Uses untFuncoes, untFuncoesSimples, untUtilRepository, untPesqAux, untLogMca,
  untCadMovCartoesParcelasCredito, untMovCar, untGravando, UNTlOGcTR;

{$R *.dfm}

{ TfrmCadMovCartoesParcelas }

procedure TfrmCadMovCartoesParcelas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  fRollBack;
  lstMovCarDelete.Clear;
  FreeAndNil(cdsMovCar);
  pCarregaParcelas(FstrNumDup, FstrCodEmp, FstrCodCli, FdtaDtaCad);
end;

procedure TfrmCadMovCartoesParcelas.btnConfirmarClick(Sender: TObject);
  Var
    fltValSta, fltDif: Double;
    intCont  : Integer;

    LAlterarVencimento: Boolean;

    LDataCalculoVencimento: TDateTime;

    LValorFrete: Double;

  function fGetDifParc(fltValor: Double): Double;
  Var fltValParc: Double;
  begin
    fltValParc := fFormataFloat((fltTotVen - fltValor) / (cdsMovCar.RecordCount -1), 2);
    Result := fFormataFloat((fltValParc * (cdsMovCar.RecordCount -1) - (fltTotVen - fltValor)), 2);
  end;
begin
  inherited;

  If Not FRecalclaComPercentual Then
  Begin
    If (fStrToFloat(edtValSta.Text) > fltTotVen) Or
       ((fStrToFloat(edtValSta.Text) = fltTotVen) And (cdsMovCar.RecordCount > 1)) Then
    Begin
      fMensagem('ATENÇÃO', 'O valor sem taxa não pode ser igual ou superior ao valor total!', ['&Ok']);
      pSetFocus(edtValSta);
      Exit;
    End;

    If edtConNsu.Visible Then
    Begin
      If edtNumNSU.Text <> edtConNsu.Text Then
      Begin
        fMensagem('ATENÇÃO', 'NSU não confere!', ['&Ok']);
        pSetFocus(edtConNsu);
        Exit;
      End;
    End;

    If Not fVerificacampos Then
      Exit;

    If rdgAltVal.ItemIndex < 2 Then
    Begin
      If fMensagem('ATENÇÃO', 'Ao escolher a opção "' + rdgAltVal.Items[rdgAltVal.ItemIndex] +
                              '", o sistema alterará a ' + LowerCase(rdgAltVal.Items[rdgAltVal.ItemIndex]) +
                              ' pelo valor digitado e recalculará todas as outras. Deseja continuar?',
                              ['Sim', 'Não']) = 2 Then
        Exit;
    End;
  End;

  edtValSta.Text := RetornaValorRecalculo(fStrToFloat(edtValSta.Text), fStrToFloat(edtValSta.Text)).ToString;

  LValorFrete := 0;

  If FRecalculaComFrete Then
    LValorFrete := fFormataFloat(fStrToFloat(edtValorFrete.Text) / cdsMovCar.RecordCount, 2);

  cdsMovCar.DisableControls;
  If rdgAltVal.ItemIndex <> 1 Then
    cdsMovCar.First
  Else
    cdsMovCar.Last;

  LAlterarVencimento := DeveAlterarOVencimento;

  LDataCalculoVencimento := IIF(fCfgSis('CTCDCV', VarBoolean),
                                edtDtaCad.Date,
                                edtDtaCup.Date);

  fltValSta := fltTotVen;
  If (rdgAltVal.ItemIndex <> 2) And (cdsMovCar.RecordCount > 1) Then
  Begin
    cdsMovCar.Edit;
    cdsMovCar.FieldByName('MCA_NUMCCD').AsString := edtNumCCD.Text;
    cdsMovCar.FieldByName('MCA_NUMNSU').AsString := edtNumNSU.Text;
    cdsMovCar.FieldByName('MCA_DTACUP').AsDateTime := edtDtaCup.Date;
    cdsMovCar.FieldByName('MCA_VALSTA').AsFloat := RetornaValorRecalculo(fFormataFloat(fStrToFloat(edtValSta.Text), 2), cdsMovCar.FieldByName('MCA_VALSTA').AsFloat);
    cdsMovCar.FieldByName('MCA_PERCAR').AsFloat := RetornaValorRecalculo(fStrToFloat(edtPerCar.Text), cdsMovCar.FieldByName('MCA_PERCAR').AsFloat);
    cdsMovCar.FieldByName('MCA_FREMKT').AsFloat := RetornaValorRecalculo(fFormataFloat(LValorFrete, 2), cdsMovCar.FieldByName('MCA_FREMKT').AsFloat);

    cdsMovCar.FieldByName('MCA_VALORI').AsFloat := cdsMovCar.FieldByName('MCA_VALSTA').AsFloat -
                                                   fFormataFloat(LValorFrete, 2) -
                                                   (cdsMovCar.FieldByName('MCA_VALSTA').AsFloat *
                                                   (cdsMovCar.FieldByName('MCA_PERCAR').AsFloat / 100));

    cdsMovCar.FieldByName('MCA_VALDUP').AsFloat := cdsMovCar.FieldByName('MCA_VALORI').AsFloat;

    cdsMovCar.FieldByName('MCA_VALTAX').AsFloat := (cdsMovCar.FieldByName('MCA_VALSTA').AsFloat *
                                                   (cdsMovCar.FieldByName('MCA_PERCAR').AsFloat / 100));
    cdsMovCar.FieldByName('MCA_DTACAD').AsDateTime := edtDtaCad.Date;
    cdsMovCar.FieldByName('MCA_CODCAR').AsString := edtCodCar.Text;
    cdsMovCar.FieldByName('MCA_PORCAR').AsString := edtPorCar.Text;
    cdsMovCar.FieldByName('MCA_CTACAR').AsString := fraplanodeContas.mskCodCta.Text;

    If rdgAltVal.ItemIndex = 0 Then
    Begin
      If LAlterarVencimento Then
      Begin
        cdsMovCar.FieldByName('MCA_DTAVEN').AsDateTime := RetonaNovoVencimento(LDataCalculoVencimento);
        LDataCalculoVencimento := cdsMovCar.FieldByName('MCA_DTAVEN').AsDateTime;
      End;
    End;

    cdsMovCar.Post;
    fltValSta := fltValSta - fStrToFloat(edtValSta.Text);
    fltValSta := fFormataFloat(fltValSta / (cdsMovCar.RecordCOunt - 1), 2);
  End
  Else
    fltValSta := fStrToFloat(edtValSta.Text);

  If rdgAltVal.ItemIndex = 0 Then
    cdsMovCar.Next
  Else If rdgAltVal.ItemIndex = 1 Then
    cdsMovCar.First;

  For intCont := 1 To IIF((rdgAltVal.ItemIndex <> 2) And (cdsMovCar.RecordCount > 1), cdsMovCar.RecordCount - 1, cdsMovCar.RecordCount) Do
  Begin
    cdsMovCar.Edit;

    cdsMovCar.FieldByName('MCA_NUMCCD').AsString := edtNumCCD.Text;
    cdsMovCar.FieldByName('MCA_NUMNSU').AsString := edtNumNSU.Text;
    cdsMovCar.FieldByName('MCA_DTACUP').AsDateTime := edtDtaCup.Date;
    cdsMovCar.FieldByName('MCA_VALSTA').AsFloat := RetornaValorRecalculo(fFormataFloat(fltValSta, 2), cdsMovCar.FieldByName('MCA_VALSTA').AsFloat);
    cdsMovCar.FieldByName('MCA_PERCAR').AsFloat := RetornaValorRecalculo(fStrToFloat(edtPerCar.Text), cdsMovCar.FieldByName('MCA_PERCAR').AsFloat);
    cdsMovCar.FieldByName('MCA_FREMKT').AsFloat := RetornaValorRecalculo(fFormataFloat(LValorFrete, 2), cdsMovCar.FieldByName('MCA_FREMKT').AsFloat);

    cdsMovCar.FieldByName('MCA_VALORI').AsFloat := cdsMovCar.FieldByName('MCA_VALSTA').AsFloat -
                                                   fFormataFloat(LValorFrete, 2) -
                                                   (cdsMovCar.FieldByName('MCA_VALSTA').AsFloat *
                                                   (cdsMovCar.FieldByName('MCA_PERCAR').AsFloat / 100));

    cdsMovCar.FieldByName('MCA_VALDUP').AsFloat := cdsMovCar.FieldByName('MCA_VALORI').AsFloat;

    cdsMovCar.FieldByName('MCA_VALTAX').AsFloat := (cdsMovCar.FieldByName('MCA_VALSTA').AsFloat *
                                                   (cdsMovCar.FieldByName('MCA_PERCAR').AsFloat / 100));

    cdsMovCar.FieldByName('MCA_DTACAD').AsDateTime := edtDtaCad.Date;
    cdsMovCar.FieldByName('MCA_CODCAR').AsString := edtCodCar.Text;
    cdsMovCar.FieldByName('MCA_PORCAR').AsString := edtPorCar.Text;
    cdsMovCar.FieldByName('MCA_CTACAR').AsString := fraplanodeContas.mskCodCta.Text;

    If LAlterarVencimento Then
    Begin
      cdsMovCar.FieldByName('MCA_DTAVEN').AsDateTime := RetonaNovoVencimento(LDataCalculoVencimento);
      LDataCalculoVencimento := cdsMovCar.FieldByName('MCA_DTAVEN').AsDateTime;
    End;

    cdsMovCar.Post;

    cdsMovCar.Next;
  End;

  If rdgAltVal.ItemIndex = 1 Then
  Begin
    If LAlterarVencimento Then
    Begin
      cdsMovCar.Edit;
      cdsMovCar.FieldByName('MCA_DTAVEN').AsDateTime := RetonaNovoVencimento(LDataCalculoVencimento);
      cdsMovCar.Post;
    End;
  End;

  {*************************************************}
  {* AJUSTA A DIFERENÇA NA PRIMEIRA/ÚLTIMA PARCELA *}
  {*REQ*155086***********************************RP*}
  If rdgAltVal.ItemIndex < 2 Then
  Begin
    fltDif := fGetDifParc(fFormataFloat(fStrToFloat(edtValSta.Text), 2));

    If fltDif <> 0 Then
    Begin
      If rdgAltVal.ItemIndex = 0 Then
        cdsMovCar.Last
      Else If rdgAltVal.ItemIndex = 1 Then
        cdsMovCar.First;

      pAlteraValoresParc(cdsMovCar.FieldByName('MCA_VALSTA').AsFloat - fltDif, LValorFrete);
    End;

    If LValorFrete > 0 Then
    Begin
      If fFormataFloat(LValorFrete * cdsMovCar.RecordCount, 2) <> fFormataFloat(fStrToFloat(edtValorFrete.Text), 2) Then
        pAlteraValoresParc(cdsMovCar.FieldByName('MCA_VALSTA').AsFloat,
                           LValorFrete -
                            (fFormataFloat(LValorFrete * cdsMovCar.RecordCount, 2) - fFormataFloat(fStrToFloat(edtValorFrete.Text), 2)));
    End;
  End;

  pSetFocus(grdDuplic);

  blnAltera := True;
  cdsMovCar.EnableControls;
  pExibeTotal;
end;

procedure TfrmCadMovCartoesParcelas.btnIncluirParcelaClick(Sender: TObject);
  Var
    LCloneDados: TUniClientDataSet;

    intParcela: Integer;

    LContador: Integer;
begin
  inherited;
  cdsMovCar.DisableControls;

  LCloneDados := fCriaCLientDatSet(cdsMovCar);
  LCloneDados.Open;
  LCloneDados.Last;

  Try
    cdsMovCar.Last;

    If MatchStr(cdsMovCar.FieldByName('MCA_PARCEL').AsString, ['Z', '999']) Then
    Begin
      pMensagemOK('Limite de parcelas atingido!');
      Exit;
    End;

    If Not fVerificaCampos Then
       exit;

    If qryConCartao.FieldByName('CAR_MAXPAR').AsInteger > 0 Then
    Begin
      If cdsMovCar.RecordCount >= qryConCartao.FieldByName('CAR_MAXPAR').AsInteger Then
      Begin
        pMensagemOK('Quantidade máxima de parcelas atingida para este cartão!');
        Exit;
      End;
    End;

    If fMensagem('ATENÇÃO', 'Ao incluir uma nova parcela, o sistema recalculará o valor de todas as outras. Deseja continuar?',
                 ['Sim', 'Não']) = 2 Then
      Exit;

    cdsMovCar.Append;
    For LContador := 0 To cdsMovCar.Fields.Count - 1 Do
      cdsMovCar.Fields[LContador].Value := LCloneDados.Fields[LContador].Value;

    //incrementa a nova parcela (pode ser letra ou número)
    If TryStrToInt(Trim(cdsMovCar.FieldByName('MCA_PARCEL').AsString), intParcela) Then
      cdsMovCar.FieldByName('MCA_PARCEL').AsString := IntToStr(fInc(intParcela))
    Else
    Begin
      intParcela := Ord(cdsMovCar.FieldByName('MCA_PARCEL').AsString[1]);
      cdsMovCar.FieldByName('MCA_PARCEL').AsString := Char(fInc(intParcela));
    End;

    cdsMovCar.FieldByName('AUTOINCREM').AsString := EmptyStr;
    cdsMovCar.FieldByName('MCA_DTAVEN').AsDateTime := IncDay(cdsMovCar.FieldByName('MCA_DTAVEN').AsDateTime,
                                                             qryConCartao.FieldByName('CAR_PERIOD').AsInteger);

    cdsMovCar.Post;

    pRecalculaParcelas();

    blnAltera := True;
  Finally
    cdsMovCar.EnableControls;

    FreeAndNil(LCloneDados);

    grdDuplicDados.Controller.FocusedRowIndex := grdDuplicDados.ViewData.RowCount -1;
  End;
end;

procedure TfrmCadMovCartoesParcelas.btnVincularCreditoClick(Sender: TObject);
Var
    LCadMovCartoesParcelasCredito: TfrmCadMovCartoesParcelasCredito;
begin
  inherited;

  If Not btnVincularCredito.Enabled Then
    Exit;

  If fEmptyStr(fCfgSis('PORCMC', varString)) Or
     fEmptyStr(fCfgSis('CTACMC', varString)) Then
  Begin
    fMensagem('ATENÇÃO', 'As configurações [CFG_PORCMC] (Portador de baixa) e [CFG_CTACMC] (Plano de Contas de baixa) devem '+
                         'estar devidamente preenchidas para que seja possível realizar a vinculação do crédito de cliente ao cartão.', ['&O k']);

    Exit;
  End;

  FUsouVinculoCC := False;

  Try
    pCriarFormularios(TfrmCadMovCartoesParcelasCredito, LCadMovCartoesParcelasCredito);
    LCadMovCartoesParcelasCredito.ValorVendaOriginal := fltTotVen;
    LCadMovCartoesParcelasCredito.QuantidadeParcelas := cdsMovCar.RecordCount;

    LCadMovCartoesParcelasCredito.edtCodigoCliente.Text := cdsMovCar.FieldByName('MCA_CODCLI').AsString;

    LCadMovCartoesParcelasCredito.ShowModal;

    If LCadMovCartoesParcelasCredito.ModalResult <> mrOk Then
      Exit;

    FAutoIncremCreditoSelecionado := LCadMovCartoesParcelasCredito.AutoIncremCreditoSelecionado;
    FValorCreditoSelecionado := LCadMovCartoesParcelasCredito.ValorCreditoSelecionado;
    FChaveCreditoSelecionado := LCadMovCartoesParcelasCredito.ChaveCreditoSelecionado;

    If FAutoIncremCreditoSelecionado.IsEmpty Then
      Exit;
  Finally
    FreeAndNil(LCadMovCartoesParcelasCredito);
  End;

  if fMensagem('ATENÇÃO', 'Deseja realmente vincular o crédito no valor de ' + FormatFloat(',0.00', FValorCreditoSelecionado) +
                          ' e recalcular as parcelas do cartão?', ['&Sim', '&Não']) = 2 Then
  Begin
    fLock_Unlock(FChaveCreditoSelecionado, False);
    FAutoIncremCreditoSelecionado := EmptyStr;
    FValorCreditoSelecionado := 0;

    Exit;
  End;

  TfrmGravando.fExecutarModal(VinculaCreditoParcelas, 'Aguarde... Vinculando o crédito.', '');
end;

function TfrmCadMovCartoesParcelas.CriaClientControleCartao(ANumDup, ACodEmp,ACodCli: String; ADtaCad: TDate): TUniClientDataSet;
begin
  Result := Nil;

  Try
    Result := TUniClientDataSet.Create(Nil);
    Result.FieldDefs.Add('MCA_NUMDUP',ftString,12);
    Result.FieldDefs.Add('MCA_CODEMP',ftString,03);
    Result.FieldDefs.Add('MCA_CODCLI',ftString,08);
    Result.FieldDefs.Add('MCA_DTACAD',ftDate);
    Result.CreateDataSet;

    Result.Append;
    Result.FieldByName('MCA_NUMDUP').AsString   := ANumDup;
    Result.FieldByName('MCA_CODEMP').AsString   := ACodEmp;
    Result.FieldByName('MCA_CODCLI').AsString   := ACodCli;
    Result.FieldByName('MCA_DTACAD').AsDateTime := ADtaCad;
    Result.Post;
  Except
    On E : Exception Do
    Begin
      pMensagensErro('Erro gerado: ' + E.Message, '[untCadMovCarParcelas.CriaClientControleCartao]');
    End;
  End;
end;

function TfrmCadMovCartoesParcelas.DeveAlterarOVencimento: Boolean;
begin
  Result := cdsMovCar.FieldByName('MCA_DTACAD').AsDateTime <> edtDtaCad.Date;
  If Not fCfgSis('CTCDCV', VarBoolean) Then
    Result := cdsMovCar.FieldByName('MCA_DTACUP').AsDateTime <> edtDtaCup.Date;
end;

procedure TfrmCadMovCartoesParcelas.btnExcluirParcelaClick(Sender: TObject);
begin
  inherited;
  If cdsMovCar.RecordCount = 1 Then
  Begin
    pMensagemOK('Não é permitido excluir todas as parcelas!');
    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Ao excluir uma parcela, o sistema recalculará o valor de todas as outras. Deseja continuar?',
               ['Sim', 'Não']) = 2 Then
    Exit;

  cdsMovCar.DisableControls;
  Try
    cdsMovCar.Last;

    lstMovCarDelete.Add(cdsMovCar.FieldByName('AUTOINCREM').AsString);

    cdsMovCar.Delete;

    pRecalculaParcelas();

    blnAltera := True;
  Finally
    cdsMovCar.EnableControls;

    grdDuplicDados.Controller.FocusedRowIndex := grdDuplicDados.ViewData.RowCount -1;
  End;
end;

procedure TfrmCadMovCartoesParcelas.pBaixarParcelasZeradasVinculo(const AChaveCredito: String);
  Var
    LConsulta,
    LZerarTaxa: TUniQuery;
begin
  LConsulta := nil;
  LZerarTaxa := nil;
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM, MCA_NUMDUP, MCA_PARCEL, MCA_CODCLI, MCA_CODEMP ' +
                          '  FROM MOVCAR                    ' +
                          ' WHERE MCA_NUMDUP = :NUMDUP      ' +
                          '   AND MCA_CODEMP = :CODEMP      ' +
                          '   AND MCA_CODCLI = :CODCLI      ' +
                          '   AND MCA_CHA_CC = :CHACC       ' +
                          '   AND MCA_DTAREC IS NULL        ' +
                          '   AND MCA_VALSTA = 0            ' +
                          '   AND IFNULL(MCA_FREMKT, 0) = 0 ' +
                          '   AND IFNULL(MCA_CUPMKT, 0) = 0 ' +
                          '   AND IFNULL(MCA_VALAJU, 0) = 0 ';

    LConsulta.ParamByName('NUMDUP').AsString := FstrNumDup;
    LConsulta.ParamByName('CODEMP').AsString := FstrCodEmp;
    LConsulta.ParamByName('CODCLI').AsString := FstrCodCli;
    LConsulta.ParamByName('CHACC').AsString  := AChaveCredito;
    LConsulta.Open;

    LZerarTaxa := fCriaQuery;
    LZerarTaxa.SQL.Text := 'UPDATE MOVCAR SET MCA_VALTAX = 0 WHERE AUTOINCREM = :AUTINC';

    While Not LConsulta.Eof Do
    Begin
      LZerarTaxa.ParamByName('AUTINC').AsString := LConsulta.FieldByName('AUTOINCREM').AsString;
      LZerarTaxa.ExecSQL;

      fBaixaCartao(Self.Name,
                   'BAIXA DE CARTÕES (Automaticamente decorrente de vínculo de crédito)',
                   LConsulta.FieldByName('AUTOINCREM').AsString,
                   LConsulta.FieldByName('MCA_NUMDUP').AsString,
                   LConsulta.FieldByName('MCA_PARCEL').AsString,
                   LConsulta.FieldByName('MCA_CODCLI').AsString,
                   LConsulta.FieldByName('MCA_CODEMP').AsString,
                   VS_Date,
                   0,
                   strLoginUsuarioLogado,
                   'BAIXA AUTOMATICA - VINCULO DE CREDITO CLIENTE',
                   fCfgSis('PORCMC', varString),
                   fCfgSis('CTACMC', varString),
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   '',
                   '');

      LConsulta.Next;
    End;
  Finally
    FreeAndNilDatasets(LConsulta);
    FreeAndNilDatasets(LZerarTaxa);
  End;
end;

procedure TfrmCadMovCartoesParcelas.btnGravarClick(Sender: TObject);
  Var
    LAutoIncrem,
    LChaveCredito: String;

    LInserir,
    LAtualizar: TUniQuery;

    LContador: Integer;
    LSucesso: Boolean;
begin
  inherited;

  LInserir := nil;
  LAtualizar := nil;
  LSucesso := False;

  If Not blnAltera Then
  Begin
    pMensagemOK('É necessário alterar algum valor para continuar.');
    Exit;
  End;

  {************************************************}
  {* EU NÃO ESTOU LOUCO. FOI COLOCADO COMO STRING *}
  {* A VERIFICAÇÃO POIS COMO DOUBLE NÃO ESTAVA    *}
  {* FUNCIONANDO. NÃO ME PESGUNTE O PORQUÊ, POIS  *}
  {* NÃO FAÇO IDEIA                               *}
  {*********************************************AJ*}
  If (edtValTot.Text <> FormatFloat(',0.00', fltTotVen)) Then
  Begin
    pMensagemOK('Valor total gerado não bate com o valor total da venda. Verifique!');
    Exit;
  End;

  If ((Not fValidaValores) And (Not FUsouVinculoCC)) Then
  Begin
    pMensagemOK('O Valor das parcelas deve ser maior que 0 (zero)!');
    pSetFocus(grdDuplic);
    Exit;
  End;

  If fMensagem('CONFIRMAÇÃO', 'Confirma a alteração de valor da(s) parcela(s)?', ['&Sim', '&Não']) = 2 Then
    Exit;

  If Not PermiteAlterarDados Then
  Begin
    pSetFocus(grdDuplic);
    Exit;
  End;

  ValorDoFreteApenasNaPrimeiraParcela;

  LChaveCredito := RetornaChaveCredito;

  cdsMovCar.DisableControls;
  Try
    Try
      LInserir := fCriarQuery('SELECT * FROM MOVCAR WHERE FALSE');
      LInserir.Open;

      LAtualizar := fCriaQuery;
      LAtualizar.SQL.Text := 'SELECT * FROM MOVCAR WHERE AUTOINCREM=:AUTINC';

      fStartTransaction;

      For LAutoIncrem In lstMovCarDelete Do
      Begin
        Try
          FCloneMovCar.Locate('AUTOINCREM', LAutoIncrem, []);

          If Not LCdsCartao.Locate('MCA_NUMDUP;MCA_CODEMP;MCA_CODCLI',
                        VarArrayOf([FCloneMovCar.FieldByName('MCA_NUMDUP').AsString,
                                    FCloneMovCar.FieldByName('MCA_CODEMP').AsString,
                                    FCloneMovCar.FieldByName('MCA_CODCLI').AsString]),[]) Then
          Begin
            fRollBack;
            pMensagemOK('Ocorreu um problema ao salvar as alterações. Por favor, Feche a rotina e reinicie a operação!');
            Exit;
          End;

          FMudouQuantidadeParcelas := True;

          untLogMca.GravaLogMca(LAutoIncrem,
                                'EXCLUSÃO',
                                Self.Name);

          untFuncoesSimples.fVerificaIntegridade(Self.Name, 'MOVCAR', FCloneMovCar);
          fExecutaSQL('DELETE FROM MOVCAR WHERE AUTOINCREM="' + LAutoIncrem + '"')
        Except On E: Exception Do
          Raise Exception.CreateFmt('Não foi possível excluir a parcela %s (%s)', [FCloneMovCar.FieldByName('MCA_PARCEL').AsString, E.Message]);
        End;
      End;

      cdsMovCar.First;
      While not cdsMovCar.Eof Do
      Begin

        If Not LCdsCartao.Locate('MCA_NUMDUP;MCA_CODEMP;MCA_CODCLI',
                      VarArrayOf([cdsMovCar.FieldByName('MCA_NUMDUP').AsString,
                                  cdsMovCar.FieldByName('MCA_CODEMP').AsString,
                                  cdsMovCar.FieldByName('MCA_CODCLI').AsString]),[]) Then
        Begin
          fRollBack;
          pMensagemOK('Ocorreu um problema ao salvar as alterações. Por favor, Feche a rotina e reinicie a operação!');
          Exit;
        End;

        If cdsMovCar.FieldByName('AUTOINCREM').AsString.IsEmpty Then
        Begin
          Try
            LInserir.Append;
            For LContador := 0 To cdsMovCar.Fields.Count - 1 Do
              LInserir.Fields[LContador].Value := cdsMovCar.Fields[LContador].Value;

            LAutoIncrem := fRetAutoIncrem('MOVCAR', VS_strCodEmp);
            LInserir.FieldByName('AUTOINCREM').AsString := LAutoIncrem;

            If Not LChaveCredito.IsEmpty Then
            Begin
              LInserir.FieldByName('MCA_CHA_CC').AsString := LChaveCredito;

              LInserir.FieldByName('MCA_HIST02').AsString := AdicionarCreditoHistorico(LInserir.FieldByName('MCA_HIST02').AsString,LChaveCredito);
            End;

            LInserir.Post;

            FMudouQuantidadeParcelas := True;

            untLogMca.GravaLogMca(LAutoIncrem,
                                  'INCLUSÃO MANUAL' + IIF(FRotina.IsEmpty, '', ' - ' + FRotina),
                                  Self.Name);
          Except
            On E: Exception Do
            Begin
              Raise Exception.CreateFmt('Não foi possível incluir a parcela %s (%s)', [cdsMovCar.FieldByName('MCA_PARCEL').AsString, E.Message]);
            End;
          End;
        End
        Else
        Begin
          Try
            LAtualizar.Close;
            LAtualizar.ParamByName('AUTINC').AsString := cdsMovCar.FieldByName('AUTOINCREM').AsString;
            LAtualizar.Open;

            LAtualizar.Edit;
            For LContador := 0 To cdsMovCar.Fields.Count - 1 Do
            Begin
              If LAtualizar.Fields[LContador].Value <> cdsMovCar.Fields[LContador].Value Then
                LAtualizar.Fields[LContador].Value := cdsMovCar.Fields[LContador].Value;
            End;

            If Not LChaveCredito.IsEmpty Then
            Begin
              LAtualizar.FieldByName('MCA_CHA_CC').AsString := LChaveCredito;

              LAtualizar.FieldByName('MCA_HIST02').AsString := AdicionarCreditoHistorico(LAtualizar.FieldByName('MCA_HIST02').AsString,LChaveCredito);
            End;

            LAtualizar.Post;

            untLogMca.GravaLogMca(cdsMovCar.FieldByName('AUTOINCREM').AsString,
                                  'ALTERAÇÃO' + IIF(FRotina.IsEmpty, '', ' - ' + FRotina),
                                  Self.Name);
          Except On E: Exception Do
            raise Exception.CreateFmt('Não foi possível alterar a parcela %s (%s)', [cdsMovCar.FieldByName('MCA_PARCEL').AsString, E.Message]);
          End;
        End;

        cdsMovCar.Next;
      End;

      If Not LChaveCredito.IsEmpty Then
      Begin
        VincularChaveCartaoCC;
        pBaixarParcelasZeradasVinculo(LChaveCredito);
      End;

      fCommit;
      FUsouVinculoCC := False;
      LSucesso := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro('Ocorreu um erro ao gravar as parcelas. Erro gerado: ' + E.Message, '[untCadMovCarParcelas.btnGravarClick]');
      End;
    End;
  Finally
    cdsMovCar.EnableControls;

    FreeAndNilDatasets(LInserir);
    FreeAndNilDatasets(LAtualizar);
  End;

  If LSucesso Then
  Begin
    pMensagemOK('Dados gravados com sucesso!');
    Self.Close;
  End;

end;

procedure TfrmCadMovCartoesParcelas.edtCodCarExit(Sender: TObject);
begin
  inherited;
  blnExitCodCar := True;
  fValidaCampos(edtCodCar,True);
end;

procedure TfrmCadMovCartoesParcelas.edtCodCarKeyPress(Sender: TObject; var Key: Char);
Var
  arrCartao : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE CARTOES  *}
  {**************************DP*}
  If fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, True, False, False, False, False, False, VS_strCodEmp) Then
  Begin
     If (fValidaCampos(Self, True)) Then
        Self.SelectNext(ActiveControl, True, True);

     pCarregaCartao;
  End;
end;

procedure TfrmCadMovCartoesParcelas.edtNumNSUKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Not CharInSet(Key, ['0'..'9', #8, #9]) Then
    Key := #0
end;

procedure TfrmCadMovCartoesParcelas.edtPerCarExit(Sender: TObject);
begin
  inherited;
  CalculaValores(True, FRecalculaComFrete);
end;

procedure TfrmCadMovCartoesParcelas.edtPorCarKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqPortador(conSimples,
                   Self,
                   edtPorCar,
                   edtDesPorCar,
                   nil,
                   Key,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   VS_strCodEmp) Then
  Begin
    If fValidaCampos(edtPorCar) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovCartoesParcelas.edtValStaExit(Sender: TObject);
begin
  inherited;
  CalculaValores(true, FRecalculaComFrete);
end;

procedure TfrmCadMovCartoesParcelas.edtValTaxExit(Sender: TObject);
begin
  inherited;
  CalculaValores(False, FRecalculaComFrete);
end;

function TfrmCadMovCartoesParcelas.ExistemMovimentosJaBaixados: Boolean;
var
  LConsulta : TUniQuery;
  LSQL : String;
begin
  Result := False;
  LSQL := EmptyStr;

  LConsulta := fCriaQuery;
  try
    LSQL :=        'SELECT *                 ';
    LSQL := LSQL + '  FROM MOVCAR            ';
    LSQL := LSQL + ' WHERE MCA_NUMDUP = :NUMDUP ';
    LSQL := LSQL + '   AND MCA_CODEMP = :CODEMP ';
    LSQL := LSQL + '   AND MCA_CODCLI = :CODCLI ';
    LSQL := LSQL + '   AND MCA_DTAREC IS NOT NULL ';
    LSQL := LSQL + '   AND MCA_VALREC <> 0        ';

    If FdtaDtaCad <> 0 Then
      LSQL := LSQL + '  AND MCA_DTACAD= :DTACAD ';

    LSQL := LSQL + 'ORDER BY MCA_PARCEL';

    LConsulta.SQL.Text := LSQL;

    LConsulta.ParamByName('NUMDUP').AsString := FstrNumDup;
    LConsulta.ParamByName('CODEMP').AsString := FstrCodEmp;
    LConsulta.ParamByName('CODCLI').AsString := FstrCodCli;
    If Assigned(LConsulta.FindParam('DTACAD')) Then
      LConsulta.ParamByName('DTACAD').AsDateTime := FdtaDtaCad;

    LConsulta.Open;

    if not LConsulta.IsEmpty then
      Result := True;
  finally
    FreeAndNilDatasets(LConsulta);
  end;
end;

procedure TfrmCadMovCartoesParcelas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  FreeAndNil(cdsMovCar);
  FreeAndNil(lstMovCarDelete);
  FreeAndNil(LCdsCartao);
  FreeAndNil(FCloneMovCar);
end;

procedure TfrmCadMovCartoesParcelas.FormCreate(Sender: TObject);
begin
  inherited;
  fltTotVen    := 0;
  qryConCartao := fCriaQuery(Self);
  qryConCta    := fCriaQuery(Self);

  lstMovCarDelete := TStringList.Create;

  FMudouQuantidadeParcelas := False;

  FAlterarCartaoCaixaVinculado := True;

  FUsouVinculoCC := False;
end;

procedure TfrmCadMovCartoesParcelas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnGravar.Click;
    VK_F11: btnVincularCredito.Click;
  End;
end;

procedure TfrmCadMovCartoesParcelas.FormResize(Sender: TObject);
begin
  inherited;
  ReCenter();
end;

procedure TfrmCadMovCartoesParcelas.FormShow(Sender: TObject);
begin
  inherited;
  If fCfgSis('VALNSU', VarBoolean) Then
  Begin
    edtNumNSU.PasswordChar := '*';
    edtNumNSU.CompZeros    := False;
    edtConNsu.Visible      := True;
    lblConNsu.Visible      := True;
  End
  Else
  Begin
    edtNumNSU.PasswordChar := #0;
    edtNumNSU.CompZeros    := True;
    edtConNsu.Visible      := False;
    lblConNsu.Visible      := False;
  End;

  blnCfg_UtiCon := fCfgSis('UTICON', varBoolean);
  blnUsaParBanDebContabil := fVerificaParametroContabilBandeira();

  edtValSta.Enabled := fVerificaAcessoSistema('CARALTVLSTX'  , strLoginUsuarioLogado);
  edtPerCar.Enabled := fVerificaAcessoSistema('CARALTTXVLADM', strLoginUsuarioLogado);
  edtValTax.Enabled := fVerificaAcessoSistema('CARALTTXVLADM', strLoginUsuarioLogado);

  pPesquisaCadCar(qryConCartao, qryConCartao, cdsMovCar.FieldByName('MCA_CODCAR').AsString);

  edtDtaCad.Enabled := FAlterarCartaoCaixaVinculado;

  pSetFocus(edtNumCCD);

  If Not cdsMovCar.FieldByName('MCA_CHA_CC').AsString.IsEmpty Then
    btnVincularCredito.Enabled := False;
end;

function TfrmCadMovCartoesParcelas.fValidaValores: Boolean;
begin
  cdsMovCar.DisableControls;
  Try
    cdsMovCar.First;
    While Not cdsMovCar.Eof Do
    Begin
      If cdsMovCar.FieldByName('MCA_VALDUP').AsFloat <= 0 Then
        Exit(False);

      cdsMovCar.Next;
    End;

    Result := True;
  Finally
    cdsMovCar.EnableControls;
  End;
end;

procedure TfrmCadMovCartoesParcelas.grdDuplicDadosMCA_CODCARGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := AText + ' - ' + fRetNomeCartao(AText);
end;

procedure TfrmCadMovCartoesParcelas.grdDuplicDadosMCA_CODCTAGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Not AText.IsEmpty Then
    AText := AText + ' - ' + fRetDescCentroCusto(AText);
end;

procedure TfrmCadMovCartoesParcelas.grdDuplicDadosMCA_CODPORGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Not AText.IsEmpty Then
    AText := AText + ' - ' + fRetNomPortador(AText);
end;

procedure TfrmCadMovCartoesParcelas.pAlteraValoresParc(fltValor, LValorFrete: Double);
begin
  cdsMovCar.Edit;
  cdsMovCar.FieldByNAme('MCA_VALSTA').AsFloat := fltValor;
  cdsMovCar.FieldByNAme('MCA_VALORI').AsFloat := cdsMovCar.FieldByNAme('MCA_VALSTA').AsFloat -
                                                 fFormataFloat(LValorFrete, 2) -
                                                 (cdsMovCar.FieldByNAme('MCA_VALSTA').AsFloat *
                                                  (cdsMovCar.FieldByNAme('MCA_PERCAR').AsFloat / 100));
  cdsMovCar.FieldByNAme('MCA_VALDUP').AsFloat := cdsMovCar.FieldByNAme('MCA_VALORI').AsFloat;
  cdsMovCar.FieldByNAme('MCA_VALTAX').AsFloat := cdsMovCar.FieldByNAme('MCA_VALSTA').AsFloat *
                                                 (cdsMovCar.FieldByNAme('MCA_PERCAR').AsFloat / 100);
  cdsMovCar.FieldByNAme('MCA_FREMKT').AsFloat := fFormataFloat(LValorFrete, 2);
  cdsMovCar.Post;
end;

procedure TfrmCadMovCartoesParcelas.pCarregaParcelas(strNumDup, strCodEmp, strCodCli: String; dtaDtaCad: TDate);
  Var
    LConsulta: TUniQuery;
    LSQL : String;
begin
  FstrNumDup := strNumDup;
  FstrCodEmp := strCodEmp;
  FstrCodCli := strCodCli;
  FdtaDtaCad := dtaDtaCad;

  FCodigoEmp := strCodCli;

  LCdsCartao := CriaClientControleCartao(strNumDup, strCodEmp, strCodCli, dtaDtaCad);

  blnAltera := False;

  LConsulta := fCriaQuery;
  Try
    LSQL :=        'SELECT *                 ';
    LSQL := LSQL + '  FROM MOVCAR            ';
    LSQL := LSQL + 'WHERE MCA_NUMDUP=:NUMDUP ';
    LSQL := LSQL + '  AND MCA_CODEMP=:CODEMP ';
    LSQL := LSQL + '  AND MCA_CODCLI=:CODCLI ';

    If FdtaDtaCad <> 0 Then
      LSQL := LSQL + '  AND MCA_DTACAD=:DTACAD ';

    LSQL := LSQL + 'ORDER BY MCA_PARCEL';

    LConsulta.SQL.Text := LSQL;

    LConsulta.ParamByName('NUMDUP').AsString := FstrNumDup;
    LConsulta.ParamByName('CODEMP').AsString := FstrCodEmp;
    LConsulta.ParamByName('CODCLI').AsString := FstrCodCli;

    If Assigned(LConsulta.FindParam('DTACAD')) Then
      LConsulta.ParamByName('DTACAD').AsDateTime := FdtaDtaCad;

    LConsulta.Open;

    cdsMovCar := fCriaClientDatSet(LConsulta);
    cdsMovCar.Open;

    FCloneMovCar := fCriaClientDatSet(LConsulta);
    FCloneMovCar.Open;

    TFloatField(cdsMovCar.FieldByName('MCA_VALSTA')).DisplayFormat := '#,##0.00';
    TFloatField(cdsMovCar.FieldByName('MCA_VALTAX')).DisplayFormat := '#,##0.00';
    TFloatField(cdsMovCar.FieldByName('MCA_PERCAR')).DisplayFormat := ',0.000000';
  Finally
    FreeAndNil(LConsulta);
  End;

  dtsMovCar.DataSet := cdsMovCar;

  edtNumCCD.Text := cdsMovCar.FieldByName('MCA_NUMCCD').AsString;
  edtNumNSU.Text := cdsMovCar.FieldByName('MCA_NUMNSU').AsString;

  If Not cdsMovCar.FieldByName('MCA_DTACUP').IsNull Then
  Begin
    edtDtaCup.Date := cdsMovCar.FieldByName('MCA_DTACUP').AsDateTime;
    dDataTraInicial := edtDtaCup.Date;
  End;

  edtValSta.Text := FormatFloat(',0.00', fFormataFloat(cdsMovCar.FieldByName('MCA_VALSTA').AsFloat, 2));

  If edtConNsu.Visible Then
    edtConNsu.Text := edtNumNSU.Text;

  FCodEmpresa := cdsMovCar.FieldByName('MCA_CODEMP').AsString;

  If Not cdsMovCar.FieldByName('MCA_CODCAR').AsString.IsEmpty Then
  Begin
    edtCodCar.Text := cdsMovCar.FieldByName('MCA_CODCAR').AsString;
    pCarregaCartao();
    sCodigoCartaoInicial := edtCodCar.Text;
  End;

  If Not cdsMovCar.FieldByName('MCA_DTACAD').IsNull Then
  Begin
    edtDtaCad.Date := cdsMovCar.FieldByName('MCA_DTACAD').AsDateTime;
    dDataCadInicial := edtDtaCad.Date;
  End;

  edtPerCar.Text := FormatFloat(',0.000000', fFormataFloat(cdsMovCar.FieldByName('MCA_PERCAR').AsFloat, 6));

  edtValTax.Text := FormatFloat(',0.00', fFormataFloat(cdsMovCar.FieldByName('MCA_VALTAX').AsFloat, 2));

  edtPorCar.Text := cdsMovCar.FieldByName('MCA_PORCAR').AsString;
  edtDesPorCar.Text := fRetNomPortador(edtPorCar.Text);

  fraPlanoDeContas.mskCodCta.Text := cdsMovCar.FieldByName('MCA_CTACAR').AsString;
  pCarregaCentroCusto();
  
  pExibeTotal;
end;

procedure TfrmCadMovCartoesParcelas.pExibeTotal;
  Var
    fltValSta: Double;

    LValorFrete: Double;
begin
  fltValSta  := 0;
  FblnAltPar := (cdsMovCar.RecordCount >= 1);

  LValorFrete := 0;

  cdsMovCar.DisableControls;
  cdsMovCar.First;
  While Not cdsMovCar.Eof Do
  Begin
    If Not cdsMovCar.FieldByName('MCA_DTAREC').IsNull Then
      FblnAltPar := False;

    fltValSta := fltValSta + cdsMovCar.FieldByName('MCA_VALSTA').Value;

    LValorFrete := LValorFrete + fFormataFloat(cdsMovCar.FieldByName('MCA_FREMKT').AsFloat, 2);

    cdsMovCar.Next;
  End;
  cdsMovCar.First;
  cdsMovCar.EnableControls;
  
  edtQtdPar.Text := '(' + IntToStr(cdsMovCar.RecordCount) + ')';
  edtValTot.Text := FormatFloat('#,##0.00', fltValSta);

  If LValorFrete <> fStrToFloat(edtValorFrete.Text) Then
    edtValorFrete.Text := FormatFloat(',0.00', LValorFrete);

  If fltTotVen = 0 Then
    fltTotVen := fltValSta;

  If Not FblnAltPar Then
    pMensagemOK('Não será possível utilizar essa função pois essa venda possui cartões já baixados.');
end;

procedure TfrmCadMovCartoesParcelas.pRecalculaParcelas;
  Var
    LValorFrete: Double;
begin
  LValorFrete := 0;
  If FRecalculaComFrete Then
    LValorFrete := fFormataFloat(fStrToFloat(edtValorFrete.Text) / cdsMovCar.RecordCount, 2);

  cdsMovCar.First;
  While Not cdsMovCar.Eof Do
  Begin
    pAlteraValoresParc(fFormataFloat(fltTotVen / cdsMovCar.RecordCount, 2),
                       LValorFrete);

    cdsMovCar.Next;
  End;

  edtValSta.Text := FormatFloat(',0.00', fFormataFloat(cdsMovCar.FieldByName('MCA_VALSTA').AsFloat, 2));
  pExibeTotal;

  //ajusta a diferença na última parcela
  If (edtValTot.Text <> FormatFloat(',0.00', fltTotVen)) Then
  Begin
    cdsMovCar.Last;
    pAlteraValoresParc(fFormataFloat(cdsMovCar.FieldByName('MCA_VALSTA').AsFloat +
                                     (fltTotVen - fStrToFloat(edtValTot.Text)), 2),
                       LValorFrete);
    pExibeTotal;
  End;

  If fFormataFloat(LValorFrete * cdsMovCar.RecordCount, 2) <> fFormataFloat(fstrToFloat(edtValorFrete.Text), 2) Then
  Begin
    cdsMovCar.Last;
    pAlteraValoresParc(cdsMovCar.FieldByName('MCA_VALSTA').AsFloat,
                       LValorFrete - (fFormataFloat(LValorFrete * cdsMovCar.RecordCount, 2) - fFormataFloat(fstrToFloat(edtValorFrete.Text), 2)));
    pExibeTotal;
  End;
end;

procedure TfrmCadMovCartoesParcelas.pCarregaCentroCusto;
begin
  if not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) then
  begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
    fraPlanoDeContas.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString;
  end else
    fraPlanoDeContas.edtDesCta.Clear;
end;

procedure TfrmCadMovCartoesParcelas.pCarregaCartao;
begin
  pPesquisaCadCar(qryConCartao, qryConCartao, edtCodCar.Text);

  edtDesCar.Text := qryConCartao.FieldByName('CAR_DESCAR').AsString;

  If FCodigoCartaoAtual.Equals(qryConCartao.FieldByName('CAR_CODCAR').AsString) Then
    Exit;

  FCodigoCartaoAtual := qryConCartao.FieldByName('CAR_CODCAR').AsString;

  If qryConCartao.FieldByName('CAR_TIPTAX').AsString.ToUpper = 'P' Then
  Begin
    edtPerCar.Text := FloatToStrF(qryConCartao.FieldByName('CAR_PERDES').AsFloat, ffNumber, 12, 6);
    edtPerCarExit(edtPerCar);
  End
  Else
  Begin
    edtValTax.Text := FloatToStrF(qryConCartao.FieldByName('CAR_PERDES').AsFloat, ffNumber, 12, 2);
    edtValTaxExit(edtPerCar);
  End;

  FRecalculaComFrete := qryConCartao.FieldByName('CAR_MKTPLA').AsString.Equals('S');

  grpFrete.Visible := FRecalculaComFrete;

  pnlDados.Height := 266;
  If Not grpFrete.Visible Then
    pnlDados.Height := pnlDados.Height - grpFrete.Height - 2;
end;

procedure TfrmCadMovCartoesParcelas.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;

  If fPesqCentroCusto(Self, fraPlanoDeContas.mskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCusto;
  End;

end;

function TfrmCadMovCartoesParcelas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CODIGO DO CARTÃO             *}
    {**************************************MV*}
    If (Sender = edtCodCar) Then
    Begin

      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do Cartão deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If blnCfg_UtiCon And blnUsaParBanDebContabil Then
        Begin
           If (sCodigoCartaoInicial <> edtCodCar.text) Then
           Begin
              fMensagem('ATENÇÃO!', 'Campo "Cartão" Alteração não permitida, em razão de paramêtros da contabilidade efetuados pela bandeira do cartão!', ['&O k']);
              edtCodCar.text := sCodigoCartaoInicial;
              result := False;
           End;
        End;

        pCarregaCartao();
        If qryConCartao.FieldbyName('CAR_CODCAR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cartão não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (qryConCartao.FieldByName('CAR_STATUS').AsString = 'N') And (Not blnExitCodCar) Then
        Begin
           fMensagem('ATENÇÃO', 'Esse cartão está inativo!', ['&Ok']);
           Result := False;
        End
        Else If (Not fVerificaAcessoCartao(edtCodCar.Text)) Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a esse Cartão!', ['&Ok']);
          Result := False;
        End;

        blnExitCodCar := False;
      End;

    End

    Else If(Sender = edtDtaCad) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(edtDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(edtDtaCad.Text) > VS_Date) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser menor ou igual a Data Atual!', ['&O k']);
        Result := False;
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(edtDtaCad.Text)) Then
      Begin
         If (StrToDate(edtDtaCad.Text) <> dDataCadInicial) Then
         Begin
            If objFechamento.FechamentoFinanceiroJaRealizado(FCodigoEmp, StrToDate(edtDtaCad.Text), false) Then
            Begin
               fMensagem('ATENÇÃO!', 'Alteração não permitida, pois existe fechamento financeiro com data igual ou posterior a data de alteração!', ['&O k']);
               edtDtaCad.Date := dDataCadInicial;
               Result := False;
            End;
         End;
      End;

    End

    Else If(Sender = edtDtaCup) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(edtDtaCup.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data da transação deve ser preenchida!', ['&O k']);
        pSetFocus(edtDtaCup);
        Result := False;
      End
      Else If (StrToDate(edtDtaCup.Text) > StrToDate(edtDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data da transação não pode ser maior que a data de cadastro!', ['&O k']);
        pSetFocus(edtDtaCup);
        Result := False;
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(edtDtaCup.Text)) Then
      Begin
         If (StrToDate(edtDtaCup.Text) <> dDataTraInicial) Then
         Begin
            if objFechamento.FechamentoFinanceiroJaRealizado(FCodigoEmp, StrToDate(edtDtaCup.Text), false) then
            Begin
               fMensagem('ATENÇÃO!', 'Alteração não permitida, pois existe fechamento financeiro com data igual ou posterior a data de alteração!', ['&O k']);
               edtDtaCup.Date := dDataTraInicial;
               Result := False;
            End;
         End
      End;

    End

    {*****************************************}
    {* VALIDA O VALOR TOTAL                  *}
    {**************************************MV*}
    Else If(Sender = edtValSta) Then
    Begin

      If fStrToFloat(edtValSta.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O valor sem taxa deve ser maior que zero!', ['&O k']);
        pSetFocus(edtValSta);
        Result := False;
      End
      Else If fEmptyStr(edtValSta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor total deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A PERC(%) TAXA ADMINISTRATIVA  *}
    {**************************************MV*}
    Else If(Sender = edtPerCar) Then
    Begin

      If fEmptyStr(edtPerCar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Taxa Administrativa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtPercar.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Taxa Administrativa deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O VALOR TAXA ADMINISTRATIVA    *}
    {**************************************MV*}
    Else If(Sender = edtValTax) Then
    Begin

      If fEmptyStr(edtValTax.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor da taxa administrativa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtValTax.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A valor da taxa administrativa deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End

    Else If(Sender = edtValorFrete) And (grpFrete.Visible) Then
    Begin

      If fStrToFloat(edtValorFrete.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!','O valor total do deve ser maior ou igual a zero!', ['&O k']);
        pSetFocus(edtValorFrete);
        Result := False;
      End
      Else If fEmptyStr(edtValorFrete.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor total do frete deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtValorFrete.Text) > fltTotVen Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor total do frete não pode ser maior que o valor total da venda!', ['&O k']);
        Result := False;
      End;

    End

    Else If(Sender = edtPorCar) Then
    Begin

      If fEmptyStr(edtPorCar.Text) Then
      begin
         fMensagem('ATENÇÃO!', 'O Portador deve ser preenchido!', ['&Ok']);
         Result := False;
      End
      Else
      Begin
        edtDesPorCar.Text := fRetNomPortador(edtPorCar.Text);
        If fEmptyStr(edtDesPorCar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não encontrado!', ['&Ok']);
          Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtPorCar.Text, VS_strCodEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorCar.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End

    Else If(Sender = fraPlanoDeContas.mskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.mskCodCta.Text) Then
      begin
         fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&Ok']);
         Result := False;
      End
      Else
      Begin

        pCarregaCentroCusto();
        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) then
        Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não encontrado!', ['&Ok']);
          Result := False;
        End;

      End;

    End;

  End;

  If Not Result Then
     pSetFocus(Sender);

end;

Procedure TfrmCadMovCartoesParcelas.CalculaValores(blnCalcPerc, ACalculaComFrete: Boolean);
  Var
    ValorTxPeloPerc: Real;

    LValorFrete,
    LValorTotal: Double;
Begin
   LValorFrete := 0;
   If ACalculaComFrete Then
     LValorFrete := fFormataFloat(fStrToFloat(edtValorFrete.Text) / cdsMovCar.RecordCount, 2);

   If blnCalcPerc Then
   Begin
     LValorTotal := fCalculaValDocCartao(fStrToFloat(edtValSta.Text),
                                         fStrToFloat(edtPerCar.Text),
                                         LValorFrete,
                                         0);

     edtValTax.Text := FloatToStrF(fStrToFloat(edtValSta.Text) - LValorFrete - LValorTotal, ffNumber, 12, 2);

     If (fStrToFloat(edtValSta.Text) <= 0) Then
       edtValTax.Text := '0,00';
   End;


   If Not blnCalcPerc Then
   Begin
     ValorTxPeloPerc := fFormataFloat(fStrToFloat(edtValSta.Text) * (fStrToFloat(edtPerCar.Text) / 100), 2);

     If (ValorTxPeloPerc <> fStrToFloat(edtValTax.Text)) Then
       edtPerCar.Text := FloatToStrF(((fStrToFloat(edtValTax.Text) / fStrToFloat(edtValSta.Text)) * 100), ffNumber, 12, 6);
   End;
End;

procedure TfrmCadMovCartoesParcelas.ValorDoFreteApenasNaPrimeiraParcela;
begin
  If Not grpFrete.Visible Then
    Exit;

  If chkDesmembrarFrete.Checked THen
    Exit;

  cdsMovCar.First;

  cdsMovCar.Edit;
  cdsMovCar.FieldByName('MCA_FREMKT').AsFloat := fFormataFloat(fStrToFloat(edtValorFrete.Text), 2);
  cdsMovCar.FieldByName('MCA_VALORI').AsFloat := fCalculaValDocCartao(cdsMovCar.FieldByName('MCA_VALSTA').AsFloat,
                                                                      cdsMovCar.FieldByName('MCA_PERCAR').AsFloat,
                                                                      cdsMovCar.FieldByName('MCA_FREMKT').AsFloat,
                                                                      0);
  cdsMovCar.FieldByName('MCA_VALDUP').AsFloat := cdsMovCar.FieldByName('MCA_VALORI').AsFloat;
  cdsMovCar.Post;

  cdsMovCar.Next;

  While Not cdsMovCar.Eof Do
  Begin
    If fFormataFloat(cdsMovCar.FieldByName('MCA_FREMKT').AsFloat, 2) = 0 Then
    Begin
      cdsMovCar.Next;

      Continue;
    End;

    cdsMovCar.Edit;
    cdsMovCar.FieldByName('MCA_FREMKT').AsFloat := 0;
    cdsMovCar.FieldByName('MCA_VALORI').AsFloat := fCalculaValDocCartao(cdsMovCar.FieldByName('MCA_VALSTA').AsFloat,
                                                                        cdsMovCar.FieldByName('MCA_PERCAR').AsFloat,
                                                                        cdsMovCar.FieldByName('MCA_FREMKT').AsFloat,
                                                                        0);
    cdsMovCar.FieldByName('MCA_VALDUP').AsFloat := cdsMovCar.FieldByName('MCA_VALORI').AsFloat;
    cdsMovCar.Post;

    cdsMovCar.Next;
  End;
end;

procedure TfrmCadMovCartoesParcelas.VinculaCreditoParcelas;
Var
    LTotalVendaOriginal: Double;
begin
  LTotalVendaOriginal := fltTotVen;

  fltTotVen := fltTotVen + FValorCreditoSelecionado;

  Try
    FRecalclaComPercentual := True;
    FPercentualAbatimento := Abs(FValorCreditoSelecionado) / LTotalVendaOriginal;
    FUsouVinculoCC := True;

    btnConfirmar.Click;
  Finally
    FRecalclaComPercentual := False;
    FPercentualAbatimento := 0;

    btnVincularCredito.Enabled := False;

    blnAltera := True;

    btnGravar.Click;

    fLock_Unlock(FChaveCreditoSelecionado, False);
  End;
end;

procedure TfrmCadMovCartoesParcelas.VincularChaveCartaoCC;
Var
    LChaveCartao: String;
begin
  If FAutoIncremCreditoSelecionado.IsEmpty THen
    Exit;

  LChaveCartao := Concat(cdsMovCar.FieldByName('MCA_NUMDUP').AsString, '-',
                         cdsMovCar.FieldByName('MCA_CODEMP').AsString, '-',
                         cdsMovCar.FieldByName('MCA_CODCLI').AsString);

  Try
    fExecutaSQL('UPDATE CADREC SET CTR_CHAMCA="' + LChaveCartao + '" WHERE AUTOINCREM="' + FAutoIncremCreditoSelecionado + '"', True);

    untLogCtr.GravaLogCtr(FAutoIncremCreditoSelecionado,
                          'VÍNCULO CRÉDITO DE CLIENTE COM CARTÃO',
                          Self.Name);
  Except
    Raise;
  End;
end;

procedure TfrmCadMovCartoesParcelas.ReCenter;
var
  LRect: TRect;
  X, Y : Integer;
begin
  LRect := Screen.WorkAreaRect;
  X := LRect.Left + (LRect.Right - LRect.Left - Width) div 2;
  Y := LRect.Top + (LRect.Bottom - LRect.Top - Height) div 2;
  SetBounds(X, Y, Width, Height);
end;

function TfrmCadMovCartoesParcelas.RetonaNovoVencimento(
  ADataCalculo: TDateTime): TDateTime;
begin
  Result := IncDay(ADataCalculo, qryConCartao.FieldByName('CAR_PERIOD').AsInteger);

  If Result < edtDtaCad.Date Then
    Result := edtDtaCad.Date;
end;

function TfrmCadMovCartoesParcelas.RetornaChaveCredito: String;
begin
  If FAutoIncremCreditoSelecionado.IsEmpty Then
    Exit(EmptyStr);

  Result := fCampoTabela('CONCAT(CTR_NUMDUP,"-",CTR_PARCEL,"-",CTR_ESPDOC,"-",CTR_CODEMP,"-",CTR_CODCLI)',
                         'CADREC',
                         ['AUTOINCREM'],
                         [FAutoIncremCreditoSelecionado]);
end;

function TfrmCadMovCartoesParcelas.RetornaValorRecalculo(AValorNormal,
  APorPercentual: Double): Double;
begin
  If Not FRecalclaComPercentual Then
    Exit(fFormataFloat(AValorNormal, 2));

  Result := fFormataFloat(APorPercentual * (1 - FPercentualAbatimento), 2);
end;

Function TfrmCadMovCartoesParcelas.fVerificaParametroContabilBandeira(): Boolean;
var
  qryAux : TUniQuery;
Begin
  result := False;

  Try
    qryAux := fCriaQuery;

    Try

      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT COUNT(CON_BANDEB) AS BANDEB FROM PARCON ');
      qryAux.SQL.Add(' WHERE CON_BANDEB = 1 ');

      if fCfgConEmp = 'S' then
      begin
        qryAux.SQL.Add(' AND CON_CODEMP = :CODEMP ');
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      end
      else
        qryAux.SQL.Add(' AND CON_CODEMP IS NULL ');

      qryAux.Open;

      If Not qryAux.IsEmpty Then
      Begin
         If qryAux.FieldByName('BANDEB').AsInteger > 0 Then
            Result := True;
      End;

    Except
      Result := False;
    End;

  Finally
    FreeAndNil(qryAux);
  End;

End;

function TfrmCadMovCartoesParcelas.fConfiguracaoExiste(strCodCfg: string; strCodEmp: string = ''): boolean;
begin
  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  Result := (fCampoTabela('COUNT(*)', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_' + strCodCfg, strCodEmp], False) > 0);
end;

function TfrmCadMovCartoesParcelas.fCfgConEmp: string;
begin
  result := 'N' ;
  if not fConfiguracaoExiste('CONEMP') then
    exit;

  if not fCfgSis('CONEMP', varBoolean) then
    exit;

  result := 'S';
end;

function TfrmCadMovCartoesParcelas.AdicionarCreditoHistorico(const AHistorico, AChaveCredito: string): string;
const
  PREFIXO = '(Vinculado e abatido: ';
var
  LPosInicio: Integer;
  LPosFim: Integer;
begin
  Result := AHistorico;

  if Trim(AChaveCredito) = '' then
    Exit;

  LPosInicio := Pos(PREFIXO, AHistorico);

  // Verifica se não existe o texto "Vinculado e abatido", ou seja nao tem registros vinculados;
  if LPosInicio = 0 then
  begin
    Result := AHistorico + ' (Vinculado e abatido: ' + AChaveCredito + ')';
    Exit;
  end;

  LPosFim := PosEx(')', AHistorico, LPosInicio + Length(PREFIXO));

  if LPosFim = 0 then
  begin
    // Não encontrou o ')' de fechamento
    Result := AHistorico + ',' + AChaveCredito;
    Exit;
  end;

  // Adiciona o novo crédito antes do ")"
  Result := Copy(AHistorico, 1, LPosFim - 1) + ',' + AChaveCredito + Copy(AHistorico, LPosFim, MaxInt);

end;

function TfrmCadMovCartoesParcelas.PermiteAlterarDados: Boolean;
begin
  Result := True;
  if ExistemMovimentosJaBaixados then
  begin
    Result := False;
    pMensagemOk('Existem Parcelas já baixadas para o movimento selecionado, por favor verifique.');
  end;
end;

end.

