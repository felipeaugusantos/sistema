unit untCadTintasBasesHydronorth;

interface

uses
  SysUtils, Classes, Controls, Forms, DB,
  untCadTintasBases, Mask, DBCtrls, 
  Uni,  AppEvnts, Menus, StdCtrls,
  EditFocus, DBEditFocus, Buttons, ComCtrls, BitBtnLockedIncrem, ExtCtrls, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesHydronorth = class(TfrmCadTintasBases)
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
  frmCadTintasBasesHydronorth: TfrmCadTintasBasesHydronorth;

implementation

uses untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadTintasBasesHydronorth }

procedure TfrmCadTintasBasesHydronorth.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  inherited;
end;

procedure TfrmCadTintasBasesHydronorth.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If fPesqEmbalagemUnidadeTinta(Self, conHyd, dbeCodUni, Nil, Nil, '', Nil, Key, arrSel) Then
  Begin
    pCarregaUnidade;
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadTintasBasesHydronorth.ValidaEmbalagemProduto: Boolean;
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
        '   HYD_CADEMB               ' +
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

function TfrmCadTintasBasesHydronorth.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmCadTintasBasesHydronorth.pCarregaUnidade;
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
        '   HYD_CADEMB                   ' +
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
