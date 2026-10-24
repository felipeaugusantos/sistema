unit untCadGerMon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, BitBtnLockedIncrem;

type
  TfrmCadGerMon = class(TfrmPaiCad)
    pnlCampos: TPanel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadMon: TUniQuery;
    dtsCadMon: TDataSource;
  protected
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadGerMon: TfrmCadGerMon;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmCadGerMon }

function TfrmCadGerMon.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If Sender = dbeCodigo Then
      Begin
        fMensagem('ATENÇÃO', 'O código deve ser preenchido!', ['OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadGerMon.pCriarDataSets;
begin
  qryCadMon := fCriarQuery('SELECT * FROM GEN_CADMON', Self);

  qryCadMon.FieldByName('MON_CODMON').DisplayLabel := 'Código';
  qryCadMon.FieldByName('MON_DESCRI').DisplayLabel := 'Descrição';
  qryCadMon.FieldByName('AUTOINCREM').Visible := False;
  qryCadMon.Open;

  dtsCadMon := fCriaDataSource(qryCadMon);
end;

procedure TfrmCadGerMon.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MON_CODMON');
  stlCampos.Add('MON_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MON_CODMON');
  stlCamInd.Add('MON_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadGerMon.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If Components[intCont] is TDBEdit Then
      TDBEdit(Components[intCont]).DataSource := dtsCadMon;
  End;

  dbeCodigo.DataField := 'MON_CODMON';
  dbeDescricao.DataField := 'MON_DESCRI';
end;

procedure TfrmCadGerMon.FormCreate(Sender: TObject);
begin
  inherited;

  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadMon;
  strNomeTabela := 'GEN_CADMON';
  strNomeCampo := 'MON_CODMON';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadGerMon.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
end;

procedure TfrmCadGerMon.btnPesquisaClick(Sender: TObject);
Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   AUTOINCREM, ';
  strSQL := strSQL + '   MON_CODMON    "Código", ';
  strSQL := strSQL + '   MON_DESCRI    "Descrição" ';
  strSQL := strSQL + ' FROM GEN_CADMON ';

  If pConsultaComp(Self, qryTabela, 'GEN_CADMON', strSQL, stlCamInd, stlDesInd, '', False) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

end.

