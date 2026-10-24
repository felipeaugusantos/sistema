unit untCadTintasBasesCalamar;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untCadTintasBases, Mask, DBCtrls, 
  Uni,  AppEvnts, Menus, StdCtrls, EditFocus, DBEditFocus, Buttons, ComCtrls, BitBtnLockedIncrem, ExtCtrls, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesCalamar = class(TfrmCadTintasBases)
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    function ValidaEmbalagemProduto: Boolean;
  protected
    procedure pCarregaUnidade; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadTintasBasesCalamar: TfrmCadTintasBasesCalamar;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadTintasBasesCalamar }

procedure TfrmCadTintasBasesCalamar.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  inherited;
end;

procedure TfrmCadTintasBasesCalamar.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If fPesqEmbalagemUnidadeTinta(Self, conCal, dbeCodUni, Nil, Nil, '', Nil, Key, arrSel) Then
  Begin
    pCarregaUnidade;
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadTintasBasesCalamar.ValidaEmbalagemProduto: Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   COUNT(0) AS QTD          ' +
        ' FROM                       ' +
        '   CAL_CADEMB               ' +
        ' WHERE EMB_CODEMB = :CODEMB ';

      qryGen.ParamByName('CODEMB').AsString := dbeCodUni.Text;
      qryGen.Open;
      Result := (qryGen.FieldByName('QTD').AsInteger > 0);
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

function TfrmCadTintasBasesCalamar.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if ((Sender = dbeCodUni) or (Sender = dbeDescricao)) then
    begin
      Result := ValidaEmbalagemProduto;
      if not Result then
      begin
        fMensagem('ATENÇÃO!', 'Não foi possível encontrar Embalagem, talvez seja necessário cadastra-la no cadastro de embalagens.',
          ['OK']);
      end;
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmCadTintasBasesCalamar.pCarregaUnidade;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                         ' +
        '   UNI_DESUNI                   ' +
        '   , UNI_SIGUNI                 ' +
        ' FROM                           ' +
        '   CAL_CADEMB                   ' +
        '   INNER JOIN CADUNI            ' +
        '     ON EMB_CODUNI = UNI_CODUNI ' +
        ' WHERE EMB_CODEMB = :CODEMB     ';
      qryGen.ParamByName('CODEMB').AsString := dbeCodUni.Text;
      qryGen.Open;

      edtDesUni.Text := qryGen.FieldByName('UNI_DESUNI').AsString;
      edtSigUni.Text := qryGen.FieldByName('UNI_SIGUNI').AsString;

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

end.
