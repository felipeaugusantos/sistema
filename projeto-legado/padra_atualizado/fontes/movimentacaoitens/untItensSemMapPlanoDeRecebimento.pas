unit untItensSemMapPlanoDeRecebimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, DB, untFuncoesSimples, untFuncoesAuxiliares, untFuncoes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  untMapeamentoItemLocalizacaoFisica, frxDBSet;

type
  TfrmItensSemMapPlanoDeRecebimento = class(TfrmPaiConfirma)
    pnlCabecalh: TPanel;
    cxgItensTableView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    dtsItens: TDataSource;
    cxgItensTableViewCODITE: TcxGridDBColumn;
    cxgItensTableViewDESITE: TcxGridDBColumn;
    cxgItensTableViewSIGUNI: TcxGridDBColumn;
    cxgItensTableViewColumn4: TcxGridDBColumn;
    btnMapeamentoLocFis: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    frxItens: TfrxReport;
    frxDBItens: TfrxDBDataset;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMapeamentoLocFisClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function frxItensUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    qryItens: TUniQuery;
  public
    FStrItens: String;
    FBlnValidado: Boolean;
    function fValidarItens: Boolean;
  end;

var
  frmItensSemMapPlanoDeRecebimento: TfrmItensSemMapPlanoDeRecebimento;

implementation

{$R *.dfm}

procedure TfrmItensSemMapPlanoDeRecebimento.btnImprimirClick(Sender: TObject);
begin
  inherited;
  pPrintReport(Self.Name, Self.Caption, '', frxItens);
end;

procedure TfrmItensSemMapPlanoDeRecebimento.btnMapeamentoLocFisClick(Sender: TObject);
var
  frmMapeamento: TfrmMapeamentoItemLocalizacaoFisica;
begin
  inherited;
  Application.CreateForm(TfrmMapeamentoItemLocalizacaoFisica, frmMapeamento);
  Try
    frmMapeamento.edtCodIte.Text := qryItens.FieldByName('ITE_CODITE').AsString;
    frmMapeamento.blnCarregandoDoPlanoDeRecebimento := True;
    frmMapeamento.ShowModal;
  Finally
    fValidarItens;
    FreeAndNil(frmMapeamento);
  End;
end;

procedure TfrmItensSemMapPlanoDeRecebimento.FormCreate(Sender: TObject);
begin
  inherited;
  qryItens := fCriaQuery;
  dtsItens.DataSet := qryItens;
  frxItens.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');
end;

procedure TfrmItensSemMapPlanoDeRecebimento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsItens);
  FreeAndNil(qryItens);
end;

procedure TfrmItensSemMapPlanoDeRecebimento.FormShow(Sender: TObject);
begin
  inherited;
  btnMapeamentoLocFis.Visible := fVerificaAcessoSistema('frmMapeamentoLocalizacaoFisica', strLoginUsuarioLogado);
end;

function TfrmItensSemMapPlanoDeRecebimento.frxItensUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If (SameText(MethodName, 'fTime')) Then
    Result := fTime(Params[0]);
end;

function TfrmItensSemMapPlanoDeRecebimento.fValidarItens: Boolean;
begin
  Result := False;
  qryItens.SQL.Clear;
  qryItens.SQL.Add('  SELECT                               ');
  qryItens.SQL.Add('   ITE_CODITE,                         ');
  qryItens.SQL.Add('   ITE_DESITE,                         ');
  qryItens.SQL.Add('   UNI_SIGUNI,                         ');
  qryItens.SQL.Add('   IFNULL(IF(LOT_LOCFIS="",            ');
  qryItens.SQL.Add('            "SEM LOCALIZAÇÃO FISICA",  ');
  qryItens.SQL.Add('            LOT_LOCFIS),               ');
  qryItens.SQL.Add('            "SEM LOCALIZAÇÃO FÍSICA")  ');
  qryItens.SQL.Add('   AS LOC_LOCFIS                       ');
  qryItens.SQL.Add(' FROM                                  ');
  qryItens.SQL.Add('   CADITE                              ');
  qryItens.SQL.Add('   INNER JOIN CADUNI                   ');
  qryItens.SQL.Add('     ON UNI_CODUNI = ITE_CODUNI        ');
  qryItens.SQL.Add('   INNER JOIN CADLOT                   ');
  qryItens.SQL.Add('     ON LOT_CODITE = ITE_CODITE        ');
  qryItens.SQL.Add(' WHERE ITE_CODITE IN (' + FStrItens +')');
  qryItens.SQL.Add('  AND ITE_CODITE NOT IN                ');
  qryItens.SQL.Add('   (SELECT                             ');
  qryItens.SQL.Add('     LCI_CODITE                        ');
  qryItens.SQL.Add('   FROM                                ');
  qryItens.SQL.Add('     LOCITE                            ');
  qryItens.SQL.Add('   WHERE LCI_CODEMP = :CODEMP)         ');
  qryItens.SQL.Add(' GROUP BY ITE_CODITE                   ');
  qryItens.SQL.Add(' ORDER BY ITE_DESITE                   ');

  qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;

  Try
    qryItens.Open;
    Result := qryItens.isEmpty;
    FBlnValidado := Result;
    If FBlnValidado Then
      Close;
  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmItensSemMapPlanoDeRecebimento.fValidarItens');
    End;
  End;
end;

end.
