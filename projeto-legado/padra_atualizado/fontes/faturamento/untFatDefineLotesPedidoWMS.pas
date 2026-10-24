unit untFatDefineLotesPedidoWMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils, System.UITypes,
  Math, BitBtnLockedIncrem, frxDMPExport, untTypesSistema,
  untDefineLotesWMS, untMovGer, untFuncFatImp, untFuncFatTypes,
  untCadLote, ComCtrls, MemDS, DBAccess, Provider, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxProgressBar, frxExportPDF, Datasnap.DBClient, System.ImageList,
  Vcl.ImgList, dxScreenTip, cxClasses, dxCustomHint, cxHint, AgrupamentoDeOndaDeSeparacao.Types;

Type
  TTipoDefinicoesLotes = (tdlPedido, tdlOndaDeSeparacao);
  TTipoSaldoLote = (tslLotesNaoAtendidos = 1, tslLotesPacialmenteAtendidos = 2, tslLotesSemValidacaoDoSaldo = 3, tslLotesBloqueados = 4);
  TTipoFolhaSeparada = (tfsNenhum, tfsFaltaEstoque, tfsTintaAutomotiva);

type
  THackDBGrid = class(TDBGridCitel);

type
  TRecalcularLocalizacoes = class
  private
    FItens  : TUniClientDataSet;
    FLotes1 : TUniClientDataSet;
    FLotes2 : TUniClientDataSet;
  public

    constructor New;
    destructor Destroy; Override;

    procedure CopiarItens(const AItens : TUniClientDataSet);

    procedure CopiarLotes1(const ALotes : TUniClientDataSet);
    procedure CopiarLotes2(const ALotes : TUniClientDataSet);

    procedure RestaurarItens(var AItens : TUniClientDataSet);

    procedure RestaurarLotes1(var ALotes : TUniClientDataSet);
    procedure RestaurarLotes2(var ALotes : TUniClientDataSet);

  end;

type
  TfrmFatDefineLotesPedidoWMS = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    prgProgresso: TProgressBar;
    Splitter1: TSplitter;
    pnlInfWms: TPanel;
    dbgLotes: TDBGridCitel;
    frxSeparacaoWMS: TfrxReport;
    frxPedido: TfrxDBDataset;
    btnConfigurar: TBitBtnLocked;
    frxExpPDF: TfrxPDFExport;
    btnSepAnd: TBitBtnLocked;
    frxSemSal: TfrxDBDataset;
    pnlLegenda: TPanel;
    shpLotesDefinidosPedido: TShape;
    lblLotesDefinidosPedido: TLabel;
    ImageList: TImageList;
    Image: TImage;
    HintControler: TcxHintStyleController;
    pnlLegendaMovimentacaoProgramada: TPanel;
    Label1: TLabel;
    Panel1: TPanel;
    shpLoteZerado: TShape;
    lblLoteZerado: TLabel;
    shpSaldoInsuficiente: TShape;
    lblSaldoInsuficiente: TLabel;
    pnlFiltroLote: TPanel;
    rdgFiltraSaldoLote: TRadioGroup;
    btnRelatorio: TBitBtnLocked;
    btnRecalcularLocalizacoes: TBitBtnLocked;
    shpLegProdutoAcabado: TShape;
    lblLegProdutoAcabado: TLabel;
    shpLoteBloqueado: TShape;
    lblLoteBloqueado: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure dbgLotesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaExit(Sender: TObject);
    function frxSeparacaoWMSUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnSepAndClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgConsultaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure rdgFiltraSaldoLoteClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnRecalcularLocalizacoesClick(Sender: TObject);
    procedure dtsConsultaDataChange(Sender: TObject; Field: TField);
    procedure dbgLotesKeyPress(Sender: TObject; var Key: Char);
  private

    FComTransacao : Boolean;
    FItensRemessa : TItensRemessa;

    intLastRecNo : Integer;
    objDefineLotes: TDefineLotesWMS;

    cdsSemSal : TUniClientDataSet; //Cds com os Colorantes sem Saldo

    cdsLotSel : TUniClientDataSet;
    dtsLotSel : TDataSource;

    clrCorZebra : TColor;

    blnFecharForm: Boolean;
    strLaySep : String;

    blnUsaWMSRastreavelTinta: Boolean;

    strSenSep : String;
    procedure pShowHint(intRecNo, x, y : Integer);
    procedure pHideHint;
    function fGetTextoHint(strCodIte, strCodEmp : String) : String;

    Const FILA_SEPARACAO = 'frmFatVendas_SEP_WMS';

    procedure pAfterScroll(DataSet: TDataSet);
    procedure pCancela(blnPerguntar: Boolean = True);
    Procedure pSetaRequeridos;

    procedure pAtualizaGridLotes;
    procedure pAtualizaGridLotesOndaDeSeparacao;
    procedure pAtualizaGridLocalizaoFisica;

    procedure pInformaLotesProduto;
    function fSalvarQuantidadeDigitada(pgbProgresso: TCxProgressBar): Boolean;

    function fCarregarPedido(pgbProgresso: TCxProgressBar): Boolean;
    function fCarregarOndaDeSeparacao(pgbProgresso: TCxProgressBar): Boolean;

    procedure pImprimeSeparacaoWMS(opcFolhaSeparada: TTipoFolhaSeparada = tfsNenhum);
    procedure pImprimeEditor;
    function fLoteDeTintaInformadoNaBaixaDaFormulacao: Boolean;
    function fBaixouAFormulacaoDaTinta(strAutInc: String): Boolean;
    procedure pVerificaTintaDeMaquinaLoteWMSBaixaFormulacao;
    procedure pVerificaSaldosGrid(dbgConsultaSaldos: TDBGridCitel; RectSaldos: TRect; DataColSaldos: integer; ColumnSaldos: TColumn; StateSaldos: TGridDrawState);
    procedure pVerificaSaldoCorte;

    procedure pIdeProGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pAjustaTamanhoDescricaoItemGrid;
    function fRetornaSaldosLote(strCodIte, strIdePro: String): Double;
    procedure pSetaLoteLocalizacaoFisicaComSaldo(cdsPedido : TUniClientDataSet);
    function fLayoutPossuiLoteOuLocalizacaoFisicaComSaldo: Boolean;
    procedure pRestaurarDefinicoesOriginais;

    procedure pConfiguraInformacoesTelaProdutoAcabado;
    procedure pBaixarSeparacaoPedidoTintaAutomotiva;
    function fTemItemTintaAutomotiva: Boolean;
    function fValidaRemessaDeSeparacao: Boolean;

    function fTemProdutoAcabado():Boolean;
    function fApenasMarcarComoImpressoPedidoOndaSeparacao: Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;
  public

    TipoDefinicoesLotes : TTipoDefinicoesLotes;
    strOndaDeSeparacao  : String;

    RecalcularLocalizacoes : TRecalcularLocalizacoes;

    { Public declarations }
    strNumPed: String;
    strEmpPed: String;
    strCodSep: String;
    strCodIte: String; // esse campo é usado apenas, qndo é produção fora de loja com WMS + Coletor (Bela Tintas)
    blnConfirma: Boolean;
    blnReimpr: Boolean;
    blnSepImp: Boolean;
    strCodCli: String;
    blnApenasImpressao : Boolean;
    arrDadosCodBarra: TarrayDadosCodBarra;
    blnExpedicao: boolean;
    blnAtualizaPedCortado: Boolean;

    strCodLseItens: String;

    stlMensagens: TStringList;

    // Autoincrem do Fatdor utilizado pelo F9 [Baixar] - Formulacao de tinta de maquina
    // Não utilizar essa variável para outra coisa;
    strAutIncTinta: String;

    pAtuSepPed : procedure (strCodSep: String) Of Object;
    function fCriarObjetos: Boolean;

    function fEhDefinicaoDeLotesPorOndaDeSeparacao : Boolean;

    property ComTransacao : Boolean Read FComTransacao Write FComTransacao;
    property ItensRemessa : TItensRemessa Read FItensRemessa;

  end;

var
  frmFatDefineLotesPedidoWMS: TfrmFatDefineLotesPedidoWMS;

implementation

uses untPai, untCfgRel, untConsultas, untCadLoteItens,
  untFuncoesSimples, untCadLocFisica, untGravando, untFuncoesGenerica,
  untCadConfRelatorios, untFuncoesRel, untFuncoesRel2, untZClient,
  untTMatrizSaldosColorantes, untFuncTinta, untFuncFat, untTipoTinta,
  untTPickingCheckOut, untFatGor, untFuncoesWMS;

{$R *.dfm}

Procedure TfrmFatDefineLotesPedidoWMS.pSetaRequeridos;
  Var
    intIndex: Integer;
Begin
  With cdsConsulta Do
  For intIndex := 0 To FieldDefs.Count - 1 Do
    FieldDefs[intIndex].Required := FALSE;
End;

procedure TfrmFatDefineLotesPedidoWMS.pVerificaSaldoCorte;
var
  fltSaldos: Double;
  blnTintaAutomotiva: Boolean;
begin
  if cdsConsulta.IsEmpty then
    Exit;

  cdsConsulta.First;

  while not cdsConsulta.Eof do
  begin
    cdsConsulta.Edit;

    fltSaldos := fRetornaSaldosLote(cdsConsulta.FieldByName('FDO_CODITE').AsString,
                                    cdsConsulta.FieldByName('FDO_IDEPRO').AsString);

    blnTintaAutomotiva := False;
    If Assigned(fTipoTinta) Then
      If (cdsConsulta.FieldByName('FDO_IDEPRO').AsString <> 'NOR') Then
        blnTintaAutomotiva := (fTipoTinta(cdsConsulta.FieldByName('FDO_IDEPRO').AsString) = ttAutomotiva);

    If (blnTintaAutomotiva) Then
    Begin
      cdsConsulta.FieldByName('SALCOR').AsInteger := Integer(tslLotesSemValidacaoDoSaldo);
    End
    Else
    Begin

      if fltSaldos <= 0 then
      begin
        if fLotePickingBloqueado(cdsConsulta.FieldByName('FDO_CODITE').AsString) then
          cdsConsulta.FieldByName('SALCOR').AsInteger := Integer(tslLotesBloqueados)
        else
          cdsConsulta.FieldByName('SALCOR').AsInteger := Integer(tslLotesNaoAtendidos);
      end
      else if cdsConsulta.FieldByName('FDO_QTDITE').AsFloat > fltSaldos then
      begin
        cdsConsulta.FieldByName('SALCOR').AsInteger := Integer(tslLotesPacialmenteAtendidos);
      end;

    End;

    cdsConsulta.Post;

    cdsConsulta.Next;
  end;
end;

procedure TfrmFatDefineLotesPedidoWMS.pVerificaSaldosGrid(
  dbgConsultaSaldos: TDBGridCitel; RectSaldos: TRect; DataColSaldos: integer; ColumnSaldos: TColumn; StateSaldos: TGridDrawState);
begin
  if cdsConsulta.FieldByName('SALCOR').AsInteger = Integer(tslLotesNaoAtendidos) then
  begin
    dbgConsultaSaldos.Canvas.Brush.Color := shpLoteZerado.Brush.Color;
    dbgConsultaSaldos.Canvas.Font.Color  := clBlack;
    dbgConsultaSaldos.Canvas.FillRect(RectSaldos);
    dbgConsulta.DefaultDrawColumnCell(RectSaldos, DataColSaldos, ColumnSaldos, StateSaldos);
  end
  else if cdsConsulta.FieldByName('SALCOR').AsInteger = Integer(tslLotesPacialmenteAtendidos) then
  begin
    dbgConsultaSaldos.Canvas.Brush.Color := shpSaldoInsuficiente.Brush.Color;
    dbgConsultaSaldos.Canvas.Font.Color  := clWhite;
    dbgConsultaSaldos.Canvas.FillRect(RectSaldos);
    dbgConsulta.DefaultDrawColumnCell(RectSaldos, DataColSaldos, ColumnSaldos, StateSaldos);
  end
  else if cdsConsulta.FieldByName('SALCOR').AsInteger = Integer(tslLotesBloqueados) then
  begin
    dbgConsultaSaldos.Canvas.Brush.Color := shpLoteBloqueado.Brush.Color;
    dbgConsultaSaldos.Canvas.Font.Color  := clWhite;
    dbgConsultaSaldos.Canvas.FillRect(RectSaldos);
    dbgConsulta.DefaultDrawColumnCell(RectSaldos, DataColSaldos, ColumnSaldos, StateSaldos);
  end;
end;

procedure TfrmFatDefineLotesPedidoWMS.pVerificaTintaDeMaquinaLoteWMSBaixaFormulacao;
begin
  If fEmptyStr(strAutIncTinta) And cdsConsulta.Active And
    (Not cdsConsulta.IsEmpty) Then
  Begin
    If blnUsaWMSRastreavelTinta Then
    Begin
      If Not fLoteDeTintaInformadoNaBaixaDaFormulacao Then
      Begin
        fMensagem('ATENÇÃO', 'Antes de imprimir a separação, favor informar o lote ' + #13#10 +
                  'para as tintas imobiliárias referente ao pedido.' + #13#10 +
                  'Faturamento -> Formulação de tinta de máquina. ', ['&Ok']);
        blnFecharForm := True;
        Exit;
      End;
    End;
  End;
end;

procedure TfrmFatDefineLotesPedidoWMS.rdgFiltraSaldoLoteClick(Sender: TObject);
begin
  inherited;

  if rdgFiltraSaldoLote.ItemIndex = 1 then
  begin
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := ' SALCOR = ' + Integer(tslLotesPacialmenteAtendidos).ToString();
    cdsConsulta.Filtered := True;
  end
  else if rdgFiltraSaldoLote.ItemIndex = 2 then
  begin
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := ' SALCOR = ' + Integer(tslLotesNaoAtendidos).ToString();
    cdsConsulta.Filtered := True;
  end
  else
  begin
    cdsConsulta.Filtered := False;
  end;
end;

function TfrmFatDefineLotesPedidoWMS.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatDefineLotesPedidoWMS.fValidaRemessaDeSeparacao: Boolean;
var
  LStatus: String;
begin
  Result := True;

  if fEmptyStr(strOndaDeSeparacao) then
    Exit;

  if (not fUsaOndaSeparacaoAgrupamento) then
    Exit;

  LStatus := fRetornaStatusRemessaDeSeparacao(strOndaDeSeparacao);

  if (not LStatus.Equals('A')) Then
  begin
    fMensagem('Atenção', 'Não é possível alterar a loc. de separação pois a remessa de separação está com status ' + IIF(LStatus.Equals('S'), '"Separando"', IIF(LStatus.Equals('P'), '"Parcialmente Finalizado"', '"Finalizado"')) + '!', ['&Ok']);
    Exit(False);
  end;

  if fPossuiQuantidadeSeparada(strOndaDeSeparacao) then
  begin
    fMensagem('Atenção', 'Não é possível alterar a loc. de separação pois a remessa de separação já possui quantidade separada!', ['&Ok']);
    Exit(False);
  end;
end;

Function TfrmFatDefineLotesPedidoWMS.fGetSql(blnLike: Boolean): String;
Begin
  Result := IIF(fEhDefinicaoDeLotesPorOndaDeSeparacao,
                objDefineLotes.fGetSqlItensOndaDeSeparacao(True),
                objDefineLotes.fGetSqlItensPedido);
End;

function TfrmFatDefineLotesPedidoWMS.fLoteDeTintaInformadoNaBaixaDaFormulacao: Boolean;
begin
  Result := True;

  Try
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If (cdsConsulta.FieldByName('FDO_IDEPRO').AsString <> 'NOR') And
         (fTipoTinta(cdsConsulta.FieldByName('FDO_IDEPRO').AsString) = ttImobiliaria) Then
      Begin
        If Not fBaixouAFormulacaoDaTinta(cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
        Begin
          Result := False;
          Break;
        End;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.First;
  End;
end;

procedure TfrmFatDefineLotesPedidoWMS.pAtualizaGridLocalizaoFisica;
begin
  If (cdsConsulta.Active) And
     (Not cdsConsulta.IsEmpty) Then
  Begin
    objDefineLotes.pCarregaLocalizaoFisica(cdsConsulta.FieldByName('FDO_CODITE').AsString,
                                           cdsConsulta.FieldByName('FDO_CODACA').AsString,
                                           cdsLotSel);

    dtsLotSel.DataSet   := cdsLotSel;
    dbgLotes.DataSource := dtsLotSel;
    dbgLotes.Visible    := True;
  End
  Else
    dbgLotes.Visible  := False;
end;

procedure TfrmFatDefineLotesPedidoWMS.pAtualizaGridLotes;
begin
  With cdsConsulta Do
  Begin
    If Active And Not IsEmpty Then
    Begin
      objDefineLotes.pCarregaLotesDigitados(FieldByName('FDO_CODITE').AsString,
        FieldByName('AUTOINCREM').AsString, cdsLotSel);

      dtsLotSel.DataSet   := cdsLotSel;
      dbgLotes.DataSource := dtsLotSel;
      dbgLotes.Visible    := True;
    End
    Else
    Begin
      dbgLotes.Visible  := False;
    End;
  End;

end;

procedure TfrmFatDefineLotesPedidoWMS.pAtualizaGridLotesOndaDeSeparacao;
begin

  With cdsConsulta Do
  Begin
    If Active And Not IsEmpty Then
    Begin
      objDefineLotes.pCarregaLotesDigitadosOndaDeSeparacao(FieldByName('FDO_CODITE').AsString, cdsLotSel);

      dtsLotSel.DataSet   := cdsLotSel;
      dbgLotes.DataSource := dtsLotSel;
      dbgLotes.Visible    := True;
    End
    Else
    Begin
      dbgLotes.Visible  := False;
    End;
  End;

end;

procedure TfrmFatDefineLotesPedidoWMS.pBaixarSeparacaoPedidoTintaAutomotiva;
  Var
    prcScroll: TprcScroll;
    blnTemItemNormal, blnTemTintaAuto: Boolean;
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  pDisableControls(cdsConsulta, prcScroll);
  Try
    blnTemItemNormal := False;
    blnTemTintaAuto  := False;

    Try
      qryUpdate.SQL.Add('UPDATE EXTDOR');
      qryUpdate.SQL.Add(' JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO');
      qryUpdate.SQL.Add('  SET FDO_DTBXSE = :DTBXSE');
      qryUpdate.SQL.Add('     ,FDO_HRBXSE = :HRBXSE');
      qryUpdate.SQL.Add('     ,FDO_OPBXSE = :OPBXSE');
      qryUpdate.SQL.Add('     ,FDO_QTDSEP = FDO_QTDITE');
      qryUpdate.SQL.Add('WHERE FDO_SEQFDO = :AUTOIN');

      If FComTransacao Then
        fStartTransaction;

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        If (cdsConsulta.FieldByName('FDO_IDEPRO').AsString <> 'NOR') And
           (fTipoTinta(cdsConsulta.FieldByName('FDO_IDEPRO').AsString) = ttAutomotiva) Then
        Begin
          blnTemTintaAuto := True;

          qryUpdate.Close;
          qryUpdate.ParamByName('DTBXSE').AsDate   := VS_Date;
          qryUpdate.ParamByName('HRBXSE').AsTime   := fTime();
          qryUpdate.ParamByName('OPBXSE').AsString := IIF(fEmptyStr(Self.strCodSep), strLoginUsuarioLogado, Self.strCodSep);
          qryUpdate.ParamByName('AUTOIN').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
          qryUpdate.ExecSQL;
        End
        Else
          blnTemItemNormal := True;

        cdsConsulta.Next;
      End;

      If (Not blnTemItemNormal) And (blnTemTintaAuto) Then
      Begin
        qryUpdate.Close;
        qryUpdate.SQL.Clear;
        qryUpdate.SQL.Add('UPDATE EXTGOR');
        qryUpdate.SQL.Add('  SET FGO_DTBXSE = :DTBXSE');
        qryUpdate.SQL.Add('     ,FGO_HRBXSE = :HRBXSE');
        qryUpdate.SQL.Add('     ,FGO_OPBXSE = :OPBXSE');
        qryUpdate.SQL.Add('WHERE FGO_SEQFGO = :SEQGER');

        qryUpdate.ParamByName('DTBXSE').AsDate   := VS_Date;
        qryUpdate.ParamByName('HRBXSE').AsTime   := fTime();
        qryUpdate.ParamByName('OPBXSE').AsString := IIF(fEmptyStr(Self.strCodSep), strLoginUsuarioLogado, Self.strCodSep);
        qryUpdate.ParamByName('SEQGER').AsString := cdsConsulta.FieldByName('FDO_SEQGER').AsString;
        qryUpdate.ExecSQL;
      End;

      If FComTransacao Then
        fCommit;

    Except
      On E: Exception Do
      Begin

        If FComTransacao Then
        Begin
          fRollback;
          pMensagensErro(E.Message, '[TfrmFatDefineLotesPedidoWMS.pBaixarSeparacaoPedidoTintaAutomotiva]');
        End;

      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
    pEnableControls(cdsConsulta, prcScroll);
  End;
end;

procedure TfrmFatDefineLotesPedidoWMS.pCancela(blnPerguntar: Boolean = True);
Begin
  If cdsConsulta.IsEmpty Then
    Close

  Else If (Not blnPerguntar) Or
          (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
  End;
End;

procedure TfrmFatDefineLotesPedidoWMS.pConfiguraInformacoesTelaProdutoAcabado;
begin
  If (cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S') Then
  Begin
    pnlInfWms.Visible                 := False;
    dbgLotes.Columns.Items[0].Visible := False;
  End
  Else
    dbgLotes.Columns.Items[0].Visible := True;
end;

procedure TfrmFatDefineLotesPedidoWMS.FormCreate(Sender: TObject);
begin
  inherited;
  pHideHint;
  strCodIte := '';
  frxSeparacaoWMS.AddFunction('function fFormataCpfCgc(strValor: String): String;');
  blnApenasImpressao := False;
  blnFecharForm := False;
  blnConfirma   := False;
  strLaySep := ExtractFilePath(Application.ExeName) + 'Fr3\' + 'separacao_pedidos_WMS.fr3';
  strAutIncTinta := '';
  blnUsaWMSRastreavelTinta := fUsaRotinaWMS And
                              (fCfgSis('TMWMSR', varBoolean)) And
                              (fCfgSis('EXIDOC') = 'PD');

  If fCfgSis('WMSLOT', varBoolean) Then
    pnlLegenda.Visible := True
  Else
    pnlLegenda.Visible := False;

  TipoDefinicoesLotes := tdlPedido;
  strOndaDeSeparacao  := '';
  blnExpedicao := False;
  blnAtualizaPedCortado := False;

  FComTransacao := True;

end;

procedure TfrmFatDefineLotesPedidoWMS.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if Assigned(dtsLotSel) Then
    FreeAndNil(dtsLotSel);

  if Assigned(cdsLotSel) Then
    FreeAndNil(cdsLotSel);

  if Assigned(objDefineLotes) Then
    FreeAndNil(objDefineLotes);

  if Assigned(RecalcularLocalizacoes) Then
    FreeAndNil(RecalcularLocalizacoes);

  inherited;
end;

procedure TfrmFatDefineLotesPedidoWMS.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_DELETE: Begin
                 If Shift = [ssCtrl] Then
                   Key := 0;
               End;

    VK_ESCAPE: Begin
                 If pnlPesquisa.Visible Then
                   inherited
                 Else
                    pCancela;
               end;

    Else inherited;
  End;

end;

procedure TfrmFatDefineLotesPedidoWMS.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

procedure TfrmFatDefineLotesPedidoWMS.FormResize(Sender: TObject);
begin
  inherited;
  pAjustaTamanhoDescricaoItemGrid;
end;

function TfrmFatDefineLotesPedidoWMS.fCriarObjetos : Boolean;
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  objDefineLotes := TDefineLotesWMS.CreateInstance(Self,
                                                   strNumPed,
                                                   strEmpPed,
                                                   strAutIncTinta,
                                                   blnUsaWMSRastreavelTinta,
                                                   strCodIte,
                                                   strCodLseItens,
                                                   strOndaDeSeparacao,
                                                   strCodCli,
                                                   False,
                                                   blnApenasImpressao,
                                                   stlMensagens,
                                                   FComTransacao);

  strSenSep := 'N';
  If fCfgSis('LSEWMS', varBoolean) Or (Not fEmptyStr(strCodLseItens)) Then
  Begin
    //S- Senha do separador / C- Código do separador / N - não solicitar separador
    strSenSep := fCfgSis('SENSEP', varString);

    If fEmptyStr(strSenSep) Then
      strSenSep := 'N';
  End;

  If fEhDefinicaoDeLotesPorOndaDeSeparacao Then
  Begin
    If (fUsaOndaSeparacaoAgrupamento) Then
      Caption := 'Definição de Lotes da Remessa de Separação (' + strOndaDeSeparacao + ')'
    Else
      Caption := 'Definição de Lotes da Onda de Separação (' + strOndaDeSeparacao + ')';
  End
  Else
    Caption := Caption + Concat(' (', strNumPed, '-PD-', strEmpPed, ') ');

  dtsLotSel := TDataSource.Create(Self);

  clrCorZebra := fCfgSis('CORZEB');

  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  Try

    pCriarFormularios(TfrmGravando, frmAguarde);

    If (fEhDefinicaoDeLotesPorOndaDeSeparacao) Then
      frmAguarde.fExecutarAcao := fCarregarOndaDeSeparacao
    Else
      frmAguarde.fExecutarAcao := fCarregarPedido;

    frmAguarde.ShowModal;
    blnFecharForm := Not frmAguarde.blnConfirma;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  pFreeAndNil(frmAguarde);
  pSetFocus(dbgConsulta);

  If cdsConsulta.Active And cdsConsulta.IsEmpty Then
  Begin
    blnConfirma := True;
    blnFecharForm := True;
  End;

  Result := Not blnFecharForm;

  pVerificaTintaDeMaquinaLoteWMSBaixaFormulacao;
end;

function TfrmFatDefineLotesPedidoWMS.fEhDefinicaoDeLotesPorOndaDeSeparacao: Boolean;
begin
  Result := (TipoDefinicoesLotes = tdlOndaDeSeparacao);
end;

procedure TfrmFatDefineLotesPedidoWMS.FormShow(Sender: TObject);
begin
  Try
    dbgConsulta.OnKeyPress := nil;

    fFindColumnByName(dbgConsulta, 'FDO_IDEPRO').Visible := VS_strUsaTmq = 'S';
    fCriarObjetos;
  Finally
    dbgConsulta.OnKeyPress := dbgConsultaKeyPress;
  End;

  If btnRecalcularLocalizacoes.Visible Then
  Begin
    RecalcularLocalizacoes := TRecalcularLocalizacoes.New;
    RecalcularLocalizacoes.CopiarItens(cdsConsulta);

    RecalcularLocalizacoes.CopiarLotes1(cdsLotSel);

    If Assigned(objDefineLotes.Lotes) Then
      RecalcularLocalizacoes.CopiarLotes2(objDefineLotes.Lotes);

  End;

  If fTemProdutoAcabado Then
    pnlLegenda.Visible := True;
end;

procedure TfrmFatDefineLotesPedidoWMS.btnSairClick(Sender: TObject);
begin
  pCancela;
end;

procedure TfrmFatDefineLotesPedidoWMS.btnSepAndClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(163, 7288, [],
                        ['CODITE'],
                        [''],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmFatDefineLotesPedidoWMS.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If (cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S') Then
    pAtualizaGridLocalizaoFisica
  Else
  Begin
    If fEhDefinicaoDeLotesPorOndaDeSeparacao Then
      pAtualizaGridLotesOndaDeSeparacao
    Else
      pAtualizaGridLotes;
  End;
end;

procedure TfrmFatDefineLotesPedidoWMS.dbgLotesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Odd(TDBGridCitel(Sender).DataSource.DataSet.RecNo) Then
  Begin
    TDBGridCitel(Sender).Canvas.Brush.Color := clrCorZebra;
    TDBGridCitel(Sender).Canvas.Font.Color  := clBlack;
    TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TfrmFatDefineLotesPedidoWMS.dbgLotesKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCadLoc : TConsultasArray;
  strCodigo : String;
Begin
  If (cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S') And
     (fEntraCons(Key)) Then
  Begin
    If fPesqLocFisica(Self, strCodigo, Nil, Key, arrCadLoc) Then
    Begin
      objDefineLotes
        .pSalvarLocalizacaoFisicaCdsLote(cdsConsulta.FieldByName('FDO_CODITE').AsString,
                                         cdsConsulta.FieldByName('FDO_CODACA').AsString,
                                         strCodigo);

      pAtualizaGridLocalizaoFisica
    End;
  End
  Else
    inherited;
end;

procedure TfrmFatDefineLotesPedidoWMS.dtsConsultaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  pConfiguraInformacoesTelaProdutoAcabado;
end;

procedure TfrmFatDefineLotesPedidoWMS.dbgConsultaDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If Not cdsConsulta.IsEmpty Then
  Begin
    pVerificaSaldosGrid(dbgConsulta, Rect, DataCol, Column, State);

    If fCfgSis('WMSLOT', varBoolean) Then
    Begin
      If cdsConsulta.FieldByName('ITE_LOTEPD').AsString = 'S' then
      Begin
        dbgConsulta.Canvas.Brush.Color := shpLotesDefinidosPedido.Brush.Color;
        dbgConsulta.Canvas.Font.Color  := clBlack;
        dbgConsulta.Canvas.FillRect(Rect);
      End;
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

    If (Column.FieldName = 'TEM_MOVLOT') Then
    Begin
      dbgConsulta.Canvas.FillRect(Rect);
      If cdsConsulta.FieldByName('TEM_MOVLOT').AsString = 'S' Then
        ImageList.Draw(dbgConsulta.Canvas, Rect.Left + ((Column.Width - ImageList.Width) div 2), Rect.Top+1, 0)
      Else
        dbgConsulta.Canvas.TextOut(Rect.Left+2, Rect.Top, '');
    End;

    If (cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S') Then
    Begin
      dbgConsulta.Canvas.Brush.Color := shpLegProdutoAcabado.Brush.Color;
      dbgConsulta.Canvas.Font.Color  := clBlack;
      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;
  End;
end;

procedure TfrmFatDefineLotesPedidoWMS.dbgConsultaEnter(Sender: TObject);
begin
  inherited;
  pnlInfWms.Visible := True;
  pConfiguraInformacoesTelaProdutoAcabado;
end;

procedure TfrmFatDefineLotesPedidoWMS.dbgConsultaExit(Sender: TObject);
begin
  inherited;
  pnlInfWms.Visible := False;
end;

procedure TfrmFatDefineLotesPedidoWMS.dbgConsultaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  If (Key = #13) Then
  Begin
    Key := #0;
    dbgConsulta.OnKeyPress := nil;
    Try
      pInformaLotesProduto;
    Finally
      Key := #0;
      dbgConsulta.OnKeyPress := dbgConsultaKeyPress;
    End;
  End;

end;

function TfrmFatDefineLotesPedidoWMS.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  objDefineLotes.blnAtualizaPedCortado := blnAtualizaPedCortado;
  Result := (inherited fAbreConsulta(blnLike));
  pSetaRequeridos;

  TFloatField(cdsConsulta.FieldByName('FDO_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsConsulta.FieldByName('ITE_SALDOS')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  objDefineLotes.blnExpedicao := blnExpedicao;

  If (fEhDefinicaoDeLotesPorOndaDeSeparacao) Then
    objDefineLotes.pAtualizaLotesOndaDeSeparacao(cdsConsulta, True)
  Else
    objDefineLotes.pAtualizaLotes(cdsConsulta, True, arrDadosCodBarra);

  pnlLegendaMovimentacaoProgramada.Visible := cdsConsulta.Locate('TEM_MOVLOT', 'S', []);

  cdsConsulta.FieldByName('FDO_IDEPRO').OnGetText := pIdeProGetText;

  pVerificaSaldoCorte;

  cdsConsulta.First;
End;

function TfrmFatDefineLotesPedidoWMS.fApenasMarcarComoImpressoPedidoOndaSeparacao: Boolean;
begin
  Result := False;

  if fEmptyStr(strOndaDeSeparacao) then
    Exit;

  if fCfgSis('RSAPRP', varBoolean) then
    Exit;

  Result := True;
end;

function TfrmFatDefineLotesPedidoWMS.fBaixouAFormulacaoDaTinta(
  strAutInc: String): Boolean;
var
  qryLotDor: TUniQuery;
begin
  Try
    qryLotDor := fCriaQuery;
    With qryLotDor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT TRUE FROM LOTDOR WHERE LDO_SEQFDO = :SEQFDO');
      ParamByName('SEQFDO').AsString := strAutInc;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryLotDor);
  End;
end;

function TfrmFatDefineLotesPedidoWMS.fCarregarOndaDeSeparacao(pgbProgresso: TCxProgressBar): Boolean;
begin

  Try

    objDefineLotes.pgbProgresso := pgbProgresso;

    If Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) Then
      objDefineLotes.lblInformacao := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));

    Result := fAbreConsulta(True) And objDefineLotes.fValidaCadastroLotesProdutosOndaDeSeparacao;

    If Result Then
      cdsConsulta.First;

  Finally
    objDefineLotes.pgbProgresso  := nil;
    objDefineLotes.lblInformacao := nil;
  End;

end;

function TfrmFatDefineLotesPedidoWMS.fCarregarPedido(pgbProgresso: TCxProgressBar): Boolean;
begin
  Try
    objDefineLotes.pgbProgresso := pgbProgresso;

    If Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) Then
      objDefineLotes.lblInformacao := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));

    Result := fAbreConsulta(True) And objDefineLotes.fValidaCadastroLotesProdutos;

    If Result Then
      cdsConsulta.First;
  Finally
    objDefineLotes.pgbProgresso  := nil;
    objDefineLotes.lblInformacao := nil;
  End;
end;

procedure TfrmFatDefineLotesPedidoWMS.btnRecalcularLocalizacoesClick(Sender: TObject);
begin
  inherited;

  If Not btnRecalcularLocalizacoes.Visible Then
    Exit;

  If Not Assigned(RecalcularLocalizacoes) Then
    Exit;

  TFrmGravando.fExecutarModal(pRestaurarDefinicoesOriginais, 'Aguarde... Restaurando definições originais!', '');

end;

procedure TfrmFatDefineLotesPedidoWMS.btnRelatorioClick(Sender: TObject);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  If cdsConsulta.RecNo < 1 Then
    Exit;

  If Not Assigned(prcExecutaRelatorio) Then
    Exit;

  prcExecutaRelatorio(32, 0,
                     [],
                     ['CODITE'],
                     [cdsConsulta.FieldByName('FDO_CODITE').AsString],
                      Sender,
                     ['CODITE'],
                     True);
end;

procedure TfrmFatDefineLotesPedidoWMS.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := FILA_SEPARACAO;
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
  pFreeAndNil(frmCadConfRelatorios);
end;

procedure TfrmFatDefineLotesPedidoWMS.btnConfirmaClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
    qryPediOnda: TUniQuery;

    procedure pImprimir;
    begin
      If FileExists(strLaySep) Then
        pImprimeSeparacaoWMS
      Else
        pImprimeEditor;
    end;

begin
  inherited;

  pLimpaPesquisa;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  If (strSenSep <> 'N') Then
  Begin
    If Not objDefineLotes.fSolicitaSeparadoresPorLocalDeSeparacao(strSenSep) Then
      Exit;
  End;

  if (not fValidaRemessaDeSeparacao) then
    Exit;

  If blnApenasImpressao Or (fMensagem('', 'Confirma digitação dos Lotes do Pedido?', ['','']) = 1) Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.fExecutarAcao := fSalvarQuantidadeDigitada;
      frmAguarde.ShowModal;
      blnConfirma := frmAguarde.blnConfirma;

      If Assigned(objDefineLotes) And Assigned(objDefineLotes.ItensRemessa) Then
        FItensRemessa := objDefineLotes.ItensRemessa;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;
    pFreeAndNil(frmAguarde);

    //Se for pelo botao F9[Baixar] - Formulacao de tinta de maquina
    If (Not fEmptyStr(strAutIncTinta)) And (blnUsaWMSRastreavelTinta) Then
    Begin
      blnSepImp := True;
      pCancela(False);
      Exit;
    End;

    If blnConfirma Then
    Begin
      If (Pos(fCfgSis('WMSSEP', varString), '1_3') > 0) Then
      Begin
        If fUsaOndaSeparacaoAgrupamento Then
          blnApenasImpressao := True;

        If (blnApenasImpressao or (fMensagem('', 'Deseja imprimir separação?', ['&Sim', '&Não']) = 1)) Then
        Begin
          If fCfgSis('TIPEXP', varInteger) = 5 Then
          Begin
            blnSepImp := True;
            Exit;
          End;

          If (Not fEmptyStr(strOndaDeSeparacao)) And (fEmptyStr(strNumPed)) Then
          Begin
            qryPediOnda := fCriaQuery;
            Try
              qryPediOnda.Close;
              qryPediOnda.SQL.Add('SELECT DISTINCT G.FGO_NUMDOC, FGO_CODCLI, G.FGO_CODEMP');
              qryPediOnda.SQL.Add('  FROM FATGOR G INNER JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM');
              qryPediOnda.SQL.Add('WHERE E.' + IIF(fUsaOndaSeparacaoAgrupamento, 'FGO_SEQOND', 'FGO_SEQSEP') + ' = ' + QuotedStr(strOndaDeSeparacao));
              qryPediOnda.Open;

              While Not qryPediOnda.Eof Do
              Begin
                strNumPed := qryPediOnda.FieldByName('FGO_NUMDOC').AsString;
                strEmpPed := qryPediOnda.FieldByName('FGO_CODEMP').AsString;
                strCodCli := qryPediOnda.FieldByName('FGO_CODCLI').AsString;

                pImprimir;

                qryPediOnda.Next;
              End;

            Finally
              strNumPed := '';
              strEmpPed := '';
              strCodCli := '';
              FreeAndNil(qryPediOnda);
            End;
          End
          Else
          Begin
            pImprimir;
          End;
        End;
      End
      Else
      Begin
        If (fCfgSis('WMSSFS') = 'S') And (fCfgSis('IMPNSE') = 'F') And FileExists(strLaySep) Then
          pImprimeSeparacaoWMS(tfsFaltaEstoque);

        blnSepImp := fMarcarPedidoComoImpresso(strNumPed, 'PD', strEmpPed, True, True);
      End;

      If (Not fCfgSis('SPTACO', varBoolean)) And fTemItemTintaAutomotiva Then
        pBaixarSeparacaoPedidoTintaAutomotiva;

      pCancela(False);
    End
    Else
    Begin

      {*** Remessa de Separação - Em TRANSAÇÃO não devemos abrir tela! ***}
      If fUsaOndaSeparacaoAgrupamento Then
      Begin
        If Assigned(stlMensagens) Then
        Begin
          stlMensagens.Add('');
          stlMensagens.Add('Não foi possível definir os lotes para a "Remessa de Separação"!');
        End
      End
      Else
        pInformaLotesProduto;

    End;

  End;
end;

function TfrmFatDefineLotesPedidoWMS.fRetornaSaldosLote(strCodIte, strIdePro: String): Double;
var
  qrySaldos: TUniQuery;
begin
  Result := 0;
  qrySaldos := fCriaQuery;

  try
    qrySaldos.Close;
    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add('SELECT ');
    qrySaldos.SQL.Add('  SUM(LOT_SALDOS) AS SALDOS');
    qrySaldos.SQL.Add('FROM');
    qrySaldos.SQL.Add('  CADLOT');
    qrySaldos.SQL.Add('  INNER JOIN CADLOC');
    qrySaldos.SQL.Add('    ON LOC_CODLOC = LOT_LOCFIS');
    qrySaldos.SQL.Add('    AND LOT_CODEMP = LOC_CODEMP');
    qrySaldos.SQL.Add('  INNER JOIN CADITE');
    qrySaldos.SQL.Add('    ON ITE_CODITE = LOT_CODITE');
    qrySaldos.SQL.Add('  LEFT JOIN LOCITE');
    qrySaldos.SQL.Add('    ON LCI_CODEMP = LOT_CODEMP');
    qrySaldos.SQL.Add('    AND LCI_CODITE = LOT_CODITE');
    qrySaldos.SQL.Add('    AND LCI_LOCFIS = CADLOC.AUTOINCREM');
    qrySaldos.SQL.Add('WHERE LOT_NUMLOT <> "A DEFINIR"');
    qrySaldos.SQL.Add('  AND LOT_NUMLOT <> "A REGULARIZAR"');
    qrySaldos.SQL.Add('  AND LOT_CODITE = :CODITE');
    qrySaldos.SQL.Add('  AND LOT_CODEMP = :CODEMP');
    qrySaldos.SQL.Add('  AND IFNULL(LOC_CRITIC, "N") = "N"');
    qrySaldos.SQL.Add('  AND IFNULL(LOC_BALCAO, "N") = "N"');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_TRANSI, "N") = "N"');
    qrySaldos.SQL.Add('  AND (');
    qrySaldos.SQL.Add('    (LOT_SALDOS > 0) ');
    qrySaldos.SQL.Add('    OR (IFNULL(LOC_PICKIN, "N") = "S")');
    qrySaldos.SQL.Add('  ) ');
    qrySaldos.SQL.Add('  AND (');
    qrySaldos.SQL.Add('    (SELECT');
    qrySaldos.SQL.Add('      COUNT(0)');
    qrySaldos.SQL.Add('    FROM');
    qrySaldos.SQL.Add('      MOVLOT');
    qrySaldos.SQL.Add('    WHERE MLT_CODEMP = LOT_CODEMP');
    qrySaldos.SQL.Add('      AND MLT_CODITE = LOT_CODITE');
    qrySaldos.SQL.Add('      AND MLT_LOTORI = LOT_NUMLOT');
    qrySaldos.SQL.Add('      AND MLT_QTDMOV = 0 ');
    qrySaldos.SQL.Add('      AND MLT_DTAREA IS NULL) = 0');
    qrySaldos.SQL.Add('  ) ');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_STATUS, "S") = "S"');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_DIGCON, "N") = "N"');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_GARPRI, "N") = "N"');

    If TPickingCheckOut.fWMSUtilizaPickingCheckOut Then
      qrySaldos.SQL.Add('  AND IFNULL(LOC_PICKIN, "N") <> "C"');

    If fUsaPickingLaboratorioWms Then
    Begin
      If fEhTintaImobiliaria(strIdePro) Then
        qrySaldos.SQL.Add(' AND ' + fRetWherePicLab)
      Else
        qrySaldos.SQL.Add(' AND IFNULL(LOC_PRILAB,"N") = "N" ');
    End;

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qrySaldos.Open;

    if not qrySaldos.IsEmpty then
      Result := qrySaldos.FieldByName('SALDOS').AsFloat;
  finally
    FreeAndNil(qrySaldos);
  end;
end;

function TfrmFatDefineLotesPedidoWMS.frxSeparacaoWMSUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If LowerCase(MethodName) = 'fformatacpfcgc' Then
    Result := fFormataCpfCgc(params[0], fSetaPais);
end;

function TfrmFatDefineLotesPedidoWMS.fSalvarQuantidadeDigitada(pgbProgresso: TCxProgressBar): Boolean;
begin

  Try
    objDefineLotes.pgbProgresso := pgbProgresso;

    If Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) Then
      objDefineLotes.lblInformacao := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));

    {Onda de Separação}
    If (fEhDefinicaoDeLotesPorOndaDeSeparacao) Then
    Begin

      Result := objDefineLotes.fValidarLotesOndaDeSeparacao(cdsConsulta) And
                objDefineLotes.fSalvarQuantidadeDigitadaBDOndaDeSeparacao(cdsConsulta, prgProgresso);

    End
    Else
    {Pedido de venda}
    Begin

      Result := objDefineLotes.fValidarLotes(cdsConsulta) And
                objDefineLotes.fSalvarQuantidadeDigitadaBD(cdsConsulta, prgProgresso);

    End;

  Finally
    objDefineLotes.pgbProgresso  := nil;
    objDefineLotes.lblInformacao := nil;
  End;

end;

function TfrmFatDefineLotesPedidoWMS.fTemItemTintaAutomotiva: Boolean;
  Var
    prcScroll: TprcScroll;
begin
  Result := False;
  pDisableControls(cdsConsulta, prcScroll);
  Try
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If (cdsConsulta.FieldByName('FDO_IDEPRO').AsString <> 'NOR') And
         (fTipoTinta(cdsConsulta.FieldByName('FDO_IDEPRO').AsString) = ttAutomotiva) Then
      Begin
        Result := True;
        Break;
      End;

      cdsConsulta.Next;
    End;
  Finally
    pEnableControls(cdsConsulta, prcScroll);
  End;
end;

function TfrmFatDefineLotesPedidoWMS.fTemProdutoAcabado: Boolean;
var
  intRecNo: Integer;
begin
  Result := False;

  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;

  try
    cdsConsulta.First;
    While (Not cdsConsulta.Eof) Do
    Begin
      If (cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S') Then
        Exit(True);

      cdsConsulta.Next;
    End;
  finally
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.EnableControls;
  end;
end;

procedure TfrmFatDefineLotesPedidoWMS.pInformaLotesProduto;
  Var
    strNumLot: String;
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  If (cdsConsulta.FieldByName('FDO_IDEPRO').AsString <> 'NOR') And
     (fEmptyStr(strAutIncTinta) Or (Not blnUsaWMSRastreavelTinta)) And
     (not fCfgSis('TINWMS',varBoolean)) Then
    Exit;

  If cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S' Then
    Exit;

  With cdsConsulta Do
  Begin
    If (FieldByName('TEMLOT').AsString <> '1') Then
    Begin
      pMensagemOk('Esse item não possui lote cadastrado!');
      Exit;
    End;

    If fCfgSis('WMSLOT', varBoolean) Then
      If (FieldByName('ITE_LOTEPD').AsString = 'S') Then
      Begin
        If (fMensagem('ATENÇÃO!', 'Lote já definido no pedido, deseja alterá-lo?', ['',''], 2) = 2) Then
          Exit;
      End;

    If objDefineLotes.fDigitaLotes(FieldByName('FDO_CODITE').AsString,
                                   FieldByName('FDO_DESCRI').AsString,
                                   FieldByName('AUTOINCREM').AsString,
                                   FieldByName('FDO_QTDITE').AsFloat,
                                   FieldByName('FDO_IDEPRO').AsString,
                                   strNumLot) Then
    Begin
      objDefineLotes.pAtualizaScrollLotes(cdsConsulta, strNumLot);
      If Not SameText(strNumLot, 'A DEFINIR') Then
        Next;
    End;
  End;

  If fEhDefinicaoDeLotesPorOndaDeSeparacao Then
    pAtualizaGridLotesOndaDeSeparacao
  Else
    pAtualizaGridLotes;

end;

procedure TfrmFatDefineLotesPedidoWMS.pRestaurarDefinicoesOriginais;
  var
    LLotes : TUniClientDataSet;
begin
  inherited;

  RecalcularLocalizacoes.RestaurarItens(cdsConsulta);
  RecalcularLocalizacoes.RestaurarLotes1(cdsLotSel);

  If Assigned(objDefineLotes.Lotes) Then
  Begin
    LLotes := objDefineLotes.Lotes;
    RecalcularLocalizacoes.RestaurarLotes2(LLotes);
    objDefineLotes.Lotes := LLotes;
  End;

end;

procedure TfrmFatDefineLotesPedidoWMS.pImprimeSeparacaoWMS(opcFolhaSeparada: TTipoFolhaSeparada = tfsNenhum);
  Const
    strCLICON = 'CLI_NOMCLI LIKE "%CONSUMIDOR%" OR ' +
                'CLI_NOMCLI LIKE "%BALCAO%"     OR ' +
                'CLI_NOMCLI LIKE "%BALCÃO%"     OR ' +
                'CLI_NOMCLI LIKE "%SEGURADORA%"    ' ;

    strCODCID = 'IF(' + strCLICON + ', FGO_CIDCON, IFNULL(ETC_CIDENT, CLI_CODCID))';

  Var
    strNomPro : String;
    strNomImp : String;
    strTipImp : String;
    strLocSep : String;
    qryEmpresa: TUniQuery;
    cdsPedido : TZClient;
    stlLocSep : TStringList;
    strOrdSep : Char;
    frxEmpresa: TfrxDBDataset;
    matrizSaldosAux : TClassMatrizSaldosColorantes;
    qryFatGorP      : TUniQuery;
    objFatVen       : TFatVenda;
    blnDeletouItens : Boolean;
    blnTinAdd       : Boolean;
    intCont         : Integer;
    blnCortados     : Boolean;
    blnImpAvTintaAutSemSaldo: Boolean;

  function fGetLocalSeparacao: TStringList;
  begin
    Result := TStringList.Create;
    Result.Sorted := True;
    Result.Duplicates := dupIgnore;
    If blnCortados Then
      Result.Add('')
    Else
    Begin
      cdsPedido.First;
      While Not cdsPedido.Eof Do
      Begin
        Result.Add(cdsPedido.FieldByname('LOCSEP').AsString);
        cdsPedido.Next;
      End;
    End;
  end;

  function fCalcQtdTot: Double;
  begin
    Result := 0;
    cdsPedido.First;
    While Not cdsPedido.Eof Do
    Begin
      Result := Result + cdsPedido.FieldByname('QTDITE').AsFloat;
      cdsPedido.Next;
    End;
  end;

  procedure pImprimirFolhaItensSemSaldo;
  begin
    If opcFolhaSeparada = tfsNenhum Then
    Begin
      If fUsaSepAvulsaTintaAutomotivaWMS Then
        pImprimeSeparacaoWMS(tfsTintaAutomotiva);

      If (fCfgSis('IMPNSE') = 'F') And fEmptyStr(strCodIte) Then
        pImprimeSeparacaoWMS(tfsFaltaEstoque);
    End;
  end;
begin
  if (opcFolhaSeparada = tfsNenhum) And fApenasMarcarComoImpressoPedidoOndaSeparacao then
  begin
    blnSepImp := fMarcarPedidoComoImpresso(strNumPed, 'PD', strEmpPed, True, True);
    pImprimirFolhaItensSemSaldo;
    Exit;
  end;

  strOrdSep := String(fCfgSis('ORDSEP', varString))[1];

  qryEmpresa := fCriaQuery;

  frxEmpresa          := TfrxDBDataset.Create(Self);
  frxEmpresa.Name     := 'frxEmpresa';
  frxEmpresa.UserName := 'frxEmpresa';
  frxEmpresa.DataSet  := qryEmpresa;
  frxSeparacaoWMS.DataSets.Add(frxEmpresa);

  blnCortados := (opcFolhaSeparada = tfsFaltaEstoque);
  blnImpAvTintaAutSemSaldo := (opcFolhaSeparada = tfsTintaAutomotiva) and (fCfgSis('IMPNSE', varString) = 'F');

  With qryEmpresa, SQL Do
  Begin
    Add('SELECT ');
    Add('  EMP_NOMEMP AS NOMEMP, ');
    Add('  EMP_ENDERE AS ENDERE, ');
    Add('  EMP_ENDNUM AS ENDNUM, ');
    Add('  EMP_BAIRRO AS BAIRRO, ');
    Add('  CID_NOMCID AS NOMCID, ');
    Add('  CID_ESTADO AS ESTADO, ');
    Add('  EMP_C_E_P_ AS C_E_P_, ');
    Add('  EMP_C_G_C_ AS C_G_C_, ');
    Add('  EMP_FONE01 AS FONE01, ');
    Add('  EMP_I_E_S_ AS I_E_S_, ');
    Add('  EMP_F_A_X_ AS F_A_X_, ');
    Add('  EMP_EMAIL_ AS EMAIL_  ');
    Add('FROM ');
    Add('  CADEMP ');
    Add('  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ');
    Add('WHERE ');
    Add('  EMP_CODEMP = :CODEMP ');

    ParamByName('CODEMP').AsString := strEmpPed;

    Open;

  End;

  cdsPedido := TZClient.Create(Self);
  With cdsPedido.qryQuery, SQL Do
  Begin
    Clear;
    Add('SELECT I.AUTOINCREM,    ');
    Add('       I.AUTOINCREM AS INC_FATDOR, ');
    Add('  "S"        AS IMPRIM, ');
    Add('  FDO_IDEPRO AS IDEPRO, ');
    Add('  1 AS ORIGEM,          ');
    Add(fSQLBarDoc('FGO') + ' AS BARDOC, ');
    Add('  FGO_NUMDOC AS NUMDOC, ');
    Add('  FGO_ESPDOC AS ESPDOC, ');
    Add('  FGO_CODEMP AS CODEMP, ');
    Add('  FGO_DTAENT AS DTAENT, ');
    Add('  FGO_HORENT AS HORENT, ');
    Add('  CLI_CODCLI AS CODCLI, ');
    Add('  CLI_FANSOB AS FANSOB, ');

    Add('  IF(CLI_CGCCPF = 1   , CLI_I_E_S_, CLI_NUMR_G) AS IESRGC, ');
    Add('  IF(' + strCLICON + ', FGO_NOMCON, CLI_NOMCLI) AS NOMCLI, ');
    Add('  IF(' + strCLICON + ', FGO_TELCON, CLI_FONE01) AS FONE01, ');
    Add('  IF(' + strCLICON + ', FGO_CGCCON, CLI_C_G_C_) AS CGCCLI, ');
    Add('  IF(' + strCLICON + ', ""        , CLI_EMAIL_) AS EMAIL_, ');

    Add('  IF(' + strCLICON + ', FGO_CEPCON, IFNULL(ETC_CEPENT, CLI_C_E_P_)) AS C_E_P_, ');
    Add('  IF(' + strCLICON + ', FGO_ENDCON, IFNULL(ETC_ENDENT, CLI_ENDENT)) AS ENDERE, ');
    Add('  IF(' + strCLICON + ', FGO_BAICON, IFNULL(ETC_BAIENT, CLI_BAIRRO)) AS BAIRRO, ');

    Add('  CID_NOMCID AS NOMCID, ');
    Add('  CID_ESTADO AS ESTADO, ');

    Add('  FGO_CONPAG AS CONPAG, ');
    Add('  FGO_CODCND AS CODCND, ');
    Add('  CND_DESCRI AS DESCND, ');
    Add('  FGO_CODFPG AS CODFPG, ');
    Add('  FPG_DESCRI AS DESFPG, ');

    Add('  G.FGO_CODVEN AS CODVEN, ');
    Add('  V.OPE_NOMOPE AS NOMVEN, ');

    Add('  G.FGO_CODDIG AS CODDIG, ');
    Add('  D.OPE_NOMOPE AS NOMDIG, ');

    Add('  S.OPE_CODOPE AS CODSEP, ');
    Add('  S.OPE_NOMOPE AS NOMSEP, ');

    Add('  FGO_CODTRA AS CODTRA, ');
    Add('  TRA_NOMTRA AS NOMTRA, ');
    Add('  TRA_FONE01 AS FONTRA, ');

    Add('  FGO_MEN001 AS MEN001, ');
    Add('  FGO_MEN002 AS MEN002, ');
    Add('  FGO_MENEXP AS MENEXP, ');
    Add('  FGO_MENEX2 AS MENEX2, ');
    Add('  FGO_MENEX3 AS MENEX3, ');
    Add('  FGO_MENEX4 AS MENEX4, ');
    Add('  FGO_PESBRU AS PESBRU, ');
    Add('  FGO_PESLIQ AS PESLIQ, ');

    Add('  ITE_REFERE AS REFERE, ');
    Add('  ITE_CODBAR AS CODBAR, ');
    Add('  ((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE) AS UNITAR, ');
    Add('  ((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE) * LDO_QTDITE AS TOTITE, ');
    Add('  ROUND((FDO_TOTFRE / FDO_QTDITE) * LDO_QTDITE, 2) AS TOTFRE, ');

    Add('  FDO_CODITE AS CODITE, ');
    Add('  FDO_DESCRI AS DESITE, ');
    Add('  FDO_COMPLE AS COMPLE, ');
    Add('  UNI_SIGUNI AS SIGUNI, ');
    Add('  LOT_NUMLOT AS NUMLOT, ');

    If blnCortados Then
      Add(' FDO_QTDITE - FDO_QTDBAI - IFNULL((SELECT SUM(IFNULL(LDO_QTDITE, 0)) FROM LOTDOR WHERE LDO_SEQFDO = I.AUTOINCREM ),0) AS QTDITE, ')
    Else
      Add('  LDO_QTDITE AS QTDITE, ');

    Add('  LOT_LOCFIS AS LOCFIS, ');

    If fCfgSis('CADLOC', varBoolean) Then
      Add('      LOC_DESCRI AS LOCDES, ');

    Add('  FDO_ENTFUT AS ENTFUT, ');
    Add('  FDO_ENTRET AS ENTRET, ');
    Add('  IF(FDO_PROACA = "S" AND FDO_CODACA IS NOT NULL AND FDO_IDEPRO = "NOR", "SIM","NÃO") AS PROACA, ');

    If Not fEmptyStr(strCodLseItens) Then
    Begin
      Add('(SELECT LSE_DESCRI FROM CADLSE WHERE LSE_CODIGO = B.ITE_CODLSE) AS LOCSEP, ');
    End
    Else
    Begin
      Add('  IF((FDO_IDEPRO <> "NOR"), ');
      Add('  (SELECT LOT_LOCSEP                        ');
      Add('   FROM CADLOT AS LOTTIN                    ');
      Add('   WHERE LOTTIN.LOT_CODITE = I.FDO_CODITE   ');
      Add('     AND LOTTIN.LOT_PRITIN = "S"            ');
      Add('     AND LOTTIN.LOT_CODEMP = :CODEMP )      ');
      //else do IF((FDO_IDEPRO <> "NOR")
      Add(' , IFNULL(LOT_LOCSEP, "")) AS LOCSEP, ');
    End;

    Add('  IFNULL(CLI_CODREG, "") AS CODREG, ');
    Add('  IFNULL(REG_DESREG, "") AS DESREG, ');
    Add('  FDO_DESCRI AS DESCRI,                            ');
    Add('  0.00       AS SALDIS,                            ');
    Add('  CAST("" AS CHAR(20)) AS LOTSAL, ');
    Add('  CAST("" AS CHAR(20)) AS LOCSAL  ');

    Add('FROM          ');
    Add('  FATGOR G    ');
    Add('  INNER JOIN FATDOR I ON I.FDO_SEQGER = G.AUTOINCREM ');
    Add('  INNER JOIN EXTDOR   ON   FDO_SEQFDO = I.AUTOINCREM ');

    If blnCortados Then
      Add('  LEFT  JOIN LOTDOR L ON L.LDO_SEQFDO = I.AUTOINCREM AND FALSE ')
    Else
      Add('  INNER JOIN LOTDOR L ON L.LDO_SEQFDO = I.AUTOINCREM ');

    If blnCortados Then
      Add('LEFT  JOIN CADLOT   ON   LOT_CODITE = I.FDO_CODITE AND ')
    Else
      Add('  INNER JOIN CADLOT   ON   LOT_CODITE = I.FDO_CODITE AND ');
    Add('                           LOT_NUMLOT = LDO_NUMLOT   AND ');
    Add('                           LOT_CODEMP = :CODEMP          ');

    If blnCortados Then
      Add(' AND FALSE ');

    Add('  INNER JOIN CADITE A  ON  A.ITE_CODITE = I.FDO_CODITE ');

    Add('  INNER JOIN ITEGER B  ON  B.ITE_CODITE = I.FDO_CODITE AND ');
    Add('                           B.ITE_CODEMP = :CODEMP          ');

    If fCfgSis('CADLOC', varBoolean) Then
    Begin
      Add('  LEFT  JOIN CADLOC   ON   LOC_CODLOC = LOT_LOCFIS     ');
      Add('                     AND   LOT_CODEMP = LOC_CODEMP     ');

    End;

    Add('  LEFT  JOIN CADUNI   ON   UNI_CODUNI = I.FDO_UNIDAD     ');

    Add('  INNER JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI ');
    Add('  LEFT  JOIN CADREG   ON   REG_CODREG = C.CLI_CODREG ');
    Add('  LEFT  JOIN AUXGOR   ON   AUX_SEQGER = G.AUTOINCREM ');
    Add('  LEFT  JOIN EXTGOR   ON   FGO_SEQFGO = G.AUTOINCREM ');

    Add('  LEFT  JOIN ENTCLI E ON   AUX_ENTGER = E.AUTOINCREM ');

    Add('  LEFT  JOIN CADCID   ON   CID_CODCID = ' + strCODCID);

    Add('  LEFT  JOIN CADOPE V ON V.OPE_CODOPE = G.FGO_CODVEN ');
    Add('  LEFT  JOIN CADOPE D ON D.OPE_CODOPE = G.FGO_CODDIG ');
    Add('  LEFT  JOIN CADOPE S ON S.OPE_CODOPE = :CODSEP      ');

    Add('  LEFT  JOIN CADCND   ON   CND_CODIGO = G.FGO_CODCND ');
    Add('  LEFT  JOIN CADFPG   ON   FPG_CODIGO = G.FGO_CODFPG ');

    Add('  LEFT  JOIN CADTRA   ON   TRA_CODTRA = G.FGO_CODTRA ');

    Add('WHERE         ');
    Add('  FGO_NUMDOC = :NUMDOC AND ');
    Add('  FGO_CODEMP = :EMPDOC AND ');
    Add('  FGO_ESPDOC = "PD" ');

    If blnCortados Then
      Add(' AND (((FDO_QTDITE - FDO_QTDBAI - IFNULL((SELECT SUM(IFNULL(LDO_QTDITE, 0)) FROM LOTDOR WHERE LDO_SEQFDO = I.AUTOINCREM ),0) ) > 0) OR (FDO_IDEPRO <> "NOR")) ');

    If Not fEmptyStr(strCodIte) Then
      Add('  AND FDO_CODITE = ' + QuotedStr(strCodIte));

    If fUsaSepAvulsaTintaAutomotivaWMS Then
    Begin
      If opcFolhaSeparada = tfsTintaAutomotiva Then
        Add('  AND LOCATE(FDO_IDEPRO, "'+ fGetTintasdeMaquina.fGetAutomotivas +'") > 0 ')
      Else
        Add('  AND LOCATE(FDO_IDEPRO, "'+ fGetTintasdeMaquina.fGetAutomotivas +'") = 0 ');
    End;

    If (fCfgSis('IMPNSE', varString) = 'S') And fEmptyStr(strCodIte) Then
    Begin
      Add('UNION ALL ');
      Add('SELECT I.AUTOINCREM,    ');
      Add('       I.AUTOINCREM AS INC_FATDOR, ');
      Add('  "S"        AS IMPRIM, ');
      Add('  FDO_IDEPRO AS IDEPRO, ');
      Add('  2 AS ORIGEM,          ');
      Add(fSQLBarDoc('FGO') + ' AS BARDOC, ');
      Add('  FGO_NUMDOC AS NUMDOC, ');
      Add('  FGO_ESPDOC AS ESPDOC, ');
      Add('  FGO_CODEMP AS CODEMP, ');
      Add('  FGO_DTAENT AS DTAENT, ');
      Add('  FGO_HORENT AS HORENT, ');
      Add('  CLI_CODCLI AS CODCLI, ');
      Add('  CLI_FANSOB AS FANSOB, ');

      Add('  IF(CLI_CGCCPF = 1   , CLI_I_E_S_, CLI_NUMR_G) AS IESRGC, ');
      Add('  IF(' + strCLICON + ', FGO_NOMCON, CLI_NOMCLI) AS NOMCLI, ');
      Add('  IF(' + strCLICON + ', FGO_TELCON, CLI_FONE01) AS FONE01, ');
      Add('  IF(' + strCLICON + ', FGO_CGCCON, CLI_C_G_C_) AS CGCCLI, ');
      Add('  IF(' + strCLICON + ', ""        , CLI_EMAIL_) AS EMAIL_, ');

      Add('  IF(' + strCLICON + ', FGO_CEPCON, IFNULL(ETC_CEPENT, CLI_C_E_P_)) AS C_E_P_, ');
      Add('  IF(' + strCLICON + ', FGO_ENDCON, IFNULL(ETC_ENDENT, CLI_ENDENT)) AS ENDERE, ');
      Add('  IF(' + strCLICON + ', FGO_BAICON, IFNULL(ETC_BAIENT, CLI_BAIRRO)) AS BAIRRO, ');

      Add('  CID_NOMCID AS NOMCID, ');
      Add('  CID_ESTADO AS ESTADO, ');

      Add('  FGO_CONPAG AS CONPAG, ');
      Add('  FGO_CODCND AS CODCND, ');
      Add('  CND_DESCRI AS DESCND, ');
      Add('  FGO_CODFPG AS CODFPG, ');
      Add('  FPG_DESCRI AS DESFPG, ');

      Add('  G.FGO_CODVEN AS CODVEN, ');
      Add('  V.OPE_NOMOPE AS NOMVEN, ');

      Add('  G.FGO_CODDIG AS CODDIG, ');
      Add('  D.OPE_NOMOPE AS NOMDIG, ');

      Add('  S.OPE_CODOPE AS CODSEP, ');
      Add('  S.OPE_NOMOPE AS NOMSEP, ');

      Add('  FGO_CODTRA AS CODTRA, ');
      Add('  TRA_NOMTRA AS NOMTRA, ');
      Add('  TRA_FONE01 AS FONTRA, ');

      Add('  FGO_MEN001 AS MEN001, ');
      Add('  FGO_MEN002 AS MEN002, ');
      Add('  FGO_MENEXP AS MENEXP, ');
      Add('  FGO_MENEX2 AS MENEX2, ');
      Add('  FGO_MENEX3 AS MENEX3, ');
      Add('  FGO_MENEX4 AS MENEX4, ');
      Add('  FGO_PESBRU AS PESBRU, ');
      Add('  FGO_PESLIQ AS PESLIQ, ');

      Add('  ITE_REFERE AS REFERE, ');
      Add('  ITE_CODBAR AS CODBAR, ');
      Add('  ((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE) AS UNITAR, ');
      Add('  ((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE) * (FDO_QTDITE - FDO_QTDBAI - IFNULL(SUM(LDO_QTDITE),0)) AS TOTITE, ');
      Add('  ROUND((FDO_TOTFRE / FDO_QTDITE) * (FDO_QTDITE - FDO_QTDBAI - IFNULL(SUM(LDO_QTDITE),0)), 2) AS TOTFRE, ');

      Add('  FDO_CODITE AS CODITE, ');
      Add('  FDO_DESCRI AS DESITE, ');
      Add('  FDO_COMPLE AS COMPLE, ');
      Add('  UNI_SIGUNI AS SIGUNI, ');
      Add('  "" AS NUMLOT, ');
      Add('  FDO_QTDITE - FDO_QTDBAI - IFNULL(SUM(LDO_QTDITE),0) AS QTDITE, ');
      Add('  "" AS LOCFIS, ');

      If fCfgSis('CADLOC', varBoolean) Then
        Add('      "" AS LOCDES, ');

      Add('  FDO_ENTFUT AS ENTFUT, ');
      Add('  FDO_ENTRET AS ENTRET, ');
      Add('  IF(FDO_PROACA = "S" AND FDO_CODACA IS NOT NULL AND FDO_IDEPRO = "NOR", "SIM","NÃO") AS PROACA, ');

      If Not fEmptyStr(strCodLseItens) Then
      Begin
        Add('(SELECT LSE_DESCRI FROM CADLSE WHERE LSE_CODIGO = B.ITE_CODLSE) AS LOCSEP, ');
      End
      Else
      Begin
        Add('  IF((FDO_IDEPRO <> "NOR"), ');
        Add('  (SELECT LOT_LOCSEP                        ');
        Add('   FROM CADLOT AS LOTTIN                    ');
        Add('   WHERE LOTTIN.LOT_CODITE = I.FDO_CODITE   ');
        Add('     AND LOTTIN.LOT_PRITIN = "S"            ');
        Add('     AND LOTTIN.LOT_CODEMP = :CODEMP )      ');
        Add(' , IFNULL(LOT_LOCSEP, "")) AS LOCSEP, ');
      End;

      Add('  IFNULL(CLI_CODREG, "") AS CODREG, ');
      Add('  IFNULL(REG_DESREG, "") AS DESREG, ');
      Add('  FDO_DESCRI AS DESCRI,                            ');
      Add('  0.00       AS SALDIS,                            ');
      Add('  CAST("" AS CHAR(20)) AS LOTSAL, ');
      Add('  CAST("" AS CHAR(20)) AS LOCSAL  ');

      Add('FROM          ');
      Add('  FATGOR G    ');
      Add('  INNER JOIN FATDOR I ON I.FDO_SEQGER = G.AUTOINCREM ');
      Add('  INNER JOIN EXTDOR   ON   FDO_SEQFDO = I.AUTOINCREM ');
      Add('  LEFT  JOIN LOTDOR L ON L.LDO_SEQFDO = I.AUTOINCREM ');
      Add('  LEFT  JOIN CADLOT   ON   LOT_CODITE = I.FDO_CODITE AND ');
      Add('                           LOT_NUMLOT = LDO_NUMLOT   AND ');
      Add('                           LOT_CODEMP = :CODEMP          ');

      Add('  INNER JOIN CADITE A  ON  A.ITE_CODITE = I.FDO_CODITE ');

      Add('  INNER JOIN ITEGER B  ON  B.ITE_CODITE = I.FDO_CODITE AND ');
      Add('                           B.ITE_CODEMP = :CODEMP          ');

      Add('  LEFT  JOIN CADUNI   ON   UNI_CODUNI = I.FDO_UNIDAD     ');

      Add('  INNER JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI ');
      Add('  LEFT  JOIN CADREG   ON   REG_CODREG = C.CLI_CODREG ');
      Add('  LEFT  JOIN AUXGOR   ON   AUX_SEQGER = G.AUTOINCREM ');
      Add('  LEFT  JOIN EXTGOR   ON   FGO_SEQFGO = G.AUTOINCREM ');

      Add('  LEFT  JOIN ENTCLI E ON   AUX_ENTGER = E.AUTOINCREM ');

      Add('  LEFT  JOIN CADCID   ON   CID_CODCID = ' + strCODCID);

      Add('  LEFT  JOIN CADOPE V ON V.OPE_CODOPE = G.FGO_CODVEN ');
      Add('  LEFT  JOIN CADOPE D ON D.OPE_CODOPE = G.FGO_CODDIG ');
      Add('  LEFT  JOIN CADOPE S ON S.OPE_CODOPE = :CODSEP      ');

      Add('  LEFT  JOIN CADCND   ON   CND_CODIGO = G.FGO_CODCND ');
      Add('  LEFT  JOIN CADFPG   ON   FPG_CODIGO = G.FGO_CODFPG ');

      Add('  LEFT  JOIN CADTRA   ON   TRA_CODTRA = G.FGO_CODTRA ');

      Add('WHERE         ');
      Add('  FGO_NUMDOC = :NUMDOC AND ');
      Add('  FGO_CODEMP = :EMPDOC AND ');
      Add('  FGO_ESPDOC = "PD"    AND ');
      Add('  FDO_JAFATU = 0       AND ');//Os produtos que ja foram faturados
      Add('  FDO_QTDITE > FDO_QTDBAI  ');//nao devem ser considerados como nao separados

      Add(' GROUP BY I.AUTOINCREM                                   ');
      Add(' HAVING MAX(FDO_QTDITE - FDO_QTDBAI) > IFNULL(SUM(LDO_QTDITE),0) ');
    End;

    Add('ORDER BY      ');
    case strOrdSep of
      '1' : Begin
              If fCfgSis('CADLOC', varBoolean) Then
                Add('  DESITE, ORIGEM, LOCFIS, LOCDES, NUMLOT  ')
              Else
                Add('  DESITE, ORIGEM, LOCFIS, NUMLOT  ');
            End;
      '2' : Begin
              If fCfgSis('CADLOC', varBoolean) Then
                Add('  ORIGEM, LOCFIS, LOCDES, NUMLOT, DESITE  ')
              Else
                Add('  ORIGEM, LOCFIS, NUMLOT, DESITE  ');
            End;
      '3' : Begin
              If fCfgSis('CADLOC', varBoolean) Then
                Add('  I.AUTOINCREM, ORIGEM, LOCFIS, LOCDES, NUMLOT  ')
              Else
                Add('  I.AUTOINCREM, ORIGEM, LOCFIS, NUMLOT  ');
            End;
      '4' : Begin
              If fCfgSis('CADLOC', varBoolean) Then
                Add('  A.ITE_CODDEP, DESITE, ORIGEM, LOCFIS, LOCDES, NUMLOT ')
              Else
                Add('  A.ITE_CODDEP, DESITE, ORIGEM, LOCFIS, NUMLOT ');
            End;
      '5' : Add('  IF(IFNULL(ENTRET, "R") = "R",0, IF(IFNULL(ENTFUT, "N") = "N", 1, 2)), DESITE, ORIGEM  ');
    end;

    ParamByName('NUMDOC').AsString := strNumPed;
    ParamByName('EMPDOC').AsString := strEmpPed;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODSEP').AsString := strCodSep;

    cdsPedido.fAbreClient(True, 'TfrmFatDefineLotesPedidoWMS.pImprimeSeparacaoWMS');

    First;
    While Not cdsPedido.Eof Do
    Begin
      cdsPedido.Edit;
      cdsPedido.FieldByName('SALDIS').AsFloat := fRetornaSaldoDisponivel(cdsPedido.FieldByName('CODITE').AsString) + cdsPedido.FieldByName('QTDITE').AsFloat;
      cdsPedido.Post;
      cdsPedido.Next;
    End;

    frxPedido.DataSet := cdsPedido;
  End;

  if (not cdsPedido.IsEmpty) then
  begin
    cdsSemSal := TUniClientDataSet.Create(Self);
    cdsPedido.AfterScroll := pAfterScroll;
    With cdsSemSal, FieldDefs Do
    Begin
      With AddFieldDef Do
      Begin
        Name     := 'AUTOINCREM';
        DataType := ftString;
        Size     := 20;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'CODITE';
        DataType := ftString;
        Size     := fTamCodIte;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'DESITE';
        DataType := ftString;
        Size     := 60;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'SIGUNI';
        DataType := ftString;
        Size     := 10;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'QTDITE';
        DataType := ftFloat;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'QTDACU';
        DataType := ftFloat;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'SALDOS';
        DataType := ftFloat;
        Required := False;
      End;

      CreateDataSet;
      Open;
      frxSemSal.DataSet := cdsSemSal;
    End;

    //Valida os Colorantes/Base das tintas de Máquina
    pCriarCdsVenda(Self);
    objFatVen := nil;
    qryFatGorP := nil;

    try
      objFatVen := TFatVenda.CreateInstance('PD');
      qryFatGorP := fCriaQuery(Self);
      objFatVen.strNumOrc := strNumPed;
      objFatVen.strEspOrc := 'PD';
      objFatVen.strEmpOri := strEmpPed;

      qryFatGorP.Close;
      qryFatGorP.SQL.Clear;
      qryFatGorP.SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
      qryFatGorP.SQL.Add('WHERE F.FGO_NUMDOC = :NUMPED ');
      qryFatGorP.SQL.Add('  AND F.FGO_CODEMP = :CODEMP ');
      qryFatGorP.SQL.Add('  AND F.FGO_ESPDOC = "PD" ');
      qryFatGorP.ParamByName('NUMPED').AsString := strNumPed;
      qryFatGorP.ParamByName('CODEMP').AsString := strEmpPed;

      qryFatGorP.Open;

      pCarregarClientePedidoOrcamento(objFatVen, strEmpPed);

      objFatVen.blnVerEstOrc := False;
      objFatVen.pCarregaPedidoOrcamento(qryFatGorP, blnDeletouItens);

      objFatVen.fVerificaEstoqueItens('PD',
                                      '',
                                      True,
                                      False,
                                      False,
                                      -1,
                                      True);

      cdsVenda.First;
      While Not cdsVenda.Eof Do
      Begin
        blnTinAdd := False;
        If cdsPedido.Locate('AUTOINCREM', cdsVenda.FieldByName('ITE_SEQDET').AsString, []) Then
        Begin
          matrizSaldosAux := TClassMatrizSaldosColorantes(objFatVen.dicFormulas.RetornaObjeto(cdsVenda.FieldByName('AUTOINCREM').AsString));
          If Assigned(matrizSaldosAux) Then
          Begin
            For intCont := 0 To matrizSaldosAux.Count - 1 Do
            Begin
              If ((matrizSaldosAux[intCont].fltSaldoML <= 0) Or (matrizSaldosAux[intCont].fltSaldoML < matrizSaldosAux[intCont].fltQtdFormAcu)) And
                 (Not ((matrizSaldosAux[intCont].fltSaldoML >= 0) And (matrizSaldosAux[intCont].strBasCol = BASE_IMOBILIARIA))) Then
              Begin
                blnTinAdd := True;

                cdsPedido.Edit;
                cdsPedido.FieldByName('IMPRIM').AsString := IfThen((blnCortados or blnImpAvTintaAutSemSaldo), 'S', 'N');
                cdsPedido.Post;

                If (blnCortados or blnImpAvTintaAutSemSaldo) Then
                Begin
                  If (matrizSaldosAux[intCont].strBasCol <> BASE_IMOBILIARIA) Then
                  Begin
                    cdsSemSal.Insert;
                    cdsSemSal.FieldByName('AUTOINCREM').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
                    cdsSemSal.FieldByName('CODITE').AsString := matrizSaldosAux[intCont].strCodIte;
                    cdsSemSal.FieldByName('DESITE').AsString := matrizSaldosAux[intCont].strDesIte;
                    cdsSemSal.FieldByName('SIGUNI').AsString := fRetSiglaUnidadePorCodIte(matrizSaldosAux[intCont].strCodIte);
                    cdsSemSal.FieldByName('QTDITE').AsFloat  := matrizSaldosAux[intCont].fltQtdFormula;
                    cdsSemSal.FieldByName('QTDACU').AsFloat  := matrizSaldosAux[intCont].fltQtdFormAcu;
                    cdsSemSal.FieldByName('SALDOS').AsFloat  := matrizSaldosAux[intCont].fltSaldoML;
                    cdsSemSal.Post;
                  End
                  Else
                  Begin
                    //Registro vazio para sair o master no relatorio.
                    cdsSemSal.Insert;
                    cdsSemSal.FieldByName('AUTOINCREM').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
                    cdsSemSal.FieldByName('CODITE').AsString := '';
                    cdsSemSal.FieldByName('DESITE').AsString := '';
                    cdsSemSal.Post;
                  End;
                End
                Else
                  Continue; // Caso nao precise ver todos colorantes, ou seja, quando a tinta já tem um item negativo marca como nao imprimir e continua para o proximo item
              End;
            End;

            If Not blnTinAdd Then
            Begin
              If blnCortados Then
              Begin
                cdsPedido.Edit;
                cdsPedido.FieldByName('IMPRIM').AsString := 'S';
                cdsPedido.Post;
              End
              Else
              Begin
                //Registro vazio para sair o master no relatorio.
                cdsSemSal.Insert;
                cdsSemSal.FieldByName('AUTOINCREM').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
                cdsSemSal.FieldByName('CODITE').AsString := '';
                cdsSemSal.FieldByName('DESITE').AsString := '';
                cdsSemSal.Post;
              End;
            End;

          End
          Else
          Begin
            cdsPedido.Edit;
            cdsPedido.FieldByName('IMPRIM').AsString := IfThen(cdsPedido.FieldByName('QTDITE').AsFloat > 0, 'S', 'N');
            cdsPedido.Post;

            //Registro vazio para sair o master no relatorio.
            cdsSemSal.Insert;
            cdsSemSal.FieldByName('AUTOINCREM').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
            cdsSemSal.FieldByName('CODITE').AsString := '';
            cdsSemSal.FieldByName('DESITE').AsString := '';
            cdsSemSal.Post;
          End;
        End;

        cdsVenda.Next;
      End;
    finally
      FreeAndNil(qryFatGorP);
      FreeAndNil(objFatVen);
    end;

    stlLocSep := fGetLocalSeparacao;

    try
      If (Not cdsPedido.IsEmpty) Then
      Begin
        frxSeparacaoWMS.LoadFromFile(strLaySep);

        If (blnCortados) and (fLayoutPossuiLoteOuLocalizacaoFisicaComSaldo) Then
          pSetaLoteLocalizacaoFisicaComSaldo(cdsPedido);

        For strLocSep In stlLocSep Do
        Begin
          cdsPedido.Filtered := False;
          cdsPedido.Filter   := 'IMPRIM = ' + QuotedStr('S');
          If Not blnCortados And ( not fEmptyStr(strLocSep) ) Then
            cdsPedido.Filter   := cdsPedido.Filter + ' AND LOCSEP = ' + QuotedStr(strLocSep);

          cdsPedido.Filtered := True;
          cdsPedido.First;

          If cdsPedido.IsEmpty Then
            Continue;

          frxSeparacaoWMS.Script.Variables['QTDTOT'] := fCalcQtdTot;
          frxSeparacaoWMS.Script.Variables['LOCAIS_SEP'] := stlLocSep.CommaText;
          frxSeparacaoWMS.Script.Variables['TIPIMP'] := IfThen(blnCortados, 'ITENS NÃO SEPARADOS', 'SEPARAÇÃO');

          If Not blnCortados Then
            strNomPro := FILA_SEPARACAO + IIF(fEmptyStr(strLocSep), '', '_' + strLocSep)
          Else
            strNomPro := FILA_SEPARACAO + '_NAO_SEP';

          pCarregaConfImpr(qryCfgRel, strNomPro);

          If fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'I') Then
          Begin
            frxSeparacaoWMS.PrintOptions.Printer    := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
            frxSeparacaoWMS.PreviewOptions.Buttons  := [pbPrint,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];
            frxSeparacaoWMS.PrintOptions.ShowDialog := fEmptyStr(frxSeparacaoWMS.PrintOptions.Printer);

            If frxSeparacaoWMS.PrepareReport Then
              pPrintReport(strNomPro, 'Impressão de Separação (WMS)', strNomImp, frxSeparacaoWMS);
          End
          Else
            pPreviewReport(strNomPro, 'Impressão de Separação (WMS)', frxSeparacaoWMS);

          blnSepImp := fMarcarPedidoComoImpresso(strNumPed, 'PD', strEmpPed, True, True);
        End;
      End;
    finally
      FreeAndNil(stlLocSep);
      FreeAndNil(cdsSemSal);
    end;
  end;

  FreeAndNil(frxEmpresa);
  FreeAndNil(qryEmpresa);
  FreeAndNil(cdsPedido);

  pImprimirFolhaItensSemSaldo;
end;

procedure TfrmFatDefineLotesPedidoWMS.pAfterScroll(DataSet : TDataSet);
Begin
  cdsSemSal.Filtered := False;
  cdsSemSal.Filter := 'AUTOINCREM = ' + QuotedStr(DataSet.FieldByName('AUTOINCREM').AsString);
  cdsSemSal.Filtered := True;
End;

procedure TfrmFatDefineLotesPedidoWMS.pIdeProGetText(Sender: TField; var Text: string;
    DisplayText: Boolean);
begin
  if Sender.AsString = 'NOR' then
    Text := 'Normal'
  else
    Text := 'Tinta';
end;

procedure TfrmFatDefineLotesPedidoWMS.pImprimeEditor;
  Var
    impSeparacao: TFatVendaImp;
    recSepara   : TDadosImpressaoVenda;
    qrySetores  : TUniQuery;

    Procedure pPreenchaMatItens(Var arrMatItens: TMatrizFechamento; strCodLse: String);
      Var
        i: Integer;
        qryAux: TUniQuery;
    Begin
      qryAux := fCriaQuery(Nil);

      With qryAux, SQL Do
      Begin
        Add('SELECT SQL_NO_CACHE          ');
        Add('  DISTINCT D.FDO_CODITE,     ');
        Add('           D.FDO_ENTFUT,     ');
        Add('           E.FDO_ENTRET      ');
        Add('FROM                         ');
        Add('  FATDOR D                   ');
        Add('  INNER JOIN EXTDOR E ON D.AUTOINCREM = E.FDO_SEQFDO ');
        Add('  INNER JOIN ITEGER G ON D.FDO_CODITE = G.ITE_CODITE ');
        Add('                     AND G.ITE_CODEMP = :CODEMP      ');
        Add('WHERE                        ');
        Add('  D.FDO_NUMDOC = :NUMDOC AND ');
        Add('  D.FDO_ESPDOC = "PD"    AND ');
        Add('  D.FDO_CODEMP = :EMPDOC AND ');
        Add('  D.FDO_CODCLI = :CODCLI AND ');
        Add('  IFNULL(G.ITE_CODLSE,"") = :CODLSE ');
        Add('ORDER BY D.FDO_CODITE        ');

        ParamByName('NUMDOC').AsString := strNumPed;
        ParamByName('EMPDOC').AsString := strEmpPed;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODLSE').AsString := strCodLse;

        Open;
        First;
        While Not EOF Do
        Begin
          SetLength(arrMatItens, Length(arrMatItens) + 1);
          i := Length(arrMatItens) - 1;
          arrMatItens[i].strCodIte := FieldByName('FDO_CODITE').AsString;
          arrMatItens[i].strEntFut := FieldByName('FDO_ENTFUT').AsString;
          arrMatItens[i].strEntRet := FieldByName('FDO_ENTRET').AsString;
          Next;
        End;
      End;

      FreeAndNil(qryAux);
    End;

    function fProducaoForaDeLoja(strNumDoc, strCodEmp, strCodCli: String): Boolean;
    var
      qryGen: TUniQuery;
    begin

      qryGen := fCriaQuery();

      Try

        qryGen.SQL.Text :=
          ' SELECT                     ' +
          '   COUNT(0) AS QTD          ' +
          ' FROM                       ' +
          '   FATGOR                   ' +
          ' WHERE FGO_NUMDOC = :NUMDOC ' +
          '   AND FGO_CODEMP = :CODEMP ' +
          '   AND FGO_CODCLI = :CODCLI ' +
          '   AND FGO_ESPDOC = "PD"    ' +
          '   AND FGO_OPRFLJ = "S"     ';

        qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
        qryGen.ParamByName('CODEMP').AsString := strCodEmp;
        qryGen.ParamByName('CODCLI').AsString := strCodCli;
        qryGen.Open;

        Result := qryGen.FieldByName('QTD').AsInteger > 0;

      Finally
        FreeAndNil(qryGen);
      End;

    end;

    function fDocumentoJaFaturado(strNumDoc, strEspDoc, strEmpDoc, strCodCli : String) : Boolean;
    Var
      qryTemp: TUniQuery;
    begin

      qryTemp := fCriaQuery(Nil);

      Try

        qryTemp.Close;
        qryTemp.SQL.Clear;
        qryTemp.SQL.Add('SELECT * FROM');
        qryTemp.SQL.Add('  FATGOR');
        qryTemp.SQL.Add('WHERE');
        qryTemp.SQL.Add('  FGO_NUMDOC = :NUMDOC AND');
        qryTemp.SQL.Add('  FGO_ESPDOC = :ESPDOC AND');
        qryTemp.SQL.Add('  FGO_CODEMP = :CODEMP AND');
        qryTemp.SQL.Add('  FGO_CODCLI = :CODCLI AND');
        qryTemp.SQL.Add('  FGO_JAFATU = 1 ');

        qryTemp.ParamByName('NUMDOC').AsString := strNumDoc;
        qryTemp.ParamByName('ESPDOC').AsString := strEspDoc;
        qryTemp.ParamByName('CODEMP').AsString := strEmpDoc;
        qryTemp.ParamByName('CODCLI').AsString := strCodCli;

        qryTemp.Open;

        Result := Not qryTemp.IsEmpty;

      Finally
        FreeAndNil(qryTemp)
      End;

    end;

begin
  If Assigned(pAtuSepPed) Then
    pAtuSepPed(strCodSep);

  qrySetores := fCriaQuery(Nil);
  FillChar(recSepara, SizeOf(recSepara), #0);  
  SetLength(recSepara.arrMatItens,0);

  With qrySetores, SQL Do
  Begin
    Clear;
    Add('SELECT                                                     ');
    Add('  DISTINCT I.ITE_CODLSE, L.LSE_DESCRI                      ');
    Add('FROM                                                       ');
    Add('  FATGOR G                                                 ');
    Add('  INNER JOIN FATDOR D ON (D.FDO_SEQGER = G.AUTOINCREM)     ');
    Add('  INNER JOIN ITEGER I ON (I.ITE_CODITE = D.FDO_CODITE) AND ');
    Add('                         (I.ITE_CODEMP = :CODEMP)          ');
    Add('  LEFT  JOIN CADLSE L ON (I.ITE_CODLSE = L.LSE_CODIGO)     ');
    Add('WHERE                                                      ');
    Add('  G.FGO_NUMDOC = :NUMDOC AND                               ');
    Add('  G.FGO_CODEMP = :EMPDOC AND                               ');
    Add('  G.FGO_ESPDOC = "PD"                                      ');

    If Not fEmptyStr(strCodLseItens) Then
      Add(' AND I.ITE_CODLSE = "' + strCodLseItens + '"             ');

    Add('ORDER BY                                                   ');
    Add('  I.ITE_CODLSE                                             ');

    ParamByName('NUMDOC').AsString := strNumPed;
    ParamByName('EMPDOC').AsString := strEmpPed;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
    First;

    While Not EOF Do
    Begin
      pPreenchaMatItens(recSepara.arrMatItens, FieldByName('ITE_CODLSE').AsString);
      Next;
    End;

    recSepara.blnQtdOri := False;
    If fProducaoForaDeLoja(strNumPed, strEmpPed, strCodCli) Then
      If fMensagem('','Selecione o tipo de quantidade?',['&Original','&Pendente'],2) = 1 Then
        recSepara.blnQtdOri := True;

    If Not(recSepara.blnQtdOri) Then
    Begin
      If fDocumentoJaFaturado(strNumPed, 'PD', strEmpPed, strCodCli) Then
      Begin
        pMensagemOK('Não há itens pendentes para impressão!');
        Exit;
      End;
    End;

    recSepara.strNumDoc := strNumPed;
    recSepara.strEspDoc := 'PD';
    recSepara.strCodCli := strCodCli;
    recSepara.strEmpDoc := strEmpPed;
    recSepara.cdsLogSep := Nil;

    recSepara.strOpcDocTrue := IIF(Self.blnExpedicao, 'EI', '');

    recSepara.blnEnt_CD := fCampoTabela('FGO_ENT_CD',
                                        'FATGOR',
                                        ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                        [strNumPed, 'PD', strEmpPed]) = 'S';

    impSeparacao := TFatVendaImp.Create;
    impSeparacao.Add(recSepara);

    If fApenasMarcarComoImpressoPedidoOndaSeparacao Then
      blnSepImp := fMarcarPedidoComoImpresso(strNumPed, 'PD', strEmpPed, True, True)
    Else
    Begin
      If impSeparacao.fImprimeSeparacao(recSepara, '', '', False) Then
        blnSepImp := fMarcarPedidoComoImpresso(strNumPed, 'PD', strEmpPed, True, True);
    End;
  End;
End;

procedure TfrmFatDefineLotesPedidoWMS.dbgConsultaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  Var
    objCord: TGridCoord;
    intRecNo : Integer;
begin
  inherited;
  objCord := TDBGridCitel(Sender).MouseCoord(X,Y);

  if (objCord.X = fFindColumnByName(TDBGridCitel(Sender), 'TEM_MOVLOT').Index + 1) Then
  begin
    intRecNo := objCord.Y - (THackDBGrid(Sender).DataLink.ActiveRecord + 1);
    pShowHint(TDBGrid(Sender).DataSource.DataSet.RecNo + intRecNo, Mouse.CursorPos.X, Mouse.CursorPos.Y);
  End
  Else
    pHideHint;

end;

procedure TfrmFatDefineLotesPedidoWMS.pShowHint(intRecNo, x, y : Integer);
  Var
    objDataSet : TUniClientDataSet;
    strHint : String;
Begin
  If (intRecNo < 1) Then
  Begin
    pHideHint;
    Exit;
  End;

  If (intLastRecNo = intRecNo) Then
    Exit;

  Try
    objDataSet := TUniClientDataSet.Create(nil);
    objDataSet.CloneCursor(cdsConsulta, False, True);
    objDataSet.RecNo := intRecNo;

    intLastRecNo := intRecNo;

    if (objDataSet.FieldByName('TEM_MOVLOT').AsString = 'N') Then
      HintControler.ShowHint(X, Y, '', 'Produto sem movimentação programada!')
    Else
    Begin
      strHint := fGetTextoHint(objDataSet.FieldByName('FDO_CODITE').AsString, VS_strCodEmp);
      if fEmptyStr(strHint) Then
        pHideHint
      Else
        HintControler.ShowHint(X, Y, '', strHint);
    End;
  Finally
    FreeAndNil(objDataSet);
  End;

End;

function TfrmFatDefineLotesPedidoWMS.fGetTextoHint(strCodIte, strCodEmp : String) : String;
  Var
    qryMovLot : TUniQuery;
Begin
  qryMovLot := fCriaQuery;
  Try
    With qryMovLot, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT ORI.LOT_LOCFIS AS LOCORI, ');
      Add('        IF(IFNULL(MLT_QTDMOV,0) > 0, MLT_QTDMOV, ORI.LOT_SALDOS) AS QTDMOV, ');
      Add('        ORI.LOT_DTAVAL AS DTAVAL, ');
      Add('        DES.LOT_LOCFIS AS LOCDES  ');
      Add(' FROM MOVLOT                      ');

      Add('   INNER JOIN CADLOT ORI ON ORI.LOT_CODITE = MLT_CODITE ');
      Add('                        AND ORI.LOT_CODEMP = MLT_CODEMP ');
      Add('                        AND ORI.LOT_NUMLOT = MLT_LOTORI ');

      Add('   INNER JOIN CADLOT DES ON DES.LOT_CODITE = MLT_CODITE ');
      Add('                        AND DES.LOT_CODEMP = MLT_CODEMP ');
      Add('                        AND DES.LOT_NUMLOT = MLT_LOTDES ');

      Add(' WHERE MLT_CODEMP = :CODEMP ');
      Add('   AND MLT_CODITE = :CODITE ');
      Add('   AND MLT_DTAREA IS NULL   ');

      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;

      Open;

      If not isEmpty Then
      Begin
        Result := fPadR('LOCALIZAÇÃO ORIGEM'  , 20)+ ' |' +
                  fPadR('QUANTIDADE'   , 12)+ ' |' +
                  fPadR('LOCALIZAÇÃO DESTINO' , 20)+ ' |';

        If fCfgSis('COLVAL', varBoolean) Then
          Result := Result + fPadR('VALIDADE' , 10)+ ' |';

        Result := Result + #13;

        While Not Eof Do
        Begin
          Result := Result + fPadR(FieldByName('LOCORI').AsString, 20)+ ' |' +
                             fPadL(FormatFloat('#,##0.00', FieldByName('QTDMOV').AsFloat), 12) + ' |' +
                             fPadR(FieldByName('LOCDES').AsString , 20)+ ' |';

          If fCfgSis('COLVAL', varBoolean) Then
            Result := Result + fPadR(FormatDateTime('dd/MM/yyyy', FieldByName('DTAVAL').AsDateTime) , 10)+ ' |';

          Result := Result + #13;

          Next;
        End;

      End
      Else
        Exit('');

    End;

  Finally
    FreeAndNil(qryMovLot);
  End;

End;

procedure TfrmFatDefineLotesPedidoWMS.pHideHint;
Begin
  intLastRecNo := -1;
  HintControler.HideHint;
End;

procedure TfrmFatDefineLotesPedidoWMS.pAjustaTamanhoDescricaoItemGrid;
var
  intColumn: Integer;
  intTamUti: Integer;
const
  intValMin: Integer = 100;
begin
  intTamUti := 0;
  For intColumn := 0 To dbgConsulta.Columns.Count -1 Do
    With dbgConsulta.Columns[intColumn] Do
      If Visible And (FieldName <> 'FDO_DESCRI') Then
        Inc(intTamUti, Width);

  {Obrigatório tamanho mínimo, senão deixa barra de rolagem horizontal}
  If (dbgConsulta.Width - intTamUti - 60) >= intValMin Then
    fFindColumnByName(dbgConsulta, 'FDO_DESCRI').Width := (dbgConsulta.Width - intTamUti - 60)
  Else
    fFindColumnByName(dbgConsulta, 'FDO_DESCRI').Width := intValMin;
end;

Procedure TfrmFatDefineLotesPedidoWMS.pSetaLoteLocalizacaoFisicaComSaldo(cdsPedido : TUniClientDataSet);
   Var
     qryLot: TUniQuery;
Begin
  qryLot := fCriaQuery(Nil);
  try
    qryLot.Close;
    qryLot.SQL.Clear;
    qryLot.SQL.Add('SELECT LT.LOT_NUMLOT AS NUMLOT, ');
    qryLot.SQL.Add('       LT.LOT_LOCFIS AS LOCFIS, ');
    qryLot.SQL.Add('       LT.LOT_SALDOS AS SALDOS');
    qryLot.SQL.Add('FROM ');
    qryLot.SQL.Add('   CADLOT LT ');
    qryLot.SQL.Add('   LEFT JOIN CADLOC LC ');
    qryLot.SQL.Add('     ON LC.LOC_CODLOC = LT.LOT_LOCFIS ');
    qryLot.SQL.Add('    AND LC.LOC_CODEMP = LT.LOT_CODEMP ');
    qryLot.SQL.Add('WHERE ');
    qryLot.SQL.Add('      LT.LOT_CODEMP = :CODEMP ');
    qryLot.SQL.Add('  AND LT.LOT_CODITE = :CODITE ');
    qryLot.SQL.Add('  AND LT.LOT_SALDOS > 0  ');
    qryLot.SQL.Add('  AND IFNULL(LC.LOC_PICKIN,"N") = "N"  ');
    qryLot.SQL.Add('  AND LT.LOT_NUMLOT <> "A DEFINIR"     ');
    qryLot.SQL.Add('  AND LT.LOT_NUMLOT <> "A REGULARIZAR" ');
    qryLot.SQL.Add('  AND IFNULL(LC.LOC_CRITIC,"N") = "N"  ');
    qryLot.SQL.Add('  AND IFNULL(LC.LOC_BALCAO,"N") = "N"  ');
    qryLot.SQL.Add('  AND IFNULL(LOT_TRANSI,"N") = "N"  ');
    qryLot.SQL.Add('  AND LT.LOT_SALDOS IN (SELECT MAX(IFNULL(LT2.LOT_SALDOS, 0)) ');
    qryLot.SQL.Add('                               FROM CADLOT LT2 ');
    qryLot.SQL.Add('                               WHERE LT2.LOT_CODEMP = LT.LOT_CODEMP AND LT2.LOT_CODITE = LT.LOT_CODITE)');

    With cdsPedido Do
    Begin
      First;
      While Not Eof Do
      Begin
        qryLot.Close;
        qryLot.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
        qryLot.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
        qryLot.Open;

        If (qryLot.IsEmpty) Then
        Begin
          Next;
          Continue;
        End;

        Edit;
        FieldByName('LOTSAL').AsString := qryLot.FieldByName('NUMLOT').AsString;
        FieldByName('LOCSAL').AsString := qryLot.FieldByName('LOCFIS').AsString;
        Post;

        Next;
      End;

      First;
    End;
  finally
    FreeAndNil(qryLot);
  end;
End;

function TfrmFatDefineLotesPedidoWMS.fLayoutPossuiLoteOuLocalizacaoFisicaComSaldo: Boolean;
begin
  Result := True;

  If Assigned(frxSeparacaoWMS.FindObject('memLOTSAL')) Then
    Exit;

  If Assigned(frxSeparacaoWMS.FindObject('memLOCSAL')) Then
    Exit;

  Result := False;
End;

{ TRecalcularLocalizacoes }

procedure TRecalcularLocalizacoes.CopiarItens(const AItens: TUniClientDataSet);
begin

  If Not Assigned(AItens) Then
    Exit;

  pCloneDataSet(FItens, AItens, True, True);

end;

procedure TRecalcularLocalizacoes.CopiarLotes1(const ALotes: TUniClientDataSet);
begin

  If Not Assigned(ALotes) Then
    Exit;

  pCloneDataSet(FLotes1, ALotes, True, True);

end;

procedure TRecalcularLocalizacoes.CopiarLotes2(const ALotes: TUniClientDataSet);
begin

  If Not Assigned(ALotes) Then
    Exit;

  pCloneDataSet(FLotes2, ALotes, True, True);

end;

destructor TRecalcularLocalizacoes.Destroy;
begin

  If Assigned(FItens) Then
    FreeAndNil(FItens);

  If Assigned(FLotes1) Then
    FreeAndNil(FLotes1);

  If Assigned(FLotes2) Then
    FreeAndNil(FLotes2);

end;

constructor TRecalcularLocalizacoes.New;
begin
  FItens  := TUniClientDataSet.Create(Nil);
  FLotes1 := TUniClientDataSet.Create(Nil);
  FLotes2 := TUniClientDataSet.Create(Nil);
end;

procedure TRecalcularLocalizacoes.RestaurarItens(var AItens: TUniClientDataSet);
begin
  AItens.EmptyDataSet;
  pCloneDataSet(AItens, FItens, True, True);
end;

procedure TRecalcularLocalizacoes.RestaurarLotes1(var ALotes: TUniClientDataSet);
begin
  ALotes.EmptyDataSet;
  pCloneDataSet(ALotes, FLotes1, True, True);
end;

procedure TRecalcularLocalizacoes.RestaurarLotes2(var ALotes: TUniClientDataSet);
begin
  ALotes.EmptyDataSet;
  pCloneDataSet(ALotes, FLotes2, True, True);
end;

end.
