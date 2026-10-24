unit untFatTrocaBase;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, EditFocus, Menus, ComCtrls,
  Buttons, ExtCtrls, AppEvnts, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatTrocaBase = class(TfrmPaiSimples)
    pnlDados: TPanel;
    edtCodIte: TEditFocus;
    pnlConfirma: TPanel;
    edtDesIte: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryConsulta01: TUniQuery;
    procedure pCarregaItem;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodEmp: String;
    strCodBas: String;
    strTabPre: String;
    fltCusBas: Double;
    fltVenBas: Double;
    strRefere: String;
    strDesBas: String;
    strUnidad: String;
    blnConfirma: Boolean;
  end;

var
  frmFatTrocaBase: TfrmFatTrocaBase;

implementation

uses  untFuncoesSimples;

{$R *.dfm}

{ TfrmFatTrocaBase }

function TfrmFatTrocaBase.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodIte) Then
    Begin

      If (fEmptyStr(edtCodIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do item deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaItem;
        If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (qryConsulta01.FieldByName('ITE_ITEBAS').AsString <> 'S') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não é uma Base!', ['&O k']);
          Result := False;
        End;

      End;

    End;
  End;

end;

procedure TfrmFatTrocaBase.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmFatTrocaBase.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  qryConsulta01 := fCriaQuery(Nil);
end;

procedure TfrmFatTrocaBase.pCarregaItem;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_REFERE, ';
  strSQL := strSQL + '  I.ITE_ITEBAS, ';
  strSQL := strSQL + '  I.ITE_CODUNI, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '  AND G.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  I.ITE_CODITE = :CODITE ';

  With qryConsulta01 Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := edtCodIte.Text;
    Open;

    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
    strDesBas      := FieldByName('ITE_DESITE').AsString;
    strRefere      := FieldByName('ITE_REFERE').AsString;
    strUnidad      := FieldByName('ITE_CODUNI').AsString;
    fltCusBas      := FieldByName('ITE_PRECUS').AsFloat;
    fltVenBas      := FieldByName('ITE_PREVE' + strTabPre).AsFloat;
  End;
end;

procedure TfrmFatTrocaBase.FormShow(Sender: TObject);
begin
  inherited;
  edtCodIte.Text := strCodBas;
  pCarregaItem;
end;

procedure TfrmFatTrocaBase.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;
    strSQL: String;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    stlCamIndIte := TStringList.Create;
    stlDesIndIte := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE AS "Codigo", ';
    strSQL := strSQL + '  I.ITE_DESITE AS "Descrição", ';
    strSQL := strSQL + '  I.ITE_REFERE AS "Referência", ';
    strSQL := strSQL + '  I.ITE_CODUNI AS "Unidade", ';
    strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS "Preço de Venda", ';
    strSQL := strSQL + '  M.MAR_DESMAR As "Marca", ';
    strSQL := strSQL + '  I.AUTOINCREM AS "AUTOINCREM" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADMAR M ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '  AND I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_ITEBAS = "S"          AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = ' + QuotedStr(strCodEmp) + ' ';

    stlCamIndIte.Add('I.ITE_DESITE');
    stlCamIndIte.Add('I.ITE_REFERE');
    stlCamIndIte.Add('I.ITE_CODITE');

    stlCamIndIte.Add('I.ITE_CODBAR');

    stlDesIndIte.Add('Descrição');
    stlDesIndIte.Add('Referência');
    stlDesIndIte.Add('Codigo');


{    If (pConsultaComp(Self, qryConsulta01, 'CADITE', strSQL, stlCamIndIte, stlDesIndIte)) Then
    Begin
      edtCodIte.Text := qryConsulta01.FieldByName('ITE_CODITE').AsString;
      If (fValidaCampos(edtCodIte, True)) Then
        SelectNext(ActiveControl, True, True);
    End;}

    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);

  End;
end;

procedure TfrmFatTrocaBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConsulta01);
end;

end.
