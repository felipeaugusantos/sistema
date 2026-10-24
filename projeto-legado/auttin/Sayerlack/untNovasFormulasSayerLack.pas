unit untNovasFormulasSayerLack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untGenericNovasFormulas, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, UniClientDataSet,
  AppEvnts, Menus, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  StdCtrls, Mask, DBCtrls, DBEditFocus, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Uni,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmNovasFormulasSayerLack = class(TfrmGenericNovasFormulas)
    lblCodigoBase: TLabel;
    dbeCodigoBase: TDBEditFocus;
    lblBase: TLabel;
    dbeBase: TDBEditFocus;
    lblProduto: TLabel;
    dbeProduto: TDBEditFocus;
    lblEmbalagem: TLabel;
    dbeEmbalagem: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    Label1: TLabel;
    Panel1: TPanel;
    dbeDtaCad: TDBEditFocus;
    Label55: TLabel;
    procedure dbeCodigoBaseKeyPress(Sender: TObject; var Key: Char);
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
  frmNovasFormulasSayerLack: TfrmNovasFormulasSayerLack;

implementation

uses
  untNovaFormulaSayerLack, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmNovasFormulasSayerLack.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeDtaCad.Field.AsDateTime := Date;
end;

constructor TfrmNovasFormulasSayerLack.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TNovaFormulaSayerLack.Create);  
end;

procedure TfrmNovasFormulasSayerLack.dbeCodigoBaseKeyPress(Sender: TObject; var Key: Char);
  var
    qryGen : TUniQuery;
    arrSel: TConsultasArray;
begin
  qryGen := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conSay, Nil, Nil, qryGen, Key, arrSel) Then
    Begin
      dbeProduto.Field.AsString := qryGen.FieldByName('BAS_PRODUT').AsString;
      dbeEmbalagem.Field.AsString := qryGen.FieldByName('BAS_DESEMB').AsString;
      dbeCodigoBase.Field.AsString := qryGen.FieldByName('BAS_CODBAS').AsString;
      dbeBase.Field.AsString :=qryGen.FieldByName('BAS_BASE__').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmNovasFormulasSayerLack.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if (Sender = dbeCodigoBase) then
    begin
      if fEmptyStr(dbeCodigoBase.Text) then
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
    else if (Sender = dbeBase) then
    begin
      if fEmptyStr(dbeBase.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Base deve ser preenchido!', ['OK']);
      end
      else if not ValidaBaseProdutoEmbalagem then
      begin
        Result := False;
        fMensagem('ATENÇÃO', 'A combinação Base/Produto/Embalagem não está cadastrada!', ['OK']);
      end;

    end
    else if (Sender = dbeProduto) then
    begin
      if fEmptyStr(dbeProduto.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo Produto deve ser preenchido!', ['OK']);
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

function TfrmNovasFormulasSayerLack.ValidaBaseProdutoEmbalagem: Boolean;
var
  qryGen: TUniQuery;
begin
  Result := True;
  qryGen := nil;
  Try
    Try
      if (not fEmptyStr(dbeCodigoBase.Text))
        and (not fEmptyStr(dbeProduto.Text))
        and (not fEmptyStr(dbeEmbalagem.Text)) then
      begin
        qryGen := fCriaQuery();
        qryGen.SQL.Text :=
          ' SELECT                                   ' +
          '   COUNT(0) AS QTD                        ' +
          ' FROM                                     ' +
          '   SAY_CADBAS                             ' +
          '   INNER JOIN SAY_CADEMB                  ' +
          '     ON BAS_DESEMB = EMB_DESEMB           ' +
          ' WHERE BAS_CODBAS = :CODBAS               ' +
          '   AND BAS_PRODUT = :PRODUT               ' +
          '   AND BAS_DESEMB = :DESEMB               ';
        qryGen.ParamByName('CODBAS').AsString := dbeCodigoBase.Text;
        qryGen.ParamByName('PRODUT').AsString := dbeProduto.Text;
        qryGen.ParamByName('DESEMB').AsString := dbeEmbalagem.Text;
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
  RegisterClass(TfrmNovasFormulasSayerLack);
  
finalization
  UnRegisterClass(TfrmNovasFormulasSayerLack);

end.
