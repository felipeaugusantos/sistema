unit untCadTintasBasesInternational;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untCadTintasBases, Mask, DBCtrls, 
  Uni,  AppEvnts, Menus, StdCtrls, EditFocus, DBEditFocus, Buttons, ComCtrls, BitBtnLockedIncrem, ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Variants;

type
  TfrmCadTintasBasesInternational = class(TfrmCadTintasBases)
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
  frmCadTintasBasesInternational: TfrmCadTintasBasesInternational;

implementation
uses  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadTintasBasesInternational }

procedure TfrmCadTintasBasesInternational.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  inherited;
end;

procedure TfrmCadTintasBasesInternational.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If fPesqEmbalagemUnidadeTinta(Self, conInt, dbeCodUni, Nil, Nil, '', Nil, Key, arrSel) Then
  Begin
    pCarregaUnidade;
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadTintasBasesInternational.ValidaEmbalagemProduto: Boolean;
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
        '   INT_CADEMB               ' +
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

function TfrmCadTintasBasesInternational.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
//  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

//  if Result then
//  begin
  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
    If fEmptyStr(dbeCodigo.Text) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O código da fórmula deve ser preenchido!', ['OK']);
    End;
  End

  Else if ((Sender = dbeCodUni) or (Sender = dbeDescricao)) then
  Begin
    Result := ValidaEmbalagemProduto;
    if not Result then
    begin
      fMensagem('ATENÇÃO!', 'Não foi possível encontrar Embalagem, talvez seja necessário cadastra-la no cadastro de embalagens.',
        ['OK']);
    end;
  End

  Else If (Sender = dbeItemBase) Then
  Begin
    If Not fEmptyStr(dbeItemBase.Text) Then
    Begin
      If Not fProdutoCadastrado(dbeItemBase.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O produto ' + dbeItemBase.Text + ' não está cadastrado!', ['OK']);
      End
    End
    Else If fEmptyStr(dbeItemBase.Text) Then
      dbeItemBase.Field.Value := Null;
  End;
//  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmCadTintasBasesInternational.pCarregaUnidade;
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
        '   INT_CADEMB                   ' +
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
