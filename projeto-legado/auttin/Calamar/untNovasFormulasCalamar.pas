unit untNovasFormulasCalamar;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untGenericNovasFormulas, DB, 
  
  StdCtrls, Mask, DBCtrls, DBEditFocus, Uni, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  UniClientDataSet, AppEvnts, Menus, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmNovasFormulasCalamar = class(TfrmGenericNovasFormulas)
    dbeKey1: TDBEditFocus;
    lblCorCod: TLabel;
    lblCodBas: TLabel;
    dbeKey2: TDBEditFocus;
    dbeKey3: TDBEditFocus;
    lblFanDeck: TLabel;
    lblEmbalagem: TLabel;
    dbeBase: TDBEditFocus;
    lblNota: TLabel;
    dbeEmbalagem: TDBEditFocus;
    Label55: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure dbeBaseKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private 
    { Private declarations }
    function ValidaBaseProdutoEmbalagem: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

var
  frmNovasFormulasCalamar: TfrmNovasFormulasCalamar;

implementation

uses
  untNovaFormulaCalamar, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmNovasFormulasCalamar }

procedure TfrmNovasFormulasCalamar.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('NFM_PRODUT').AsString := 'PERSONALIZADA';
  qryTabela.FieldByName('NFM_COLECA').AsString := 'PERSONALIZADA';
  inherited;
end;

procedure TfrmNovasFormulasCalamar.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeDtaCad.Field.AsDateTime := Date;
end;

constructor TfrmNovasFormulasCalamar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TNovaFormulaCalamar.Create);
end;

procedure TfrmNovasFormulasCalamar.dbeBaseKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    qryGen : TUniQuery;
begin
  qryGen :=  fCriaQuery(Self);
  Try
    If fPesqBaseTinta(Self, conCal, dbeBase, Nil, qryGen, Key, arrSel) Then
    Begin
      dbeEmbalagem.Field.AsString := qryGen.FieldByName('BAS_CODEMB').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmNovasFormulasCalamar.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if (Sender = dbeBase) then
    begin
      if fEmptyStr(dbeBase.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Código Base deve ser preenchido!', ['OK']);
      end
      else if not ValidaBaseProdutoEmbalagem then
      begin
        Result := False;
        fMensagem('ATENÇÃO', 'A combinação Base/Produto/Embalagem não está cadastrada!', ['OK']);
      end;
    end
    else if (Sender = dbeEmbalagem) then
    begin
      if fEmptyStr(dbeEmbalagem.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Embalagem deve ser preenchido!', ['OK']);
      end
      else if not ValidaBaseProdutoEmbalagem then
      begin
        Result := False;
        fMensagem('ATENÇÃO', 'A combinação Base/Produto/Embalagem não está cadastrada!', ['OK']);
      end;
    end;

  end;

  if not Result then
    pSetFocus(Sender);
end;

function TfrmNovasFormulasCalamar.ValidaBaseProdutoEmbalagem: Boolean;
var
  qryGen: TUniQuery;
begin
  Result := True;
  qryGen := nil;
  Try
    Try
      if (not fEmptyStr(dbeBase.Text))
        and (not fEmptyStr(dbeEmbalagem.Text)) then
      begin
        qryGen := fCriaQuery();
        qryGen.SQL.Text :=
          ' SELECT                         ' +
          '   COUNT(0) AS QTD              ' +
          ' FROM                           ' +
          '   CAL_CADBAS                   ' +
          '   INNER JOIN CAL_CADEMB        ' +
          '     ON BAS_CODEMB = EMB_CODEMB ' +
          '   INNER JOIN CADITE            ' +
          '     ON BAS_CODITE = ITE_CODITE ' +
          '   INNER JOIN CADUNI            ' +
          '     ON EMB_CODUNI = UNI_CODUNI ' +
          ' WHERE BAS_CODBAS = :CODBAS     ' +
          '   AND BAS_CODEMB = :CODEMB     ';
        qryGen.ParamByName('CODBAS').AsString := dbeBase.Text;
        qryGen.ParamByName('CODEMB').AsString := dbeEmbalagem.Text;
        qryGen.Open;
        Result := qryGen.FieldByName('QTD').AsInteger > 0;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

initialization
  RegisterClass(TfrmNovasFormulasCalamar);
finalization
  UnRegisterClass(TfrmNovasFormulasCalamar);

end.
