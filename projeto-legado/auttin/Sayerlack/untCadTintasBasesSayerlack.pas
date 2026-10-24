unit untCadTintasBasesSayerlack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintasBases, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  DBCtrls, DBEditFocus, Buttons, ComCtrls, BitBtnLockedIncrem,
  ExtCtrls, Uni, DB, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesSayerlack = class(TfrmCadTintasBases)
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    function ValidaEmbalagemProduto: Boolean;
  protected
    procedure pCarregaUnidade; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadTintasBasesSayerlack: TfrmCadTintasBasesSayerlack;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadTintasBasesSayerlack }

procedure TfrmCadTintasBasesSayerlack.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;

  inherited;
end;

procedure TfrmCadTintasBasesSayerlack.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If fPesqEmbalagemUnidadeTinta(Self, conSay, dbeCodUni, Nil, Nil, '', Nil, Key, arrSel) Then
  Begin
    pCarregaUnidade;
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadTintasBasesSayerlack.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if ((Sender = dbeCodUni) or (Sender = dbeDescricao))
      and ((not fEmptyStr(dbeCodUni.Text)) and (not fEmptyStr(dbeDescricao.Text))) then
    begin
      Result := ValidaEmbalagemProduto;
      if not Result then
      begin
        fMensagem('ATENÇÃO!', 'Não foi possível encontrar essa combinação Embalagem/Produto, talvez seja necessário cadastra-la no cadastro de embalagens.',
          ['OK']);
      end;
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmCadTintasBasesSayerlack.pCarregaUnidade;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
         ' SELECT                           ' +
         '   UNI_DESUNI                     ' +
         '   , UNI_SIGUNI                   ' +
         ' FROM                             ' +
         '   SAY_CADEMB                     ' +
         '   INNER JOIN CADUNI              ' +
         '     ON EMB_CODUNI = UNI_CODUNI   ' +
         ' WHERE EMB_DESEMB = :DESEMB       ';
      qryGen.ParamByName('DESEMB').AsString := dbeCodUni.Text;
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

function TfrmCadTintasBasesSayerlack.ValidaEmbalagemProduto: Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                       ' +
        '   COUNT(0) AS QTD            ' +
        ' FROM                         ' +
        '   SAY_CADEMB                 ' +
        ' WHERE EMB_DESEMB = :DESEMB   ';

      qryGen.ParamByName('DESEMB').AsString := dbeCodUni.Text;
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

end.
