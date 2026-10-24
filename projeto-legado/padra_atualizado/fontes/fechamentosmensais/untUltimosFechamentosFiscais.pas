unit untUltimosFechamentosFiscais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, untFechamentoFiscal;

type
  TfrmUltimosFechamentosFiscais = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    cxgEmpresas: TcxGrid;
    cxgEmpresasLevel1: TcxGridLevel;
    cxvEmpresas: TcxGridDBBandedTableView;
    cxvEmpresasCODEMP: TcxGridDBBandedColumn;
    cxvEmpresasNOMEMP: TcxGridDBBandedColumn;
    cxvEmpresasULTFEC: TcxGridDBBandedColumn;
    Splitter1: TSplitter;
    cxgFechamentos: TcxGrid;
    cxvFechamentos: TcxGridDBBandedTableView;
    cxvFechamentosANOMES: TcxGridDBBandedColumn;
    cxvFechamentosNOMOPE: TcxGridDBBandedColumn;
    cxvFechamentosDTAFEC: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    cxvFechamentosCODOPE: TcxGridDBBandedColumn;
    cxvFechamentosHORFEC: TcxGridDBBandedColumn;
    btnIncFec: TBitBtnLocked;
    btnRevFec: TBitBtnLocked;
    pnlInfoContabil: TPanel;
    cxvFechamentosFECCNT: TcxGridDBBandedColumn;
    StyleRepository: TcxStyleRepository;
    estiloFecCnt: TcxStyle;
    estiloPadrao: TcxStyle;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnIncFecClick(Sender: TObject);
    procedure btnRevFecClick(Sender: TObject);
    procedure cxvFechamentosStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    objFechamento: TFechamentoFiscal;

    procedure pCarregaDados(strUltEmpFec: String);

    procedure pAfterScroll(dataSet: TDataSet);

  public
    { Public declarations }
  end;

var
  frmUltimosFechamentosFiscais: TfrmUltimosFechamentosFiscais;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples,
  untIncluiFechamentoFiscal,
  untExcluiFechamentoFiscal,
  Contabilidade.OutrosFechamentos.Funcoes;


procedure TfrmUltimosFechamentosFiscais.btnIncFecClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmIncluiFechamentoFiscal, frmIncluiFechamentoFiscal);

  frmIncluiFechamentoFiscal.objFechamento := objFechamento;

  If Not objFechamento.cdsUltFecTodas.IsEmpty Then
    frmIncluiFechamentoFiscal.strCodEmp := objFechamento.cdsUltFecTodas.FieldByName('FEC_CODEMP').AsString;

  If frmIncluiFechamentoFiscal.ShowModal = mrOk Then
    pCarregaDados(objFechamento.strUltEmpFechada);

  pFreeAndNil(frmIncluiFechamentoFiscal);
end;

procedure TfrmUltimosFechamentosFiscais.btnRevFecClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmExcluiFechamentoFiscal, frmExcluiFechamentoFiscal);

  If Not objFechamento.cdsUltFecTodas.IsEmpty Then
    frmExcluiFechamentoFiscal.strCodEmp := objFechamento.cdsUltFecTodas.FieldByName('FEC_CODEMP').AsString;

  If frmExcluiFechamentoFiscal.ShowModal = mrOk Then
    pCarregaDados(objFechamento.strUltEmpFechada);

  pFreeAndNil(frmExcluiFechamentoFiscal);
end;

procedure TfrmUltimosFechamentosFiscais.cxvFechamentosStylesGetContentStyle(
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

procedure TfrmUltimosFechamentosFiscais.FormCreate(Sender: TObject);
begin
  inherited;

  objFechamento := TFechamentoFiscal.Create(Self);
  pnlInfoContabil.Visible := TOutrosFechamentos.fContabilidadeLigada ;

  pCarregaDados('');

  cxvEmpresas.DataController.DataSource := objFechamento.cdsUltFecTodas.dtsSource;
  cxvEmpresas.NavigatorButtons.First.Click;

  cxvFechamentos.DataController.DataSource := objFechamento.cdsUltimos24.dtsSource;
  cxvFechamentos.NavigatorButtons.First.Click;
end;

procedure TfrmUltimosFechamentosFiscais.pCarregaDados(strUltEmpFec: String);
  Var
    strCodEmp: String;
Begin
  strCodEmp := '';

  If Not strUltEmpFec.IsEmpty Then
    strCodEmp := strUltEmpFec;

  objFechamento.fCarregaUltimoFechamentoTodasEmpresas;

  objFechamento.fCarregaUltimos24;

  If Assigned(objFechamento.cdsUltFecTodas) Then
  Begin
    cxvEmpresas.Focused := True;

    If Not strCodEmp.IsEmpty Then
      objFechamento.cdsUltFecTodas.Locate('FEC_CODEMP', strCodEmp, []);

    objFechamento.cdsUltFecTodas.AfterScroll := pAfterScroll;

    pAfterScroll(objFechamento.cdsUltFecTodas);
  End;

End;

procedure TfrmUltimosFechamentosFiscais.pAfterScroll(dataSet: TDataSet);
Begin
  objFechamento.pAfterScrollEmpresa(dataSet);

  If Assigned(objFechamento.cdsUltFecTodas) And objFechamento.cdsUltFecTodas.Active Then
    cxvFechamentos.Bands[0].Caption := 'Fechamentos da empresa: ' + objFechamento.cdsUltFecTodas.FieldByName('FEC_CODEMP').AsString;
End;

procedure TfrmUltimosFechamentosFiscais.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F2: btnIncFec.Click;
    VK_F3: btnRevFec.Click;
  End;
end;

end.
