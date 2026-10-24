unit Contabilidade.View.HistoricoPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Contabilidade.View.TfrmPaiCadContabilidade, frxClass, frxExportCSVTestabilidade;

type
  TfrmHistoricoPadrao = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsHisPad: TDataSource;
    dbeTPLACO: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmHistoricoPadrao: TfrmHistoricoPadrao;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, Contabilidade.Consultas,
  Contabilidade.Funcoes, Contabilidade.Classes.UniQueryAuditoria;

{$R *.dfm}

procedure TfrmHistoricoPadrao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmHistoricoPadrao.btnGravarClick(Sender: TObject);
begin
  if string(dbeTPLACO.Text).IsEmpty then
    dbeTPLACO.Clear;

  inherited;
end;

procedure TfrmHistoricoPadrao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  if blnUsaProTpl then
    dbeTPLACO.Text := fRetTplacoEmpresaLogada()
  else
    dbeTPLACO.Clear;
end;

procedure TfrmHistoricoPadrao.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrHist: TConsultasArray;
begin
  chrKey := '/';
  If fPesqHistoricoPadrao(Self, Nil, Nil, qryTabela, chrKey, arrHist) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmHistoricoPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'HISPAD';
  strNomeCampo      := 'PAD_CODIGO';

  blnUsaProTpl := fCfgHisTpl;
  strCampoTplaco := 'PAD_TPLACO';

  qryTabela         := fCriaQueryContabilidade('HISPAD', Self.Name, Self);
  qryTabela.SQL.Text := 'SELECT * FROM HISPAD';
  dtsHisPad.DataSet := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeTPLACO;

  dbeDescri.MaxLength := fCfgMaxHpd ;
end;

function TfrmHistoricoPadrao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin

    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código do histórico padrão deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeDescri) Then
  Begin
    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição do histórico padrão deve ser preenchido!', ['&OK']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmHistoricoPadrao.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('PAD_CODIGO');
  stlCampos.Add('PAD_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('PAD_DESCRI');
  stlCamInd.Add('PAD_CODIGO');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

end.
