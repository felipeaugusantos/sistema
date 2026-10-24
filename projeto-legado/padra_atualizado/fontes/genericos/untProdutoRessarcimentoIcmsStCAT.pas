unit untProdutoRessarcimentoIcmsStCAT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  EditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxClasses, cxGridCustomView,
  cxGrid, UniClientDataSet;

type
  TfrmProdutoRessarcimentoIcmsStCAT = class(TfrmPai)
    cxgAbrev: TcxGrid;
    cxgAbrevTableView: TcxGridDBBandedTableView;
    cxgAbrevDBColUF: TcxGridDBBandedColumn;
    cxgAbrevDBColCodSit: TcxGridDBBandedColumn;
    cxgAbrevDBColBasIcm: TcxGridDBBandedColumn;
    cxgAbrevDBColAlqIcm: TcxGridDBBandedColumn;
    cxgAbrevDBColBasRet: TcxGridDBBandedColumn;
    cxgAbrevDBColAlqRet: TcxGridDBBandedColumn;
    cxgAbrevDBColIVA_ST: TcxGridDBBandedColumn;
    cxgAbrevDBColResIcm: TcxGridDBBandedColumn;
    cxgAbrevDBColRes_St: TcxGridDBBandedColumn;
    cxgAbrevDBColResTot: TcxGridDBBandedColumn;
    cxgAbrevLevel: TcxGridLevel;
    pnlHeader: TPanel;
    cxgAbrevTableViewColumn1: TcxGridDBBandedColumn;
    Label4: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    cxStyle: TcxStyleRepository;
    cxsIcms: TcxStyle;
    cxsST: TcxStyle;
    cxsRessarcimento: TcxStyle;
    cxsDesconto: TcxStyle;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsGrid : TUniClientDataSet;
    dtsGrid : TDataSource;
    FCodAbreviacao: String;
    FDataSetOrigem: TUniClientDataSet;
    procedure FormataCampos(DataSet: TUniClientDataSet);
    procedure CarregarDados;
    procedure CarregaProduto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure SetData(DataSet: TUniClientDataSet);
    property CodAbreviacao: String read FCodAbreviacao write FCodAbreviacao;
  end;

implementation

{$R *.dfm}

uses
  untConsultas, untTypesSistema, untFuncoesSimples, untConstantes;

procedure TfrmProdutoRessarcimentoIcmsStCAT.CarregaProduto;
var
  LIpiEnt: Double;
  fltValRet: Double;
begin
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
  LIpiEnt := fCampoTabela('ITE_IPIENT', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [edtCodIte.Text, VS_strCodEmp]);

  CarregarDados;
  cdsGrid.DisableControls;
  try
    cdsGrid.First;
    while not cdsGrid.Eof do
    begin
      cdsGrid.Edit;
      cdsGrid.FieldByName('IPIENT').AsFloat := LIpiEnt;
      cdsGrid.FieldByName('CAT_BASRET').AsFloat := cdsGrid.FieldByName('CAT_BASRET').AsFloat + LIpiEnt;

      fltValRet := cdsGrid.FieldByName('CAT_BASRET').AsFloat *
                   cdsGrid.FieldByName('CAT_ALQRET').AsFloat *
                   cdsGrid.FieldByName('CAT_IVA_ST').AsFloat / 100 - cdsGrid.FieldByName('CAT_RESICM').AsFloat;

      If fltValRet <= 0 Then
        fltValRet := 0.00;

      If (Not CST_SUBSTITUICAO.Contains(cdsGrid.FieldByName('CAT_CODSIT').AsString)) Then
        fltValRet := 0.00;

      cdsGrid.FieldByName('CAT_RES_ST').AsFloat := fltValRet;
      cdsGrid.FieldByName('CAT_RESTOT').AsFloat := cdsGrid.FieldByName('CAT_RESICM').AsFloat + fltValRet;

      cdsGrid.Post;

      cdsGrid.Next;
    end;
  finally
    cdsGrid.EnableControls;
  end;

  cxgAbrevTableView.DataController.DataSource := dtsGrid;
end;

procedure TfrmProdutoRessarcimentoIcmsStCAT.CarregarDados;
var
  LField: TFieldDef;
  intCont  : Integer;
  intRecno : Integer;
begin
  inherited;
  if cdsGrid.Active then
    cdsGrid.EmptyDataSet;

  if cdsGrid.FieldDefs.Count = 0 then
  begin
    For intCont := 0 To FDataSetOrigem.Fields.Count -1 Do
    Begin
      LField := cdsGrid.FieldDefs.AddFieldDef;
      LField.Name          := FDataSetOrigem.Fields[intCont].FieldName;
      LField.DataType      := FDataSetOrigem.Fields[intCont].DataType;
      LField.Size          := FDataSetOrigem.Fields[intCont].Size;
      LField.Required      := False;
    End;

    LField := cdsGrid.FieldDefs.AddFieldDef;
    LField.Name     := 'IPIENT';
    LField.DataType := ftFloat;
    LField.Required := False;

    cdsGrid.CreateDataSet;

    FormataCampos(FDataSetOrigem);
  end;

  cdsGrid.LogChanges := False;

  intRecno := FDataSetOrigem.RecNo;
  FDataSetOrigem.DisableControls;
  FDataSetOrigem.First;

  While (Not FDataSetOrigem.Eof) Do
  Begin
    cdsGrid.Append;

    For intCont := 0 To FDataSetOrigem.Fields.Count -1 Do
      cdsGrid.Fields[intCont].Value := FDataSetOrigem.Fields[intCont].Value;

    cdsGrid.Post;
    FDataSetOrigem.Next;
  End;
  FDataSetOrigem.RecNo := intRecno;
  FDataSetOrigem.EnableControls;
end;

procedure TfrmProdutoRessarcimentoIcmsStCAT.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrProduto : TConsultasArray;
begin
  inherited;
  if fPesqItem(
    conIteSimples,              //opcTipIte: TTipoConsultaItem;
    Self,                       //Self     : TForm;                         {* Formulário                                  *}
    edtCodIte,                  //edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
    edtDesIte,                  //edtDesIte: TCustomEdit;                   {* Edit da Descrição do item                   *}
    Nil,                        //qryTabela: TUniQuery;                     {* Query                                       *}
    Key,                        //Var chrKey: Char;                         {* Key                                         *}
    arrProduto,                 //Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
    True,                       //blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
    nil,                        //objFrmPnl: TPanelCx = Nil;                {* Painel                                      *}
    'Consulta de Itens',        //strTitulo: string = 'Consulta de Itens';
    '1',                        //strTabPre: String = '1';
    '',                         //strConPag: String = '';
    0,                          //fltTaxVpr: Double = 0;
    False,                      //blnEmpFat: Boolean = False;
    False,                      //blnExiPar: Boolean = False;
    0,                          //intOpcAtivos: Integer = 0;
    cdrCodIte,                  //opcCodIte: TCodigoRetornoItem = cdrCodIte;
    '',                         //strAplica: String = '';
    False,                      //blnPedCom: Boolean = False;   {* Se é pedido de compra                        *}
    '',                         //strCodCli: String = '';
    '',                         //strCodVen: String = '';
    True,                       //blnMostrarPrecos: Boolean = True;
    False,                      //blnTablet: Boolean = False;
    True,                       //blnConsiderarExiLis: Boolean = True;
    '',                         //strCodCmp: String = ''; // Codigo do Comprador
    False,                      //blnDepMatPriIndustrial: Boolean = False;
    False,                      //blnDepProAcaIndustrial: Boolean = False;
    False,                      //blnDepProEmbIndustrial: Boolean = False;
    False,                      //blnDepProGraIndustrial: Boolean = False;
    False,                      //blnVeioF11: Boolean = False;
    False,                      //blnSomenteAgrotoxico: Boolean = False;
    False,                      //blnMostrarItensDeServico: Boolean = False;
    False,                      //blnExibeColunaSaldoCD: Boolean = False;
    '',                         //strEmp_CD: String = '';
    -1,                         //fltDescFidelidade: Double = -1;
    False,                      //blnFaturamento: Boolean = False;
    '',                         //strCodFab: String = '';
    True,                       //blnMostraSaldo: Boolean = True;
    '',                         //strFiltros: string = '';
    '',                         //strCodEmp: String = '';
    '',                         //strEmpSaldoMatrizCD: String = '';
    '',                         //strDescri: String = '';
    '',                         //strCodBar: String = '';
    '',                         //strProdutoLocalizar: String = '';
    True,                       //blnConfirma: Boolean = True;
    False,                      //blnConEquEnt: Boolean = False;
    False,                      //blnSomenteEstrutura: Boolean = False;
    Nil,                        //objPnlBanner: TPanelCx = Nil;
    Nil,                        //objPnlPreFiltro: TPanelCx = Nil;
    '',                         //strCodCnd: String = '';
    '',                         //strNumOrc: String = '';
    '',                         //strEspOrc: String = '';
    FCodAbreviacao              //strCodAbf: String = ''
    ) then
  begin
    fValidaCampos(edtCodIte, True);
  end;
end;

procedure TfrmProdutoRessarcimentoIcmsStCAT.FormataCampos(DataSet: TUniClientDataSet);
var
  LFieldOrigem: TField;
  LFieldDestino : TField;
begin
  for LFieldOrigem in DataSet.Fields do
  begin
    LFieldDestino := cdsGrid.FieldByName(LFieldOrigem.FieldName);
    if not Assigned(LFieldDestino) then
      Continue;

    LFieldDestino.Alignment := LFieldOrigem.Alignment;
    if LFieldOrigem is TFloatField then
      TFloatField(LFieldDestino).DisplayFormat := TFloatField(LFieldOrigem).DisplayFormat;
  end;

  TFloatField(cdsGrid.FieldByName('IPIENT')).DisplayFormat := '#,##0.00';
end;

procedure TfrmProdutoRessarcimentoIcmsStCAT.FormCreate(Sender: TObject);
begin
  inherited;
  cdsGrid := TUniClientDataSet.Create(Nil);
  dtsGrid := TDataSource.Create(Nil);
  dtsGrid.DataSet := cdsGrid;
end;

procedure TfrmProdutoRessarcimentoIcmsStCAT.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsGrid);
  FreeAndNil(cdsGrid);
end;

procedure TfrmProdutoRessarcimentoIcmsStCAT.FormShow(Sender: TObject);
begin
  pSetFocus(edtCodIte);
end;

function TfrmProdutoRessarcimentoIcmsStCAT.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LCodAbreviacao: String;
begin
  Result := True;

  if Sender = edtCodIte then
  begin
    if fEmptyStr(edtCodIte.Text) then
    begin
      Result := False;
      Exit;
    end;

    if fCfgSis('TIPABF') = '2' then
      LCodAbreviacao := fCampoTabela('ITE_CODABF', 'ITEGER', ['ITE_CODEMP', 'ITE_CODITE'], [VS_strCodEmp, edtCodIte.Text], False)
    else
      LCodAbreviacao := fCampoTabela('ITE_CODABF', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text], False);

    if LCodAbreviacao <> FCodAbreviacao then
    begin
      fMensagem('ATENÇÃO!', 'O Código da abreviação fiscal do produto deve ser ' + FCodAbreviacao + '!', ['&Ok']);
      Result := False;
      Exit;
    end;

    CarregaProduto();
  end;
end;

procedure TfrmProdutoRessarcimentoIcmsStCAT.SetData(DataSet: TUniClientDataSet);
begin
  FDataSetOrigem := DataSet;
end;

end.
