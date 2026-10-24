unit untCadPpgNexaBasesEmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBClient,
  cxButtonEdit, cxEditRepositoryItems, Uni, untPpgNexaBasesEmpresas, frxClass,
  frxExportCSVTestabilidade, UniClientDataSet,    untAutcomTintaFactory, untIDataSet,
  untPai,cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadPpgNexaBasesEmp = class(TfrmPai)
    pnlGeral: TPanel;
    btnGravar: TBitBtnLocked;
    dtsBasEmp: TDataSource;
    cxRepositorio: TcxEditRepository;
    btnProduto: TcxEditRepositoryButtonItem;
    cdsBasEmp: TUniClientDataSet;
    cdsBasEmpCODEMP: TStringField;
    cdsBasEmpNOMEMP: TStringField;
    cdsBasEmpCODITE: TStringField;
    cdsBasEmpDESITE: TStringField;
    cdsBasEmpCODBAS: TStringField;
    cdsBasEmpDESBAS: TStringField;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1CODBAS: TcxGridDBColumn;
    cxGrid1DBTableView1DESBAS: TcxGridDBColumn;
    cxGrid1DBTableView1CODEMP: TcxGridDBColumn;
    cxGrid1DBTableView1NOMEMP: TcxGridDBColumn;
    cxGrid1DBTableView1CODITE: TcxGridDBColumn;
    cxGrid1DBTableView1DESITE: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBTableView1EMBALA: TcxGridDBColumn;
    cxGrid1DBTableView1PESESP: TcxGridDBColumn;
    cdsBasEmpEMBALA: TFloatField;
    cdsBasEmpPESESP: TFloatField;
    procedure btnProdutoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnProdutoPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    PpgNexaBasEmp: TPpxBasEmp;

    function fCarregaItem(strCodIte, strCodEmp: String): String;
  public
    { Public declarations }
    strCodBas: String;
    strDesBas: String;
    strBasEpo: String;    
    fltEmbala: Double;
    fltPesEsp: Double;
  end;

var
  frmCadPpgNexaBasesEmp: TfrmCadPpgNexaBasesEmp;

implementation

uses untStrUtils;

{$R *.dfm}

procedure TfrmCadPpgNexaBasesEmp.btnGravarClick(Sender: TObject);
begin
  inherited;

  PpgNexaBasEmp.pGravaBasesEmp(cdsBasEmp);
end;

procedure TfrmCadPpgNexaBasesEmp.btnProdutoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  strSQL     : String;
  strSQLWhere: String;
  qryCadIte  : IDataSet;
  arrTitCol  : Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  inherited;

  qryCadIte := TAutcomTintaFactory.Get.fGetDataSet;

  strSQL := 'SELECT';
  strSQL := strSQL + '   ITE_DESITE, ';  pAddNomeColuna('Descrição');
  strSQL := strSQL + '   ITE_REFERE, ';  pAddNomeColuna('Referência');
  strSQL := strSQL + '   ITE_CODITE, ';  pAddNomeColuna('Código');
  strSQL := strSQL + '   ITE_CODBAR, ';  pAddNomeColuna('Cód. Barra');
  strSQL := strSQL + '   AUTOINCREM  ';
  strSQL := strSQL + ' FROM CADITE ';

  strSQLWhere := strSQLWhere + ' WHERE ITE_ITEATI = "S" ';
  strSQLWhere := strSQLWhere + '   AND ITE_ITEBAS = "S" ';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
    strSQLWhere := strSQLWhere + '  AND ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));

  strSQLWhere := strSQLWhere + '  AND ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

  If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM',
                                            'CADITE', 'untCadPpgNexaBasesEmp', 'Consulta Item - PPG\Nexa', qryCadIte, [], []) Then
  Begin
    cdsBasEmp.Edit;
    cdsBasEmpCODITE.AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;
    cdsBasEmpDESITE.AsString := qryCadIte.FieldByName('ITE_DESITE').AsString;
    cdsBasEmp.Post;
  End;

end;

procedure TfrmCadPpgNexaBasesEmp.btnProdutoPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  strDescri: String;
begin
  inherited;
  strDescri := '';

  If (Not TStrUtils.fEmptyStr(DisplayValue)) Then
    strDescri := fCarregaItem(DisplayValue, cdsBasEmpCODEMP.AsString);

  If TStrUtils.fEmptyStr(DisplayValue) Then
  Begin
    cdsBasEmp.Edit;
    cdsBasEmpCODITE.AsString := '';
    cdsBasEmpDESITE.AsString := '';
    cdsBasEmp.Post;
  End

  Else If TStrUtils.fEmptyStr(strDescri) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse item não está Cadastrado!', ['OK']);
    DisplayValue := '';
  End

  Else
  Begin
    cdsBasEmp.Edit;
    cdsBasEmpCODITE.AsString := DisplayValue;
    cdsBasEmpDESITE.AsString := strDescri;
    cdsBasEmp.Post;
  End;
end;

function TfrmCadPpgNexaBasesEmp.fCarregaItem(strCodIte, strCodEmp: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen     := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT I.ITE_DESITE ' +
                '   FROM CADITE I     ' +
                '   JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ' +
                '                AND G.ITE_CODEMP = :CODEMP      ' +
                '  WHERE I.ITE_CODITE = :CODITE ';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := strCodEmp;
  qryGen.Open;

  Result := qryGen.FieldbyName('ITE_DESITE').AsString;
end;

procedure TfrmCadPpgNexaBasesEmp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(PpgNexaBasEmp);

  inherited;
end;

procedure TfrmCadPpgNexaBasesEmp.FormCreate(Sender: TObject);
begin
  inherited;
  TAutcomTintaFactory.Get.pSetaCodIte(cdsBasEmpCODITE);
  cdsBasEmp.CreateDataSet;
end;

procedure TfrmCadPpgNexaBasesEmp.FormShow(Sender: TObject);
begin
  inherited;
  PpgNexaBasEmp := TPpxBasEmp.Create(Nil);
  PpgNexaBasEmp.strCodBas := strCodBas;
  PpgNexaBasEmp.strDesBas := strDesBas;
  PpgNexaBasEmp.strBasEpo := strBasEpo;
  PpgNexaBasEmp.fltEmbala := fltEmbala;
  PpgNexaBasEmp.fltPesEsp := fltPesEsp;
  PpgNexaBasEmp.pPreencheClientBases(cdsBasEmp);
end;

end.
