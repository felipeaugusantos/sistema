unit untConsultaVendaDepartamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, Uni,
  cxDataStorage, cxEdit, cxNavigator,  untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, UniClientDataSet,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, untConsultas, untTypesSistema,
  untFuncoesSimples, untFuncoesConsulta, cxGridCitel;

type
  TfrmConsultaVendaDepartamento = class(TfrmPaiConfirma)
    pnlParametros: TPanel;
    Label1: TLabel;
    edtDepartamento: TEditFocus;
    edtDesDepartamento: TEditFocus;
    cxgConsultaDBTableView: TcxGridDBTableView;
    cxgConsultaLevel: TcxGridLevel;
    cxgConsulta: TcxGrid;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    dtsConsul: TDataSource;
    cxgConsultaDBTableViewColumn2: TcxGridDBColumn;
    cxgConsultaDBTableViewColumn3: TcxGridDBColumn;
    cxgConsultaDBTableViewColumn4: TcxGridDBColumn;
    dbgDocumentosDBViewMaster: TcxGridDBTableViewCitel;
    dbgDocumentosDBViewMasterColumn1: TcxGridDBColumn;
    cxgConsultaDBTableViewColumn1: TcxGridDBColumn;
    procedure edtDepartamentoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtDepartamentoExit(Sender: TObject);
  private
    { Private declarations }
    FcdsVenda: TUniClientDataSet;

    arrDepartamento: TConsultasArray;
    cdsRelatorio : TUniClientDataSet;

    procedure pAbreConsulta;
    procedure pCriaTabelaRelatorio;
    procedure pAdicionaCampoNoDataSet(Dataset: TUniClientDataSet;
                                      strFieldName: string;
                                      FieldType: TFieldType;
                                      intSize: Integer = 0;
                                      blnRequired: Boolean = False);

    function fValidaFiltro(arrConsulta: TConsultasArray; strCampoFiltro: string; strValor: string): Boolean;
  public
    { Public declarations }
    property cdsVenda: TUniClientDataSet write FcdsVenda;

  end;

implementation

{$R *.dfm}

uses untGravando;

procedure TfrmConsultaVendaDepartamento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsRelatorio);
end;

procedure TfrmConsultaVendaDepartamento.FormShow(Sender: TObject);
begin
  inherited;

  pCriaTabelaRelatorio;
  pAbreConsulta;

end;

procedure TfrmConsultaVendaDepartamento.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde, Carregando Pedidos...', '');
end;

procedure TfrmConsultaVendaDepartamento.edtDepartamentoExit(Sender: TObject);
begin
  inherited;
   pEdtCodSelectExit(edtDepartamento, edtDesDepartamento, arrDepartamento, fRetDescDepartamento, nil, 'do depaertamento', 3);
end;

procedure TfrmConsultaVendaDepartamento.edtDepartamentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqDepartamento(Self, edtDepartamento, edtDesDepartamento, Nil, Key, arrDepartamento, False) Then
  begin
    if fValidaCampos(edtDepartamento, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConsultaVendaDepartamento.pAbreConsulta;
var
  strCodDep: string;
  strNomeDep: string;
begin
  cdsRelatorio.EmptyDataSet;

  FcdsVenda.DisableControls;
  try
    FcdsVenda.IndexFieldNames := 'ITE_CODVEN';
    FcdsVenda.First;
    while not FcdsVenda.Eof do
    begin
      strCodDep := fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [FcdsVenda.FieldByName('ITE_CODITE').AsString], False);
      strNomeDep := fRetDescDepartamento(strCodDep);

      if (Length(arrDepartamento) = 0) and (fEmptyStr(edtDepartamento.Text)) then
      begin
        if (fEmptyStr(strCodDep)) then
          strNomeDep := 'SEM DEPARTAMENTO'
      end
      else if (not fValidaFiltro(arrDepartamento, edtDepartamento.Text, strCodDep)) then
      begin
        FcdsVenda.Next;
        Continue;
      end;

      cdsRelatorio.Append;
      cdsRelatorio.FieldByName('DEP_CODIGO').AsString := strCodDep;
      cdsRelatorio.FieldByName('DEP_DESCRI').AsString := strCodDep + ' - ' + strNomeDep;
      cdsRelatorio.FieldByName('DET_QTDITE').AsFloat  :=FcdsVenda.FieldByName('ITE_QTDITE').AsFloat;
      cdsRelatorio.FieldByName('DET_TOTITE').AsFloat  := FcdsVenda.FieldByName('ITE_TOTITE').AsFloat;
      cdsRelatorio.FieldByName('DET_CODVEN').AsString := FcdsVenda.FieldByName('ITE_CODVEN').AsString + ' - ' + fRetNomeOperador(FcdsVenda.FieldByName('ITE_CODVEN').AsString);
      cdsRelatorio.Post;

      FcdsVenda.Next;
    end;

  finally
    FcdsVenda.EnableControls;
  end;
end;

procedure TfrmConsultaVendaDepartamento.pAdicionaCampoNoDataSet(Dataset: TUniClientDataSet;
                                                                strFieldName: string;
                                                                FieldType: TFieldType;
                                                                intSize: Integer = 0;
                                                                blnRequired: Boolean = False);
var
  Field: TFieldDef;
begin
  Field := cdsRelatorio.FieldDefs.AddFieldDef;
  Field.Name := strFieldName;
  Field.DataType := FieldType;
  Field.Required := blnRequired;

  if (intSize > 0) then
    Field.Size := intSize;

end;

procedure TfrmConsultaVendaDepartamento.pCriaTabelaRelatorio;
begin
  cdsRelatorio := TUniClientDataSet.Create(Nil);
  pAdicionaCampoNoDataSet(cdsRelatorio, 'DEP_CODIGO', ftString, 3);
  pAdicionaCampoNoDataSet(cdsRelatorio, 'DEP_DESCRI', ftString, 60);
  pAdicionaCampoNoDataSet(cdsRelatorio, 'DET_QTDITE', ftFloat);
  pAdicionaCampoNoDataSet(cdsRelatorio, 'DET_TOTITE', ftFloat);
  pAdicionaCampoNoDataSet(cdsRelatorio, 'DET_CODVEN', ftString, 60);

  cdsRelatorio.CreateDataSet;
  dtsConsul.DataSet := cdsRelatorio;

  TFloatField(cdsRelatorio.FieldByName('DET_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsRelatorio.FieldByName('DET_TOTITE')).DisplayFormat := '#,##0.00';
end;

function TfrmConsultaVendaDepartamento.fValidaFiltro(
  arrConsulta: TConsultasArray; strCampoFiltro, strValor: string): Boolean;
var
  intIndice: Integer;
begin
  result := False;

  if (strCampoFiltro = strValor) then
    result := True
  else
  begin
    for intIndice := 0 to Length(arrConsulta) - 1 do
    begin
      if (arrConsulta[intIndice].strCodigo = strValor) then
      begin
        result := True;
        break;
      end;
    end;
  end;
end;

end.

