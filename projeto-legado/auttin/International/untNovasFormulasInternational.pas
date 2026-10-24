unit untNovasFormulasInternational;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untGenericNovasFormulas, DB, 
  
  StdCtrls, Mask, DBCtrls, DBEditFocus, Uni, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  UniClientDataSet, AppEvnts, Menus, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmNovasFormulasInternational = class(TfrmGenericNovasFormulas)
    dbeCor: TDBEditFocus;
    lblFanDeck: TLabel;
    lblEmbalagem: TLabel;
    dbeBase: TDBEditFocus;
    lblNota: TLabel;
    dbeEmbalagem: TDBEditFocus;
    dbeLinha: TDBEditFocus;
    lblLinha: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label55: TLabel;
    procedure dbeBaseKeyPress(Sender: TObject; var Key: Char);
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
  frmNovasFormulasInternational: TfrmNovasFormulasInternational;

implementation

uses
  untNovaFormulaInternational, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmNovasFormulasInternational }

procedure TfrmNovasFormulasInternational.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeDtaCad.Field.AsDateTime := Date;
end;

constructor TfrmNovasFormulasInternational.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TNovaFormulaInternational.Create);
end;

procedure TfrmNovasFormulasInternational.dbeBaseKeyPress(Sender: TObject; var Key: Char);
  var
    qryGen : TUniQuery;
    arrSel: TConsultasArray;

begin
  qryGen := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conint, dbeBase, Nil, qryGen, Key, ArrSel) Then
    Begin
      dbeEmbalagem.Field.AsString := qryGen.FieldByName('BAS_CODEMB').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmNovasFormulasInternational.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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
        fMensagem('ATENÇÃO', 'A combinação Base/Embalagem não está cadastrada!', ['OK']);
      end;
    end
    else if (Sender = dbeCor) then
    begin
      if fEmptyStr(dbeCor.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Cor deve ser preenchido!', ['OK']);
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
        fMensagem('ATENÇÃO', 'A combinação Base/Embalagem não está cadastrada!', ['OK']);
      end;
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

function TfrmNovasFormulasInternational.ValidaBaseProdutoEmbalagem: Boolean;
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
          '   INT_CADBAS                   ' +
          '   INNER JOIN INT_CADEMB        ' +
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
  RegisterClass(TfrmNovasFormulasInternational);
finalization
  UnRegisterClass(TfrmNovasFormulasInternational);

end.
