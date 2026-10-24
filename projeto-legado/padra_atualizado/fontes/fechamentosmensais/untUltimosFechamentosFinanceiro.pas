unit untUltimosFechamentosFinanceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, cxProgressBar,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid, untFechamentoFinanceiro,
  UniClientDataSet, UniDataSetProvider, DBAccess, Uni, untTypesSistema;

type
  TArrSelIDX = TArray<String>;

  TfrmUltimosFechamentosFinanceiro = class(TfrmPaiConfirma)
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
    UniDataSource1: TUniDataSource;
    cxvFechamentosFECCNT: TcxGridDBBandedColumn;
    StyleRepository: TcxStyleRepository;
    estiloFecCnt: TcxStyle;
    estiloPadrao: TcxStyle;
    pnlInfoContabil: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnIncFecClick(Sender: TObject);
    procedure btnRevFecClick(Sender: TObject);
    procedure cxvFechamentosStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    objFechamento: TFechamentoFinanceiro;
    AcdsUltimoFechamento: TUniClientDataSet;
    AdspUltimoFechamento: TUniDataSetProvider;
    AdtsUltimoFechamento: TUniDataSource;

    AcdsUltimo24Fechamento: TUniClientDataSet;
    AdspUltimo24Fechamento: TUniDataSetProvider;
    AdtsUltimo24Fechamento: TUniDataSource;

    procedure CriaCdsUltimo24Lancametos;
    procedure AfterScroll(dataSet: TDataSet);
    procedure CarregaDados(strUltEmpFec: String);
    procedure UltimoFechamento;
    procedure Ultimos24Fechamentos;
    function RetornaUltimoFechamentoTodasEmpresas(pgbProgresso: TcxProgressBar): Boolean;
    function RetornaUltimos24Fechamentos(pgbProgresso: TcxProgressBar): Boolean;
  public
    { Public declarations }
  end;

var
  frmUltimosFechamentosFinanceiro: TfrmUltimosFechamentosFinanceiro;

implementation

uses untIncluiFechamentoFinanceiro,
     untExcluiFechamentoFinanceiro,
     untFuncoesSimples,
     untGravando,
     Contabilidade.OutrosFechamentos.Funcoes;

{$R *.dfm}

procedure TfrmUltimosFechamentosFinanceiro.btnIncFecClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('INCLUIRFECFIN') Then
  begin
    pCriarFormularios(TfrmIncluiFechamentoFinanceiro, frmIncluiFechamentoFinanceiro);

    frmIncluiFechamentoFinanceiro.objFechamento := objFechamento;

    If Not AcdsUltimoFechamento.IsEmpty Then
      frmIncluiFechamentoFinanceiro.ACodEmpresa := AcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString;

    If frmIncluiFechamentoFinanceiro.ShowModal = mrOk Then
      CarregaDados(objFechamento.AUltEmpFechada);

    pFreeAndNil(frmIncluiFechamentoFinanceiro);
  end
  else
    fMensagem('Aviso', 'Usuário sem permissão!', ['&O k']);
end;

procedure TfrmUltimosFechamentosFinanceiro.btnRevFecClick(Sender: TObject);
var
  DataFechamento: string;
  I: Integer;
  Selecionados: Integer;
  Row : Integer;
  LblnFechamentoIgnorado: Boolean ;
begin
  inherited;
  If fVerificaAcessoSistema('EXCLUIRFECFIN') Then
  begin
    if cxvFechamentos.DataController.GetSelectedCount > 1 then
    begin
      If fMensagem('ATENÇÃO', 'Deseja realmente excluir os fechamentos selecionados?', ['&Sim', '&Não']) = 1 Then
      begin
        Selecionados := cxvFechamentos.ViewData.DataController.GetSelectedCount;

        LblnFechamentoIgnorado := False ;
        for I := 0 to Selecionados - 1 do
        begin
          Row := cxvFechamentos.ViewData.DataController.GetSelectedRowIndex(I);
          DataFechamento := cxvFechamentos.ViewData.Records[Row].Values[cxvFechamentos.Bands.GridView.FindItemByName('cxvFechamentosANOMES').Index];

          if not TOutrosFechamentos.fPodeDeletarFechamento(AcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString, StrToDateDef( DataFechamento, 0)) then
          begin
            LblnFechamentoIgnorado := True ;
            continue ;
          end ;

          objFechamento.ExcluiFechamento(AcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString, StrToDateDef( DataFechamento, 0))
        end;

        if not LblnFechamentoIgnorado then
          pMensagemOk('Fechamentos excluídos com sucesso!')
        else
          pMensagemOk('Nem todos fechamentos foram excluídos, verifique!') ;

        CarregaDados('');
      end;
    end
    else
    begin
      pCriarFormularios(TfrmExcluiFechamentoFinanceiro, frmExcluiFechamentoFinanceiro);

      If Not AcdsUltimoFechamento.IsEmpty Then
        frmExcluiFechamentoFinanceiro.ACodEmpresa := AcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString;

      If frmExcluiFechamentoFinanceiro.ShowModal = mrOk Then
        CarregaDados(objFechamento.AUltEmpFechada);

      pFreeAndNil(frmExcluiFechamentoFinanceiro);
    end;
  end
  else
    fMensagem('Aviso', 'Usuário sem permissão!', ['&O k']);
end;

procedure TfrmUltimosFechamentosFinanceiro.FormCreate(Sender: TObject);
begin
  inherited;
  objFechamento := TFechamentoFinanceiro.Create(Self,'TfrmUltimosFechamentosFinanceiro');
  pnlInfoContabil.Visible := TOutrosFechamentos.fContabilidadeLigada ;

  AcdsUltimoFechamento := TUniClientDataSet.Create(Self);
  AdspUltimoFechamento := TUniDataSetProvider.Create(Self);
  AdtsUltimoFechamento := TUniDataSource.Create(Self);
  AdtsUltimoFechamento.DataSet := AcdsUltimoFechamento;

  CriaCdsUltimo24Lancametos;
  CarregaDados('');

  cxvEmpresas.DataController.DataSource := AdtsUltimoFechamento;
  cxvEmpresas.NavigatorButtons.First.Click;

  cxvFechamentos.DataController.DataSource := AdtsUltimo24Fechamento;
  cxvFechamentos.NavigatorButtons.First.Click;

  pSetFocus(cxgEmpresas);
end;

procedure TfrmUltimosFechamentosFinanceiro.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnIncFec.Click;
    VK_F3: btnRevFec.Click;
  End;
end;

procedure TfrmUltimosFechamentosFinanceiro.AfterScroll(dataSet: TDataSet);
begin
//  objFechamento.AfterScrollEmpresa(dataSet);

  If Assigned(AcdsUltimo24Fechamento) And AcdsUltimo24Fechamento.Active Then
  begin
    If Not AcdsUltimo24Fechamento.IsEmpty Then
    Begin
      cxvFechamentos.Bands[0].Caption := 'Fechamentos da empresa: ' + AcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString;

      If AcdsUltimo24Fechamento.IsEmpty Then
        AcdsUltimo24Fechamento.Filter   := 'FEC_CODEMP = ' + QuotedStr('')
      Else
        AcdsUltimo24Fechamento.Filter   := 'FEC_CODEMP = ' + QuotedStr(AcdsUltimoFechamento.FieldByName('FEC_CODEMP').AsString);

      AcdsUltimo24Fechamento.Filtered := True;
    End;
  end;
end;

procedure TfrmUltimosFechamentosFinanceiro.CarregaDados(strUltEmpFec: String);
Var
  AEmpresa: String;
Begin
  AEmpresa := '';

  If Not strUltEmpFec.IsEmpty Then
    AEmpresa := strUltEmpFec;

  UltimoFechamento;
  Ultimos24Fechamentos;

  If Assigned(AcdsUltimoFechamento) Then
  Begin
    cxvEmpresas.Focused := True;

    If Not AEmpresa.IsEmpty Then
      AcdsUltimoFechamento.Locate('FEC_CODEMP', AEmpresa, []);

    AcdsUltimoFechamento.AfterScroll := AfterScroll;
    AfterScroll(AcdsUltimoFechamento);
  End;

end;

procedure TfrmUltimosFechamentosFinanceiro.CriaCdsUltimo24Lancametos;
begin
  AcdsUltimo24Fechamento := TUniClientDataSet.Create(Self);
  AdspUltimo24Fechamento := TUniDataSetProvider.Create(Self);
  AdtsUltimo24Fechamento := TUniDataSource.Create(Self);
  AdtsUltimo24Fechamento.DataSet := AcdsUltimo24Fechamento;
end;

procedure TfrmUltimosFechamentosFinanceiro.cxvFechamentosStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  LStatus: string;
  LRowInfo: TcxRowInfo;
begin
  inherited;

  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      LRowInfo := cxvFechamentos.DataController.GetRowInfo(ARecord.Index);
      LStatus := VarToStr(cxvFechamentos.DataController.Values[LRowInfo.RecordIndex, cxvFechamentosFECCNT.Index]);

      if LStatus = 'S' then
        AStyle := estiloFecCnt
      else
        AStyle := estiloPadrao;
    end;
  end;
end;

function TfrmUltimosFechamentosFinanceiro.RetornaUltimoFechamentoTodasEmpresas(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := objFechamento.CarregaUltimoFechamentoTodasEmpresas(AcdsUltimoFechamento, AdspUltimoFechamento, pgbProgresso);
end;

function TfrmUltimosFechamentosFinanceiro.RetornaUltimos24Fechamentos(pgbProgresso: TcxProgressBar): Boolean;
begin
  if Assigned(AcdsUltimo24Fechamento) then
  begin
    FreeAndNil(AcdsUltimo24Fechamento);
    FreeAndNil(AdtsUltimo24Fechamento);
    FreeAndNil(AdspUltimo24Fechamento);
    CriaCdsUltimo24Lancametos;
    cxvFechamentos.DataController.DataSource := nil;
    cxvFechamentos.DataController.DataSource := AdtsUltimo24Fechamento;
  end;

  Result := objFechamento.CarregaUltimos24Fechamentos(AcdsUltimo24Fechamento, AdspUltimo24Fechamento, pgbProgresso);
end;

procedure TfrmUltimosFechamentosFinanceiro.UltimoFechamento;
begin
  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'ÚLTIMO FECHAMENTO';
    frmGravando.lblGravando.Caption := 'Aguarde enquanto carrega os últimos fechamentos de todas as empresas.';
    frmGravando.fExecutarAcao       := RetornaUltimoFechamentoTodasEmpresas;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmUltimosFechamentosFinanceiro.Ultimos24Fechamentos;
begin
  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'ÚLTIMOS 24 FECHAMENTOS';
    frmGravando.lblGravando.Caption := 'Aguarde enquanto carrega os últimos 24 fechamentos.';
    frmGravando.fExecutarAcao       := RetornaUltimos24Fechamentos;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

end.
