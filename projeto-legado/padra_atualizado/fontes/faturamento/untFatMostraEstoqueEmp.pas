unit untFatMostraEstoqueEmp;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, Menus, EditFocus, Uni,
  AppEvnts, UniDataSetProvider, DB, UniClientDataSet, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, strUtils, cxGridDBTableView, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGrid, cxCurrencyEdit, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient,
  cxGridCitel, cxDataControllerConditionalFormattingRulesManagerDialog, cxProgressBar,
  untSalvaConfiguracaoGrid;

type
  TfrmFatMostraEstoqueEmp = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    pnlBotoesMostra: TPanel;
    edtItem: TEditFocus;
    dtsSalEmp: TDataSource;
    cdsSalEmp: TUniClientDataSet;
    dspSalEmp: TUniDataSetProvider;
    qrySalEmp: TUniQuery;
    cxStyleRepository: TcxStyleRepository;
    cxStyleSalRes: TcxStyle;
    cxStyleSalDis: TcxStyle;
    cxStyleSelecao: TcxStyle;
    pnlSelecEmpresa: TPanel;
    lbl1: TLabel;
    chkSaldosDisponiveis: TCheckBox;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Splitter1: TSplitter;
    cxGridEstrutura: TcxGridCitel;
    cxGridDadosEstrutura: TcxGridDBTableViewCitel;
    gsEMP_NOMEMP: TcxGridDBColumn;
    gsITE_SALFIS: TcxGridDBColumn;
    gsITE_SALRES: TcxGridDBColumn;
    gsITE_SALREG: TcxGridDBColumn;
    gsITE_SALDIS: TcxGridDBColumn;
    gsITE_PREVE1: TcxGridDBColumn;
    gsITE_PREVE2: TcxGridDBColumn;
    gsITE_PREVE3: TcxGridDBColumn;
    gsITE_PREVE4: TcxGridDBColumn;
    gsITE_PREVE5: TcxGridDBColumn;
    gsITE_PREVE6: TcxGridDBColumn;
    gsITE_PREVE7: TcxGridDBColumn;
    gsITE_FUTPRE: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dbeEstoqueMM: TcxGridCitel;
    cxGridDados: TcxGridDBTableViewCitel;
    gdEMP_NOMEMP: TcxGridDBColumn;
    gdITE_SALFIS: TcxGridDBColumn;
    gdITE_SALRES: TcxGridDBColumn;
    gdITE_SALREG: TcxGridDBColumn;
    gdITE_SALDIS: TcxGridDBColumn;
    gdITE_PREVE1: TcxGridDBColumn;
    gdITE_PREVE2: TcxGridDBColumn;
    gdITE_PREVE3: TcxGridDBColumn;
    gdITE_PREVE4: TcxGridDBColumn;
    gdITE_PREVE5: TcxGridDBColumn;
    gdITE_PREVE6: TcxGridDBColumn;
    gdITE_PREVE7: TcxGridDBColumn;
    gdITE_FUTPRE: TcxGridDBColumn;
    cxGridNivel: TcxGridLevel;
    gsITE_SUBITE: TcxGridDBColumn;
    btnPrepTE: TBitBtnLocked;
    gdITE_ESTMIN: TcxGridDBColumn;
    gdITE_ESTMAX: TcxGridDBColumn;
    gdITE_SALEND: TcxGridDBColumn;
    gsITE_SALEND: TcxGridDBColumn;
    gdITE_ORDPRO: TcxGridDBColumn;
    gsITE_ORDPRO: TcxGridDBColumn;
    gdITE_FUTFAL: TcxGridDBColumn;
    gdITE_FUTAGU: TcxGridDBColumn;
    gsITE_FUTFAL: TcxGridDBColumn;
    gsITE_FUTAGU: TcxGridDBColumn;
    chkMostrarML: TCheckBox;
    gdITE_SALEXT: TcxGridDBColumn;
    gsITE_SALEXT: TcxGridDBColumn;
    gdITE_SDPDBF: TcxGridDBColumn;
    gsITE_SDPDBF: TcxGridDBColumn;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsSalEmpAfterScroll(DataSet: TDataSet);
    procedure cxGridDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkSaldosDisponiveisClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnPrepTEClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkMostrarMLClick(Sender: TObject);
    procedure btnResPadResumoClick(Sender: TObject);
  private
    { Private declarations }
    intCalSal,
    intRecNo : Integer;

    blnRestaurado,
    blnUsaPDV,
    blnOrdPro,
    blnEmcFen,
    blnEntFut,
    blnUsaEstExt: Boolean;

    blnAcessoTodasAsEmpresas : Boolean;

    cdsIteEst: TUniClientDataSet;
    dtsIteEst: TDataSource;
    dspIteEst: TUniDataSetProvider;
    qryIteEst: TUniQuery;

    function fGetSql(blnItemEstrutura : Boolean = False): String;

    function fMostraSomaSaldos(cdsDados : TUniClientDataSet) : Boolean;

    procedure pcdsSalEmp;
    function fcdsSalEmp(pgbProgresso: TcxProgressBar) : Boolean;

    procedure pcdsIteEst;
    function fcdsIteEst(pgbProgresso: TcxProgressBar) : Boolean;

    procedure pAjustaColunasSaldo(blnIndexaColunas: Boolean);

    procedure pAlteraParaML(blnML: Boolean);

    procedure pFormataCampos(dtsDados: TDataSet);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodIte: String;
    strTabPre: String;
    strNumLot: String;
    fltQtdIte: Double;
    blnPedCorte: Boolean;
    blnFaturamento: Boolean;
    blnEstrutura: Boolean;
    blnMostrarPrecos: Boolean;
  end;


implementation

uses untfuncoesSimples, untModulo, untCadLote, untConsultas, untTypesSistema,
  untPreparaGeracaoTE, untGravando, untIFatReservaSaldo, untTFatReservaSaldo,
  untIFatEntregaFutura, untTFatEntregaFutura;

{$R *.dfm}

procedure TfrmFatMostraEstoqueEmp.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtCodEmp, True) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatMostraEstoqueEmp.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraEstoqueEmp.btnPrepTEClick(Sender: TObject);
Var
  objPreparaGer: TPreparaGeracaoTE;
begin
  inherited;
  If Not fVerificaAcessoSistema('frmPreparaGerTE') Then
  Begin
    pMensagemOk('Usuário sem permissão para o módulo "Movimentação de Itens - ' +
                'Preparador para Geração de Transferência de Estoque"!');
    Exit;
  End;

  objPreparaGer := TPreparaGeracaoTE.Create;
  objPreparaGer.pInformaPreparacao(strCodIte);

  FreeAndNil(objPreparaGer);
end;

procedure TfrmFatMostraEstoqueEmp.btnResPadResumoClick(Sender: TObject);
begin
  inherited;
  TSalvaConfiguracaoGrid.pApagaConfiguracoes(Self.Name);
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxGridDados, Self.Name + '_INI');
  pAjustaColunasSaldo(True);
end;

function TfrmFatMostraEstoqueEmp.fMostraSomaSaldos(cdsDados : TUniClientDataSet) : Boolean;
  Var
    fltCNV_ML: Double;
    objCadLot: TCadLot;

  function fGetSaldo(ACampo: String): Double;
  begin
    If Not fEmptyStr(strNumLot) Then
      Result := fCampoTabela('LOT_' + ACampo, 'CADLOT',
                            ['LOT_CODITE','LOT_CODEMP','LOT_NUMLOT'],
                            [cdsDados.FieldByName('ITE_CODITE').AsString,
                             cdsDados.FieldByName('EMP_CODEMP').AsString,
                             strNumLot])
    Else
      Result := fCampoTabela('ITE_' + ACampo, 'ITEGER',
                            ['ITE_CODITE','ITE_CODEMP'],
                            [cdsDados.FieldByName('ITE_CODITE').AsString,
                             cdsDados.FieldByName('EMP_CODEMP').AsString]);
  end;

begin
  Result := True;

  Try
    fltCNV_ML := 1;

    objCadLot := TCadLot.Create(Self);

    With cdsDados Do
    Begin
      frmGravando.pgbStatus.Position := 0;
      frmGravando.pgbStatus.Properties.Max := RecordCount;
      Application.ProcessMessages;

      First;

      While (Not Eof) Do
      Begin
        Edit;

        If Not fEmptyStr(strNumLot) Then
          FieldByName('ITE_SALDOS').AsFloat := objCadLot.fSaldoLote( FieldByName('ITE_CODITE').AsString,
                                                                     FieldByName('EMP_CODEMP').AsString,
                                                                     strNumLot);

        fltCNV_ML := IIF(FieldByName('ITE_CNV_ML').AsFloat <= 0, 1, FieldByName('ITE_CNV_ML').AsFloat);

        FieldByName('ITE_SALRES').AsFloat := fGetSaldo('QTPD_V') + fGetSaldo('QTPD_F');

//        FieldByName('ITE_SALRES').AsFloat := TSaldoReservado.New(
//                       TReservaParametros.New()
//                         .EmpresaItem(FieldByName('EMP_CODEMP').AsString)
//                         .CodigoItem(FieldByName('ITE_CODITE').AsString)
//                         .CodEmpresa(FieldByName('EMP_CODEMP').AsString)
//                         .DesconsideraPedidosCorte(Not blnPedCorte)
//                         .DesconsideraPedidosEnderecamento(True)
//                         .ConverterML(False)
//                         .TipoReserva(trsPedidoVenda)
//                         .NumeroLote(strNumLot)
//                       ).fGetQuantidade();

        If blnOrdPro Then
          FieldByName('ITE_SALORD').AsFloat := fGetSaldo('QTPD_P')
//          FieldByName('ITE_SALORD').AsFloat := TSaldoReservado.New(
//                         TReservaParametros.New()
//                           .EmpresaItem(FieldByName('EMP_CODEMP').AsString)
//                           .CodigoItem(FieldByName('ITE_CODITE').AsString)
//                           .CodEmpresa(FieldByName('EMP_CODEMP').AsString)
//                           .DesconsideraPedidosCorte(Not blnPedCorte)
//                           .ConverterML(False)
//                           .TipoReserva(trsOrdemProducao)
//                           .NumeroLote(strNumLot)
//                         ).fGetQuantidade()
        Else
          FieldByName('ITE_SALORD').AsFloat := 0;

        FieldByName('ITE_SALEND').AsFloat := fGetSaldo('QTPD_E');
//        FieldByName('ITE_SALEND').AsFloat := TSaldoReservado.New(
//                       TReservaParametros.New()
//                         .EmpresaItem(FieldByName('EMP_CODEMP').AsString)
//                         .CodigoItem(FieldByName('ITE_CODITE').AsString)
//                         .CodEmpresa(FieldByName('EMP_CODEMP').AsString)
//                         .DesconsideraPedidosCorte(Not blnPedCorte)
//                         .ConverterML(False)
//                         .TipoReserva(trsEnderecamento)
//                         .NumeroLote(strNumLot)
//                       ).fGetQuantidade();

        FieldByName('ITE_SALREG').AsFloat := fGetSaldo('SALREG');
//        FieldByName('ITE_SALREG').AsFloat := TSaldoReservado.New(
//                       TReservaParametros.New()
//                         .EmpresaItem(FieldByName('EMP_CODEMP').AsString)
//                         .CodigoItem(FieldByName('ITE_CODITE').AsString)
//                         .CodEmpresa(FieldByName('EMP_CODEMP').AsString)
//                         .DesconsideraPedidosCorte(Not blnPedCorte)
//                         .ConverterML(False)
//                         .TipoReserva(trsGarantia)
//                         .NumeroLote(strNumLot)
//                       ).fGetQuantidade();

        FieldByName('ITE_SALEXT').AsFloat := TSaldoReservado.New(
                       TReservaParametros.New()
                         .EmpresaItem(FieldByName('EMP_CODEMP').AsString)
                         .CodigoItem(FieldByName('ITE_CODITE').AsString)
                         .CodEmpresa(FieldByName('EMP_CODEMP').AsString)
                         .DesconsideraPedidosCorte(Not blnPedCorte)
                         .ConverterML(False)
                         .TipoReserva(trsExterno)
                         .NumeroLote(strNumLot)
                       ).fGetQuantidade();

        If FieldByName('ITE_SALEXT').AsFloat < 0 Then
          FieldByName('ITE_SALEXT').AsFloat := 0;

        If blnEntFut or blnEmcFen Then
        Begin
          FieldByName('ITE_FUTFAL').AsFloat := fGetSaldo('QTEF_F');
//          FieldByName('ITE_FUTFAL').AsFloat := TEntregaFutura.New(
//                         TParamEF.New()
//                           .CodIte(FieldByName('ITE_CODITE').AsString)
//                           .CodEmp(FieldByName('EMP_CODEMP').AsString)
//                           .ConverteML(False)
//                           .TipoEF(tefFaltaDeProduto)
//                           .Lote(strNumLot)
//                         ).Total();

          FieldByName('ITE_FUTAGU').AsFloat := fGetSaldo('QTEF_A');
//          FieldByName('ITE_FUTAGU').AsFloat := TEntregaFutura.New(
//                         TParamEF.New()
//                           .CodIte(FieldByName('ITE_CODITE').AsString)
//                           .CodEmp(FieldByName('EMP_CODEMP').AsString)
//                           .ConverteML(False)
//                           .TipoEF(tefAguardandoCliente)
//                           .Lote(strNumLot)
//                         ).Total();

          FieldByName('ITE_FUTPRE').AsFloat := fGetSaldo('QTEF_P');
//          FieldByName('ITE_FUTPRE').AsFloat := TEntregaFutura.New(
//                         TParamEF.New()
//                           .CodIte(FieldByName('ITE_CODITE').AsString)
//                           .CodEmp(FieldByName('EMP_CODEMP').AsString)
//                           .ConverteML(False)
//                           .TipoEF(tefPrevisao)
//                           .Lote(strNumLot)
//                         ).Total();

          FieldByName('ITE_QTPDBF').AsFloat := fGetSaldo('QTPDBF');
          FieldByName('ITE_SDPDBF').AsFloat := fGetSaldo('SDPDBF');
        End Else
        Begin
          FieldByName('ITE_FUTFAL').AsFloat := 0;
          FieldByName('ITE_FUTAGU').AsFloat := 0;
          FieldByName('ITE_FUTPRE').AsFloat := 0;
          FieldByName('ITE_QTPDBF').AsFloat := 0;
          FieldByName('ITE_SDPDBF').AsFloat := 0;
        End;

        If (Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura Then
        Begin
          FieldByName('ITE_SALFIS').AsFloat  := FieldByName('ITE_SALDOS').AsFloat + FieldByName('ITE_SAL_ML').AsFloat / fltCNV_ML +
                                                FieldByName('ITE_FUTPRE').AsFloat +
                                                FieldByName('ITE_FUTFAL').AsFloat +
                                                FieldByName('ITE_FUTAGU').AsFloat + 
                                                FieldByName('ITE_QTPDBF').AsFloat;
        End                                        
        Else
          FieldByName('ITE_SALFIS').AsFloat  := FieldByName('ITE_SALDOS').AsFloat + FieldByName('ITE_SAL_ML').AsFloat / fltCNV_ML;

        FieldByName('ITE_SALDIS').AsFloat := fCalculaSaldoDisponivel(intCalSal,
                                                FieldByName('ITE_SALFIS').AsFloat,
                                                FieldByName('ITE_SALREG').AsFloat,
                                                FieldByName('ITE_SALRES').AsFloat,
                                                FieldByName('ITE_SALEND').AsFloat,
                                                FieldByName('ITE_SALORD').AsFloat,
                                                FieldByName('ITE_FUTPRE').AsFloat,
                                                FieldByName('ITE_FUTFAL').AsFloat,
                                                FieldByName('ITE_FUTAGU').AsFloat,
                                                FieldByName('ITE_SALEXT').AsFloat,
                                                FieldByName('ITE_SDPDBF').AsFloat);

        FieldByName('ITE_SALFIS_ML').AsFloat := FieldByName('ITE_SALFIS').AsFloat * fltCNV_ML;
        FieldByName('ITE_SALREG_ML').AsFloat := FieldByName('ITE_SALREG').AsFloat * fltCNV_ML;
        FieldByName('ITE_SALEXT_ML').AsFloat := FieldByName('ITE_SALEXT').AsFloat * fltCNV_ML;
        FieldByName('ITE_SALORD_ML').AsFloat := FieldByName('ITE_SALORD').AsFloat * fltCNV_ML;
        FieldByName('ITE_SALRES_ML').AsFloat := FieldByName('ITE_SALRES').AsFloat * fltCNV_ML;
        FieldByName('ITE_SALEND_ML').AsFloat := FieldByName('ITE_SALEND').AsFloat * fltCNV_ML;
        FieldByName('ITE_SALDIS_ML').AsFloat := FieldByName('ITE_SALDIS').AsFloat * fltCNV_ML;
        FieldByName('ITE_FUTPRE_ML').AsFloat := FieldByName('ITE_FUTPRE').AsFloat * fltCNV_ML;
        FieldByName('ITE_FUTFAL_ML').AsFloat := FieldByName('ITE_FUTFAL').AsFloat * fltCNV_ML;
        FieldByName('ITE_FUTAGU_ML').AsFloat := FieldByName('ITE_FUTAGU').AsFloat * fltCNV_ML;
        FieldByName('ITE_SDPDBF_ML').AsFloat := FieldByName('ITE_SDPDBF').AsFloat * fltCNV_ML;

        Post;

        Next;

        frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;

      pFormataCampos(cdsDados);

      First;

      chkMostrarML.Visible := fltCNV_ML <> 1;
    End;

    FreeAndNil(objCadLot);

  Except
    Result := False;
  End;

end;

procedure TfrmFatMostraEstoqueEmp.pFormataCampos(dtsDados: TDataSet);
Begin
  With dtsDados Do
  Begin
    (FieldByName('ITE_SALFIS') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALREG') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALEXT') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALORD') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALRES') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALEND') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALDIS') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_FUTPRE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_FUTFAL') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_FUTAGU') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_SDPDBF') As TFloatField).DisplayFormat := '#,##0.00';

    (FieldByName('ITE_SALFIS_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALREG_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALEXT_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALORD_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALRES_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALEND_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALDIS_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_FUTPRE_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_FUTFAL_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_FUTAGU_ML') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SDPDBF_ML') As TFloatField).DisplayFormat := '#,##0.00';
  End;
End;

procedure TfrmFatMostraEstoqueEmp.pAlteraParaML(blnML: Boolean);
Begin
  If blnML Then
  Begin
    gdITE_SALFIS.DataBinding.FieldName := 'ITE_SALFIS_ML';
    gdITE_SALREG.DataBinding.FieldName := 'ITE_SALREG_ML';
    gdITE_SALEXT.DataBinding.FieldName := 'ITE_SALEXT_ML';
    gdITE_SALRES.DataBinding.FieldName := 'ITE_SALRES_ML';
    gdITE_SALEND.DataBinding.FieldName := 'ITE_SALEND_ML';
    gdITE_ORDPRO.DataBinding.FieldName := 'ITE_SALORD_ML';
    gdITE_FUTPRE.DataBinding.FieldName := 'ITE_FUTPRE_ML';
    gdITE_FUTFAL.DataBinding.FieldName := 'ITE_FUTFAL_ML';
    gdITE_FUTAGU.DataBinding.FieldName := 'ITE_FUTAGU_ML';
    gdITE_SDPDBF.DataBinding.FieldName := 'ITE_SDPDBF_ML';
    gdITE_SALDIS.DataBinding.FieldName := 'ITE_SALDIS_ML';

    gsITE_SALFIS.DataBinding.FieldName := 'ITE_SALFIS_ML';
    gsITE_SALREG.DataBinding.FieldName := 'ITE_SALREG_ML';
    gsITE_SALEXT.DataBinding.FieldName := 'ITE_SALEXT_ML';
    gsITE_SALRES.DataBinding.FieldName := 'ITE_SALRES_ML';
    gsITE_SALEND.DataBinding.FieldName := 'ITE_SALEND_ML';
    gsITE_ORDPRO.DataBinding.FieldName := 'ITE_SALORD_ML';
    gsITE_FUTPRE.DataBinding.FieldName := 'ITE_FUTPRE_ML';
    gsITE_FUTFAL.DataBinding.FieldName := 'ITE_FUTFAL_ML';
    gsITE_FUTAGU.DataBinding.FieldName := 'ITE_FUTAGU_ML';
    gsITE_SDPDBF.DataBinding.FieldName := 'ITE_SDPDBF_ML';
    gsITE_SALDIS.DataBinding.FieldName := 'ITE_SALDIS_ML';
  End Else
  Begin
    gdITE_SALFIS.DataBinding.FieldName := 'ITE_SALFIS';
    gdITE_SALREG.DataBinding.FieldName := 'ITE_SALREG';
    gdITE_SALEXT.DataBinding.FieldName := 'ITE_SALEXT';
    gdITE_SALRES.DataBinding.FieldName := 'ITE_SALRES';
    gdITE_SALEND.DataBinding.FieldName := 'ITE_SALEND';
    gdITE_ORDPRO.DataBinding.FieldName := 'ITE_SALORD';
    gdITE_FUTPRE.DataBinding.FieldName := 'ITE_FUTPRE';
    gdITE_FUTFAL.DataBinding.FieldName := 'ITE_FUTFAL';
    gdITE_FUTAGU.DataBinding.FieldName := 'ITE_FUTAGU';
    gdITE_SDPDBF.DataBinding.FieldName := 'ITE_SDPDBF';
    gdITE_SALDIS.DataBinding.FieldName := 'ITE_SALDIS';

    gsITE_SALFIS.DataBinding.FieldName := 'ITE_SALFIS';
    gsITE_SALREG.DataBinding.FieldName := 'ITE_SALREG';
    gsITE_SALEXT.DataBinding.FieldName := 'ITE_SALEXT';
    gsITE_SALRES.DataBinding.FieldName := 'ITE_SALRES';
    gsITE_SALEND.DataBinding.FieldName := 'ITE_SALEND';
    gsITE_ORDPRO.DataBinding.FieldName := 'ITE_SALORD';
    gsITE_FUTPRE.DataBinding.FieldName := 'ITE_FUTPRE';
    gsITE_FUTFAL.DataBinding.FieldName := 'ITE_FUTFAL';
    gsITE_FUTAGU.DataBinding.FieldName := 'ITE_FUTAGU';
    gsITE_SDPDBF.DataBinding.FieldName := 'ITE_SDPDBF';
    gsITE_SALDIS.DataBinding.FieldName := 'ITE_SALDIS';
  End;
End;

procedure TfrmFatMostraEstoqueEmp.pcdsIteEst;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.lblGravando.Caption := 'Calculando saldos das estruturas, aguarde...';
      frmGravando.fExecutarAcao       := fcdsIteEst;
      frmGravando.showModal;
      Self.Repaint();
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmFatMostraEstoqueEmp.pcdsIteEst');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatMostraEstoqueEmp.pcdsSalEmp;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.lblGravando.Caption := 'Calculando saldos, aguarde...';
      frmGravando.fExecutarAcao       := fcdsSalEmp;
      frmGravando.showModal;
      Self.Repaint();
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmFatMostraEstoqueEmp.pcdsSalEmp');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmFatMostraEstoqueEmp.fcdsIteEst(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := fMostraSomaSaldos(cdsIteEst);
end;

function TfrmFatMostraEstoqueEmp.fcdsSalEmp(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := fMostraSomaSaldos(cdsSalEmp);
end;

procedure TfrmFatMostraEstoqueEmp.FormCreate(Sender: TObject);
begin
  inherited;
  blnRestaurado := False;
  If Not TSalvaConfiguracaoGrid.fExisteRegistro(Self.Name) Then
    TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxGridDados, Self.Name + '_INI')
  Else
  begin
    TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxGridDados, Self.Name);
    blnRestaurado := True;
  end;

  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  blnEmcFen := fCfgSis('EMCFEN') = '2';
  blnOrdPro := fCfgSis('ORDPRO', varBoolean);
  intCalSal := fCfgSis('CALSAL', varInteger);
  blnUsaPDV := fCfgSis('USAPDV', varBoolean);
  blnUsaEstExt := fCfgSis('ESTEXT', varBoolean);
  If (Not blnAcessoTodasAsEmpresas) And (Not blnUsaEstExt) Then
    blnUsaEstExt := (fCampoTabela('COUNT(1)', 'CFGSIS', ['SIS_CODCFG','SIS_VALCFG'], ['CFG_ESTEXT','S'], False) > 0);

  blnMostrarPrecos := fCfgSis('VENEST', varBoolean);
  strNumLot := '';
  fltQtdIte := 0;
  blnPedCorte := False;
  blnFaturamento  := False;

  pAjustaColunasSaldo(not blnRestaurado);
end;

procedure TfrmFatMostraEstoqueEmp.pAjustaColunasSaldo(blnIndexaColunas: Boolean);
 Var
    Idx: integer;

    procedure pSetIndex(cxg: TcxGridDBColumn);
    begin
      Inc(Idx);
      
      cxg.Index := Idx;
    end;

    procedure pOrdemInicialGridDados;
    begin
      Idx := -1;

      pSetIndex(gdEMP_NOMEMP);
      pSetIndex(gdITE_SALFIS);
      pSetIndex(gdITE_SALREG);
      pSetIndex(gdITE_SALEXT);
      pSetIndex(gdITE_SALRES);
      pSetIndex(gdITE_SDPDBF);
      pSetIndex(gdITE_SALEND);
      pSetIndex(gdITE_ORDPRO);

      Case intCalSal Of
        1: Begin
             pSetIndex(gdITE_SALDIS); 
              
             pSetIndex(gdITE_FUTPRE);
             pSetIndex(gdITE_FUTFAL);
             pSetIndex(gdITE_FUTAGU);
           End;
        2: Begin
             If fCfgSis('BEFTRG', VarBoolean) Then
             Begin
               pSetIndex(gdITE_SALDIS); 
                
               pSetIndex(gdITE_FUTPRE);
               pSetIndex(gdITE_FUTFAL);
               pSetIndex(gdITE_FUTAGU);
             End
             Else
             Begin
               pSetIndex(gdITE_FUTPRE);
               pSetIndex(gdITE_FUTFAL);
               pSetIndex(gdITE_FUTAGU);
               
               pSetIndex(gdITE_SALDIS);  
             End;
           End;
        3: Begin
             pSetIndex(gdITE_FUTPRE);
             pSetIndex(gdITE_FUTAGU);

             pSetIndex(gdITE_SALDIS);  

             pSetIndex(gdITE_FUTFAL);
           End;
        4: Begin
             pSetIndex(gdITE_FUTFAL);
               
             pSetIndex(gdITE_SALDIS);  
             
             pSetIndex(gdITE_FUTPRE);
             pSetIndex(gdITE_FUTAGU);
           End;
        5: Begin
             pSetIndex(gdITE_FUTPRE);
               
             pSetIndex(gdITE_SALDIS);  

             pSetIndex(gdITE_FUTAGU);
             pSetIndex(gdITE_FUTFAL);
           End;
      End;

      pSetIndex(gdITE_PREVE1);
      pSetIndex(gdITE_PREVE2);
      pSetIndex(gdITE_PREVE3);
      pSetIndex(gdITE_PREVE4);
      pSetIndex(gdITE_PREVE5);
      pSetIndex(gdITE_PREVE6);
      pSetIndex(gdITE_PREVE7);
      pSetIndex(gdITE_ESTMIN);
      pSetIndex(gdITE_ESTMAX);
    end;

    procedure pOrdemInicialGridEstru;
    begin
      Idx := -1;

      pSetIndex(gsITE_SUBITE);
      pSetIndex(gsEMP_NOMEMP);
      pSetIndex(gsITE_SALFIS);
      pSetIndex(gsITE_SALREG);
      pSetIndex(gsITE_SALEXT);
      pSetIndex(gsITE_SALRES);
      pSetIndex(gsITE_SDPDBF);
      pSetIndex(gsITE_SALEND);
      pSetIndex(gsITE_ORDPRO);

      Case intCalSal Of
        1: Begin
             pSetIndex(gsITE_SALDIS); 
              
             pSetIndex(gsITE_FUTPRE);
             pSetIndex(gsITE_FUTFAL);
             pSetIndex(gsITE_FUTAGU);
           End;
        2: Begin
             If fCfgSis('BEFTRG', VarBoolean) Then
             Begin
               pSetIndex(gsITE_SALDIS); 
                
               pSetIndex(gsITE_FUTPRE);
               pSetIndex(gsITE_FUTFAL);
               pSetIndex(gsITE_FUTAGU);
             End
             Else
             Begin
               pSetIndex(gsITE_FUTPRE);
               pSetIndex(gsITE_FUTFAL);
               pSetIndex(gsITE_FUTAGU);
               
               pSetIndex(gsITE_SALDIS);  
             End;
           End;
        3: Begin
             pSetIndex(gsITE_FUTPRE);
             pSetIndex(gsITE_FUTAGU);

             pSetIndex(gsITE_SALDIS);  

             pSetIndex(gsITE_FUTFAL);
           End;
        4: Begin
             pSetIndex(gsITE_FUTFAL);
               
             pSetIndex(gsITE_SALDIS);  
             
             pSetIndex(gsITE_FUTPRE);
             pSetIndex(gsITE_FUTAGU);
           End;
        5: Begin
             pSetIndex(gsITE_FUTPRE);
               
             pSetIndex(gsITE_SALDIS);  

             pSetIndex(gsITE_FUTAGU);
             pSetIndex(gsITE_FUTFAL);
           End;
      End;

      pSetIndex(gsITE_PREVE1);
      pSetIndex(gsITE_PREVE2);
      pSetIndex(gsITE_PREVE3);
      pSetIndex(gsITE_PREVE4);
      pSetIndex(gsITE_PREVE5);
      pSetIndex(gsITE_PREVE6);
      pSetIndex(gsITE_PREVE7);
    end;
    
Begin
  If blnIndexaColunas Then
  Begin
    pOrdemInicialGridDados;
    pOrdemInicialGridEstru;
  End;  

  gdITE_FUTPRE.Visible := blnEntFut;
  gdITE_FUTFAL.Visible := blnEntFut;
  gdITE_FUTAGU.Visible := blnEntFut;
  gdITE_SDPDBF.Visible := blnEntFut;

  gdITE_ORDPRO.Visible := blnUsaPDV And blnOrdPro;
  gdITE_SALEND.Visible := blnUsaPDV;
  gdITE_SALRES.Visible := blnUsaPDV;

  gsITE_FUTPRE.Visible := blnEntFut;
  gsITE_FUTFAL.Visible := blnEntFut;
  gsITE_FUTAGU.Visible := blnEntFut;

  gsITE_ORDPRO.Visible := blnUsaPDV And blnOrdPro;
  gsITE_SALEND.Visible := blnUsaPDV;
  gsITE_SALRES.Visible := blnUsaPDV;

  gdITE_SALEXT.Visible := blnUsaEstExt;
  gsITE_SALEXT.Visible := blnUsaEstExt;

  gdITE_SALEXT.Visible := blnUsaEstExt;
  gsITE_SALEXT.Visible := blnUsaEstExt;

  gdITE_SDPDBF.Visible := fReservaSaldoPedidosBaixaEntregaFutura;
  gsITE_SDPDBF.Visible := fReservaSaldoPedidosBaixaEntregaFutura;
End;

procedure TfrmFatMostraEstoqueEmp.FormDestroy(Sender: TObject);
begin
   TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxGridDados, Self.Name);

  inherited;
  if blnEstrutura Then
  Begin
    FreeAndNil(cdsIteEst);
    FreeAndNil(dtsIteEst);
    FreeAndNil(dspIteEst);
    FreeAndNil(qryIteEst);
  End;
end;

procedure TfrmFatMostraEstoqueEmp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F8: Begin
            btnPrepTE.Click;
            Key := 0;
          End;
  end;
end;

procedure TfrmFatMostraEstoqueEmp.FormShow(Sender: TObject);
  Var
    intContador: Integer;
    objCadLot  : TCadLot;
begin
  inherited;

  blnAcessoTodasAsEmpresas := (Not fCfgSis('ACEMPI', varBoolean));

  objCadLot := TCadLot.Create(Self);

  qrySalEmp.Connection := frmModulo.GetCurrentConnection;

  With qrySalEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSql);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    pFormataCampos(qrySalEmp);
  End;

  For intContador := 1 To qrySalEmp.FieldCount Do
  Begin
    qrySalEmp.Fields.FieldByNumber(intContador).Required := False;
    qrySalEmp.Fields.FieldByNumber(intContador).ReadOnly := False;
  End;

  cdsSalEmp.Open;
  pcdsSalEmp;

  If Not fEmptyStr(strNumLot) Then
    Caption := Caption + ' - ' + objCadLot.strTitLab + ': ' + strNumLot;

  If pnlSelecEmpresa.Visible Then
  Begin
    chkSaldosDisponiveis.Checked := True;
    pSetFocus(edtCodEmp);
  End;

  FreeAndNil(objCadLot);

  {********************************************}
  {* EXIBE INFORMAÇOES DOS ITENS DE ESTRUTURA *}
  {*****************************************GB*}
  cxGridEstrutura.Visible := blnEstrutura;
  Splitter1.Visible       := blnEstrutura;
  if blnEstrutura Then
  Begin
    cdsIteEst := TUniClientDataSet.Create(Self);
    dtsIteEst := TDataSource.Create(Self);
    dspIteEst := TUniDataSetProvider.Create(Self);
    qryIteEst := fCriaQuery(Self);

    dspIteEst.DataSet := qryIteEst;
    cdsIteEst.SetProvider(dspIteEst);
    dtsIteEst.DataSet := cdsIteEst;
    cxGridDadosEstrutura.DataController.DataSource := dtsIteEst;

    With qryIteEst Do
    Begin
      SQL.Add(fGetSql(True));
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      pFormataCampos(qryIteEst);

      For intContador := 1 To FieldCount Do
      Begin
        Fields.FieldByNumber(intContador).Required := False;
        Fields.FieldByNumber(intContador).ReadOnly := False;
      End;

    End;

    cdsIteEst.Open;
    pcdsIteEst;

  End;

end;

procedure TfrmFatMostraEstoqueEmp.cdsSalEmpAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IntRecNo := cdsSalEmp.RecNo;
end;

procedure TfrmFatMostraEstoqueEmp.chkMostrarMLClick(Sender: TObject);
begin
  inherited;

  pAlteraParaML(chkMostrarML.Checked);
end;

procedure TfrmFatMostraEstoqueEmp.chkSaldosDisponiveisClick(Sender: TObject);
begin
  inherited;
  cdsSalEmp.Filtered := False;

  If chkSaldosDisponiveis.Checked Then
  Begin
    cdsSalEmp.Filter := 'ITE_SALDIS >= ' +
      floatToStr(fltQtdIte);
    cdsSalEmp.Filtered := True;      
  End;
end;

procedure TfrmFatMostraEstoqueEmp.cxGridDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
    Close;
end;

procedure TfrmFatMostraEstoqueEmp.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, Not blnAcessoTodasAsEmpresas) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatMostraEstoqueEmp.fGetSql(blnItemEstrutura: Boolean): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  strSQL := strSQL + ' (0.00) ITE_SALRES, ';
  strSQL := strSQL + ' (0.00) ITE_SALEND, ';
  strSQL := strSQL + ' (0.00) ITE_SALREG, ';
  strSQL := strSQL + ' (0.00) ITE_SALEXT, ';
  strSQL := strSQL + ' (0.00) ITE_SALDIS, ';
  strSQL := strSQL + ' (0.00) ITE_SALORD, ';
  strSQL := strSQL + ' (0.00) ITE_SALFIS, ';
  strSQL := strSQL + ' (0.00) ITE_FUTPRE, ';
  strSQL := strSQL + ' (0.00) ITE_FUTFAL, ';
  strSQL := strSQL + ' (0.00) ITE_FUTAGU, ';
  strSQL := strSQL + ' (0.00) ITE_SDPDBF, ';
  strSQL := strSQL + ' (0.00) ITE_QTPDBF, ';

  strSQL := strSQL + ' (0.000) ITE_SALRES_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALEND_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALREG_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALEXT_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALDIS_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALORD_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALFIS_ML, ';
  strSQL := strSQL + ' (0.000) ITE_FUTPRE_ML, ';
  strSQL := strSQL + ' (0.000) ITE_FUTFAL_ML, ';
  strSQL := strSQL + ' (0.000) ITE_FUTAGU_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SDPDBF_ML, ';
  strSQL := strSQL + ' (0.000) ITE_QTPDBF_ML, ';

  strSQL := strSQL + '  EMP_CODEMP, ';

  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_SAL_ML, ';
  strSQL := strSQL + '  I.ITE_CNV_ML, ';

  {**************************************}
  {* 1: APENAS TABELA DE CLIENTE        *}
  {* 2: CONFIGURAÇÃO                    *}
  {***********************************AF*}
  If blnMostrarPrecos Then
  Begin
    If (fCfgSis('TBCCFG') = '1')              Or
       (Not fVerificaAcessoSistema('VITBPR')) Then
    Begin

      If Not fEmptyStr(strTabPre) Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ', ';

        Case StrToInt(strTabPre) Of
          1: gdITE_PREVE1.Visible := True;
          2: gdITE_PREVE2.Visible := True;
          3: gdITE_PREVE3.Visible := True;
          4: gdITE_PREVE4.Visible := True;
          5: gdITE_PREVE5.Visible := True;
          6: gdITE_PREVE6.Visible := True;
          7: gdITE_PREVE7.Visible := True;
        End;

      End
      Else
      Begin
        strSQL := strSQL + '  G.ITE_PREVE1, ';
        gdITE_PREVE1.Visible := True;
      End;

    End
    Else
    Begin
      {*************************************}
      { HAB SOMENTE AS TABS CONFORME A CFG  }
      {**********************************JB*}
      If VS_strTabPrc[1] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE1, ';
        gdITE_PREVE1.Visible := True;
      End;

      If VS_strTabPrc[2] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE2, ';
        gdITE_PREVE2.Visible := True;
      End;

      If VS_strTabPrc[3] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE3, ';
        gdITE_PREVE3.Visible := True;
      End;

      If VS_strTabPrc[4] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE4, ';
        gdITE_PREVE4.Visible := True;
      End;

      If VS_strTabPrc[5] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE5, ';
        gdITE_PREVE5.Visible := True;
      End;

      If VS_strTabPrc[6] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE6, ';
        gdITE_PREVE6.Visible := True;
      End;

      If VS_strTabPrc[7] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE7, ';
        gdITE_PREVE7.Visible := True;
      End;

    End;
  End;

  strSQL := strSQL + ' CONCAT(EMP_CODEMP, "-", EMP_NOMFAN) AS EMP_NOMEMP, ';
  strSQL := strSQL + ' I.ITE_CODITE, ITE_ESTMIN, ITE_ESTMAX ';

  If blnItemEstrutura Then
  Begin
    strSQL := strSQL + ',';
    strSQL := strSQL + ' CONCAT(I.ITE_CODITE, " - ", I.ITE_DESITE) AS DESITE  ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER G ';
  strSQL := strSQL + '  JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADEMP   ON G.ITE_CODEMP = EMP_CODEMP ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP AND ';

  If (Not blnAcessoTodasAsEmpresas) Then
    strSQL := strSQL + '  (LOCATE(EMP_CODEMP, ' + QuotedStr(strEmpEstUsuarioLogado) + ') > 0) AND ';

  If Not blnItemEstrutura Then
    strSQL := strSQL + '  G.ITE_CODITE = :CODITE '
  Else
  Begin
    strSQL := strSQL + '  G.ITE_CODITE IN ( ';
    strSQL := strSQL + '     SELECT DMT_ITESUB ';
    strSQL := strSQL + '     FROM DETMAT ';
    strSQL := strSQL + '     WHERE DMT_SEQGER IN ( ';

    strSQL := strSQL + '          SELECT AUTOINCREM ';
    strSQL := strSQL + '          FROM GERMAT ';
    strSQL := strSQL + '          WHERE GMT_CODITE = :CODITE ';

    strSQL := strSQL + '     ) ';
    strSQL := strSQL + '  ) ';
  End;

  strSQL := strSQL + 'UNION ';

  strSQL := strSQL + 'SELECT ';

  strSQL := strSQL + ' (0.00) ITE_SALRES, ';
  strSQL := strSQL + ' (0.00) ITE_SALEND, ';
  strSQL := strSQL + ' (0.00) ITE_SALREG, ';
  strSQL := strSQL + ' (0.00) ITE_SALEXT, ';
  strSQL := strSQL + ' (0.00) ITE_SALDIS, ';
  strSQL := strSQL + ' (0.00) ITE_SALFIS, ';
  strSQL := strSQL + ' (0.00) ITE_SALORD, ';
  strSQL := strSQL + ' (0.00) ITE_FUTPRE, ';
  strSQL := strSQL + ' (0.00) ITE_FUTFAL, ';
  strSQL := strSQL + ' (0.00) ITE_FUTAGU, ';
  strSQL := strSQL + ' (0.00) ITE_SDPDBF, ';
  strSQL := strSQL + ' (0.00) ITE_QTPDBF, ';

  strSQL := strSQL + ' (0.000) ITE_SALRES_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALEND_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALREG_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALEXT_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALDIS_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALORD_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SALFIS_ML, ';
  strSQL := strSQL + ' (0.000) ITE_FUTPRE_ML, ';
  strSQL := strSQL + ' (0.000) ITE_FUTFAL_ML, ';
  strSQL := strSQL + ' (0.000) ITE_FUTAGU_ML, ';
  strSQL := strSQL + ' (0.000) ITE_SDPDBF_ML, ';
  strSQL := strSQL + ' (0.000) ITE_QTPDBF_ML, ';

  strSQL := strSQL + '  EMP_CODEMP, ';

  strSQL := strSQL + '  G.ITE_SALDOS, ';

  strSQL := strSQL + '  G.ITE_SAL_ML, ';
  strSQL := strSQL + '  I.ITE_CNV_ML, ';

  {**************************************}
  {* 1: APENAS TABELA DE CLIENTE        *}
  {* 2: CONFIGURAÇÃO                    *}
  {***********************************AF*}
  If blnMostrarPrecos Then
  Begin
    If (fCfgSis('TBCCFG') = '1')              Or
       (Not fVerificaAcessoSistema('VITBPR')) Then
    Begin

      If Not fEmptyStr(strTabPre) Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ', ';

        Case StrToInt(strTabPre) Of
          1: gdITE_PREVE1.Visible := True;
          2: gdITE_PREVE2.Visible := True;
          3: gdITE_PREVE3.Visible := True;
          4: gdITE_PREVE4.Visible := True;
          5: gdITE_PREVE5.Visible := True;
          6: gdITE_PREVE6.Visible := True;
          7: gdITE_PREVE7.Visible := True;
        End;

      End
      Else
      Begin
        strSQL := strSQL + '  G.ITE_PREVE1, ';
        gdITE_PREVE1.Visible := True;
      End;

    End
    Else
    Begin
      {*************************************}
      { HAB SOMENTE AS TABS CONFORME A CFG  }
      {**********************************JB*}
      If VS_strTabPrc[1] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE1, ';
        gdITE_PREVE1.Visible := True;
      End;

      If VS_strTabPrc[2] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE2, ';
        gdITE_PREVE2.Visible := True;
      End;

      If VS_strTabPrc[3] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE3, ';
        gdITE_PREVE3.Visible := True;
      End;

      If VS_strTabPrc[4] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE4, ';
        gdITE_PREVE4.Visible := True;
      End;

      If VS_strTabPrc[5] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE5, ';
        gdITE_PREVE5.Visible := True;
      End;

      If VS_strTabPrc[6] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE6, ';
        gdITE_PREVE6.Visible := True;
      End;

      If VS_strTabPrc[7] = 'S' Then
      Begin
        strSQL := strSQL + '  G.ITE_PREVE7, ';
        gdITE_PREVE7.Visible := True;
      End;

    End;
  End;

  strSQL := strSQL + '  CONCAT(EMP_CODEMP, "-", EMP_NOMFAN) AS EMP_NOMEMP, ';
  strSQL := strSQL + '  I.ITE_CODITE, ITE_ESTMIN, ITE_ESTMAX  ';

  If blnItemEstrutura Then
  Begin
    strSQL := strSQL + ',';
    strSQL := strSQL + ' CONCAT(I.ITE_CODITE, " - ", I.ITE_DESITE) AS DESITE ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER G ';
  strSQL := strSQL + '  JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADEMP   ON G.ITE_CODEMP = EMP_CODEMP ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  G.ITE_CODEMP <> :CODEMP AND ';

  If (Not blnAcessoTodasAsEmpresas) Then
    strSQL := strSQL + '  (LOCATE(G.ITE_CODEMP, ' + QuotedStr(strEmpEstUsuarioLogado) + ') > 0) AND ';

  If Not blnItemEstrutura Then
    strSQL := strSQL + '  G.ITE_CODITE = :CODITE '
  Else
  Begin
    strSQL := strSQL + '  G.ITE_CODITE IN ( ';
    strSQL := strSQL + '     SELECT DMT_ITESUB ';
    strSQL := strSQL + '     FROM DETMAT ';
    strSQL := strSQL + '     WHERE DMT_SEQGER IN ( ';

    strSQL := strSQL + '          SELECT AUTOINCREM ';
    strSQL := strSQL + '          FROM GERMAT ';
    strSQL := strSQL + '          WHERE GMT_CODITE = :CODITE ';

    strSQL := strSQL + '     ) ';
    strSQL := strSQL + '  ) ';
  End;

  If blnItemEstrutura Then
  Begin
    strSQL := strSQL + ' ORDER BY   ';
    strSQL := strSQL + ' DESITE,    ';
    strSQL := strSQL + ' EMP_NOMEMP ';
  End;

  Result := strSQL;
end;

function TfrmFatMostraEstoqueEmp.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodEmp) And pnlSelecEmpresa.Visible Then
    Begin
      edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Código da Empresa para o Item!', ['&Ok']);
        Result := False;
      End

      Else If fEmptyStr(edtNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
      End

      Else If (fCfgSis('ACEMPI', varBoolean))  And (Pos(edtCodEmp.Text, strEmpMultiLojaUsuarioLogado) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;


end.


