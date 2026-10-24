unit untCadMzaMon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMzaMon = class(TfrmPaiCad)
    pnlCampos: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmCadMzaMon: TfrmCadMzaMon;

implementation

uses untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadMzaMon }

function TfrmCadMzaMon.fValidaCampos(Sender: TWinControl;
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

procedure TfrmCadMzaMon.pCriarDataSets;
begin
  qryCadMon := fCriarQuery('SELECT * FROM MZA_CADMON', Self);

  qryCadMon.FieldByName('MON_CODMON').DisplayLabel := 'Código';
  qryCadMon.FieldByName('MON_DESCRI').DisplayLabel := 'Descrição';
  qryCadMon.FieldByName('AUTOINCREM').Visible := False;
  qryCadMon.Open;

  dtsCadMon := fCriaDataSource(qryCadMon);
end;

procedure TfrmCadMzaMon.pInicializaIndices;
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

procedure TfrmCadMzaMon.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If Components[intCont] is TDBEdit Then
      TDBEdit(Components[intCont]).DataSource := dtsCadMon;
  End;

  dbeCodigo.DataField    := 'MON_CODMON';
  dbeDescricao.DataField := 'MON_DESCRI';
end;

procedure TfrmCadMzaMon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadMon);
end;

procedure TfrmCadMzaMon.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela     := qryCadMon;
  strNomeTabela := 'MZA_CADMON';
  strNomeCampo  := 'MON_CODMON';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadMzaMon.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqMontadoraTinta(Self, conMza, nil, nil, qrytabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

end.

