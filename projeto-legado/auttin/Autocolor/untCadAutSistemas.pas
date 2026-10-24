unit untCadAutSistemas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Grids, DBGridCitel, DBGrids, StdCtrls, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB, Uni,
  BitBtnLockedIncrem;

type
  TfrmCadAutSistemas = class(TfrmPaiCad)
    Panel1: TPanel;
    dbeSistemas: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeLinhas: TDBEditFocus;
    pnlCabecalho: TPanel;
    Label3: TLabel;
    dbeTipo: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    qryCadSis : TUniQuery;
    dtsCadSis : TDataSource;
    { Private declarations }
  public
    function fCriarQuery(strTabela: String; AOwner: TComponent): TUniQuery;
    procedure pCriaDataSets;
    procedure pInicializaIndices; override;
    procedure pConfiguraDbes;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmCadAutSistemas: TfrmCadAutSistemas;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmCadAutSistemas.fCriarQuery(strTabela: String;
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

procedure TfrmCadAutSistemas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pConfiguraDbes;
  qryTabela := qryCadSis;
  strNomeTabela := 'AUT_CADSIS';
  strNomeCampo  := 'AUT_CODSIS';
end;

procedure TfrmCadAutSistemas.pConfiguraDbes;
  Var
    intCont : Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
      TDBEdit(Components[intCont]).DataSource := dtsCadSis;
  End;

  dbeSistemas.DataField := 'AUT_CODSIS';
  dbeLinhas.DataField := 'AUT_CODMAT';
  dbeTipo.DataField := 'AUT_TIPO__';
end;

procedure TfrmCadAutSistemas.pCriaDataSets;
begin
  qryCadSis := fCriarQuery('AUT_CADSIS', Self);
  qryCadSis.SQL.Text := 'SELECT * FROM AUT_CADSIS WHERE AUT_CODEMP = :CODEMP;';
  qryCadSis.ParamByName('CODEMP').AsString := VS_strCodEmp;
  dtsCadSis := fCriaDataSource(qryCadSis);

  qryCadSis.FieldByName('AUT_CODSIS').DisplayLabel := 'Sistema';
  qryCadSis.FieldByName('AUT_CODMAT').DisplayLabel := 'Material';
  qryCadSis.FieldByName('AUT_TIPO__').DisplayLabel := 'Tipo';
  qryCadSis.FieldByName('AUT_CODEMP').Visible := False;
  qryCadSis.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmCadAutSistemas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUT_CODSIS');
  stlCampos.Add('AUT_CODMAT');
  stlCampos.Add('AUT_TIPO__');
  stlCampos.Add('AUT_CODEMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('AUT_CODSIS');
  stlCamInd.Add('AUT_CODMAT');
  stlCamInd.Add('AUT_TIPO__');
  stlCamInd.Add('AUT_CODEMP');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Linha');
end;

procedure TfrmCadAutSistemas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeSistemas);
end;

procedure TfrmCadAutSistemas.btnGravarClick(Sender: TObject);
begin
  inherited;
  //
end;

function TfrmCadAutSistemas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeSistemas) Then
    Begin
      If fEmptyStr(dbeSistemas.Text) Then
      Begin
        fMensagem('', 'Entre com um sistema!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeLinhas) Then
    Begin
      If (fEmptyStr(dbeLinhas.Text)) Then
      Begin
        fMensagem('', 'Entre com um material!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeTipo) and (fEmptyStr(dbeTipo.Text)) Then
    Begin
      fMensagem('', 'Entre com um tipo!', ['OK']);
      Result := False;
    End;


  end;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

