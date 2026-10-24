unit untCadTintasBasesAlessi;

interface

uses
  SysUtils, Classes, Controls, Forms, DB,
  untCadTintasBases, Mask, DBCtrls, 
  Uni, AppEvnts, Menus, StdCtrls,
  EditFocus, DBEditFocus, Buttons, ComCtrls, BitBtnLockedIncrem, ExtCtrls, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesAlessi = class(TfrmCadTintasBases)
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
  frmCadTintasBasesAlessi: TfrmCadTintasBasesAlessi;

implementation

uses untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadTintasBasesAlessi }

procedure TfrmCadTintasBasesAlessi.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  inherited;
end;

procedure TfrmCadTintasBasesAlessi.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
  qryCadUni: TUniQuery;
  arrSel: TConsultasArray;

begin
  if dbeCodUni.ReadOnly then
    Exit;

  if not (qryTabela.State in [dsEdit, dsInsert]) then
    Exit;

  qryCadUni := fCriaQuery;
  Try
    If fPesqEmbalagemUnidadeTinta(Self, conAle, Nil, Nil, Nil, '', qryCadUni, key, arrSel) Then
    Begin
      dbeCodUni.Text := qryCadUni.FieldByName('EMB_CODUNI').AsString;
      pCarregaUnidade;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryCadUni);
  End;
end;

function TfrmCadTintasBasesAlessi.ValidaEmbalagemProduto: Boolean;
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
        '   ALE_CADEMB               ' +
        ' WHERE EMB_CODUNI = :CODEMB ';

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

function TfrmCadTintasBasesAlessi.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmCadTintasBasesAlessi.pCarregaUnidade;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT UNI_CODUNI                             ' +
        '      , UNI_DESUNI                             ' +
        '      , UNI_SIGUNI                             ' +
        '      , EMB_NOME__                             ' +
        '   FROM ALE_CADEMB                             ' +
        '  INNER JOIN CADUNI ON EMB_CODUNI = UNI_CODUNI ' +
        '  WHERE EMB_CODUNI = :CODEMB                   ';
      qryGen.ParamByName('CODEMB').AsString := dbeCodUni.Text;
      qryGen.Open;

      dbeCodUni.Text := qryGen.FieldByName('UNI_CODUNI').AsString;
      edtDesUni.Text := qryGen.FieldByName('UNI_DESUNI').AsString;
      edtSigUni.Text := qryGen.FieldByName('UNI_SIGUNI').AsString;
      dbeEmbala.Text := qryGen.FieldByName('EMB_NOME__').AsString;

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
