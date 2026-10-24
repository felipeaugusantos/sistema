unit Contabilidade.View.FechamentoDiaMes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid, cxProgressBar,
  Uni, UniClientDataSet,UniDataSetProvider,
  Contabilidade.Classes.FechamentoDiaMes;

type
  TfrmFechamentoContabilDiaMes = class(TfrmPaiContabilidade)
    pnlTopo: TPanel;
    Splitter1: TSplitter;
    cxgEmpresas: TcxGrid;
    cxvEmpresas: TcxGridDBBandedTableView;
    cxvEmpresasCODEMP: TcxGridDBBandedColumn;
    cxvEmpresasNOMEMP: TcxGridDBBandedColumn;
    cxvEmpresasULTFEC: TcxGridDBBandedColumn;
    cxgEmpresasLevel1: TcxGridLevel;
    cxgFechamentos: TcxGrid;
    cxvFechamentos: TcxGridDBBandedTableView;
    cxvFechamentosANOMES: TcxGridDBBandedColumn;
    cxvFechamentosNOMOPE: TcxGridDBBandedColumn;
    cxvFechamentosDTAFEC: TcxGridDBBandedColumn;
    cxvFechamentosCODOPE: TcxGridDBBandedColumn;
    cxvFechamentosHORFEC: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    btnRevFec: TBitBtnLocked;
    btnIncFec: TBitBtnLocked;
    cxvEmpresasFECFIN: TcxGridDBBandedColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnIncFecClick(Sender: TObject);
    procedure btnRevFecClick(Sender: TObject);
  private
    Fobjfechamento: TFechamentoContabilDiaMes;

    FcdsUltimoFechamento: TUniClientDataSet;
    FdspUltimoFechamento: TUniDataSetProvider;
    FdtsUltimoFechamento: TUniDataSource;

    FcdsUltimo24Fechamento: TUniClientDataSet;
    FdspUltimo24Fechamento: TUniDataSetProvider;
    FdtsUltimo24Fechamento: TUniDataSource;

    procedure pCriaCdsUltimo24Lancamentos;
    procedure pDestroiCdsUltimo24Lancamentos;
    procedure pAfterScroll(ADataSet: TDataSet);
    procedure pCarregaDados(const AstrUltEmpFec: String);
    procedure pUltimoFechamento;
    procedure pUltimos24Fechamentos;
    function fRetornaUltimoFechamentoTodasEmpresas(pgbProgresso: TcxProgressBar): Boolean;
    function fRetornaUltimos24Fechamentos(pgbProgresso: TcxProgressBar): Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples,
  Contabilidade.Funcoes,
  Contabilidade.View.FechamentoDiaMesIncluir,
  Contabilidade.View.FechamentoDiaMesExcluir;

{$R *.dfm}

procedure TfrmFechamentoContabilDiaMes.pAfterScroll(ADataSet: TDataSet);
begin
  If Assigned(FcdsUltimo24Fechamento) And FcdsUltimo24Fechamento.Active Then
  begin
    If Not FcdsUltimo24Fechamento.IsEmpty Then
    Begin
      cxvFechamentos.Bands[0].Caption := 'Fechamentos da empresa: ' + FcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString;

      If FcdsUltimo24Fechamento.IsEmpty Then
        FcdsUltimo24Fechamento.Filter   := 'FEC_CODEMP = ' + QuotedStr('')
      Else
        FcdsUltimo24Fechamento.Filter   := 'FEC_CODEMP = ' + QuotedStr(FcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString);

      FcdsUltimo24Fechamento.Filtered := True;
    End;
  end;
end;

procedure TfrmFechamentoContabilDiaMes.pCarregaDados(const AstrUltEmpFec: String);
Var
  LEmpresa: String;
Begin
  LEmpresa := '';

  If Not AstrUltEmpFec.IsEmpty Then
    LEmpresa := AstrUltEmpFec;

  pUltimoFechamento;
  pUltimos24Fechamentos;

  If Assigned(FcdsUltimoFechamento) Then
  Begin
    cxvEmpresas.Focused := True;

    If Not LEmpresa.IsEmpty Then
      FcdsUltimoFechamento.Locate('FEC_CODEMP', LEmpresa, []);

    FcdsUltimoFechamento.AfterScroll := pAfterScroll;
    pAfterScroll(FcdsUltimoFechamento);
  End;

end;

procedure TfrmFechamentoContabilDiaMes.pCriaCdsUltimo24Lancamentos;
begin
  pDestroiCdsUltimo24Lancamentos;
  FcdsUltimo24Fechamento := TUniClientDataSet.Create(Self);
  FdspUltimo24Fechamento := TUniDataSetProvider.Create(Self);
  FdtsUltimo24Fechamento := TUniDataSource.Create(Self);
  FdtsUltimo24Fechamento.DataSet := FcdsUltimo24Fechamento;
  cxvFechamentos.DataController.DataSource := FdtsUltimo24Fechamento;
end;

procedure TfrmFechamentoContabilDiaMes.pDestroiCdsUltimo24Lancamentos;
begin
  if Assigned(FcdsUltimo24Fechamento) then
  begin
    FreeAndNil(FcdsUltimo24Fechamento);
    FreeAndNil(FdspUltimo24Fechamento);
    FreeAndNil(FdtsUltimo24Fechamento);
  end;
end;

procedure TfrmFechamentoContabilDiaMes.pUltimoFechamento;
begin
  fChamaTelaGravando(fRetornaUltimoFechamentoTodasEmpresas);
end;

procedure TfrmFechamentoContabilDiaMes.pUltimos24Fechamentos;
begin
  fChamaTelaGravando(fRetornaUltimos24Fechamentos);
end;

procedure TfrmFechamentoContabilDiaMes.btnIncFecClick(Sender: TObject);
var
  LfrmIncluiFechamentoDiaMes: TfrmIncluiFechamentoDiaMes;
begin
  inherited;

  try
    pCriarFormularios(TfrmIncluiFechamentoDiaMes, LfrmIncluiFechamentoDiaMes);
    LfrmIncluiFechamentoDiaMes.objFechamento := FobjFechamento;
    If Not FcdsUltimoFechamento.IsEmpty Then
      LfrmIncluiFechamentoDiaMes.ACodEmpresa := FcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString;

    If LfrmIncluiFechamentoDiaMes.ShowModal = mrOk Then
      pCarregaDados(FobjFechamento.fGetUltimaEmpresaFechada);
  finally
    FreeandNil(LfrmIncluiFechamentoDiaMes);
  end;
end;

procedure TfrmFechamentoContabilDiaMes.btnRevFecClick(Sender: TObject);
var
  LstrDataFechamento: string;
  LintCount, LintRow, LintSelecionados: Integer;
  LblnRaiz: Boolean;
  LfrmExcluiFechamentoDiaMes: TfrmExcluiFechamentoDiaMes;
begin
  inherited;

  try
    if cxvFechamentos.DataController.GetSelectedCount > 1 then
    begin
      If fMensagem('ATENÇÃO', 'Deseja realmente excluir os fechamentos selecionados?', ['&Sim', '&Não']) = 1 Then
      begin
        LintSelecionados := cxvFechamentos.ViewData.DataController.GetSelectedCount;

        LblnRaiz := False;
        for LintCount := 0 to LintSelecionados - 1 do
        begin
          LintRow := cxvFechamentos.ViewData.DataController.GetSelectedRowIndex(LintCount);
          LstrDataFechamento := cxvFechamentos.ViewData.Records[LintRow].Values[cxvFechamentos.Bands.GridView.FindItemByName('cxvFechamentosANOMES').Index];
          LblnRaiz := Fobjfechamento.fTemOutrosFechamentosNaRaiz(FcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString, StrToDateDef( LstrDataFechamento, 0));

          if LblnRaiz then
            break;
        end;

        LblnRaiz := LblnRaiz and (fMensagem('ATENÇÃO', 'Deseja excluir o fechamento para as outras empresas na mesma raiz?', ['&Sim', '&Não']) = 1);

        for LintCount := 0 to LintSelecionados - 1 do
        begin
          LintRow := cxvFechamentos.ViewData.DataController.GetSelectedRowIndex(LintCount);
          LstrDataFechamento := cxvFechamentos.ViewData.Records[LintRow].Values[cxvFechamentos.Bands.GridView.FindItemByName('cxvFechamentosANOMES').Index];
          FobjFechamento.fExcluirFechamento(FcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString, StrToDateDef( LstrDataFechamento, 0), LblnRaiz);
        end;

        fMensagem('', 'Fechamantos excluídos com sucesso!', ['&O k']);
        pCarregaDados('');
      end;
    end
    else
    begin
      pCriarFormularios(TfrmExcluiFechamentoDiaMes, LfrmExcluiFechamentoDiaMes);
      try
        LfrmExcluiFechamentoDiaMes.objFechamento := FobjFechamento;
        If Not FcdsUltimoFechamento.IsEmpty Then
          LfrmExcluiFechamentoDiaMes.ACodEmpresa := FcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString;

        If LfrmExcluiFechamentoDiaMes.ShowModal = mrOk Then
          pCarregaDados('');
      finally
        FreeAndNil(LfrmExcluiFechamentoDiaMes);
      end;
    end;
  except
    on FE: TFechamentoException do
      fMensagem('ATENÇÃO', FE.Message, ['&O k']);

    on E: Exception do
      pMensagensErro(E.Classname + ': ' + E.Message, 'TfrmFechamentoContabilDiaMes.btnRevFecClick');
  end;
end;

procedure TfrmFechamentoContabilDiaMes.FormCreate(Sender: TObject);
begin
  inherited;
  Fobjfechamento := TFechamentoContabilDiaMes.Create(Self.Name);

  FcdsUltimoFechamento := TUniClientDataSet.Create(Self);
  FdspUltimoFechamento := TUniDataSetProvider.Create(Self);
  FdtsUltimoFechamento := TUniDataSource.Create(Self);
  FdtsUltimoFechamento.DataSet := FcdsUltimoFechamento;
  cxvEmpresas.DataController.DataSource := FdtsUltimoFechamento;

  FcdsUltimo24Fechamento := nil;
  FdspUltimo24Fechamento := nil;
  FdtsUltimo24Fechamento := nil;

  pCarregaDados('');

  cxvEmpresas.NavigatorButtons.First.Click;
  cxvFechamentos.NavigatorButtons.First.Click;

  pSetFocus(cxgEmpresas);
end;

procedure TfrmFechamentoContabilDiaMes.FormDestroy(Sender: TObject);
begin
  inherited;
  pDestroiCdsUltimo24Lancamentos;
  FreeAndNil(FdtsUltimoFechamento);
  FreeAndNil(FdspUltimoFechamento);
  FreeAndNil(FdspUltimoFechamento);
  FreeAndNil(Fobjfechamento);
end;

procedure TfrmFechamentoContabilDiaMes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnIncFec.Click;
    VK_F3: btnRevFec.Click;
  End;
end;

function TfrmFechamentoContabilDiaMes.fRetornaUltimoFechamentoTodasEmpresas(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  try
    pSetaTextoProgresso(pgbProgresso, 'Aguarde...Carregando último fechamento de cada empresa. ');
    Fobjfechamento.fCarregaUltimoFechamentoTodasEmpresas(FcdsUltimoFechamento, FdspUltimoFechamento);
//    FdtsUltimo24Fechamento.DataSet := FcdsUltimoFechamento;
//    cxvEmpresas.DataController.DataSource := FdtsUltimoFechamento;
  except
    on E: Exception do
      pMensagensErro(E.Message, 'TfrmFechamentoContabilDiaMes.fRetornaUltimoFechamentoTodasEmpresas');
  end;
end;

function TfrmFechamentoContabilDiaMes.fRetornaUltimos24Fechamentos(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  try
    pSetaTextoProgresso(pgbProgresso, 'Aguarde...Carregando últimos 24 fechamentos.');
    pCriaCdsUltimo24Lancamentos;
    Fobjfechamento.fCarregaUltimos24Fechamentos(FcdsUltimo24Fechamento, FdspUltimo24Fechamento);
//    FdtsUltimo24Fechamento.DataSet := FcdsUltimo24Fechamento;
//    cxvFechamentos.DataController.DataSource := FdtsUltimo24Fechamento;

  except
    on E: Exception do
      pMensagensErro(E.Message, 'TfrmFechamentoContabilDiaMes.fRetornaUltimos24Fechamentos');
  end;
end;

end.
