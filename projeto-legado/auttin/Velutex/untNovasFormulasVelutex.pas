unit untNovasFormulasVelutex;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untGenericNovasFormulas, DB, 
  
  StdCtrls, Mask, DBCtrls, DBEditFocus, Uni, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  UniClientDataSet, AppEvnts, Menus, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmNovasFormulasVelutex = class(TfrmGenericNovasFormulas)
    dbeCorCod: TDBEditFocus;
    lblCorCod: TLabel;
    lblCodBas: TLabel;
    dbeCodBas: TDBEditFocus;
    lblFanDeck: TLabel;
    lblProduto: TLabel;
    lblEmbalagem: TLabel;
    lblNota: TLabel;
    Panel1: TPanel;
    dbeColecao: TDBEditFocus;
    dbeNota: TDBEditFocus;
    dbeUnidade: TDBEditFocus;
    dbeCodNome: TDBEditFocus;
    dbeProduto: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    Label55: TLabel;
    procedure dbeProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeColecaoExit(Sender: TObject);
    procedure dbeCodNomeExit(Sender: TObject);
  private 
    { Private declarations }
    function fRetMenorUnidade : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

var
  frmNovasFormulasVelutex: TfrmNovasFormulasVelutex;

implementation

uses
  untNovaFormulaVelutex, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmNovasFormulasVelutex }


procedure TfrmNovasFormulasVelutex.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeUnidade.Text := 'LT';
  dbeDtaCad.Field.AsDateTime := Date;
end;

constructor TfrmNovasFormulasVelutex.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TNovaFormulaVelutex.Create);
end;

procedure TfrmNovasFormulasVelutex.dbeCodNomeExit(Sender: TObject);
begin
//  inherited;
  pSetFocus(dbgComponentes);
end;

procedure TfrmNovasFormulasVelutex.dbeColecaoExit(Sender: TObject);
begin
//  inherited;
  pSetFocus(dbeProduto);
end;

procedure TfrmNovasFormulasVelutex.dbeProdutoKeyPress(Sender: TObject; var Key: Char);
var
  qryGen : TUniQuery;
  arrSel: TConsultasArray;
begin
  qryGen := fCriaQuery;
  Try
    Try
      If fPesqBaseTinta(Self, conVel, dbeCodBas, dbeProduto, qryGen, Key, arrSel, true, '') Then
      Begin
        dbeCodBas.Field.AsString  := qryGen.FieldByName('BAS_CODBAS').AsString;
        dbeProduto.Field.AsString := qryGen.FieldByName('BAS_PRODUT').AsString;
        dbeUnidade.Field.AsString := fRetMenorUnidade;
        SelectNext(ActiveControl, True, True);
      End;
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO', Format('%s: %s', [E.ClassName, E.Message]), ['&Ok']);
      end;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmNovasFormulasVelutex.fRetMenorUnidade: String;
Var
  qryGen  : TUniQuery;
begin
  Result := '';

  Try
    qryGen := fCriaQuery;
    qryGen.SQL.Text := 'SELECT BAS_CODUNI '+
                       '  FROM  VEL_CADBAS '+
                       ' WHERE BAS_CODBAS = :CODBAS '+
                       '   AND BAS_PRODUT = :PRODUT '+
                       '   AND ((BAS_CODITE IS NOT NULL) AND  (BAS_CODITE <> "")) ';

    qryGen.ParamByName('CODBAS').AsString := dbeCodBas.Text;
    qryGen.ParamByName('PRODUT').AsString := dbeProduto.Text;
    qryGen.Open;

    If qryGen.Locate('BAS_CODUNI', 'LT', []) Then
      Result := 'LT'
    else
    If qryGen.Locate('BAS_CODUNI', 'GL', []) Then
      Result := 'GL'
    else
    If qryGen.Locate('BAS_CODUNI', 'LA', []) Then
      Result := 'LA';


  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmNovasFormulasVelutex.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if (Sender = dbeCorCod) then
    begin
      if fEmptyStr(dbeCorCod.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Color Code deve ser preenchido!', ['OK']);
      end;
    end
    else if (Sender = dbeCodBas) then
    begin
      if fEmptyStr(dbeCodBas.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Código Base deve ser preenchido!', ['OK']);
      end;

    end
    else if (Sender = dbeColecao) then
    begin
      if fEmptyStr(dbeColecao.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Coleção deve ser preenchido!', ['OK']);
      end;
    end
    else if (Sender = dbeProduto) then
    begin
      if fEmptyStr(dbeProduto.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Produto deve ser preenchido!', ['OK']);
      end
    end
    else if (Sender = dbeUnidade) then
    begin
      if fEmptyStr(dbeUnidade.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Unidade deve ser preenchido!', ['OK']);
      end
    end
    else if (Sender = dbeCodNome) then
    begin
      if fEmptyStr(dbeCodNome.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Cód.Nome deve ser preenchido!', ['OK']);
      end
    end;

  end;

  if not Result then
    pSetFocus(Sender);
end;


initialization
  RegisterClass(TfrmNovasFormulasVelutex);
finalization
  UnRegisterClass(TfrmNovasFormulasVelutex);

end.
