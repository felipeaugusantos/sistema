unit untCadBrazilianColorMontadora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadBrazilianColorMontadora = class(TfrmPaiCad)
    pnlCampos: TPanel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    lblSigla: TLabel;
    dbeSigla: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
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
  frmCadBrazilianColorMontadora: TfrmCadBrazilianColorMontadora;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadBrazilianColorMontadora }

function TfrmCadBrazilianColorMontadora.fValidaCampos(Sender: TWinControl;
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
      End;
    End
    Else If Sender = dbeCodigo Then
    Begin
      if fEmptyStr(dbeCodigo.Text) then
      begin
        fMensagem('ATENÇÃO', 'O código deve ser preenchido!', ['OK']);
        Result := False;
      end;
    End
    Else If Sender = dbeSigla Then
    Begin
      if fEmptyStr(dbeSigla.Text) then
      begin
        fMensagem('ATENÇÃO', 'A sigla deve ser preenchido!', ['OK']);
        Result := False;
      end;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadBrazilianColorMontadora.pCriarDataSets;
begin
  qryCadMon := fCriarQuery('SELECT * FROM BZC_CADMON', Self);

  qryCadMon.FieldByName('MON_CODMON').DisplayLabel := 'Código';
  qryCadMon.FieldByName('MON_DESCRI').DisplayLabel := 'Descrição';
  qryCadMon.FieldByName('MON_SIGLA_').DisplayLabel := 'Sigla';
  qryCadMon.FieldByName('AUTOINCREM').Visible := False;
  qryCadMon.Open;

  dtsCadMon := fCriaDataSource(qryCadMon);
end;

procedure TfrmCadBrazilianColorMontadora.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MON_CODMON');
  stlCampos.Add('MON_DESCRI');
  stlCampos.Add('MON_SIGLA_');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MON_CODMON');
  stlCamInd.Add('MON_DESCRI');
  stlCamInd.Add('MON_SIGLA_');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Sigla');
end;

procedure TfrmCadBrazilianColorMontadora.pLigarDataSets;
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
  dbeSigla.DataField := 'MON_SIGLA_';
end;

procedure TfrmCadBrazilianColorMontadora.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadMon);
end;

procedure TfrmCadBrazilianColorMontadora.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela     := qryCadMon;
  strNomeTabela := 'BZC_CADMON';
  strNomeCampo  := 'MON_CODMON';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadBrazilianColorMontadora.btnGravarClick(Sender: TObject);
begin
  dbeCodigo.Text := fStrZero(dbeCodigo.Text, 5);
  inherited;
end;

procedure TfrmCadBrazilianColorMontadora.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadBrazilianColorMontadora.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqMontadoraTinta(Self, conBzc, Nil, Nil, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);
end;

end.

