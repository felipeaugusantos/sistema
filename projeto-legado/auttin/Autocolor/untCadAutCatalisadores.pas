unit untCadAutCatalisadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Grids, DBGridCitel, DBGrids, StdCtrls, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB, Uni,
  BitBtnLockedIncrem;

type
  TfrmCadAutCatalisador = class(TfrmPaiCad)
    Panel1: TPanel;
    dbeSistemas: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeDiluente: TDBEditFocus;
    pnlCabecalho: TPanel;
    Label3: TLabel;
    dbeMin: TDBEditFocus;
    Label4: TLabel;
    dbeMax: TDBEditFocus;
    Label5: TLabel;
    dbeDescri: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeSistemasKeyPress(Sender: TObject; var Key: Char);
    procedure dbeDiluenteKeyPress(Sender: TObject; var Key: Char);
  private
    qryCadCat : TUniQuery;
    dtsCadCat : TDataSource;
    { Private declarations }
  public
    function fCriarQuery(strTabela: String; AOwner: TComponent): TUniQuery;
    procedure pCriaDataSets;
    procedure pInicializaIndices; override;
    procedure pConfiguraDbes;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaLinha(strLinha: String): Boolean;
    function fValidaBase(strBase: String): Boolean;
    { Public declarations }
  end;

var
  frmCadAutCatalisador: TfrmCadAutCatalisador;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmCadAutCatalisador.fCriarQuery(strTabela: String;
  AOwner: TComponent): TUniQuery;
  Var
    intCont : Integer;
begin
  {******************************************************************}
  {* CRIA UMA TUniQuery E DEIXA OS CAMPOS FIXOS, ISSO EVITA QUE       *}
  {* QUANDO SE USA O METODO CLOSE, PERCA AS PROPRIEDADES DOS CAMPOS *}
  {***************************************************************PH*}

  Result := fCriaQuery(AOwner);
  Result.SQL.Text := 'SELECT * FROM ' + strTabela + ' WHERE FALSE;';
  Result.Open;
  Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs[intCont].CreateField(Result);
  End;
end;

procedure TfrmCadAutCatalisador.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pConfiguraDbes;
  qryTabela := qryCadCat;
  strNomeTabela := 'AUT_CADCAT';
  strNomeCampo  := 'CAT_CODCAT';
end;

procedure TfrmCadAutCatalisador.pConfiguraDbes;
  Var
    intCont : Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
      TDBEdit(Components[intCont]).DataSource := dtsCadCat;
  End;

  dbeSistemas.DataField := 'CAT_CODSIS';
  dbeDiluente.DataField := 'CAT_CODCAT';
  dbeMin.DataField := 'CAT_PORMIN';
  dbeMax.DataField := 'CAT_PORMAX';
  dbeDescri.DataField := 'CAT_DESCRI';
end;

procedure TfrmCadAutCatalisador.pCriaDataSets;
begin
  qryCadCat := fCriarQuery('AUT_CADCAT', Self);
  qryCadCat.SQL.Text := 'SELECT * FROM AUT_CADCAT WHERE CAT_CODEMP = :CODEMP;';
  qryCadCat.ParamByName('CODEMP').AsString := VS_strCodEmp;
  dtsCadCat := fCriaDataSource(qryCadCat);

  qryCadCat.FieldByName('CAT_CODSIS').DisplayLabel := 'Linha';
  qryCadCat.FieldByName('CAT_CODCAT').DisplayLabel := 'Código';
  qryCadCat.FieldByName('CAT_PORMIN').DisplayLabel := 'Minimo';
  qryCadCat.FieldByName('CAT_PORMAX').DisplayLabel := 'Máximo';
  qryCadCat.FieldByName('CAT_DESCRI').DisplayLabel := 'Descrição';
  qryCadCat.FieldByName('CAT_PESPEC').DisplayLabel := 'P. Específico';
  qryCadCat.FieldByName('CAT_CODEMP').Visible := False;
  qryCadCat.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmCadAutCatalisador.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CAT_CODSIS');
  stlCampos.Add('CAT_CODCAT');
  stlCampos.Add('CAT_DESCRI');
  stlCampos.Add('CAT_PESPEC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CAT_CODSIS');
  stlCamInd.Add('CAT_CODCAT');
  stlCamInd.Add('CAT_DESCRI');
  stlCamInd.Add('CAT_PESPEC');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Linha');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadAutCatalisador.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeSistemas);
end;

procedure TfrmCadAutCatalisador.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtsCadCat);
  FreeAndNil(qryCadCat);
  inherited;
end;

function TfrmCadAutCatalisador.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeSistemas) Then
    Begin
      If Not fValidaLinha(dbeSistemas.Text) Then
      Begin
        fMensagem('', 'Linha Inválida!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDiluente) Then
    Begin
      If not fValidaBase(dbeDiluente.Text) Then
      Begin
        fMensagem('', 'Base Inválida', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeMin) Then
    Begin
      If (fEmptyStr(dbeMin.Text)) or (fStrToFloat(dbeMin.Text) <= 0) or (fStrToFloat(dbeMin.Text) > 100) Then
      Begin
        fMensagem('', 'Valor Mínimo Inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeMax) Then
    Begin
      If (fEmptyStr(dbeMax.Text)) or (fStrToFloat(dbeMax.Text) <= 0) or (fStrToFloat(dbeMax.Text) > 100) Then
      Begin
        fMensagem('', 'Valor Máximo Inválido!', ['OK']);
        Result := False;
      End;
    End;

  end;


  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadAutCatalisador.fValidaBase(strBase: String): Boolean;
  Var
    qryCadLin : TUniQuery;
begin
  qryCadLin := fCriaQuery;
  qryCadLin.SQL.Text := 'SELECT BAS_CODBAS FROM AUT_CADBAS WHERE BAS_CODBAS = "' + strBase + '"';
  qryCadLin.Open;
  Result := Not qryCadLin.IsEmpty;
  FreeAndNil(qryCadLin);
end;

function TfrmCadAutCatalisador.fValidaLinha(strLinha: String): Boolean;
  Var
    qryCadLin : TUniQuery;
begin
  qryCadLin := fCriaQuery;
  qryCadLin.SQL.Text := 'SELECT AUT_CODMAT FROM AUT_CADSIS WHERE AUT_CODMAT = "' + strLinha + '"';
  qryCadLin.Open;
  Result := Not qryCadLin.IsEmpty;
  FreeAndNil(qryCadLin);
end;

procedure TfrmCadAutCatalisador.dbeSistemasKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    strSQL: String;
    qryCadMat : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadMat := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	AUT_CODMAT AS "Linha", ';
    strSQL := strSQL + ' 	AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	AUT_CADSIS ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	AUT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
    strSQL := strSQL + ' GROUP BY AUT_CODMAT ';

    stlIndice.Add('Linha');

    stlDescricao.Add('Linha');
    utcRegistros.Limpar(Self.Name + 'AUT_CADSIS');

    If pConsultaComp(Self, qryCadMat, 'AUT_CADSIS', strSQL, stlIndice, stlDescricao) Then
    Begin
      dbeSistemas.Text := qryCadMat.FieldByName('AUT_CODMAT').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadMat);
  end;
end;

procedure TfrmCadAutCatalisador.dbeDiluenteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    strSQL: String;
    qryCadMat : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadMat := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	BAS_CODBAS AS "Base", ';
    strSQL := strSQL + ' 	BAS_DESBAS AS "Descrição", ';
    strSQL := strSQL + ' 	AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	AUT_CADBAS ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	BAS_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlIndice.Add('Base');

    stlDescricao.Add('Base');
    utcRegistros.Limpar(Self.Name + 'AUT_CADBAS');

    If pConsultaComp(Self, qryCadMat, 'AUT_CADBAS', strSQL, stlIndice, stlDescricao) Then
    Begin
      dbeDiluente.Text := qryCadMat.FieldByName('BAS_CODBAS').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadMat);
  end;
end;

end.

