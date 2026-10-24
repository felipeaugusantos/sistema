unit untCadNexaBasesEmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBClient,
  cxButtonEdit, cxEditRepositoryItems, Uni, untNexaBasesEmpresas, frxClass,
  frxExportCSVTestabilidade, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadNexaBasesEmp = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnGravar: TBitBtnLocked;
    dtsBasEmp: TDataSource;
    cxGrid1DBTableView1CODEMP: TcxGridDBColumn;
    cxGrid1DBTableView1NOMEMP: TcxGridDBColumn;
    cxGrid1DBTableView1DESITE: TcxGridDBColumn;
    cxGrid1DBTableView1CODBAS: TcxGridDBColumn;
    cxGrid1DBTableView1DESBAS: TcxGridDBColumn;
    cxRepositorio: TcxEditRepository;
    btnProduto: TcxEditRepositoryButtonItem;
    cxGrid1DBTableView1CODITE: TcxGridDBColumn;
    cdsBasEmp: TUniClientDataSet;
    cdsBasEmpCODEMP: TStringField;
    cdsBasEmpNOMEMP: TStringField;
    cdsBasEmpCODITE: TStringField;
    cdsBasEmpDESITE: TStringField;
    cdsBasEmpCODBAS: TStringField;
    cdsBasEmpDESBAS: TStringField;
    procedure btnProdutoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProdutoPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    NexaBasEmp: TNexaBasEmp;

    function fCarregaItem(strCodIte, strCodEmp: String): String;
  public
    { Public declarations }
    strCodBas: String;
    strDesBas: String;
    strBasEpo: String;    
    fltEmbala,
    fltPesEsp: Double;
  end;

var
  frmCadNexaBasesEmp: TfrmCadNexaBasesEmp;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadNexaBasesEmp.btnGravarClick(Sender: TObject);
begin
  inherited;
  With NexaBasEmp Do
  Begin
//    If fProdutosPreenchidos(cdsBasEmp) Then
      pGravaBasesEmp(cdsBasEmp);
  End;
end;

procedure TfrmCadNexaBasesEmp.btnProdutoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    arrSel: TconsultasArray;
    qryCadIte: TUniQuery;
    Key: Char;
begin
  inherited;
  key := '/';
  qryCadIte    := fCriaQuery(Self);
  Try
    If fPesqItem(conIteSimples, Self, Nil, Nil, qryCadIte, Key, arrSel) Then
    Begin
      If  (fItemAtivo(qryCadIte.FieldByName('ITE_CODITE').AsString)) Then
      Begin
        cdsBasEmp.Edit;
        cdsBasEmpCODITE.AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;
        cdsBasEmpDESITE.AsString := fCarregaItem(qryCadIte.FieldByName('ITE_CODITE').AsString, cdsBasEmp.FieldByName('CODEMP').AsString);
        cdsBasEmp.Post;
      End
      Else
      Begin
        fMensagem('ATENÇÃO', 'Esse item não está ativo!', ['OK']);
        cdsBasEmp.Edit;
        cdsBasEmpCODITE.AsString := '';
        cdsBasEmpDESITE.AsString := '';
        cdsBasEmp.Post;
      End;
    End;

  Finally
    FreeAndNil(qryCadIte);
  End;
end;

procedure TfrmCadNexaBasesEmp.btnProdutoPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  strDescri: String;
begin
  inherited;
  strDescri := '';
  If (Not fEmptyStr(DisplayValue)) Then
    strDescri := fCarregaItem(DisplayValue, cdsBasEmpCODEMP.AsString);

  If fEmptyStr(DisplayValue) Then
  Begin
    cdsBasEmp.Edit;
    cdsBasEmpCODITE.AsString := '';
    cdsBasEmpDESITE.AsString := '';
    cdsBasEmp.Post;
  End

  Else If Not (fItemAtivo(DisplayValue)) Then
  Begin
    fMensagem('ATENÇÃO', 'Esse item não está ativo!', ['OK']);
    DisplayValue := '';
  End

  Else If fEmptyStr(strDescri) Then
  Begin
    fMensagem('ATENÇÃO', 'Esse item não está Cadastrado!', ['OK']);
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

function TfrmCadNexaBasesEmp.fCarregaItem(strCodIte, strCodEmp: String): String;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Self);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := ' SELECT I.ITE_DESITE ' +
                  '   FROM CADITE I     ' +
                  '   JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ' +
                  '                AND G.ITE_CODEMP = :CODEMP      ' +
                  '  WHERE I.ITE_CODITE = :CODITE ';
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := FieldbyName('ITE_DESITE').AsString;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadNexaBasesEmp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(NexaBasEmp);  
  inherited;
end;

procedure TfrmCadNexaBasesEmp.FormCreate(Sender: TObject);
begin
  inherited;
  cdsBasEmp.CreateDataSet;
end;

procedure TfrmCadNexaBasesEmp.FormShow(Sender: TObject);
begin
  inherited;
  NexaBasEmp := TNexaBasEmp.Create(Nil);
  NexaBasEmp.strCodBas := strCodBas;
  NexaBasEmp.strDesBas := strDesBas;
  NexaBasEmp.strBasEpo := strBasEpo;
  NexaBasEmp.fltEmbala := fltEmbala;
  NexaBasEmp.fltPesEsp := fltPesEsp;
  NexaBasEmp.pPreencheClientBases(cdsBasEmp);
end;

end.
