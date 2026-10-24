unit Contabilidade.View.HistoricoDosLancamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Contabilidade.View.TfrmPaiCadContabilidade, frxClass, frxExportCSVTestabilidade,
  DBMemoFocus;

type
  TfrmHistoricoDosLancamentos = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dtsHisLan: TDataSource;
    dbmDescri: TDBMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmHistoricoDosLancamentos: TfrmHistoricoDosLancamentos;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, Contabilidade.Consultas;

{$R *.dfm}

procedure TfrmHistoricoDosLancamentos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbmDescri, False);
end;

procedure TfrmHistoricoDosLancamentos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbmDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmHistoricoDosLancamentos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrHist: TConsultasArray;
begin
  chrKey := '/';
  If fPesqHistoricoDosLancamentos(Self, Nil, Nil, qryTabela, chrKey, arrHist) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmHistoricoDosLancamentos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'HISLAN';
  strNomeCampo      := 'HIS_CODIGO';

  qryTabela         := fCriarQuery('SELECT * FROM HISLAN', Self);
  dtsHisLan.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  pHabilitaCodigo(dbeCodigo, dbmDescri, False);
end;

function TfrmHistoricoDosLancamentos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin

    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código do histórico de lançamentos deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbmDescri) Then
  Begin
    If fEmptyStr(dbmDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição do histórico de lançamentos deve ser preenchido!', ['&OK']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmHistoricoDosLancamentos.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('HIS_CODIGO');
  stlCampos.Add('HIS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('HIS_DESCRI');
  stlCamInd.Add('HIS_CODIGO');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

end.
